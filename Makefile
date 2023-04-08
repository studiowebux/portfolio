deploy:
	ansible-playbook -l portfolio, ansible/deploy.yml

local:
	http-server