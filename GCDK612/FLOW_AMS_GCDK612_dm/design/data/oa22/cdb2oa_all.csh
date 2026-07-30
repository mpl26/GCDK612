#!/bin/csh -f
#set verbose
#------------------------------------------------------------------------
# History: 2005-Mar-31: RayV created this program for translate all libraries
#                       in Ether design database.
#------------------------------------------------------------------------
set NDATE = `date +%Y%m%d`  #Example: 20050309
#
if ( -f ./cds.lib ) mv ./cds.lib ./cds.lib_$NDATE
cp -p ./cds.lib.PRECONVERT ./cds.lib
if ( -f ./lib.defs ) mv ./lib.defs ./lib.defs_$NDATE
# Translate:
echo "Translation start: `date`"
echo "Using version:"
cdb2oa -V
cdb2oa -W
sleep 5  # Give 5 sec chance to abort
echo ""
echo "Converting gpdk090..."
set CDKDIR = ../../../share/CDK090
if ( -d $CDKDIR/gpdk090/libs.oa22/gpdk090 ) mv $CDKDIR/gpdk090/libs.oa22/gpdk090 $CDKDIR/gpdk090/libs.oa22/gpdk090_old_$NDATE
cdb2oa -lib gpdk090 -cdslibpath ../../custom_cdb -oalibpath $CDKDIR/gpdk090/libs.oa22/gpdk090 -log ./cdb2oa_gpdk090.log
# Must do lefin after conversion.  Must NOT use '-overwrite' option.
echo "Lefin to modify gpdk090..."
lefin -lef $CDKDIR/gsclib090/lef/gpdk090_tech_9lm.lef -lib gpdk090 -libPath $CDKDIR/gpdk090/libs.oa22/gpdk090 -log ./lefin_gpdk090.log
echo "Converting gsclib090..."
if ( -d $CDKDIR/gsclib090/oa22/gsclib090 ) mv $CDKDIR/gsclib90/oa22/gsclib090 $CDKDIR/gsclib090/oa22/gsclib090_old_$NDATE
cdb2oa -lib gsclib090 -cdslibpath ../../custom_cdb -oalibpath $CDKDIR/gsclib090/oa22/gsclib090 -log ./cdb2oa_gsclib090.log
echo "Converting gsclib090... (NOT used by ether, but done for completeness)"
if ( -d $CDKDIR/giolib090/oa22/giolib090 ) mv $CDKDIR/giolib090/oa22/giolib090 $CDKDIR/giolib090/oa22/giolib090_old_$NDATE
cdb2oa -lib giolib090 -cdslibpath ../../custom_cdb -oalibpath $CDKDIR/giolib090/oa22/giolib090 -log ./cdb2oa_giolib090.log
echo ""

./cdb2oa_x.csh ether_label
./cdb2oa_x.csh av_hrcx_ether
./cdb2oa_x.csh ether
./cdb2oa_x.csh ether_sims

echo "Translation done: `date`"
