module.exports = ({ core }) => {
    const buildWorkingDirectory = (context) => {
        const { notification: { service } } = context;

        return `${service.specification.slug}`;
    }

    const buildScriptPath = (context) => {
        const { notification: { specification: action } } = context;

        const workingDirectory = buildWorkingDirectory(context);

        return `${workingDirectory}/${action.slug}.sh`;
    }

    const { NP_ACTION_CONTEXT } = process.env;
    const context = JSON.parse(NP_ACTION_CONTEXT);
    const { notification: { id: actionId, type: actionType, service, link, parameters } } = context;
    const serviceId = service ? service.id : '';
    const linkId = link ? link.id : '';

    if (linkId) {
        core.exportVariable('LINK_ID', linkId);
    }

    if (serviceId) {
        core.exportVariable('SERVICE_ID', serviceId);
    }

    for (let [key, value] of Object.entries(parameters)) {
        console.log(`Exporting ${key.toUpperCase()}: ${value}`)
        core.exportVariable(key.toUpperCase(), value);
    }

    for (let [key, value] of Object.entries(service.attributes)) {
        console.log(`Exporting ${key.toUpperCase()}: ${value}`)
        core.exportVariable(key.toUpperCase(), value);
    }

    console.log(`Exporting DIMENSIONS: ${JSON.stringify(service.dimensions)}`)
    core.exportVariable('DIMENSIONS', JSON.stringify(service.dimensions))
    core.exportVariable('SCRIPT_PATH', buildScriptPath(context));
    core.exportVariable('WORKING_DIRECTORY', buildWorkingDirectory(context));
    core.exportVariable('ACTION_TYPE', actionType);
    core.exportVariable('ACTION_ID', actionId);
};
