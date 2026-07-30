/*********************************************************

WARNING:  This program is supplied for reference purposes only.
It comes with no warranty.  It can change cells in your
database. Cadence Design Systems assumes no liability if you
choose to run the programs contained in this file on your
database.  You assume all liability if you run any of these
programs on your database.
Always backup your database before running any programs which
may change the database.

USE AT YOUR OWN RISK.

**********************************************************/

;;; This program fixes the cdb2oa error CDBOA-611
;;;
;;; Usage:
;;; OAfixDupInstTermsLib( ?logFileName "logFile" ?libList "libName" )
;;;      - Processes named library
;;; OAfixDupInstTermsLib( ?logFileName "logFile" ?libList list( lib1 lib2... ) )
;;;      - Processes libraries in list
;;; OAfixDupInstTermsLib( ?logFileName "logFile" )
;;;      - Processes all libraries in cds.lib
;;; OAfixDupInstTermsLib( ?logFileName "logFile" ?skipList list( lib1 lib2... ) )
;;;      - Processes all libraries in cds.lib except those in 
;;;      skip list

;;; To work on a single cell
;;; OAeditCellFixDupInstTerms( ?libName "libName" ?cellName "cellName" ?log stdout )

procedure( OAfixDupInstTermsLib( @key logFileName log libList skipList viewList )
  let((
          logFile)

    unless( outportp( log )
       unless( logFileName
          sprintf( logFileName "libEdit%d.log" ipcGetPid() )
       ) ; ** unless logFileName **
       log = outfile( logFileName )
    ) ; ** unless log **
    unless( outportp( log )
       log = poport
    ) ; ** unless outportp **
 
;; Get the library list
    if( libList then
       unless( listp( libList )
          libList = list( libList )
       ) ; ** unless listp **
       libList = foreach( mapcar libName libList
                    ddGetObj( libName )
                 ) ; ** foreach mapcar **
    else
       libList = ddGetLibList()
    ) ; ** when libList **
;; Remove the skipped libraries
    when( skipList
       unless( listp( skipList )
          skipList = list( skipList )
       ) ; ** unless listp **
       libList = setof( lib libList
                        ! member( lib~>name skipList )
                 )
    ) ; ** when skipList **

    foreach( lib libList
       libName = lib~>name
       foreach( cell lib->cells
          OAeditCellFixDupInstTerms( ?libName libName ?cellId cell ?viewList viewList ?log log )
       ) ; ** foreach cell **
    ) ; ** foreach lib **
    when( logFileName
       close( log )
       view( logFileName )
    ) ; ** when logFileName **
  ) ; ** let **
) ; ** procedure OAeditLib **

procedure( OAeditCellFixDupInstTerms( @key libName cellName cellId viewList log )
  let((
          cvId
      fix)
    if( cellName then
       cellId = ddGetObj( libName cellName )
    else
       unless( libName
          libName = cellId~>lib~>name
       ) ; ** unless libName **
    ) ; ** if cellName **
    unless( viewList
       viewList = cell~>views~>name
    ) ; ** unless viewList **
    unless( listp( viewList )
       viewList = list( viewList )
    ) ; ** unless listp **
    unless( log
       log = poport
    ) ; ** unless log **
 
    cellName = cellId~>name
    
    foreach( view viewList
       fprintf( log "Processing Cell: %s %s %s \n" libName cellName view)
       if( ddGetObj( libName cellName view ) then
          cvId = dbOpenCellViewByType( libName cellName view nil "a" )
          if( cvId then

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;              PUT YOUR EDITS HERE
;;;
;;;   Your editing procedure should return a t if it had to do 
;;;   anything, otherwise it should return a nil
;;;
;;;         fix = OAfixInstTerms( cvId log )
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
             fix = OAfixDupInstTerms( cvId ?log log ?fixIt t )
             when( fix
                dbSave( cvId )
                dbClose( cvId )
             ) ; ** when fix **
          else
             fprintf( log "*ERROR* Unable to open cellview for editing: %s %s %s. Skipping. \n" libName cellName view )
          ) ; ** if cvId **
       else
          fprintf( log "*ERROR* Cannot find cellview: %s %s %s. Skipping. \n" libName cellName view )

       ) ; ** if ddGetObj **
       drain( log )
    ) ; ** foreach view **
  ) ; ** let **
) ; ** procedure OAeditCellFixDupInstTerms **

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;

procedure( OAfixDupInstTerms( cvId @key ( log poport )
                              ( reportIt t ) ( fixIt nil )
           )
  let((
          instTerm
       chk
       instTerms
       insts
       instTermList
       termList
       curInstTerm
       curTerm
       matchedTerm
       suspectInstTerms
       netId
       it)

    insts = setof( inst cvId~>instances
                   inst~>instTerms
            )

    foreach( inst insts
       instTermList = inst~>instTerms
       termList = instTermList~>term
       indx = 0

       while( instTermList
          curInstTerm = car( instTermList )
          instTermList = cdr( instTermList )
          curTerm = curInstTerm~>term
          suspectInstTerms = setof( it instTermList
                                    eq( it~>term curTerm )
                             )
          when( suspectInstTerms
             netId = curInstTerm~>net
             while( it = car( suspectInstTerms )
                suspectInstTerms = cdr( suspectInstTerms )
                if( eq( it~>net netId ) then
;; The nets are the same, remove one of them.
                   when( reportIt
                      fprintf( log "%s/%s/%s - Found duplicate instTerm  %s on net %s on instance %s\n"
                               cvId~>libName cvId~>cellName cvId~>viewName curInstTerm~>name netId~>name inst~>name
                      )
                   ) ; ** when reportIt **
                   when( fixIt
                      remd( it suspectInstTerms )
                      remd( it instTermList )
                      dbDeleteObject( it )
                   ) ; ** when deleteIt **
                else
;; Check the number of elements in the nets
                   fprintf( log "%s/%s/%s - Found duplicate instTerm  %s on net %s and net %s on instance %s\n"
                            cvId~>libName cvId~>cellName cvId~>viewName curInstTerm~>name netId~>name it~>net~>name inst~>name
                   )
                   when( fixIt
                      cond( 
                         ( ! netId~>figs && ! netId~>pins && netId~>instTermCount < 2
                             fprintf( log "Deleting instTerm %s\n" curInstTerm~>name )
                             dbDeleteObject( curInstTerm )
                             curInstTerm = it
                             remd( curInstTerm suspectInstTerms )
                             remd( curInstTerm instTermList )
                             netId = curInstTerm~>net
                         )
                         ( ! it~>net~>figs && ! it~>net~>pins && it~>net~>instTermCount < 2
                             fprintf( log "Deleting instTerm %s\n" it~>name )
                             remd( it suspectInstTerms )
                             remd( it instTermList )
                             dbDeleteObject( it )
                         )
                         ( t
                           fprintf( log "This requires manual edits." )
                         )
                      )  ; ** cond netId **

                   ) ; ** when fixIt **
                   
                ) ; ** if eq **
             ) ; ** foreach it **
          ) ; ** when suspectInstTerms **
       ) ; ** while instTermList **
    ) ; ** foreach inst **
          
;; Return value
    cvId~>modifiedButNotSaved
    
  ) ; ** let **
) ; ** procedure OAfixDupInstTerms **
