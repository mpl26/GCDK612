;;
;; Set the Spectre Model Path
;;
  if(isContextLoaded("schView") then
      envSetVal("asimenv.startup" "simulator" 'string "spectre")
      libPath = ddGetObjReadPath( ddGetObj( "gpdk090" ) )
      asiSetEnvOptionVal(asiGetTool('spectre) "modelFiles"
         list(
            list(strcat( libPath "/../../models/spectre/gpdk090.scs") "NN")
      ))
    )

  printf("\n  *************************************************************
          \n  *              Cadence Design Systems, Inc.                 *
          \n  *                                                           *
          \n  *                    Generic 90nm PDK                       *
          \n  *                        (gpdk090)                          *
          \n  *                                                           *
          \n  *************************************************************
          \n")
