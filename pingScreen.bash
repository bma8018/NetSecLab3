#!/bin/bash

net= false
range= false
cha=$1
first=""
end=""
a=0

while [$a < ${#cha}];
        do
        if [[$cha[$a] == '/']]
                then first=$cha[:$a]
                net=true
                $echo " ${first}"
                end+=$cha[$a:]
                break
        fi
        if [[$cha[$a] == '-']]
                then first=$cha[:$a]
                range=true
                echo "$first"
                end+=$cha[$a:]
                break
        fi
        a = $a + 1
done

leng=32
hostmax=""
b=0

if [[ $net == true ]]
        then while [[$b < ${end}]];
        do
                hostmax += "0"
                b++
        done
        while [[$b < ${leng} ]];
        do
                hostmax += "1"
        done
fi

e1=""
e2=""
e3=""
e4=""

i=0


f1=""
f2=""
f3=""
f4=""

g=$((2#$hostmax))
i=0

while [[$i <${#first}]];
do
        if [[$first[i] =='.']]
                then
        fi
        i++
done



bit1= false
bit2= false
bit3= false
bit4= false

while[[$f1 <= $e1]];
do
        if[[$f1 == $e1]]
                then do $bit1= true
                done
        while[[$f2 <= $e2]];
        do
                if[[$f2 == $e2]]
                        then $bit2= true

                while[[$f3 <= $e3]];
                do
                        if[[$f3 == $e3]]
                                then $bit3= true

                        while[[$f4 < 255 ]]|| [!((($bit1)||($bit2)||($bit3))||($e4 == $f4))]
                                $add=[$f1+"."+$f2+"."+$f3+"."+$f4];
                                ping -c 1 $add > /dev/null
                                if [$? -eq 0];
                                        then echo $add ": host is up."
                                fi
                                $f4++
                        done
                        if [[$f4 =>255]]
                                then $f4=0
                        fi
                        $f3++
                done
                if [[$f3 =>255]]
                        then $f3=0
                fi
                $f2++
        done
        if [[$f2 =>255]]
                then $f2=0
        fi
        $f1++
done 