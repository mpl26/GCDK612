printf("***************************************************************\n")
printf("*           90nm  Generic Standard Cell Library               *\n")
printf("*                                                             *\n")
printf("* This library is provided as an education medium. It is      *\n")
printf("* based upon the generic process available thru Cadence PDK   *\n")
printf("* factory in the GPDK Process Delivery Kit.                   *\n")
printf("* Cadence shall in no case be liable for the contents of      *\n")
printf("* this library.                                               *\n")
printf("*                                                             *\n")
printf("* Copyright Cadence Design Systems  2002 2003 2004            *\n")
printf("* gsclib090 v0.2, Apr 2004, Copyright Cadence Design Systems  *\n")
printf("*                                                             *\n")
printf("***************************************************************\n")
printf(" \n")

;; FYI, this file is a WORK-IN-PROGRESS!  Not all procedures have been
;; updated for use with the 90nm gsclib090 library.  
;;
;; Normally, this file loads ONCE per session upon library access.
;; To force reloading of this file, type:  Gsclib090Init()

when( getd('hiGraphicMode) && hiGraphicMode()

	; if IC5.0 or later
	; Preset the VXL component type ref library to make user's life
	; a little bit easier.
	if( car(parseString(nth(3 parseString(getVersion())) ".")) == "5"
		then
			envSetVal("layoutXL" "compTypeRefLibs" 'string "gsclib090")
		else
			printf("*** WARNING: This library works better with IC5.033USR1 or later...\n")
			printf("***          Some features have been disabled for the version you are running.\n")
			printf(" \n")
	    )

	unless( gsclib090.init
	printf("Loading custom Skill for gsclib090....\n")
	;;printf("WARNING.  Not all procedures have been updated for use with this 90nm library....\n")
	
	procedure( Gsclib090AbgenPrep(cv viewName "gt")
		prog( (newCV)
			printf("*** INFO: Processing %L %L %L.\n" cv~>libName cv~>cellName cv~>viewName)
			unless( Gsclib090VerifyLayout(cv) 
				printf("*** ERROR: Please review layout for problems...\n")
				return(nil)
			      )
			unless( dbSave(cv cv~>libName cv~>cellName viewName)
				printf("*** ERROR: Could not duplicate the layout...\n")
				return(nil)
			      )
			unless( newCV = dbOpenCellViewByType(cv~>libName cv~>cellName viewName nil "a")
				printf("*** ERROR: Could not edit copied cellview....\n")
				return(nil)
			      )
			unless( Gsclib090AbgenPrepDoIt(newCV)
				printf("*** ERROR: Problem processing the cellview...\n")
				return(nil)
			      )
			unless( dbSave(newCV)
				printf("*** ERROR: Could not save new cellview...\n")
				return(nil)
			      )
			printf("*** INFO: Done !\n")
			return(t)
		    )
		)
	procedure( Gsclib090AbgenPrepDoIt(cv)
		prog( (pins newFig)
			pins = cv~>terminals~>pins
			printf("*** INFO: Processing pins...\n")
			foreach( pin pins
				 foreach(fig pin~>fig
					 newFig = dbCopyFig(fig cv)
					 fig~>purpose = "pin"
				        )
			       )
			printf("*** INFO: Flattening instances...\n")
			foreach( inst cv~>instances
				 dbFlattenInst(inst 20 t nil)
			       )
			return(t)
		    )
		 )
	procedure( Gsclib090VerifyLayout(cv)
		prog( (pins status term netExpr bndr x y xx yy labels)
			status = nil

			printf("*** INFO: Layout verification for %s %s %s\n"
				cv~>libName cv~>cellName cv~>viewName)
			
			unless( pins = cv~>terminals~>pins
				printf("*** ERROR: There does not appear to be pins in your layout !\n")
				return(nil)
			      )

			unless( Gsclib090VerifyPowerTerms(cv)
				return(nil)
			      )

			foreach( pin pins
				 printf("*** INFO: Verifying pins purpose for net %L.\n" pin~>term~>name)
				 foreach( figure pin~>fig
					  ;;unless( figure~>purpose == "drawing" ;)
					  unless( ( figure~>purpose == "pin"  || figure~>purpose == "drawing" )
						  printf("*** ERROR: For CDK090 libraries, pins are generally drawn using the 'pin' or 'drawing' purpose.\n")
						  printf("***        Some shapes for pin on net %L are using another layer purpose.\n" 
								pin~>term~>name)
						  ; here, see if label exists on "label" purpose with origin overlapping pin
						  status = t
					        )
					)
			       )
			when(status return(nil))
			status = nil
			printf("*** INFO: SKIPPING verification of labels for each terminal.  SKILL code is not yet ready.\n")
			;foreach( term cv~>terminals
			;	 printf("*** INFO: Verifying label for terminal %L.\n" term~>name)
			;	 unless( labels = term~>textDisplays
			;		 status = t
			;		 printf("*** ERROR: Missing textDisplay for terminal.\n")
			;	       )
			;	 unless( status
			;		 foreach( l labels
			;			 	x = xCoord(car(l~>parent~>bBox))
			;				y = yCoord(car(l~>parent~>bBox))
			;				xx = xCoord(cadr(l~>parent~>bBox))
			;				yy = yCoord(cadr(l~>parent~>bBox))
			;				unless( xCoord(l~>xy) < xx &&
			;					xCoord(l~>xy) > x  &&
			;					yCoord(l~>xy) < yy &&
			;					yCoord(l~>xy) > y
			;					printf("*** ERROR: Label origin must be within the pin !\n")
			;					status = t
			;				      )
			;				unless( l~>lpp == list("text" "drawing")
			;					printf("*** ERROR: Label LPP must be text/drawing.\n")
			;					status = t
			;				      )
			;			)
;	
;			               )
;					 
;			       )
;			when( status return(nil))
			printf("*** INFO: Verifying boundary.\n")
			unless( bndr = setof(shape cv~>shapes shape ~>layerName == "prBoundary")
				printf("*** ERROR: Layout must contain prBoundary shape...\n")
				return(nil)
			      )
			printf("***     :.")
			unless( onep(length(bndr))
				printf("*** ERROR: Layout must contain only 1 prBoundary shape...\n")
				return(nil)
			      )
			printf(".")
			bndr = car(bndr)
			x = xCoord(car(bndr~>bBox))
			y = yCoord(car(bndr~>bBox))
			xx = xCoord(cadr(bndr~>bBox))
			yy = yCoord(cadr(bndr~>bBox))
			unless( x == 0.0
				printf("\n*** ERROR: Cell x origin must be 0.\n")
				return(nil)
			      )
			printf(".")
			unless( y == 0.0
				printf("\n*** ERROR: Cell y origin must be 0.\n")
				return(nil)
			      )
			printf(".")
			unless( yy == 2.61
				printf("\n*** ERROR: Cell height must be 2.61.\n")
				return(nil)
			      )
			printf(".")
			when( abs(int(xx / 0.29 + 0.00001) - xx/0.29) > 0.0001
				printf("\n*** ERROR: Cell width must be a multiple of 0.29.\n")
				return(nil)
			      )
			printf(".\n")
			return(t)
	            )
	         )

	procedure( Gsclib090VerifyPowerTerms(cv)
		prog( (netExpr)
			printf("*** INFO: Verifying power terminals 'VDD' & 'VSS'.\n")
			unless( member("VDD" cv~>terminals~>name)
				printf("*** ERROR: Missing required terminal 'VDD' in the layout.\n")
				return(nil)
			       )
			printf("***     :.")
			term = car(exists(term cv~>terminals term~>name == "VDD"))
			unless( term~>direction == "input"
				printf("\n*** ERROR: Power supply terminal must be of input type.\n")
				return(nil)
			      )
			printf(".")
			unless( netExpr = dbGetTermNetExpr(term)
				printf("\n*** ERROR: Missing net expression on power supply terminal.\n")
				return(nil)
			      )
			printf(".")
			unless( netExpr == "[@VDD:%:VDD!]"
				printf("\n*** ERROR: Net expression not following Specs...\n")
				return(nil)
			      )
			printf(".\n")
			unless( member("VSS" cv~>terminals~>name)
				 printf("\n*** ERROR: Missing required terminal 'VSS' in the layout.\n")
				 return(nil)
			       )
			printf("***     :.")
			term = car(exists(term cv~>terminals term~>name == "VSS"))
			unless( term~>direction == "input"
				printf("\n*** ERROR: Ground  terminal must be of input type.\n")
				return(nil)
			      )
			printf(".")
			unless( netExpr = dbGetTermNetExpr(term)
				printf("\n*** ERROR: Missing net expression on power supply terminal.\n")
				return(nil)
			      )
			printf(".")
			unless( netExpr == "[@VSS:%:VSS!]"
				printf("\n*** ERROR: Net expression not following Specs...\n")
				return(nil)
			      )
			printf(".\n")
			return(t)
	 	    )
	 	  )
			
			
	procedure( Gsclib090VerifySchematic(cv)
		prog( ()
			printf("*** INFO: Verifying connectivity for %s\\%s\\%s.\n"
				cv~>libName cv~>cellName cv~>viewName)
			
			unless( Gsclib090VerifyPowerTerms(cv)
				return(nil)
			      )

			return(t)
	    	    )
	    	 )


	procedure( Gsclib090NetlistSubckt(cv f)

	; Note: This is a simplified netlisting procedure that assumes that
	; the input is an extracted cellview... (no vectored connectivity).

		prog( (terms wTerm mos conn res cap)
			printf("*** INFO: Writing subcircuit for %s\\%s\\%s.\n"
				cv~>libName cv~>cellName cv~>viewName)

			fprintf(f "*************************************************************\n")
			fprintf(f "** Subcircuit for %s/%s/%s\n" cv~>libName cv~>cellName cv~>viewName)
			fprintf(f "** (c) Cadence Design Systems, 2002.\n")
			fprintf(f "** This information can be freely redistributed provided\n")
			fprintf(f "** this header is not removed.\n")
			fprintf(f "** This Library is provided by Cadence without any guaranties.\n")
			fprintf(f "** timeStamp: %L\n" getCurrentTime() )
			fprintf(f "** \n")
			fprintf(f " \n")

			; Output the .SUBCKT line (termOrder does not care for lib char).
			fprintf(f ".SUBCKT %s " cv~>cellName)
			terms = cv~>terminals
			wTerm = setof( term terms 
						term~>direction == "input" && 
						!(term~>name == "VDD" || term~>name == "VSS"))~>name
			wTerm = sort(wTerm 'alphalessp)
			foreach( term wTerm fprintf(f "%s " term) )

			wTerm = setof( term terms term~>direction == "output")~>name
			wTerm = sort(wTerm 'alphalessp)
			foreach( term wTerm fprintf(f "%s " term) )

			fprintf(f "VDD VSS\n")

			; Now process the MOS devices.
			mos = setof(inst cv~>instances inst~>cellName == "pmos1v" || inst~>cellName == "nmos1v")
			foreach( m mos
				 fprintf(f "%s %s %s %s %s %s w=%s l=%s ad=%s as=%s pd=%s ps=%s\n"
					 if( substring(m~>name 1 1) == "M" 
						;;m~>name 
						if( m~>cellName == "nmos1v" then
							strcat("MN" substring(m~>name 2 strlen(m~>name)-1))
						  )
						if( m~>cellName == "pmos1v" then
							strcat("MP" substring(m~>name 2 strlen(m~>name)-1))
						  )
					   )
					  Gsclib090GetConn(m "D")
					  Gsclib090GetConn(m "G")
					  Gsclib090GetConn(m "S")
					  Gsclib090GetConn(m "B")
					  m~>model
					  aelEngNotation(m~>w)
					  aelEngNotation(m~>l)
					  aelEngNotation(m~>ad)
					  aelEngNotation(m~>as)
					  aelEngNotation(m~>pd)
					  aelEngNotation(m~>ps))

			       )
			; Now processing the PRESISTORs...
			res = setof(inst cv~>instances inst~>cellName == "presistor")
			foreach( r res
				 fprintf(f "%s %s %s %s\n"
						if( substring(r~>name 1 1) == "R"
							r~>name
							strcat("R" substring(r~>name 2 strlen(r~>name)-1))
						  )
						Gsclib090GetConn(r "PLUS")
						Gsclib090GetConn(r "MINUS")
						aelEngNotation(r~>r)
					)
			       )
			; Now processing the PCAPACITORs...
			cap = setof(inst cv~>instances inst~>cellName == "pcapacitor")
			foreach( c cap
				 fprintf(f "%s %s %s %s\n"
						if( substring(c~>name 1 1) == "C"
							c~>name
							strcat("C" substring(c~>name 2 strlen(c~>name)-1))
						  )
						Gsclib090GetConn(c "PLUS")
						Gsclib090GetConn(c "MINUS")
						aelEngNotation(c~>c)
					)
			       )
			fprintf(f ".ENDS %s \n\n" cv~>cellName)		
			return(t)
		    )
		)
	  

		procedure(Gsclib090GetConn(device name)
			let( (conn netName)
				conn = car(exists(co device~>conns co~>name ==name))
				netName = conn~>net~>term~>name || conn~>net~>name
				when(substring(netName 1 1) == "+" 
					netName = substring(netName 2 strlen(netName)-1)
				    )
				rexCompile(":") 
				netName = rexReplace(netName "_" 0)
				netName
			   )
			)

	procedure(Gsclib090SubcktFile(libName viewList fileName)
		prog( (libId f cv)
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library...\n")
				return()
			      )
			fileName = simplifyFilename(fileName)
			unless( f = outfile(fileName)
				printf("*** ERROR: Could not open output file...\n")
				return()
			      )
			fprintf(f "************************************************\n")
			fprintf(f "* Subcircuit file for library characterization. \n")
			fprintf(f "* (Do not use for regular simulations...)       \n")
			fprintf(f "*                                               \n")
			fprintf(f "* (c) 2002 Cadence Design Systems.              \n")
			fprintf(f "*  Gilles S.C. Lamant - gscl@cadence.com        \n")
			fprintf(f "************************************************\n")
			fprintf(f " \n \n \n")
			fprintf(f ".GLOBAL VDD VSS\n")
			fprintf(f " \n")

			foreach( cell libId~>cells
				 if( cv = dbOpenCellView(libName cell~>name viewList nil "r")
					then
						when( Gsclib090VerifySchematic(cv)
							Gsclib090NetlistSubckt(cv f)
						    )
					else
						printf("*** WARNING: No valid view found for %L\n" cell~>name)
				    )
				)
			close(f)
			return(t)
		    )
		)

	procedure( Gsclib090Pipo(libName)
		prog( (libId validCellNames cellname validCellNamesList name f fileName cv excludeCells)
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library.\n")
				return()
			      )
			validCellNames = ""
			validCellNamesList = '()
			excludeCells = ""
			foreach( cell libId~>cells
				 name = cell~>name
				 when( 
                                        ;; Can comment out these lines before "&&" if you want ALL "layout" views in the library
                                        ( member(substring(name strlen(name)-1 2) list("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "XL")) ||
				         member(substring(name strlen(name)-2 3) list("X12" "X16" "X20")) ||
				         member(substring(name strlen(name)-3 4) list("_hvt" )) ||
					 member(substring(name 1 4) list("FILL") ) ||
					;; member(substring(name 1 1) list("P" "W") ) ||    ; IOLIB cells but this script isn't good for those
					 member(name list("ANTENNA" "TIEHI" "TIELO") ) ) &&
				        member("layout" cell~>views~>name) && 
				          ! ( member(substring(name 1 4) list("test")) || member(substring(name 1 6) list("prgrid" "zpcell")) )
					cv = dbOpenCellView(libName name "layout" nil "r")
					if( Gsclib090VerifyLayout(cv)
						then
							printf("*** INFO: Adding %L\n\n" name )
							validCellNames = strcat(validCellNames name ",")
							validCellNamesList = cons(name validCellNamesList)
						else
							printf("*** ERROR: Cell not added to list because of problems...\n\n")
							excludeCells = strcat(excludeCells " " name)
					  )
				     )
			       )

			validCellNames = substring(validCellNames 1 strlen(validCellNames)-1)

			printf("*** INFO : Cell List %L\n" validCellNames)
			printf("*** WARNING: Cells with problems %L\n" excludeCells)
			
			unless( fileName = makeTempFileName("/tmp/pipo")
				printf("*** ERROR: Could not create temp file for PIPO setup.\n")
				return()
			      )	
			unless( f = outfile(fileName)
				printf("*** ERROR: Could not open temp file for PIPO setup.\n")
				return()
			      )
			fprintf(f " ; PIPO Setup file for %L\n" libName)
			fprintf(f " ; Generated %L\n" getCurrentTime() )
			fprintf(f " ; (c) 2002-2005 Cadence Design Systems.\n")
			fprintf(f " \n")
			fprintf(f "streamOutKeys = list(nil \n")
			fprintf(f "\t 'runDir \t\t\"./WORK/PIPO/\"\n")
			fprintf(f "\t 'libName \t\t%L\n" libName)
			fprintf(f "\t 'primaryCell \t\t%L\n" validCellNames)
			fprintf(f "\t 'viewName \t\t\"layout\"\n")
			fprintf(f "\t 'outFile \t\t%L\n" strcat(libName ".gds"))
			fprintf(f "\t 'errFile \t\t\"PIPO.LOG\"\n" )
			fprintf(f "\t 'scale \t\t0.000500\n")
			fprintf(f "\t 'units \t\t\"microns\"\n")
			fprintf(f "\t 'hierDepth\t\t32\n")
			fprintf(f "\t 'convertToGeo\t\tt\n")
			fprintf(f "\t 'maxVertices\t\t200\n")
			fprintf(f "\t 'refLib\t\tnil\n")
			fprintf(f "\t 'libVersion\t\t\"5.0\"\n")
			fprintf(f "\t 'caseSensitivity\t\"preserve\"\n")
			fprintf(f "\t 'keepPcell\t\tnil\n")
			;;BAD Map format;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename("./cdk/gpdk090/stream/streamLayer.Map"))
			;;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename(strcat(libId~>readPath "/../stream/stream.map")))
			fprintf(f "\t 'convertPin\t\t\"geometry\"\n")
			fprintf(f "\t )\n")
			fprintf(f "\n")

			close(f)
			system( sprintf(nil "pipo strmout %s\n" fileName))
	 		printf("Check your run directory for PIPO.LOG and GDSII file...\n")

                        ; Now create individual .gds files for each cell
			foreach( cellname validCellNamesList 
				unless( fileName = makeTempFileName("/tmp/pipo")
					printf("*** ERROR: Could not create temp file for PIPO setup.\n")
					return()
				      )	
				unless( f = outfile(fileName)
					printf("*** ERROR: Could not open temp file for PIPO setup.\n")
					return()
				      )
				fprintf(f " ; PIPO Setup file for %L\n" libName)
				fprintf(f " ; Generated %L\n" getCurrentTime() )
				fprintf(f " ; (c) 2002-2005 Cadence Design Systems.\n")
				fprintf(f " \n")
				fprintf(f "streamOutKeys = list(nil \n")
				fprintf(f "\t 'runDir \t\t\"./WORK/PIPO/\"\n")
				fprintf(f "\t 'libName \t\t%L\n" libName)
				fprintf(f "\t 'primaryCell \t\t%L\n" cellname)
				fprintf(f "\t 'viewName \t\t\"layout\"\n")
				fprintf(f "\t 'outFile \t\t%L\n" strcat(cellname ".gds"))
				fprintf(f "\t 'errFile \t\t%L\n" strcat("PIPO.LOG." cellname))
				fprintf(f "\t 'scale \t\t0.000500\n")
				fprintf(f "\t 'units \t\t\"microns\"\n")
				fprintf(f "\t 'hierDepth\t\t32\n")
				fprintf(f "\t 'convertToGeo\t\tt\n")
				fprintf(f "\t 'maxVertices\t\t200\n")
				fprintf(f "\t 'refLib\t\tnil\n")
				fprintf(f "\t 'libVersion\t\t\"5.0\"\n")
				fprintf(f "\t 'caseSensitivity\t\"preserve\"\n")
				fprintf(f "\t 'keepPcell\t\tnil\n")
				;;BAD Map format;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename("./cdk/gpdk090/stream/streamLayer.Map"))
				;;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename(strcat(libId~>readPath "/../stream/stream.map")))
				fprintf(f "\t 'convertPin\t\t\"geometry\"\n")
				fprintf(f "\t )\n")
				fprintf(f "\n")
	
				close(f)
				system( sprintf(nil "pipo strmout %s\n" fileName))
		 		printf("Check your run directory for PIPO.LOG.%s and %s.gds file...\n" cellname cellname)
                        ) ;foreach
			return()
		    )
		)

;	procedure( Giolib090Pipo(libName)
;		prog( (libId validCellNames cellname validCellNamesList name f fileName cv excludeCells)
;			unless( libId = ddGetObj(libName)
;				printf("*** ERROR: Could not find specified library.\n")
;				return()
;			      )
;			validCellNames = ""
;			validCellNamesList = '()
;			excludeCells = ""
;			foreach( cell libId~>cells
;				 name = cell~>name
;				 when( 
;					member(substring(name 1 1) list("B" "I" "P") ) &&
;				        member("layout" cell~>views~>name) && 
;				          ! ( member(substring(name 1 4) list("test")) || member(substring(name 1 6) list("prgrid" "zpcell")) )
;					cv = dbOpenCellView(libName name "layout" nil "r")
;					if( ( Giolib090VerifyLayout(cv) || member( name list("IORINGFEED3X" "BONDPAD52")) )
;						then
;							printf("*** INFO: Adding %L\n\n" name )
;							validCellNames = strcat(validCellNames name ",")
;							validCellNamesList = cons(name validCellNamesList)
;						else
;							printf("*** ERROR: Cell not added to list because of problems...\n\n")
;							excludeCells = strcat(excludeCells " " name)
;					  )
;				     )
;			       )
;
;			validCellNames = substring(validCellNames 1 strlen(validCellNames)-1)
;
;			printf("*** INFO : Cell List %L\n" validCellNames)
;			printf("*** WARNING: Cells with problems %L\n" excludeCells)
;			
;			unless( fileName = makeTempFileName("/tmp/pipo")
;				printf("*** ERROR: Could not create temp file for PIPO setup.\n")
;				return()
;			      )	
;			unless( f = outfile(fileName)
;				printf("*** ERROR: Could not open temp file for PIPO setup.\n")
;				return()
;			      )
;			fprintf(f " ; PIPO Setup file for %L\n" libName)
;			fprintf(f " ; Generated %L\n" getCurrentTime() )
;			fprintf(f " ; (c) 2002-2005 Cadence Design Systems.\n")
;			fprintf(f " \n")
;			fprintf(f "streamOutKeys = list(nil \n")
;			fprintf(f "\t 'runDir \t\t\"./WORK/PIPO/\"\n")
;			fprintf(f "\t 'libName \t\t%L\n" libName)
;			fprintf(f "\t 'primaryCell \t\t%L\n" validCellNames)
;			fprintf(f "\t 'viewName \t\t\"layout\"\n")
;			fprintf(f "\t 'outFile \t\t%L\n" strcat(libName ".gds"))
;			fprintf(f "\t 'errFile \t\t\"PIPO.LOG\"\n" )
;			fprintf(f "\t 'scale \t\t0.000500\n")
;			fprintf(f "\t 'units \t\t\"microns\"\n")
;			fprintf(f "\t 'hierDepth\t\t32\n")
;			fprintf(f "\t 'convertToGeo\t\tt\n")
;			fprintf(f "\t 'maxVertices\t\t200\n")
;			fprintf(f "\t 'refLib\t\tnil\n")
;			fprintf(f "\t 'libVersion\t\t\"5.0\"\n")
;			fprintf(f "\t 'caseSensitivity\t\"preserve\"\n")
;			fprintf(f "\t 'keepPcell\t\tnil\n")
;			;;BAD Map format;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename("./cdk/gpdk090/stream/streamLayer.Map"))
;			;;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename(strcat(libId~>readPath "/../stream/stream.map")))
;			fprintf(f "\t 'convertPin\t\t\"geometry\"\n")
;			fprintf(f "\t )\n")
;			fprintf(f "\n")
;
;			close(f)
;			system( sprintf(nil "pipo strmout %s\n" fileName))
;	 		printf("Check your run directory for PIPO.LOG and GDSII file...\n")
;
;                        ; Now create individual .gds files for each cell
;			foreach( cellname validCellNamesList 
;				unless( fileName = makeTempFileName("/tmp/pipo")
;					printf("*** ERROR: Could not create temp file for PIPO setup.\n")
;					return()
;				      )	
;				unless( f = outfile(fileName)
;					printf("*** ERROR: Could not open temp file for PIPO setup.\n")
;					return()
;				      )
;				fprintf(f " ; PIPO Setup file for %L\n" libName)
;				fprintf(f " ; Generated %L\n" getCurrentTime() )
;				fprintf(f " ; (c) 2002-2005 Cadence Design Systems.\n")
;				fprintf(f " \n")
;				fprintf(f "streamOutKeys = list(nil \n")
;				fprintf(f "\t 'runDir \t\t\"./WORK/PIPO/\"\n")
;				fprintf(f "\t 'libName \t\t%L\n" libName)
;				fprintf(f "\t 'primaryCell \t\t%L\n" cellname)
;				fprintf(f "\t 'viewName \t\t\"layout\"\n")
;				fprintf(f "\t 'outFile \t\t%L\n" strcat(cellname ".gds"))
;				fprintf(f "\t 'errFile \t\t%L\n" strcat("PIPO.LOG." cellname))
;				fprintf(f "\t 'scale \t\t0.000500\n")
;				fprintf(f "\t 'units \t\t\"microns\"\n")
;				fprintf(f "\t 'hierDepth\t\t32\n")
;				fprintf(f "\t 'convertToGeo\t\tt\n")
;				fprintf(f "\t 'maxVertices\t\t200\n")
;				fprintf(f "\t 'refLib\t\tnil\n")
;				fprintf(f "\t 'libVersion\t\t\"5.0\"\n")
;				fprintf(f "\t 'caseSensitivity\t\"preserve\"\n")
;				fprintf(f "\t 'keepPcell\t\tnil\n")
;				;;BAD Map format;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename("./cdk/gpdk090/stream/streamLayer.Map"))
;				;;fprintf(f "\t 'layerTable\t\t%L\n" simplifyFilename(strcat(libId~>readPath "/../stream/stream.map")))
;				fprintf(f "\t 'convertPin\t\t\"geometry\"\n")
;				fprintf(f "\t )\n")
;				fprintf(f "\n")
;	
;				close(f)
;				system( sprintf(nil "pipo strmout %s\n" fileName))
;		 		printf("Check your run directory for PIPO.LOG.%s and %s.gds file...\n" cellname cellname)
;                        ) ;foreach
;			return()
;		    )
;		)

	procedure(Gsclib090Area(libName fileName)
		prog( (libId validCellNames name f cv excludeCells)
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library.\n")
				return()
			      )
			validCellNames = ""
			excludeCells = ""
			unless( f = outfile(simplifyFilename(fileName))
				printf("*** ERROR: Could not open file for area output.\n")
				return()
		              )
			fprintf(f "%s\tarea\n" libName)
			foreach( cell libId~>cells
				 name = cell~>name
				 when( ( member(substring(name strlen(name)-1 2) list("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "XL")) ||
				         member(substring(name strlen(name)-2 3) list("X12" "X16" "X20")) ||
				         member(substring(name strlen(name)-3 4) list("_hvt" )) ||
					 member(name list("FILL1" "FILL2" "FILL4" "FILL8" "FILL16" "FILL32" "FILL64" "ANTENNA" "TIEHI" "TIELO") ) ) &&
				       member("layout" cell~>views~>name)
					cv = dbOpenCellView(libName name "layout" nil "r")
					if( Gsclib090VerifyLayout(cv)
						then
							printf("*** INFO: Adding %L\n\n" name )
							validCellNames = strcat(validCellNames name ",")	
							Gsclib090SaveArea(cv f)
						else
							printf("*** INFO: Cell not added to list because of problems...\n\n")
							excludeCells = strcat(excludeCells " " name)
					  )
					when(cv dbClose(cv))
				     )
			       )

			validCellNames = substring(validCellNames 1 strlen(validCellNames)-1)
			close(f)
			printf("*** INFO : Cell List %L\n" validCellNames)
			printf("*** WARNING: Cells with problems %L\n" excludeCells)
			return(t)
			
		)
	)


	procedure(Gsclib090PostProcessAbstracts(libName )
		prog( (libId validCellNames cv excludeCells powerTerm groundTerm)
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library.\n")
				return()
			      )
			validCellNames = ""
			excludeCells = ""

			foreach( cell libId~>cells
				 name = cell~>name
				 when( ( member(substring(name strlen(name)-1 2) list("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "XL")) ||
				         member(substring(name strlen(name)-2 3) list("X12" "X16" "X20")) ||
				         member(substring(name strlen(name)-3 4) list("_hvt" )) ||
					 member(name list("FILL1" "FILL2" "FILL4" "FILL8" "FILL16" "FILL32" "FILL64" "ANTENNA" "TIEHI" "TIELO") ) ) &&
				         member("abstract" cell~>views~>name)
					 when( cv = dbOpenCellView(libName name "abstract" nil "a")
						printf("INFO: Processing %L abstract.\n" name)
						; We need to convert the regular terminal to add to it
						; the required inherited connections
						if( powerTerm = dbFindTermByName(cv "VDD")
							then
							    printf("INFO: Adding net expression to VDD terminal.\n")
							    dbReplaceTermNetExpr(powerTerm "[@VDD:%:VDD!]")
							else
     							    printf("ERROR: Could not find VDD terminal in layout %L ...\n" name)
						  )
						if( groundTerm = dbFindTermByName(cv "VSS")
							then
							    printf("INFO: Adding net expression to VSS terminal.\n")
							    dbReplaceTermNetExpr(groundTerm "[@VSS:%:VSS!]")
							else
     							    printf("ERROR: Could not find VSS terminal in layout %L ...\n" name)
						  )
					     )
					 when(cv dbSave(cv) dbClose(cv))
				     ) 
			       )

			return(t)
			
		)
	)

	procedure(Gsclib090PostProcessLayouts(libName )
		prog( (libId validCellNames cv excludeCells powerTerm groundTerm)
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library.\n")
				return()
			      )
			validCellNames = ""
			excludeCells = ""

			foreach( cell libId~>cells
				 name = cell~>name
				 when( ( member(substring(name strlen(name)-1 2) list("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "XL")) ||
				         member(substring(name strlen(name)-2 3) list("X12" "X16" "X20")) ||
				         member(substring(name strlen(name)-3 4) list("_hvt" )) ||
					 member(name list("FILL1" "FILL2" "FILL4" "FILL8" "FILL16" "FILL32" "FILL64" "ANTENNA" "TIEHI" "TIELO") ) ) &&
				         member("layout" cell~>views~>name)
					 when( cv = dbOpenCellView(libName name "layout" nil "a")
						printf("INFO: Processing %L layout.\n" name)
						; We need to convert the regular terminal to add to it
						; the required inherited connections
						if( powerTerm = dbFindTermByName(cv "VDD")
							then
							    printf("INFO: Adding net expression to VDD terminal.\n")
							    dbReplaceTermNetExpr(powerTerm "[@VDD:%:VDD!]")
							else
     							    printf("ERROR: Could not find VDD terminal in layout %L ...\n" name)
						  )
						if( groundTerm = dbFindTermByName(cv "VSS")
							then
							    printf("INFO: Adding net expression to VSS terminal.\n")
							    dbReplaceTermNetExpr(groundTerm "[@VSS:%:VSS!]")
							else
     							    printf("ERROR: Could not find VSS terminal in layout %L ...\n" name)
						  )
					     )
					 when(cv dbSave(cv) dbClose(cv))
				     ) 
			       )

			return(t)
			
		)
	)

	procedure(Gsclib090PostProcessSchematics(libName  @optional (keepMarkers nil))
		;; WARNING.  WORK-IN-PROGRESS!  At present, this handles terminals with-or-without previous net-expression
                ;;    It also DELETES P/G labels!!!  If there's no wire to the pin, THIS WOULD CREATE OPENS!
		;;    It does NOT delete previous net-expressions-on-wires!  
		;;    Still need to enhance to fix the above problems.
		;;      e.g. foreach term, assemble all the net pieces, identify label-net-expressions, and replace. 
		;;      Then CONVERT normal labels instead of deleting them
		prog( (libId validCellNames cv excludeCells Marker Markers Shape MarkerShape )
			unless( libId = ddGetObj(libName)
				printf("*** ERROR: Could not find specified library.\n")
				return()
			      )
			validCellNames = ""
			excludeCells = ""

			foreach( cell libId~>cells
				 name = cell~>name
				 when( ( member(substring(name strlen(name)-1 2) list("X1" "X2" "X3" "X4" "X5" "X6" "X7" "X8" "XL")) ||
				         member(substring(name strlen(name)-2 3) list("X12" "X16" "X20")) ||
				         member(substring(name strlen(name)-3 4) list("_hvt" )) ||
					 member(name list("FILL1" "FILL2" "FILL4" "FILL8" "FILL16" "FILL32" "FILL64" "ANTENNA" "TIEHI" "TIELO") ) ) &&
				         member("schematic" cell~>views~>name)
					 when( cv = dbOpenCellView(libName name "schematic" nil "a")
						printf("INFO: Processing %L schematic.\n" name)
						; We need to convert the regular terminal to add to it
						; the required inherited connections

						NetExpressions = list( list("VDD" "[@VDD:%:VDD!]") list("VSS" "[@VSS:%:VSS!]") )
						foreach( NetExp NetExpressions
		  					TermName = car(NetExp)
		  					ThisNetExpr = cadr(NetExp)
		  					if( !( Term = dbFindTermByName(cv TermName)) then
     								printf("ERROR: Could not find %s terminal in schematic %L ...\n" TermName name)
  							else
					  			printf("INFO: Adding net expression to %s terminal.\n" TermName)
		  						foreach( Pin Term~>pins
     	  							Object = Pin~>fig
    							 
     	  							; remove old net-expression on terminal, if any
     	  							foreach( Child Object~>children
     	  								if( Child~>theLabel = "cdsNetExpr()"
     	  									dbDeleteObject(Child)
     	  								) ;if
     	  							) ;foreach Child
  							 
     	  							;create net-expression on Pin(s)
     	  							schCreateNetExpression( cv ThisNetExpr Object Object~>xy "lowerLeft" Object~>orient "stick" 0.0625 )
    								 
    							 
     								) ;foreach Pin
    							 
     								foreach( Shape cv~>shapes
     	  								if( Shape~>objType == "label" then
     	  									if( Shape~>theLabel == TermName then
     	  										;use existing label to define net-expression at same place
     	  										;;schCreateNetExpression( cv ThisNetExpr Shape~>parent Shape~>xy Shape~>justify Shape~>orient Shape~>font Shape~>height )
     	  										dbDeleteObject(Shape)
     	  									) ;if
     	  								) ;if
     								) ;foreach Shape
    								 
  							) ;if
  							 
						) ;foreach NetExp


						; Check, and either remove or keep markers
						schCheck(cv)

						;; WHAT IS WRONG??  This doesn't work, nor CICcheckAllSch("gsclib" t) from which this was copied.
						if( keepMarkers == nil then
					  		printf("INFO: Removing markers after check-and-save.\n")
                                                	Markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker" 
							   memq(lpp~>purpose '("error" "warning"))))
                                                	foreach( Marker Markers
					  		              printf("INFO: Foreach Marker...\n")
                                                		foreach( MarkerShape Marker~>shapes
					  		                printf("INFO: Delete MarkerShape.\n")
                                                			dbDeleteObject( MarkerShape )
                                                		);; foreach MarkerShape
                                                	);; foreach error or warning marker type
						);; unless
						dbSave(cv) dbClose(cv)
					);; when cv open
				);;when cv name is on the list
			);;foreach cell

			return(t)
			
		);prog
	)

	procedure( Gsclib090SaveArea(cv f)
		prog( (bndr area x xx y yy)
			
			unless( bndr = setof(shape cv~>shapes shape ~>layerName == "prBoundary")
				printf("*** ERROR: Layout must contain prBoundary shape...\n")
				return(nil)
			      )
			printf("***     :.")
			unless( onep(length(bndr))
				printf("*** ERROR: Layout must contain only 1 prBoundary shape...\n")
				return(nil)
			      )
			printf(".")
			bndr = car(bndr)
			x = xCoord(car(bndr~>bBox))
			y = yCoord(car(bndr~>bBox))
			xx = xCoord(cadr(bndr~>bBox))
			yy = yCoord(cadr(bndr~>bBox))
			unless( x == 0.0
				fprintf("\n*** ERROR: Cell x origin must be @ 0.\n")
				return(nil)
			      )
			printf(".")
			unless( y == 0.0
				fprintf("\n*** ERROR: Cell y origin must be @ 0.\n")
				return(nil)
			      )
			printf(".")
			unless( yy == 2.61
				fprintf("\n*** ERROR: Cell height must be 2.61.\n")
				return(nil)
			      )
			printf(".")
			when( abs(int(xx / 0.29 + 0.00001) - xx/0.29) > 0.0001
				printf("\n*** ERROR: Cell width must be a multiple of 0.29.\n")
				return(nil)
			      )

			area = truncate((xx - x) * (yy - y) * 10000.00)/10000.00

			fprintf(f "%s\t%.4n\n" cv~>cellName area)
			return(t)
			)
	)

	gsclib090.init = t
	gsclib090.load = strcat(ddGetObj("gsclib090")~>readPath "/libInit.il")

	procedure( Gsclib090Init()
			gsclib090.init = nil
			loadi(gsclib090.load)
		 )
      )

;	procedure( Giolib090VerifyLayout(cv)
;		prog( (pins status term netExpr bndr x y xx yy labels)
;			status = nil
;
;			printf("*** INFO: Layout verification for %s %s %s\n"
;				cv~>libName cv~>cellName cv~>viewName)
;			
;			unless( pins = cv~>terminals~>pins
;				printf("*** ERROR: There does not appear to be pins in your layout !\n")
;				return(nil)
;			      )
;
;			unless( Gsclib090VerifyPowerTerms(cv)
;				return(nil)
;			      )
;
;			foreach( pin pins
;				 printf("*** INFO: Verifying pins purpose for net %L.\n" pin~>term~>name)
;				 foreach( figure pin~>fig
;					  ;;unless( figure~>purpose == "drawing" ;)
;					  unless( ( figure~>purpose == "pin"  || figure~>purpose == "drawing" )
;						  printf("*** ERROR: For CDK090 libraries, pins are generally drawn using the 'pin' or 'drawing' purpose.\n")
;						  printf("***        Some shapes for pin on net %L are using another layer purpose.\n" 
;								pin~>term~>name)
;						  ; here, see if label exists on "label" purpose with origin overlapping pin
;						  status = t
;					        )
;					)
;			       )
;			when(status return(nil))
;			status = nil
;			printf("*** INFO: SKIPPING verification of labels for each terminal.  SKILL code is not yet ready.\n")
;			;foreach( term cv~>terminals
;			;	 printf("*** INFO: Verifying label for terminal %L.\n" term~>name)
;			;	 unless( labels = term~>textDisplays
;			;		 status = t
;			;		 printf("*** ERROR: Missing textDisplay for terminal.\n")
;			;	       )
;			;	 unless( status
;			;		 foreach( l labels
;			;			 	x = xCoord(car(l~>parent~>bBox))
;			;				y = yCoord(car(l~>parent~>bBox))
;			;				xx = xCoord(cadr(l~>parent~>bBox))
;			;				yy = yCoord(cadr(l~>parent~>bBox))
;			;				unless( xCoord(l~>xy) < xx &&
;			;					xCoord(l~>xy) > x  &&
;			;					yCoord(l~>xy) < yy &&
;			;					yCoord(l~>xy) > y
;			;					printf("*** ERROR: Label origin must be within the pin !\n")
;			;					status = t
;			;				      )
;			;				unless( l~>lpp == list("text" "drawing")
;			;					printf("*** ERROR: Label LPP must be text/drawing.\n")
;			;					status = t
;			;				      )
;			;			)
;;	
;;			               )
;;					 
;;			       )
;;			when( status return(nil))
;			;printf("*** INFO: Verifying boundary.\n")
;			;unless( bndr = setof(shape cv~>shapes shape ~>layerName == "prBoundary")
;			;	printf("*** ERROR: Layout must contain prBoundary shape...\n")
;			;	return(nil)
;			;      )
;			;printf("***     :.")
;			;unless( onep(length(bndr))
;			;	printf("*** ERROR: Layout must contain only 1 prBoundary shape...\n")
;			;	return(nil)
;			;      )
;			;printf(".")
;			;bndr = car(bndr)
;			;x = xCoord(car(bndr~>bBox))
;			;y = yCoord(car(bndr~>bBox))
;			;xx = xCoord(cadr(bndr~>bBox))
;			;yy = yCoord(cadr(bndr~>bBox))
;			;unless( x == 0.0
;			;	printf("\n*** ERROR: Cell x origin must be 0.\n")
;			;	return(nil)
;			;      )
;			;printf(".")
;			;unless( y == 0.0
;			;	printf("\n*** ERROR: Cell y origin must be 0.\n")
;			;	return(nil)
;			;      )
;			;printf(".")
;			;unless( yy == 2.61
;			;	printf("\n*** ERROR: Cell height must be 2.61.\n")
;			;	return(nil)
;			;      )
;			;printf(".")
;			;when( abs(int(xx / 0.29 + 0.00001) - xx/0.29) > 0.0001
;			;	printf("\n*** ERROR: Cell width must be a multiple of 0.29.\n")
;			;	return(nil)
;			;      )
;			;printf(".\n")
;			return(t)
;		    )
;	         )
)
