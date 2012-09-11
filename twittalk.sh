#!/bin/bash

twitterer="Joey7Barton"
#rm -rf $twitterer
#mkdir $twitterer; cd $twitterer
#wget http://mobile.twitter.com/$twitterer
#grep "<a name=\"tweet" $twitterer > times.txt
#grep "p=s" $twitterer > poster.txt
#grep "class=\"tweet-text\"" $twitterer > tweet.txt
#cd ..


#Clean times.txt
contentcount=$(grep -c "<a name=\"tweet" "$twitterer/times.txt")
echo $contentcount
#exit
i=$contentcount
while [ "$i" != "0" ]; do
	content=$(awk -v line=$i 'NR==line{print;exit}' $twitterer/times.txt)
	searchstring="?p=p\">"
	#search for strings index postion
	srchpos1=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	#update content 1000 characters
	content=${content:srchpos1+4}
	#new search string
	searchstring='</a>'
	#second postion the end of the title
	srchpos2=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	content=${content:1:srchpos2-2}
	echo $content >> $twitterer/times2.txt
	i=$[i-1]
done



