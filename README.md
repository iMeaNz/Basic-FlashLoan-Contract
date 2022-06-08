# Basic FlashLoan contract (AAVE V2)

This a basic contract that performs a flashloan, it is implemented based on AAVE V2 contracts.
To make it work, simply find the address of the `LendingPoolAddressesProvider` contract (check the AAVE [documentation](https://docs.aave.com/developers/v/2.0/deployed-contracts/deployed-contracts)), put the addresses of the assets you want to borrow, their amounts and the debt mode, then simply call the `myFlashLoan` function.
>This contract has not been not audited and has no safety checks, **use at your own risks !**