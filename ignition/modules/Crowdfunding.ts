import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const CrowdfundingModule = buildModule("CrowdfundingModule", (m) => {
  
  const crowdfunding = m.contract("Crowdfunding");

  return { crowdfunding };
});

export default CrowdfundingModule;

/**
 * CrowdfundingModule#Crowdfunding - 0x95cA45Cd3969E89054F21F17D753cB1317dcBF83
 *  - https://sepolia-blockscout.lisk.com//address/0x95cA45Cd3969E89054F21F17D753cB1317dcBF83#code
 */