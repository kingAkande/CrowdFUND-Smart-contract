// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Crowdfunding {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }


    struct Campaign {
        string title;
        string description;
        address payable benefactor;
        uint256 goal;
        uint256 deadline;
        uint256 amountRaised;
    }

    Campaign[] public campaigns;

    //  events


    event CampaignCreated( uint256 campaignId, string title, address benefactor,uint256 goal, uint256 deadline);
    event DonationReceived(uint256 campaignId, address donor, uint256 amount);
    event CampaignEnded(uint256 campaignId, address benefactor, uint256 amount);

    // fuction to create Campaign


    function createCampaign(string memory _title,string memory _description,address payable _benefactor, uint256 _goal, uint256 _duration ) public {
       
        uint256 deadline = block.timestamp + _duration;

        campaigns.push(  Campaign(_title, _description, _benefactor, _goal, deadline, 0));
           
        emit CampaignCreated( campaigns.length - 1,_title, _benefactor, _goal, deadline);
        
    }

    // function to donate to Campaign

    function donateToCampaign(uint256 _campaignId) public payable {

        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp < campaign.deadline, "Campaign has ended");

        campaign.amountRaised += msg.value;

        emit DonationReceived(_campaignId, msg.sender, msg.value);
    }

    // function to end Campaign

    function endCampaign(uint256 _campaignId) public {

        Campaign storage campaign = campaigns[_campaignId];

        require(  block.timestamp >= campaign.deadline, "Campaign is still ongoing" ); 

        require(campaign.amountRaised > 0, "No funds raised");

        uint256 amount = campaign.amountRaised;

        campaign.amountRaised = 0;

        campaign.benefactor.transfer(amount);

        emit CampaignEnded(_campaignId, campaign.benefactor, amount);
    }

// function to withdraw left over fund from the contract by the owner only

      function withdrawLeftoverFunds() public onlyOwner {

        payable(owner).transfer(address(this).balance);

    }
}
