i=1
while [ $i -le 1000000 ]
do
        echo $i >> res.txt
        i=$(($i+1))
done