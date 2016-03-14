a=weather_raw
b=results
mkdir -p $b

#add header
sed -n '6p' $a/DFW.txt > $b/header
echo  "header created"


(cd $a && find . -type f -name '*.txt') |
while read file
do   
	#echo ${file:(2)
	tail --lines=+7  "$a/$file" > "$b/$file"
	echo  "$file is finished."
done


#merge all files
cat $b/*.txt > all_weather
echo  "merged all files "

#add header
cat  $b/header all_weather > all_weather.csv 
echo  "added header to the csv file"

#remove seperated files
rm results -r 
rm all_weather
echo  "removed unnecessary files"
