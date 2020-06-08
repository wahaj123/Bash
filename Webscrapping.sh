#!/bin/bash
curl -sL https://www.mcdelivery.com.pk/pk/browse/menu.html | grep -o '<li class="secondary-menu-item ">.*</li>' | sed 's/href=/\nhref=/g' | \
grep 'href=\"' | \
sed 's/.*href="//g;s/".*//g' > URL.txt
sed -i 's/amp;//' URL.txt

ARRAY=()
while read -r LINE
do
    ARRAY+=("$LINE")
done < URL.txt

for LINE in "${ARRAY[@]}"
do    
    echo $LINE
    var = $(curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep '<span>.*</span>' | sed 's/<[^>]\+>//g')
    curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" > $var.txt
    #  var ="$(curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep '<span>.*</span>' | sed 's/<[^>]\+>//g')" >> 1234.txt
    #  echo $var
     curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep -o '<h5 class="product-title">.*</h5>' | sed 's/<[^>]\+>//g' >> name.txt
     curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep -o '<span class="starting-price">.*</span>' | sed 's/<[^>]\+>//g' >> price.txt 
done
for LINE in $(nl name.txt |awk '{ print $1 }'); do
  echo "($(sed -n "${LINE}p" name.txt), $(sed -n "${LINE}p" price.txt))"
  echo -en '\n'
done >> deals.txt  
#paste -d , name.txt price.txt > price+name.txt
#class="secondary-menu-item-target"

# URL= "https://www.mcdelivery.com.pk/pk/browse/menu.html"
# arr=(); 
# while read -r line; 
# do arr+=(${URL}${line}) ; 
# done < text1.txt; echo -e ${arr[@]}
# subscripting
# echo ${ARRAY[0]}
# echo ${ARRAY[1]}
# echo ${ARRAY[2]}

# looping
# for LINE in "${ARRAY[@]}"
# do
#  echo ${ARRAY[@]}
# done

# t="10"
# I="/home/wahaj/Downloads/text.txt"
# url="https://www.mcdelivery.com.pk/pk/browse/menu.html"
# while IFS= read -r line
# do
#         url="$url $line"
#         echo $url
# done <<<"$(-${t} ${I})"