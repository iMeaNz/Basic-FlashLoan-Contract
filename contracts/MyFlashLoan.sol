// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { FlashLoanReceiverBase } from "./FlashLoanReceiverBase.sol";
import { ILendingPool } from "./ILendingPool.sol";
import { ILendingPoolAddressesProvider } from "./ILendingPoolAddressesProvider.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyFlashLoan is FlashLoanReceiverBase, Ownable {

    //Provide the address of the LendingPoolAddressesProvider contract
    constructor (address _provider) FlashLoanReceiverBase(ILendingPoolAddressesProvider(_provider)) {}

    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    )
        external override returns (bool) {
        for (uint i = 0; i < assets.length; i++) {
            uint amountOwing = amounts[i] + premiums[i];
            IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
        }
        return true;
    }
    
    function myFlashLoan() public onlyOwner {
        address receiverAddress = address(this);
        address[] memory assets = new address[](1);
        assets[0] = address(INSERT_ASSET_ADDRESS);
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = INSERT_AMOUNT;
        // 0 = no debt, 1 = stable, 2 = variable
        uint256[] memory modes = new uint256[](1);
        modes[0] = INSERT_MODE;
        address onBehalfOf = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;
        LENDING_POOL.flashLoan(
            receiverAddress,
            assets,
            amounts,
            modes,
            onBehalfOf,
            params,
            referralCode
        );
    }
}