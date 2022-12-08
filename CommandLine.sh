echo 'Question 1'
echo ' '
echo 'The location with the maximum number of purchases is:' 


#cut the column of interest, sort in alphabetical order and count the occurrences for each location, then retrieve the first row
 
cut -d, -f5 bank_transactions.csv | sort | uniq -c | sort -nr | awk 'FNR==1 {print $2}'

echo ' '
echo 'Question 2'
echo ' '
echo 'The total amount of transactions for male and female customers respectively is:'


#sum the transaction amount of males and females to observe who spent more

awk -F, '{a[$4]+=$9}END{for(i in a) print i,a[i]}' bank_transactions.csv | awk 'NR >=3 && NR<=4 {print}'

echo ' '
echo 'Question 3'
echo ' '
echo 'The customer with the highest average transaction amount is:'



#cut the columns of interest and compute the customer ID count and the sum of transactions

cut -d, -f2 bank_transactions.csv | sort | uniq -c > counter.csv

awk -F, '{a[$2]+=$9}END{for(i in a) print i, a[i]}' bank_transactions.csv | sort  > sum.csv

join -1 2 -2 1 counter.csv sum.csv > join.csv #join the two created files

awk '{print $1}' join.csv > result1.csv 

awk '{printf("%3.f\n", $3/$2);}' join.csv > result2.csv #compute the average

paste result1.csv result2.csv | sort -h -r -k2 | awk 'FNR==1 {print $1}' #return the ID of the customer with greater average amount
