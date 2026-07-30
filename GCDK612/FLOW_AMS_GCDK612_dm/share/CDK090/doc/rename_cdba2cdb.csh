#!/bin/csh -f

alias grep /usr/xpg4/bin/grep 

# Usage: $0 dirname1 [dirname2 ...]
# Will traverse the directories and rename files and dirs with 'cdba' to 'cdb'
#    and 'CDBA' to 'CDB'.  Examines the content of text files too.
#    

onintr END

set FILE = /tmp/rename.$$

echo ""
echo "Searching for files to rename..."
echo ""
find $argv \( -name '*cdba*' -o -name '*CDBA*' \) -type f -print >& ${FILE}.list1
find $argv \( -name '*cdba*' -o -name '*CDBA*' \) -type d -print >>& ${FILE}.list1

if (`cat ${FILE}.list1 | wc -l` > 0 ) then
   echo ""
   echo "Will RENAME the following files:"
   cat ${FILE}.list1
   echo ""
   echo "EXAMINE THE RENAME LIST FIRST.  (Edit ${FILE}.list1 if desired)."
   echo -n "   Proceed? (n) > "
   set ans = "$<"
   set ans = ($ans) #strip leading/trailing blanks
   if ( "$ans" !~ [yY]* ) goto END

   # The deepest files and directory names must be renamed first, so sort:
   sort -r -o ${FILE}.list1 ${FILE}.list1

   foreach file ( `cat ${FILE}.list1` )
      set newfile = `echo $file | sed -e 's/cdba/cdb/g' -e 's/CDBA/CDB/g'`
      unset ERRORFLAG
      if ( -e $newfile) set ERRORFLAG = 1
      if ( ! $?ERRORFLAG ) mv $file $newfile
      if ( ! $?ERRORFLAG ) echo "File renamed to: $newfile"
      if ( $?ERRORFLAG ) echo "ERROR. $newfile already exists. $file not renamed."
   end
endif


# Fix file content:
echo ""
echo "Searching for files to edit..."
echo ""
set ARGVMOD = `echo $argv | sed -e 's/cdba/cdb/g' -e 's/CDBA/CDB/g'` 
#find $ARGVMOD \( -name '*cds.lib*' -o -name '*.csh*' \) -print | \
#   egrep -v '\.log|\.LOG|/old/' | \
#   xargs egrep -l 'cdba|CDBA' > ${FILE}.list2
find $ARGVMOD -type f -print | egrep -v '\.log|\.LOG|old/|/old|orig|/WORK|\.pdf' | xargs egrep -l 'cdba/|/cdba|/CDBA|CDBA/' > ${FILE}.list2

if (`cat ${FILE}.list2 | wc -l` == 0 ) goto END

split -l 20  ${FILE}.list2 ${FILE}.list2

# Eliminate all but text or script files:
foreach split ( ${FILE}.list2?* )
   foreach file2 (`cat $split`)
      set file2txt = `file $file2 | awk '{print $NF}' | egrep -s "text|script" && echo $file2`
      if ($file2txt !~ "") then
         echo $file2 >> ${FILE}.list3
      endif
   end
end


if (`cat ${FILE}.list3 | wc -l` > 0 ) then
   echo ""
   echo "Will EDIT the following files, changing cdba/CDBA to cdb/CDB :"
   cat ${FILE}.list3
   echo ""
   echo "EXAMINE THE EDIT-FILE LIST FIRST.  (Edit ${FILE}.list3 if desired)."
   echo -n "   Proceed? (n) > "
   set ans = "$<"
   set ans = ($ans) #strip leading/trailing blanks
   if ( "$ans" !~ [yY]* ) goto END

   echo ""
   set tarfile = rename_`date +%Y%m%d.%H%M%S`.tar
   echo "Creating backup tar file before changes: $tarfile"
   tar -cf $tarfile -I ${FILE}.list3 || exit 1
   echo ""

   split -l 20  ${FILE}.list3 ${FILE}.list3

   foreach split ( ${FILE}.list3?* )
      foreach file2 (`cat $split`)
         set file2txt = `file $file2 | awk '{print $NF}' | egrep -s 'text|script' && echo $file2`
         if ($file2txt !~ "") then
            cat $file2 | sed -e 's@/cdba@/cdb@g' -e 's@cdba/@cdb/@g' -e 's@/CDBA@/CDB@g' -e 's@CDBA/@CDB/@g' > ${FILE}.tmp
            mv ${FILE}.tmp $file2
         else
            echo "ERROR. $file2 is not a 'text' file.  Not edited."
         endif
      end
   end
endif


END:
touch ${FILE}.list{1,3}  # Make sure they exist
if ( `cat ${FILE}.list{1,3} | wc -l` =~ 0 ) echo "Nothing found.  No files changed."

rm -rf ${FILE}*

