#!/bin/bash
# Automate gpg tasks

clear

# List public keys
listKey()
{
gpg --list-keys
}


# Generate pair of keys
generate()
{
gpg --full-generate-key
}


# Export key
exportKey()
{
read -p 'Email: ' email
gpg --armor --export $email > $email.pubkey.asc
}


# Add someone's public key
addKey()
{
ls -l
read -e -p 'File: ' file
gpg --import $file
}


# Edit public Key
editKey()
{
gpg --list-key | grep uid
#read -p "Key id: " key
#gpg --edit-key $key
}


# Sign message
sign()
{
ls -l
read -e -p "File: " file
gpg --clear-sign --armor $file
}


# Check signature
check()
{
ls -l
read -e -p "File: " file
gpg --verify $file
}


# Crypt message
crypt()
{
ls -l
read -e -p 'File: ' file
read -p 'Receiver: ' receiver
gpg --encrypt --sign --armor -r $receiver $file
}


# Decrypt message
decrypt()
{
ls -l
read -e -p 'File: ' file
gpg --decrypt $file
}


echo "========================================"
echo "= AUTOMATE GPG BY MARTINOU             ="
echo "=                                      ="
echo "= [0] Generate pair of keys            ="
echo "= [1] List keys                        ="
echo "= [2] Export key                       ="
echo "= [3] Add public key                   ="
echo "= [4] Edit public key                  ="
echo "= [5] Check signature                  ="
echo "= [6] Decrypt message                  ="
echo "= [7] Crypt+Sign message               ="
echo "= [8] Clear sign message               ="
echo "=                                      ="
echo "= Press Q to quit                      ="
echo "========================================"
echo ""

read -p 'Choose: ' number


case $number in

  q)
    exit
    ;;
  Q)
    exit
    ;;
  0)
    generate
    ;;
  1)
    listKey
    ;;
  2)
    exportKey
    ;;
  3)
    addKey
    ;;
  4)
    editKey
    ;;
  5)
    check
    ;;
  6)
    decrypt
    ;;
  7)
    crypt
    ;;
  8)
    sign
    ;;
esac
