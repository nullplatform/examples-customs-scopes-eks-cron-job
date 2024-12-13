source $WORKING_DIRECTORY/build_context.sh
source $WORKING_DIRECTORY/config_cluster.sh

cat $WORKING_DIRECTORY/cron.yaml

kubectl delete -f $WORKING_DIRECTORY/cron.yaml