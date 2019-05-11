
entryPoint()
{
    clear
    echo -e "\033[97;1mITC 350-Open Source Software Project\n\n"
	echo "===================================================================="
	echo -e "             \033[94;5;1mCustomer Account Banking System        \033[0m"
	echo "===================================================================="

	echo -e "\033[31m1) Create a new customer account"
	echo -e "\033[32m2) Update account data" 
	echo -e "\033[33m3) View and manage transaction" 
	echo -e "\033[34m4) Check customer's account details"
	echo -e "\033[97m5) Delete customer's account"
	echo -e "\033[36m6) Exit\e[0m\n"
	echo "Choose an option:"
	read choice

	case $choice in
	1) addAccount ;;
	2) updateAccount ;;
	3) transaction ;;
	4) showAccount ;;
	5) deleteAccount ;;
	6) exit 1;;
	esac
}

addAccount() {

    clear
    echo "Enter Your Full Name: "
    read fName lName
    name=$fName" "$lName

    while [[ $name =~ [[:digit:]] || -z $name ]]; do
        echo "Your name must not have numerics or be left empty, Try again: "
        read name
    done
    echo ""

    echo "Enter your date of birth: "
	read dob

    while [[ $dob =~ [[:alpha:]] || -z $dob ]]; do
        echo ""
	    echo "Your birth date must not have alphabets or be left empty, Try again: "
	    read dob
    done
    echo ""

	echo "Enter your national number (tazkira or passport): "
	read nationalNum

	while [[ $nationalNum =~ [[:alpha:]] || -z $nationalNum ]]; do
        echo ""
	    echo "Your ID must not have alphabets or be left empty, Try again: "
	    read nationalNum
    done

	echo ""

	echo "Enter your email address: "
	read email

    while [[ ${email} != *"@"* || -z $email ]]; do
        echo ""
	    echo "This is not a valid email address, Try again: "
	    read email
    done
    echo ""

	echo "Enter name of your city: "
	read city

	while [[ $city =~ [[:digit:]] || -z $city ]]; do
        echo ""
        echo "Your city name must not have numerics or be left empty, Try again: "
        read city
    done
    echo ""

	echo "Enter name of your country: "
	read country

    while [[ $country =~ [[:digit:]] || -z $country ]]; do
        echo ""
        echo "Your country name must not have numerics or be left empty, Try again: "
        read country
    done

    echo ""

	echo "Enter your phone number: "
	read phoneNumber

	while [[ $phoneNumber =~ [[:alpha:]] || -z $phoneNumber ]]; do
        echo ""
	    echo "Your phone number must not have alphabets or be left empty, Try again: "
	    read phoneNumber
    done
    echo ""

	echo "Select your account type: "

	echo "1) Savings Account"
	echo "2) Current Account"
	read accountType

	case $accountType in 
	    1)	accountType="savings-account" ;;
		2)	accountType="current-account" ;;
	esac
	
	echo "Enter your initial deposit amount: "
	read initialDeposit

    while [[ $initialDeposit =~ [[:alpha:]] || -z $initialDeposit ]]; do
            echo ""
	        echo "Your initial deposit must not have alphabets or be left empty, Try again: "
	        read initialDeposit
    done

    echo "Your Information is ------------"
    echo ""
    echo -e "Name: \033[32;1m" $name
    echo -e "\033[0mDate of Birth: \033[32;1m" $dob
    echo -e "\033[0mNational Number: \033[32;1m" $nationalNum
    echo -e "\033[0mEmail Address: \033[32;1m" $email
    echo -e "\033[0mCity: \033[32;1m" $city
    echo -e "\033[0mCountry: \033[32;1m" $country
    echo -e "\033[0mPhone Number: \033[32;1m" $phoneNumber
    echo -e "\033[0mAccount Type: \033[32;1m" $accountType
    echo -e "\033[0mInitial Deposit: \033[32;1m" $initialDeposit
    echo -e "\033[0mEnd of Information-------------"

    cd ~/Desktop/
    echo ""
    echo "Is the information accurate or should we try again?"
    echo "1) It's Accurate"
    echo "2) Try Again"
    read tryAgain

    if [[ tryAgain -eq 2 ]]; then
        addAccount
    fi

    if [ ! -f ~/Desktop/example.csv ]; then
        touch ~/Desktop/example.csv
        id=10000
    else
        id=$(awk 'END {print $1}' FS="," example.csv)
    fi
    echo "$(($id+1)),$name,$dob,$nationalNum,$email,$city,$country,$phoneNumber,$accountType,$initialDeposit" >> example.csv

    echo ""
    echo "Customer Account Successfully Created\n"
    entryPoint
}

