const hre = require("hardhat");
async function main() {
  const Registration = await hre.ethers.getContractFactory("Registration");
  const registration = await Registration.deploy();

  await registration.deployed();
  console.log(
    `Registration deployed to ${registration.address}`
  );
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
