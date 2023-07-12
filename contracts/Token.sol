//SPDX-License-Identifier: MIT

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.18;


import "hardhat/console.sol";


contract Token {
    
    string public name = "PKS TOKEN";
    string public symbol = "PKS";
    uint256 public totalSupply = 100;
    address public owner;

    mapping(address => uint256) balances;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event TransferFrom(address indexed _from, address indexed _to, uint256 _value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function tokenBalance(address account) external view returns (uint) {
        return balances[account];
    }

    function mintToken(address to , uint value) public onlyOwner{
        balances[to] += value;

        emit Mint(to, value);
    }

    function burnToken(uint value) public {
        require(balances[msg.sender] >= value , "Insufficient Balance");

        balances[msg.sender] -= value;
        
        emit Burn(msg.sender, value);
    }
    
    function transfer(address to, uint value) external {

        require(balances[msg.sender] >= value, "Not enough tokens");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function transferFrom(address from , address to, uint value) external {

        require(balances[from] >= value, "Not enough tokens");

        balances[from] -= value;
        balances[to] += value;

        emit TransferFrom(from, to, value);
    }
}