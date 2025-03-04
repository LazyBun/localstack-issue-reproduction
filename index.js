exports.handler = async (event) => {
    console.log(`Processing job ${event.job}`);
    return { status: "completed", job: event.job };
};
