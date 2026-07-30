#!/bin/csh -f
#set verbose
#------------------------------------------------------------------------
# History: 2005-Mar-18: RayV created this program for translate "$1"
# Syntax: cdb2oa_x.csh <libname>
#         cdb2oa_x.csh ether  #(for example) 
#------------------------------------------------------------------------
#
if ($1 == "") then
 echo "Error: need an argument (Eg: cdb2oa_n.csh ether ) ... abort."; 
 exit 1
endif
 
set NDATE = `date +%Y%m%d`  #Example: 20050309
#
# 1. Translation preparation
#    (a) Clean up data source:
pushd ../cdb; echo "FYI: pwd = `pwd`"
if (! -d $1 ) then
   echo "Error: The given library, $1, is not found ... abort process."
   exit 1
endif
# -----------------------------------------------------------------------
cd $1   
find . -name "*.cdslck" -print | xargs rm -f; echo "FYI: clean .cdslck"
find . -name "*.cd%"    -print | xargs rm -f; echo "FYI: clean .cd%"
find . -name "*.cd-"    -print | xargs rm -f; echo "FYI: clean .cd-"
find . -name "*.pak"    -print | xargs rm -f; echo "FYI: clean .pak"
find . -name ".inca*"   -print | xargs rm -f; echo "FYI: clean .cnca"
find . -name "*.cd%"    -print | xargs rm -f; echo "FYI: clean .cd%"
find . -name "*_bak*"   -print | xargs rm -rf; echo "FYI: clean _bak"
find . -name "*_old*"   -print | xargs rm -rf; echo "FYI: clean _old"
find . -name "*_bad*"   -print | xargs rm -rf; echo "FYI: clean _bad"
find . -name ".abstract.messages" -print | xargs rm -f; echo "FYI: clean .abstract.messages"
find . -name ".abstract.status"   -print | xargs rm -f; echo "FYI: clean .abstract.status"
find . -name "abstract#2epin"     -print | xargs rm -rf; echo "FYI: clean  abstract.pin"
find . -name "abstract#2eext"     -print | xargs rm -rf; echo "FYI: clean  abstract.ext"
#--------------------------------------------------------------------
#    (b) Clean up target area:
popd; echo "FYI: pwd = `pwd`"
if (-d ./$1 ) then
   mv ./$1 ./$1_old${NDATE}
   if (-f ./cdb2oa_$1.log ) mv ./cdb2oa_$1.log ./cdb2oa_$1.log${NDATE}
endif
#
# 2. Check destination:
if ( -f ./$1 ) mv ./$1 ./$1_$NDATE

# 3. Translate:
echo "FYI: Translation starts: `date`"
cdb2oa -lib $1 -cdslibpath       ../../custom_cdb -log cdb20a_$1.log 
echo "FYI: Translation finish: `date`"
#
