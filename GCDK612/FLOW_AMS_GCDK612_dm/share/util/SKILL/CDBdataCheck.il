;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File:         CDBdataCheck.il
;
; Description:  Check various data objects in a CDB library for issues
; Description:  that may be problems when translated to Open Access.
;
; Author:       Dennis Higgins  <higgins@cadence.com>
; Created:      Mar 12 11:38 03
; Modified:     Mar 14 19:17 03 CDBdataCheck higgins
; Language:     Skill
; Package:      N/A
; MainFun:      CDBdataCheck
; Status:       Experimental (Do Not Distribute)
;
; (C) Copyright 2003, Cadence Design Systems, all rights reserved.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Usage:        ** TO BE RUN FROM A CDB DFII SESSION **
;               run CDBdataCheckUI()
;               select a library to check
;               specify one or more cell names to check
;                 if no cell names are specified then all cell 
;                 names in the library will be checked
;                 separate multiple cell names with spaces
;               specify one or more view names to check
;                 if no view names are specified then all view 
;                 names for each checked ell name will be checked
;                 separate multiple view names with spaces
;               select the type of checks to be performed
;
; The output file of the checked library will be displayed after
; all checks are completed. No data is modified.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


procedure(CDBdataCheck(@key library cells views
			(fullCheck nil)
			(magCheck nil)
			(mosaicCheck nil)
			(viewTypeCheck nil)
			(pointsCheck nil)
			(nameCheck nil))
  let(((lib ddGetObj(library)) dir of ofp cv out)

    if(!lib then
	hiGetAttention()
	printf("Can't find specified library : %s\n" library)
    else
	;;data info collection directory for each library
	sprintf(dir "./CDBdataCheck_%s" lib~>name)
	unless(isDir(dir)
	    createDir(dir)
	)

	;;fprintf(of "START : %s\n\n" getCurrentTime())
	;;fprintf(of "VERSION : %s\n\n" cadr(parseString(getVersion(t))))

	;;this is just for testing
	;;what is the run time
	;;t1 = getCurrentTime()
	;;printf("%s\n" t1)
	sprintf(of "CDBdataCheck_%s.out" lib~>name)
	ofp = outfile(of)
	foreach(cell lib~>cells
	    when(!cells || member(cell~>name cells)
		foreach(view cell~>views
		    when(!views || member(view~>name views)
			;;when(attr prefix = attr)
			;;sprintf(of "%s/%s^%s" dir cell~>name view~>name)
			;;printf("Output : %s\n" of)
			;;ofp = outfile(of "w")

			cv = dbOpenCellViewByType(lib~>name cell~>name view~>name)
			when(cv
			    out = ""
			    when(magCheck || fullCheck
				;;println("Magnification checks")
				out = CDB_dataCheck_mag(cv out)
			    ) ; ** when viewTypes **
			    when(viewTypeCheck || fullCheck
				;;println("ViewType checks")
				out = CDB_dataCheck_viewType(cv out)
			    ) ; ** when viewTypes **
			    when(pointsCheck || fullCheck
				;;println("Point checks")
				out = CDB_dataCheck_points(cv out)
			    ) ; ** when points **
			    when(mosaicCheck || fullCheck
				;;println("Mosaic checks")
				out = CDB_dataCheck_mosaic(cv out)
			    )
			    when(nameCheck || fullCheck
				;;println("Name checks")
				out = CDB_dataCheck_name(cv out)
			    )
			    unless(out == ""
				fprintf(ofp "\n--- %s/%s ---\n" cell~>name view~>name)
				fprintf(ofp "%s" out)
			    )
			    
			    dbClose(cv)
			) ; ** when cv **
			
			;;close(ofp)

			;;cleanup - remove empty files
			;;when(fileLength(of) == 0 deleteFile(of))
			
			;;close(of)
		    ) ; ** when view **
		) ; ** foreach view **
	    ) ; ** when cells **
	    
	) ; ** foreach cell **
	
	;;fprintf(of "STOP : %s" getCurrentTime())
	;;t2 = getCurrentTime()
	;;printf("%s\n" t2)
	;;printf("CDBdataCheck run time = %d\n" compareTime(t2 t1))

	close(ofp)
	view(of)
	t
    ) ; ** if lib **

  ) ; ** let **
) ; ** procedure CDBdataCheck **

