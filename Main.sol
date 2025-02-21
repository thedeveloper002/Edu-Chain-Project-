// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReferralVoting {
    mapping(address => uint256) public votes; // Tracks voting power
    mapping(address => address) public referrer; // Tracks who referred whom
    mapping(address => bool) public hasVoted; // Tracks if a user has voted

    function vote(address _referrer) public {
        require(!hasVoted[msg.sender], "You have already voted.");

        uint256 votingPower = 1; // Default voting power

        if (_referrer != address(0) && votes[_referrer] > 0 && referrer[msg.sender] == address(0)) {
            referrer[msg.sender] = _referrer;
            votingPower += votes[_referrer] / 2; // Boost voting power by 50% of referrer
        }

        votes[msg.sender] = votingPower;
        hasVoted[msg.sender] = true;
    }

    function getVotePower(address user) public view returns (uint256) {
        return votes[user];
    }
}
