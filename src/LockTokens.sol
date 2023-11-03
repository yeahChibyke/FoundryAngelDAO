// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {AngelGovernanceToken} from "./AngelGovernanceToken.sol";

error LockTokens__NotOwner();

contract LockTokens {
    address private immutable i_owner;
    IERC20 public angelDollar;
    AngelGovernanceToken public angelGovernanceToken;
    uint256 public swapRatio = 30; // 30 AngelDollar for 1 AngelGovernanceToken

    event AccountBalanceChecked(address account, uint256 balance);
    event TokensMinted(address account, uint256 amount);

    constructor() {
        i_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (i_owner != msg.sender) revert LockTokens__NotOwner();
        _;
    }

    function setTokenAddresses(address _angelDollar, address _governanceToken) public onlyOwner {
        angelDollar = IERC20(_angelDollar);
        angelGovernanceToken = AngelGovernanceToken(_governanceToken);
    }

    function swap(uint256 amountAngelDollar) public {
        require(amountAngelDollar >= 30, "Amount must be greater than 30");
        require(angelDollar.balanceOf(msg.sender) >= amountAngelDollar, "Insufficient AngelDollar balance");

        // Calculate the corresponding amount of AngelGovernanceToken based on the swap ratio
        uint256 amountAngelGovernanceToken = amountAngelDollar / swapRatio;

        // console.log commented out. events used instead
        // console.log("Account balance : ", angelDollar.balanceOf(msg.sender));
        // Emit the AccountBalanceChecked event
        emit AccountBalanceChecked(msg.sender, angelDollar.balanceOf(msg.sender));

        // Transfer AngelDollar from the sender to this contract
        require(angelDollar.transferFrom(msg.sender, i_owner, amountAngelDollar), "AngelDollar transfer failed");

        // console.log commented out. events used instead
        // console.log("Minting Tokens to senders address");
        // Emit the TokensMinted event
        emit TokensMinted(msg.sender, amountAngelGovernanceToken);

        // Transfer AngelGovernanceToken from this contract to the sender
        angelGovernanceToken.mint(msg.sender, amountAngelGovernanceToken);
    }
    /*
    // Owner can withdraw any remaining tokens left in the contract
    function withdrawTokens(address tokenAddress, uint256 amount) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(owner(), amount), "Token transfer failed");
    } */

    // Owner can update the swap ratio if needed
    function updateSwapRatio(uint256 newRatio) external onlyOwner {
        require(newRatio > 0, "Swap ratio must be greater than 0");
        swapRatio = newRatio;
    }
}
