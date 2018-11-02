#!/bin/bash

#CREATED BY SAADAT RIVI (https://github.com/SaadatRizvi)
touch ~/.aws/creds.current.vals
chmod 777 ~/.aws/creds.current.vals 
sed -i -e "s/\[qa\]/\[qa2\]/" ~/.aws/credentials
sed -i -e "s/\[qa1\]/\[qa\]/" ~/.aws/credentials


aws sts get-session-token --serial-number "arn:aws:iam::{aws_account_ID}:mfa/{IAM_user_name}" --profile qa--output text --token-code "$1"|awk  '{print "\naws_access_key_id=\""$2"\"" "\naws_secret_access_key=\""$4"\""  "\naws_session_token=\""$5"\""  }'  2>&1 | tee  ~/.aws/creds.current.vals

sed -i -e "s/\[qa\]/\[qa1\]/" ~/.aws/credentials
sed -i -e "s/\[qa2\]/\[qa\]/" ~/.aws/credentials

source ~/.aws/creds.current.vals 
printf "\n"

sed -i -e "s/aws_access_key_id/aws_access_key_id1/g" ~/.aws/credentials
sed -i -e "s/aws_secret_access_key/aws_secret_access_key1/g" ~/.aws/credentials
sed -i -e "s/aws_session_token/aws_session_token1/g" ~/.aws/credentials


for i in {1..2}
do
	sed -i '0,/aws_access_key_id1/s/.*aws_access_key_id1.*/aws_access_key_id = {aws_access_key_id}/' ~/.aws/credentials
	sed -i '0,/aws_secret_access_key1/s/.*aws_secret_access_key1.*/aws_secret_access_key = {aws_secret_access_key}/' ~/.aws/credentials
	sed -i '0,/aws_session_token1/s/.*aws_session_token1.*/aws_session_token = {aws_session_token}/' ~/.aws/credentials
done


	sed -i -e "s/{aws_access_key_id}/$(echo $aws_access_key_id | sed -e 's/[]\/$*.^[]/\\&/g')/g" ~/.aws/credentials
	sed -i -e "s/{aws_secret_access_key}/$(echo $aws_secret_access_key | sed -e 's/[]\/$*.^[]/\\&/g')/g" ~/.aws/credentials
	sed -i -e "s/{aws_session_token}/$(echo $aws_session_token | sed -e 's/[]\/$*.^[]/\\&/g')/g" ~/.aws/credentials


sed -i -e "s/aws_access_key_id1/aws_access_key_id/g" ~/.aws/credentials
sed -i -e "s/aws_secret_access_key1/aws_secret_access_key/g" ~/.aws/credentials
sed -i -e "s/aws_session_token1/aws_session_token/g" ~/.aws/credentials


rm ~/.aws/creds.current.vals

