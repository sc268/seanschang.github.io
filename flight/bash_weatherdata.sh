a=dat
b=results
mkdir -p $b
(cd $a && find . -type f -name '*.csv') |
while read file
do   
	#echo ${file:(2) i.e. remove file path "./"
	#grep  '(ATL|IAH|JFK|LAX|ORD)' "b/tmp.csv" | grep -E  "(ATL|IAH|JFK|LAX|ORD)"  > "$b/LAX_${file: (2)}"
	cut -d, -f5-7,10,11,15,25,32-34,43-45,51-55,57,59-63 "$a/$file" > "$b/tmp.csv"
	grep 'ATL' "$b/tmp.csv" | grep -E "(IAH|JFK|LAX|ORD)" > "$b/ATL_${file: (2)}"
	grep 'IAH' "$b/tmp.csv"| grep -E     "(JFK|LAX|ORD)"  > "$b/IAH_${file: (2)}"
	grep 'JFK' "$b/tmp.csv" | grep -E         "(LAX|ORD)" > "$b/JFK_${file: (2)}"
	grep 'LAX' "$b/tmp.csv" | grep -E             "(ORD)" > "$b/ORD_${file: (2)}"
	rm "$b/tmp.csv"
	echo  "$file is finished."
done


#merge all files
cat header_new.txt $b/*.csv > topairports.csv
echo  "merged all files, added header to the csv file"
 

#add header

#head -n 1 $a/On_Time_On_Time_Performance_2013_1.csv > header.txt
#head -n 1 $a/On_Time_On_Time_Performance_2005_1.csv > header.txt
#echo  "header created"



rm $b -r 
#rm topairports.csv
echo "removed unnecessary files"

