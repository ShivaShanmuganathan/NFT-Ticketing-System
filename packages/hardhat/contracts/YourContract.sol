pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  bool public saleIsActive = false;

  constructor() {}

  function openSale() public {

    saleIsActive = true;

  }

  function closeSale() public {

    saleIsActive = false;

  }


}
