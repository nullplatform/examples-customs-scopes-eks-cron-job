SCOPE=$(np scope read --id "$SCOPE_ID" --api-key "$NP_API_KEY" --format json)

export SCOPE_NAME=$(echo $SCOPE | jq .slug -r)
export APPLICATION_ID=$(echo $SCOPE | jq .application_id -r)
export ASSET_NAME=$(echo $SCOPE | jq .asset_name -r)

APPLICATION=$(np application read --id "$APPLICATION_ID" --api-key "$NP_API_KEY" --format json)
export APPLICATION_NAME=$(echo $APPLICATION | jq .slug -r)
export NAMESPACE_ID=$(echo $APPLICATION | jq .namespace_id -r)

NAMESPACE=$(np namespace read --id "$NAMESPACE_ID" --api-key "$NP_API_KEY" --format json)
export NAMESPACE_NAME=$(echo $NAMESPACE | jq .slug -r)
export ACCOUNT_ID=$(echo $NAMESPACE | jq .account_id -r)

ACCOUNT=$(np account read --id "$ACCOUNT_ID" --api-key "$NP_API_KEY" --format json)
export ACCOUNT_NAME=$(echo $ACCOUNT | jq .slug -r)

DEPLOYMENT=$(np deployment read --id "$DEPLOYMENT_ID" --api-key "$NP_API_KEY" --format json)

export RELEASE_ID=$(echo $DEPLOYMENT | jq .release_id -r)

RELEASE=$(np release read --id "$RELEASE_ID" --api-key "$NP_API_KEY" --format json)

export BUILD_ID=$(echo $RELEASE | jq .build_id -r)
export SEMVER=$(echo $RELEASE | jq .semver -r)

ASSETS=$(np asset list --build-id "$BUILD_ID" --name "$ASSET_NAME" --api-key "$NP_API_KEY" --format json)

export IMAGE=$(echo $ASSETS | jq ".results[0].url" -r)

gomplate -f $WORKING_DIRECTORY/template.yaml > $WORKING_DIRECTORY/cron.yaml