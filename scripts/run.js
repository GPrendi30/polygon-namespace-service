
const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy("wknd");
    await domainContract.deployed();
    console.log("Contract deployed at: ", domainContract.address);
    console.log("Contract owner: ", owner.address);


    const txn = await domainContract.register("dormant", {value: hre.ethers.utils.parseEther("0.1")});
    await txn.wait();

    const domainOwner = await domainContract.getAddress("dormant");
    console.log("Owner of domain:", domainOwner);

    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log("Balance of domain contract:", hre.ethers.utils.formatEther(balance));
}

const runMain = async () => {
    try {
        await main();
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
};

runMain();