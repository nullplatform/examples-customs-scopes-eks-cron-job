SCOPE=$(np scope read --id "$SCOPE_ID" --api-key "$NP_API_KEY" --format json)

export DEPLOYMENT_ID=$(echo $SCOPE | jq ".active_deployment // empty" -r)

if [[ -n "$DEPLOYMENT_ID" ]]; then
    source $WORKING_DIRECTORY/deploy.sh
fi

