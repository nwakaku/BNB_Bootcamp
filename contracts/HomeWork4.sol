// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BadLotteryGame {
    uint256 public prizeAmount; // payout amount
    address payable[] public players;
    uint256 public num_players;
    address payable[] public prize_winners;
    event winnersPaid(uint256);

    //No identifier name for WinnersPaid event

    constructor() {}

    // No need for constructor since its empty

    function addNewPlayer(address payable _playerAddress) public payable {
        // No need for payable in _playerAddress
        if (msg.value == 500000) {
            players.push(_playerAddress);
            // Not sure of _playerAddress validity
        }
        num_players++;
        if (num_players > 50) {
            emit winnersPaid(prizeAmount);
        }
    }

    function pickWinner(address payable _winner) public {
        if (block.timestamp % 15 == 0) {
            // use timestamp for random number
            //The contract is not using a proper random number generator.
            // It uses the current block timestamp as a source of randomness, which can be easily manipulated by miners.
            prize_winners.push(_winner);
        }
    }

    function payout() public {
        if (address(this).balance == 500000 * 100) {
            uint256 amountToPay = prize_winners.length / 100;
            distributePrize(amountToPay);
        }
    }

    function distributePrize(uint256 _amount) public {
        //The distributePrize function does not check if the contract has enough funds to distribute the prize.
        for (uint256 i = 0; i <= prize_winners.length; i++) {
            prize_winners[i].transfer(_amount);
        }
    }

    //The contract does not have any mechanism for handling failed transactions.
    // If a transaction fails for any reason, the contract does not have a fallback mechanism to handle it.
}
