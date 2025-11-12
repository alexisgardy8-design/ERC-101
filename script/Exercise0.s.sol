// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IEvaluator {
    function ex0_setupProject() external;
}

contract Exercise0Script is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        evaluator.ex0_setupProject();
        
        vm.stopBroadcast();
        
        console.log("ex0_setupProject() called successfully!");
    }
}
