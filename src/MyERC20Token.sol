// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC20Token is ERC20, Ownable {
    uint256 public constant TOKEN_PRICE = 1000;
    uint256 public constant FREE_TOKENS = 100 * 10**18;
    
    mapping(address => bool) public allowList;
    mapping(address => uint256) public tierList;
    
    bool public whitelistEnabled;
    bool public tierEnabled;
    
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }
    
    function getToken() external returns (bool) {
        if (whitelistEnabled) {
            require(allowList[msg.sender], "Not whitelisted");
        }
        _mint(msg.sender, FREE_TOKENS);
        return true;
    }
    
    function buyToken() external payable returns (bool) {
        require(msg.value > 0, "Send ETH");
        
        if (tierEnabled) {
            require(allowList[msg.sender], "Not whitelisted");
            require(tierList[msg.sender] > 0, "No tier");
            
            uint256 multiplier = tierList[msg.sender];
            _mint(msg.sender, msg.value * TOKEN_PRICE * multiplier);
        } else {
            _mint(msg.sender, msg.value * TOKEN_PRICE);
        }
        return true;
    }
    
    function isCustomerWhiteListed(address addr) external view returns (bool) {
        return allowList[addr];
    }
    
    function setWhitelist(address addr, bool status) external onlyOwner {
        allowList[addr] = status;
    }
    
    function enableWhitelist(bool enabled) external onlyOwner {
        whitelistEnabled = enabled;
    }
    
    function customerTierLevel(address addr) external view returns (uint256) {
        return tierList[addr];
    }
    
    function setTier(address addr, uint256 tier) external onlyOwner {
        tierList[addr] = tier;
    }
    
    function enableTier(bool enabled) external onlyOwner {
        tierEnabled = enabled;
    }
    
    receive() external payable {}
}