updateAccount() {

    clear
    if [ ! -f ~/Desktop/example.csv ]; then
        echo "File not found, make sure its located in Desktop, press any key to return to main menu"
        read null
        entryPoint
    fi
    echo -e "Enter your Account ID: "
	read accID

    cd ~/Desktop/

    while [[ -z $(awk -v awkID=$accID '{ if ($1 == awkID) print $1 }' FS="," example.csv) ]]; do

        echo -e "\nAccount ID not found, Please try again: "
        read accID
    done

	echo -e "\033[32;1m1) Name"
	echo "2) Date of birth"
	echo "3) National number"
	echo "4) Email"
	echo "5) City name"
	echo "6) Country name"
	echo "7) Phone number"
	echo "8) Account type"
	echo -e "9) Your Balance\033[0m"
    echo -e "\nWhat would you like to change? "
    read updateChoice

    case $updateChoice in

    1)
        echo ""
		echo "Enter new name: "
		read newName

        while [[ $newName =~ [[:digit:]] || -z $newName ]]; do
            echo "Your name must not have numerics or be left empty, Try again: "
            read newName
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newName '{ if ($1 == awkID) $2=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
	;;

    2)
        echo ""
		echo "Enter new DOB: "
		read newDOB

        while [[ $newDOB =~ [[:alpha:]] || -z $newDOB ]]; do
            echo ""
	        echo "Your birth date must not have alphabets or be left empty, Try again: "
	        read newDOB
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newDOB '{ if ($1 == awkID) $3=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    3)
        echo ""
        echo "Enter new national number (tazkira or passport): "
	    read newNationalNum

	    while [[ $newNationalNum =~ [[:alpha:]] || -z $newNationalNum ]]; do
            echo ""
	        echo "Your ID must not have alphabets or be left empty, Try again: "
	        read newNationalNum
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newNationalNum '{ if ($1 == awkID) $4=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    4)
        echo ""
        echo "Enter new email address: "
	    read newEmail

        while [[ ${newEmail} != *"@"* || -z $newEmail ]]; do
            echo ""
	        echo "This is not a valid email address, Try again: "
	        read newEmail
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newEmail '{ if ($1 == awkID) $5=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    5)
        echo ""
        echo "Enter your updated city name: "
	    read newCity

	    while [[ $newCity =~ [[:digit:]] || -z $newCity ]]; do
            echo ""
            echo "Your city name must not have numerics or be left empty, Try again: "
            read newCity
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newCity '{ if ($1 == awkID) $6=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    6)
        echo ""
        echo "Enter your updated country name: "
	    read newCountry

        while [[ $newCountry =~ [[:digit:]] || -z $newCountry ]]; do
            echo ""
            echo "Your country name must not have numerics or be left empty, Try again: "
            read newCountry
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newCountry '{ if ($1 == awkID) $7=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    7)
        echo ""
        echo "Enter new phone number: "
	    read newPhoneNumber

	    while [[ $newPhoneNumber =~ [[:alpha:]] || -z $newPhoneNumber ]]; do
            echo ""
	        echo "Your phone number must not have alphabets or be left empty, Try again: "
	        read newPhoneNumber
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newPhoneNumber '{ if ($1 == awkID) $8=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    8)
        echo ""
        echo "Select new account type: "
	    echo "1) Savings Account"
	    echo "2) Current Account"
	    read newAccountType

	    case $newAccountType in 
	        1)	newAccountType="savings-account" ;;
		    2)	newAccountType="current-account" ;;
	    esac

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newAccountType '{ if ($1 == awkID) $9=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;

    9)
        echo ""
        echo "Enter your new deposit amount: "
	    read newInitialDeposit

        while [[ $newInitialDeposit =~ [[:alpha:]] || -z $newInitialDeposit ]]; do
            echo ""
	        echo "Your deposit amount must not have alphabets or be left empty, Try again: "
	        read newInitialDeposit
        done

        cd ~/Desktop/
        awk -v awkID=$accID -v awkData=$newInitialDeposit '{ if ($1 == awkID) $10=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
        echo ""
    ;;
    esac
    
    clear
    echo ""
    echo -e "\n\033[32;1Account Successfully Updated"
    echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
    read null
    entryPoint
}

