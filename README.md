# 🗳️ Referral-Based Voting Power

## 🔥 Overview
**Referral-Based Voting Power** is a smart contract that enhances voting influence through referrals. Users who vote can increase their voting power by being referred by someone who already has voting power. This incentivizes engagement and community-driven decision-making.

## 📜 Smart Contract Address  
`0x98A5dD1fFf698a0497060966928FCd62108caE47`

## ✨ Features
- **Vote Once**: Each user can vote only once.  
- **Referral Boost**: A voter’s power increases by **50% of their referrer’s power**.  
- **Transparent & Fair**: Every vote is recorded on-chain.  

## 🚀 How It Works
1. A user calls `vote(address _referrer)`.  
2. If a referrer is provided and has voting power, the new voter gains a **50% boost** based on the referrer’s power.  
3. Voting power is stored and can be retrieved via `getVotePower(address user)`.  

## 🔧 Smart Contract Code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReferralVoting {
    mapping(address => uint256) public votes;
    mapping(address => address) public referrer;
    mapping(address => bool) public hasVoted;

    function vote(address _referrer) public {
        require(!hasVoted[msg.sender], "You have already voted.");

        uint256 votingPower = 1;

        if (_referrer != address(0) && votes[_referrer] > 0 && referrer[msg.sender] == address(0)) {
            referrer[msg.sender] = _referrer;
            votingPower += votes[_referrer] / 2;
        }

        votes[msg.sender] = votingPower;
        hasVoted[msg.sender] = true;
    }

    function getVotePower(address user) public view returns (uint256) {
        return votes[user];
    }
}