procedure(CDB_dataCheck_mag(cv out)
   foreach(inst cv~>instances 
       unless(!inst~>mag || onep(inst~>mag)
	   sprintf(out "%sMAGNIFICATION      : of %g for %s named %L of %s/%s/%s\n"
		   out inst~>mag inst~>objType inst~>name
		   inst~>libName inst~>cellName inst~>viewName)
       ) ;;end unless
   );;foreach inst
  out
) ; ** procedure CDB_dataCheck_mag **

procedure(CDB_dataCheck_viewType(cv out)
  when(or(and(cv~>viewName == "layout"
	      cv~>cellViewType != "maskLayout")
	  and(cv~>viewName == "schematic"
	      cv~>cellViewType != "schematic")
	  and(cv~>viewName == "schematicSymbol"
	      cv~>cellViewType != "schematicSymbol")
       )
      sprintf(out "%sMISMATCHED VIEW    : NAME = %L : TYPE = %L\n"
	      out cv~>viewName cv~>cellViewType)
  ) ; ** when or **
  when(cv~>cellViewType == "stranger"
      sprintf(out "%sSTRANGER VIEW TYPE : NAME = %L : TYPE = %L\n"
	      out cv~>viewName cv~>cellViewType)
  )
  out
) ; ** procedure CDB_dataCheck_viewType **

procedure(CDB_dataCheck_points(cv out)
  let((cpnts dx dy l1 l2 area)
    foreach(shp cv~>shapes
	;;bypass MPPs
	;;unless(car(car(shp~>groupMembers)~>prop)~>name == "rodMasterName"
	when(shp~>points
	    unless((l1 = length(shp~>points)) == 
		(l2 = length((cpnts = dbCompressPointArray(shp~>points
							   nil cv~>DBUPerUU))))
		sprintf(out "%sCOLINEAR POINTS    : %s on %L\n" out shp~>objType shp~>lpp)
		sprintf(out "%s                   : original   (%d) : %L\n" out l1 shp~>points)
		sprintf(out "%s                   : compressed (%d) : %L\n" out l2 cpnts)
		;;fprintf(oport "\t%L\n" shp~>??)
	    ) ; ** unless l1 **
	) ; ** if shp **
	when( shp~>objType == "rect"
	    ;;check for zero area shapes
	    dx = xCoord(car(shp~>bBox)) - xCoord(cadr(shp~>bBox))
	    dy = yCoord(car(shp~>bBox)) - yCoord(cadr(shp~>bBox))
	    unless((area = abs( dx * dy )) > 0
		sprintf(out "%sZERO AREA SHAPE    : %s on %L at %L\n"
			out shp~>objType shp~>lpp shp~>bBox)
	    )
	) ; ** if shp **
	;;) ; ** unless car **
    ) ; ** foreach shp **
    out
  ) ; ** let **
) ; ** procedure CDB_dataCheck_points **

procedure(CDB_dataCheck_mosaic(cv out)
  let((MosaicInst)
    if( cv~>mosaics then
	foreach( Mosaic cv~>mosaics
	    if(Mosaic~>mosaicType != "simple" then
		sprintf(out "%sCOMPLEX MOSAIC     : named %L at %L of %s/%s/%s\n"
			 out Mosaic~>name Mosaic~>xy
			 Mosaic~>libName Mosaic~>cellName Mosaic~>viewName
		) 
	    else
		MosaicInst = car(Mosaic~>instanceList)
		unless(car(Mosaic~>tileArray) == "R0"
		    sprintf(out "%sMOSAIC ROTATION    : of %s for %L at %L of %s/%s/%s\n"
			     out car(Mosaic~>tileArray) Mosaic~>name Mosaic~>xy
			     MosaicInst~>libName MosaicInst~>cellName
			     MosaicInst~>viewName
		    )
		) ; ** unless car **
		foreach( Term MosaicInst~>instTerms
		    sprintf(out "%sMOSAIC INSTANCE TERMINALS : %L on %s at %L for %s/%s/%s\n"
			    out Term Mosaic~>name Mosaic~>xy
			    MosaicInst~>libName
			    MosaicInst~>cellName MosaicInst~>viewName
		    )
		) ; ** foreach Term **
	    ) ; ** if Mosaic **
	) ; ** foreach Mosaic **
    ) ; ** if cv **
    out
  ) ; ** let **
) ; ** procedure CDB_dataCheck_mosaic **