transaction() {

    clear
    if [ ! -f ~/Desktop/example.csv ]; then
        echo "File not found, make sure its located in Desktop, press any key to return to main menu"
        read null
        entryPoint
    fi
    echo -e "Enter your Account ID: "
	read accID

    cd ~/Desktop/

    while [[ -z $(awk -v awkID=$accID '{ if ($1 == awkID) print $1 }' FS="," example.csv) ]]; do

        echo -e "\nAccount ID not found, Please try again: "
        read accID
    done

	echo -e "\n\033[32;1m1) Deposit"
	echo -e "2) Withdraw"
	echo -e "3) Show Balance\033[0m\n"
	read transactionChoice

    case $transactionChoice in

	1) 	
		echo -e "Enter deposit amount:"
		read amount
		balance=$(awk -v awkID=$accID '{ if ($1 == awkID) print $10}' FS="," example.csv)
		updatedBalance=$(($balance+$amount))
		awk -v awkID=$accID -v awkData=$updatedBalance '{ if ($1 == awkID) $10=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
	;;

	2) 
		echo -e "Enter the amount to withdraw:"
		read amount
		balance=$(awk -v awkID=$accID '{ if ($1 == awkID) print $10}' FS="," example.csv)
		updatedBalance=$(($balance-$amount))
		awk -v awkID=$accID -v awkData=$updatedBalance '{ if ($1 == awkID) $10=awkData; print $0 > "example.csv" }' OFS="," FS="," example.csv
	;;
	3)	
		awk -v awkID=$accID '{ if ($1 == awkID) print "You Current Balance is: " $10 }' FS="," example.csv
        echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
        read null
        entryPoint
	;;
	esac

    clear
    echo ""
    echo -e "\n\033[32;1 Transaction Successful"
    awk -v awkID=$accID '{ if ($1 == awkID) print "You Current Balance is: " $10 }' FS="," example.csv    
    echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
    read null
    entryPoint
}

showAccount() {

    clear
    if [ ! -f ~/Desktop/example.csv ]; then
        echo "File not found, make sure its located in Desktop, press any key to return to main menu"
        read null
        entryPoint
    fi
    echo -e "Enter your Account ID: "
	read accID

    cd ~/Desktop/

    while [[ -z $(awk -v awkID=$accID '{ if ($1 == awkID) print $1 }' FS="," example.csv) ]]; do

        echo -e "\nAccount ID not found, Please try again: "
        read accID
    done

    echo -e "\033[94;1mAccount Information------------------------\033[0m"
    awk -v awkID=$accID '{ if ($1 == awkID) print "Name: " $2}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Date of Birth: " $3}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "National Number: " $4}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Email: " $5}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "City name: " $6}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Country name: " $7}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Phone number: " $8}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Account type: " $9}' FS="," example.csv
    awk -v awkID=$accID '{ if ($1 == awkID) print "Balance: " $10}' FS="," example.csv

    echo -e "\n"
    echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
    read null
    entryPoint
}

deleteAccount() {

    clear
    if [ ! -f ~/Desktop/example.csv ]; then
        echo "File not found, make sure its located in Desktop, press any key to return to main menu"
        read null
        entryPoint
    fi
    echo -e "Enter your Account ID: "
	read accID

    cd ~/Desktop/

    while [[ -z $(awk -v awkID=$accID '{ if ($1 == awkID) print $1 }' FS="," example.csv) ]]; do

        echo -e "\nAccount ID not found, Please try again: "
        read accID
    done
    echo "Are you sure you want to delete this account?"
    echo "1) Yes"
    echo "2) No"
    read deleteChoice

    case $deleteChoice in

    1) 
        awk -v awkID=$accID '{ if ($1 != awkID) print $0 > "example.csv" }' OFS="," FS="," example.csv
    ;;

    2)
        echo -e "\n"
        echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
        read null
        entryPoint
    ;;
    esac
    echo -e "\n"
    echo -e "\033[94;5;1mHit return to go back to main menu\033[0m"
    read null
    entryPoint
}

entryPoint