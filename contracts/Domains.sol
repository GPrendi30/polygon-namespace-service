// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// string utils from hardhat
import { StringUtils } from "./libraries/StringUtils.sol";
import { Base64 } from "./libraries/Base64.sol";
import "hardhat/console.sol";


// openzeppelin ERC721 contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Domains {

    // top level domain
    string public TLD;

    // store domain names and their ownership to an address
    mapping(string => address) public domains;

    constructor(string memory _tld) payable {
        TLD = _tld;
        console.log("This is my domain contract. Nice.");
    }

    function price(string calldata name) public pure returns(uint) {
        uint len = StringUtils.strlen(name); // find the length of the string

        require (len > 0);

        if (len == 3) {
            return 5 * 10**17; // 0.5 Matic
        } else if (len == 4) {
            return 3 * 10**17; // 0.3 Matic
        } else {
            return 1 * 10**17;
        }
    }

    function register(string calldata name) public payable {
        domains[name] = msg.sender;
        console.log("%s has registered a domain with name: %s", msg.sender, name);

        uint _price = price(name);
        require(msg.value >= _price, "Not enough to cover the price");

        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    function getAddress(string calldata name) public view returns(address) {
        return domains[name];
    }
}