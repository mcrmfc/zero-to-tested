host=`cat terraform.tfstate | python -c 'import sys, json; print json.load(sys.stdin)["modules"][0]["resources"]["aws_instance.jenkins"]["primary"]["attributes"]["public_dns"]'`
echo http://$host:8080

