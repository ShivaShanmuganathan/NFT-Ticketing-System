pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
import "./Base64.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTx is ERC721URIStorage {

  using Counters for Counters.Counter;
  Counters.Counter private currentId;

  bool public saleIsActive = false;
  uint256 public totalTickets = 10;
  uint256 public availableTickets = 10;
  uint256 public mintPrice = 0.1 ether;

  mapping (address => uint[]) public holderTokenIDs;

  constructor() ERC721("NFTx", "NFTx") {
    currentId.increment();
  }

  function openSale() public {

    saleIsActive = true;

  }

  function closeSale() public {

    saleIsActive = false;

  }

  function mint() public payable{

    require(availableTickets > 0, "Tickets are not available");
    require(msg.value >= mintPrice, "Not enough ETH!");
    require(saleIsActive, "Tickets are not on sale!");

    string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{ "name": "NFTix #',
                        Strings.toString(currentId.current()),
                        '", "description": "A NFT-powered ticketing system", ',
                        '"traits": [{ "trait_type": "Checked In", "value": "false" }, { "trait_type": "Purchased", "value": "true" }], ',
                        '"image": "ipfs://QmPwUPQHFKFvZjmyt3samCQTPyb2mr6mNouMc84xWdyFHj" }'
                    )
                )
            )
      );

    string memory tokenURI = string(
            abi.encodePacked("data:application/json;base64,", json)
    );

    
    _safeMint(msg.sender, currentId.current());
    console.log(tokenURI);
    _setTokenURI(currentId.current(), tokenURI);

    holderTokenIDs[msg.sender].push(currentId.current());

    currentId.increment();
    availableTickets -= 1;

  }

  function displayAvailableTickets() public view returns(uint256){
    return availableTickets;
  }

  function displayTotalTickets() public view returns(uint256){
    return totalTickets;
  }


}
