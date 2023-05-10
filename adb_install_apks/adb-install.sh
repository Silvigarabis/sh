#!/system/bin/sh
# for Android, run with root or adb
SESSION=`pm install-create -d -r`
ID=`echo ${SESSION}|sed 's/.*\[\([0-9]*\)\]/\1/'`
for f in *.apk
do
  pm install-write "${ID}" "${f}" "${f}"
done
pm install-commit "${ID}"
