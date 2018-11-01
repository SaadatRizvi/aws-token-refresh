# aws-token-refresh utility

A small command line utility script that automates the process of refreshing your aws-cli account credentials.

### Prerequisites

- Linux (preferably Ubuntu)
- `sed` command line tool
- aws-cli 
- AWS Credentials Setup ( ~/.aws/credentials and  ~/.aws/config)

####Example Setup
#####~/.aws/credentials
```$xslt
[default]
region = eu-west-1
[qa]
region = eu-west-1
[prod]
region = eu-west-1
[prodcli]
region = eu-west-1
```




#####~/.aws/config
```$xslt
[default]
aws_access_key_id = 123GENERATRED 
aws_secret_access_key = 123123GENERATRED 
aws_session_token = 12321231GENERATRED 

[qa]
aws_access_key_id = 123GENERATRED  
aws_secret_access_key = 123123GENERATRED  
aws_session_token = 12321231GENERATRED 

[qa1]
aws_access_key_id = YOUR_CLI_CREDENTIALS
aws_secret_access_key = YOUR_CLI_CREDENTIALS

[prod]
aws_access_key_id = YOUR_CLI_CREDENTIALS
aws_secret_access_key = YOUR_CLI_CREDENTIALS

[default1]
aws_access_key_id = 123GENERATRED  
aws_secret_access_key = 123123GENERATRED  
aws_session_token = 12321231GENERATRED 

```

## Getting Started

To run the script:

1) Make it executable 
`chmod u+x aws-session-refresh.sh`

2) Replace `{aws_account_ID}` and `{IAM_user_name}` in the script with your account's values

3) Run the script and provide your qa-cli mfa-token as a command line arguement
`./aws-session-refresh.sh {mfa-token}`

*Voila! Your token has been updated*

## Note

- This is still experimental so use it with your own risk
- This script works for profile qa with the above mentioned AWS Credentials Setup. (Nevertheless, this script can be modified for use with other profiles)
- In `~/.aws/config`, `[qa1]` contains your account credentials whereas `[qa]` contains the temporarily generated tokens. This is done to accomodate terraform.
- The script updates values inside `[qa]` and `[default]` 
- This script can be added as a function in `~/.bashrc` so that it can be easily accessed from the terminal.

