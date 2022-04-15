# The output directory
DIR="records"

# if there's no dir called "records"
if [[ ! -d "$DIR" ]]; then
  printf "Making the records dir"
  mkdir "$DIR" 
fi

while IFS="," read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11
  do  
    # cd inside records
    cd "$DIR" 
    # if there's no dir called '$col2' inside Records
    if [[ ! -d "$col2" ]] 
    then
        mkdir "$col2" # create a dir "$col2"
    fi
    
    # cd inside "$col2"
    cd "$col2"

    # create a file and write into it:
    touch "$col4.txt"
    file="$col4.txt"
    dlrSym="$ "

    printf "Card Type Code : $col1 \n" >> $file
    printf "Card Type Full Name: $col2 \n" >> $file
    printf "Issuing Bank: $col3 \n" >> $file
    printf "Card Number: $col4 \n" >> $file
    printf "Card Holder's Name : $col5 \n" >> $file
    printf "CVV/CVV2: $col6 \n" >> $file
    printf "Issue Date: $col7 \n" >> $file
    printf "Expiry Date: $col8 \n" >> $file
    printf "Billing Date : $col9 \n" >> $file
    printf "Card PIN: $col10 \n" >> $file
    printf "Credit Limit: $ $col11 USD \n" >> $file

    # decide the name for the file, and rename $file
    DATE_BIN=$(command -v date)
    DATE=`${DATE_BIN} +%m/%y`

    if [[ "$DATE" < "$col8" ]]; then mv "$file" "$col4.active"
    else mv "$file" "$col4.expired"
    fi

    cd ..  # exit from the dir $col2

  cd .. # exit from the dir Records
  done < <(tail -n +2 cc_records.csv)

