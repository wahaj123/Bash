#!/bin/bash
curl -sL https://www.mcdelivery.com.pk/pk/browse/menu.html | grep -o '<li class="secondary-menu-item ">.*</li>' | sed 's/href=/\nhref=/g' | \
grep 'href=\"' | \
sed 's/.*href="//g;s/".*//g' > URL.txt
sed -i 's/amp;//' URL.txt

curl -sL https://www.mcdelivery.com.pk/pk/browse/menu.html | grep -o '<li class="secondary-menu-item ">.*</li>' | sed 's/<[^>]\+>//g' > deals.txt

ARRAY=()
while read -r LINE
do
    ARRAY+=("$LINE")
done < URL.txt

deals=()
while read -r main
do
    deals+=("$main")
done < deals.txt
i= 0

for LINE in "${ARRAY[@]}"
do    
    echo $LINE
    echo ${deals[$i]}
    i=$(( $i + 1));
    touch ${deals[$i]}.txt
    curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep -o '<h5 class="product-title">.*</h5>' | sed 's/<[^>]\+>//g' >> name.txt
    curl https://www.mcdelivery.com.pk/pk/browse/menu.html"$LINE" | grep -o '<span class="starting-price">.*</span>' | sed 's/<[^>]\+>//g' >> price.txt 
    #   for LINE in $(nl name.txt |awk '{ print $1 }'); do
    #   echo "Name: ($(sed -n "${LINE}p" name.txt) \n Price $(sed -n "${LINE}p" price.txt))"
    #   echo -en '\n'
    #   done 
    for LINE in $(nl name.txt |awk '{ print $1 }'); do
    echo -e "$LINE- name: $(sed -n "${LINE}p" name.txt)\n   Price: $(sed -n "${LINE}p" price.txt)\n"
    done >> "${deals[$i]}".txt
done

  

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