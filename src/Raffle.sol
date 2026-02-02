// Layout of Contract:
// license
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions


// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A sinple Raffle Contract
 * @author Mohit raj
 * @notice This contract is to create simple Raffle contract
 * @dev Implements Chainlink VRFv2.5
 */

contract Raffle{

    /* ERRORS */
    error Raffle__SendMoreMoneyToEnterRaffle();

    uint256 private entranceFee;
    //@dev The duration of the Lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    event RaffleEntred(address indexed player);

    constructor (uint256 _entranceFee , uint256 _interval){
        i_interval=_interval;
        entranceFee =_entranceFee;
        s_lastTimeStamp= block.timestamp;
    }

    function enterRaffel()external payable{
        if(msg.value<entranceFee){
            revert Raffle__SendMoreMoneyToEnterRaffle();
        }
        s_players.push(payable(msg.sender));

        emit RaffleEntred(msg.sender);
    }
    
    function pickUpWinner()external {
        if((block.timestamp- s_lastTimeStamp) < i_interval){
            revert();
        }
    }

    /*Getter Functions */

    function getEnterRaffel()public view returns(uint256){
        return entranceFee;
    }
}