procedure(CDB_dataCheck_name(cv out)
  let((badChars objs name)

    ;;check against signals,terminals names
    badChars = list("." "@" ";" ":" " " "*" "'" "`" "<" ">") 
    rexMagic(nil)
    foreach(type '(signals terminals)
	foreach(obj get(cv type)
	    when((name = obj~>name)
		foreach(badchar badChars
		    ;; printf( "%L %L \n" badchar name )
		    when(rexMatchp(badchar name)
			sprintf(out "%sNAME CONFLICT      : %L in %s %L\n"
				out badchar obj~>objType name)
		    ) ;end when
		) ; end foreach badchar
	    ) ; ** when name **
	) ; end foreach name
    ) ; ** foreach obj **

    ;;check against cell, view, instances, mosaics names
    badChars = list(" " "<" ">" "(" ")" "/")
    foreach(type '(cell view instances mosaics)
	objs = get(cv type)
	unless(listp(objs) objs = list(objs))
	foreach(obj objs
	    when((name = obj~>name)
		foreach(badchar badChars
		    ;; printf( "%L %L \n" badchar name )
		    when(rexMatchp(badchar name)
			sprintf(out "%sNAME CONFLICT      : %L in %s %L\n"
				out badchar obj~>objType name)
		    ) ;end when
		) ; ** foreach badchar **
	    ) ; ** when name **
	) ; ** foreach obj **
    ) ; ** foreach type **

    out
  ); end let
) ; ** procedure CDB_dataCheck_name **


procedure(_CDBdataCheck_Form()
  hiCreateAppForm(
      ?name '_CDB_DATA_CHECK_FORM
      ?fields list(
		  list(hiCreateCyclicField(
			   ?name 'lib
                             ?prompt "Library Name"
                             ?choices list(" ")
                             ?value " "
		       )
		       0:0 400:30 100)

		  list(hiCreateStringField(
			   ?name 'cell
                             ?prompt "Cell Names"
		       )
                       0:30 400:30 100)

		  list(hiCreateStringField(
			   ?name 'view
			   ?prompt "View Names"
		       )
                       0:60 400:30 100)
		  list(hiCreateToggleField(
			   ?name 'opts
			   ?choices '((magCheck Magnification)
				      (viewTypeCheck ViewTypes)
				      (pointsCheck Points)
				      (mosaicCheck Mosaics)
				      (nameCheck Names))
			   ?value list(t t t t t)
		       )
		       0:90 400:60 100)
	      )
      ?formTitle "CDB Data Checker"
      ?callback list("_CDBdataCheckUICB()")
  )
) ; ** procedure CDBdataCheck_Form **

_CDBdataCheck_Form()

procedure(CDBdataCheckUI()
  _CDB_DATA_CHECK_FORM->lib->choices = ddGetLibList()~>name
  _CDB_DATA_CHECK_FORM->lib->value = car(ddGetLibList()~>name)
  hiDisplayForm(_CDB_DATA_CHECK_FORM)
) ; ** procedure CDBdataCheckUI **

procedure(_CDBdataCheckUICB()
  CDBdataCheck(?library _CDB_DATA_CHECK_FORM->lib->value
	       ?cells parseString(_CDB_DATA_CHECK_FORM->cell->value)
	       ?views parseString(_CDB_DATA_CHECK_FORM->view->value)
	       ?magCheck nth(0 _CDB_DATA_CHECK_FORM->opts->value)
	       ?viewTypeCheck nth(1 _CDB_DATA_CHECK_FORM->opts->value)
	       ?pointsCheck nth(2 _CDB_DATA_CHECK_FORM->opts->value)
	       ?mosaicCheck nth(3 _CDB_DATA_CHECK_FORM->opts->value)
	       ?nameCheck nth(4 _CDB_DATA_CHECK_FORM->opts->value))
) ; ** procedure CDBdataCheckUICB **
