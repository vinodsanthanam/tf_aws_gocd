
firsttime_setup:
	pip install awscli oktaauth aws_role_credentials

# Set up the following environment variables before using the  make file
# export OKTA_USER_NAME=xxxx@thoughtworks.com
# export AWS_APP_ID=xxxxx12312xxxxx12312
okta_auth:
	oktaauth --username ${OKTA_USER_NAME} --server thoughtworks.okta.com --apptype amazon_aws --appid ${AWS_APP_ID} | aws_role_credentials saml --profile beach --region us-east-2 > /dev/null 2>&1

generate_keys: okta_auth
	mkdir -p ansible/keys
	"yes" | ssh-keygen -f ./ansible/keys/ssh_key -q -P "test"
	chmod 0600 ./ansible/keys/*.*

infra_plan: okta_auth
	terraform plan

infra_apply: okta_auth
	terraform apply

setup_ssh:
	eval `ssh-agent`
	ssh-add ansible/keys/ssh_key

ssh_into_the_instance:
	ssh -i ansible/keys/ssh_key ec2-user@3.130.1.216

kill_all_ssh_agents:
	ps aux | grep 'ssh-agent' | awk '{print $2}' | xargs kill -9

taint_instance:
	terraform taint -module="instanceModule" aws_instance.instance