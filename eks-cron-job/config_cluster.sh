aws eks update-kubeconfig --region us-east-1 --name developent

kubectl config set-cluster arn:aws:eks:us-east-1:688720756067:cluster/developent

kubectl config use-context arn:aws:eks:us-east-1:688720756067:cluster/developent