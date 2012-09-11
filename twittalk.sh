#!/bin/bash
twitterer="Joey7Barton"

get () {
	twitterer="Joey7Barton"
	rm -rf $twitterer
	mkdir $twitterer; cd $twitterer
	wget http://mobile.twitter.com/$twitterer
	grep "<a name=\"tweet" $twitterer > times.txt
	grep "p=s" $twitterer > poster.txt
	grep "class=\"tweet-text\"" $twitterer > tweet.txt
	cd ..
}

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

#Clean poster.txt
contentcount=$(grep -c "<a href=" "$twitterer/poster.txt")
echo $contentcount
i=$contentcount
while [ "$i" != "0" ]; do
	content=$(awk -v line=$i 'NR==line{print;exit}' $twitterer/poster.txt)
	searchstring="\"/"
	#search for strings index postion
	srchpos1=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	#update content 1000 characters
	content=${content:srchpos1}
	#new search string
	searchstring='?p=s">'
	#second postion the end of the title
	srchpos2=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	content=${content:1:srchpos2-2}
	echo $content >> $twitterer/poster2.txt
	i=$[i-1]
done

#Clean tweet.txt
contentcount=$(grep -c "<div class" "$twitterer/tweet.txt")
echo $contentcount
i=$contentcount
while [ "$i" != "0" ]; do
	content=$(awk -v line=$i 'NR==line{print;exit}' $twitterer/tweet.txt)
	searchstring="tweet-text\">"
	#search for strings index postion
	srchpos1=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	#update content 1000 characters
	content=${content:srchpos1+10}
	#new search string
	searchstring='</div>'
	#second postion the end of the title
	srchpos2=$(awk -v a="$content" -v b="$searchstring" 'BEGIN{print index(a,b)}')
	content=${content:1:srchpos2-2}
	echo $content >> $twitterer/tweet2.txt
	i=$[i-1]
done



