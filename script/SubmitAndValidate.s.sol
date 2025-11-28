// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IEvaluator {
    function submitExercice(address erc20Address) external;
    function ex2_testErc20TickerAndSupply() external;
}

contract SubmitAndValidateScript is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        address myContractAddress = vm.envAddress("MY_CONTRACT_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        
        // Submit the contract
        evaluator.submitExercice(myContractAddress);
        console.log("Contract submitted successfully!");
        
        // Test ERC20 ticker and supply
        evaluator.ex2_testErc20TickerAndSupply();
        console.log("ex2_testErc20TickerAndSupply() passed!");
        
        vm.stopBroadcast();
    }
}