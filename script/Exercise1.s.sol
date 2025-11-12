// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IEvaluator {
    function ex1_getTickerAndSupply() external;
    function readTicker(address studentAddress) external view returns (string memory);
    function readSupply(address studentAddress) external view returns (uint256);
}

contract Exercise1Script is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        evaluator.ex1_getTickerAndSupply();
        
        vm.stopBroadcast();
        
        console.log("ex1_getTickerAndSupply() called successfully!");
    }
    
    function readAssignment() external view {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        address myAddress = vm.addr(vm.envUint("PRIVATE_KEY"));
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        
        string memory ticker = evaluator.readTicker(myAddress);
        uint256 supply = evaluator.readSupply(myAddress);
        
        console.log("Your assigned ticker:", ticker);
        console.log("Your assigned supply:", supply);
    }
}
