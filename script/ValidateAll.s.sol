// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyERC20Token.sol";

interface IEvaluator {
    function ex3_testGetToken() external;
    function ex4_testBuyToken() external;
    function ex5_testDenyListing() external;
    function ex6_testAllowListing() external;
    function ex7_testDenyListing() external;
    function ex8_testTier1Listing() external;
    function ex9_testTier2Listing() external;
}

contract ValidateAllScript is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        address payable tokenAddress = payable(vm.envAddress("MY_CONTRACT_ADDRESS"));
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        MyERC20Token token = MyERC20Token(tokenAddress);
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        
        evaluator.ex3_testGetToken();
        console.log("[OK] ex3 - 2 points");
        
        evaluator.ex4_testBuyToken();
        console.log("[OK] ex4 - 2 points");
        
        token.enableWhitelist(true);
        evaluator.ex5_testDenyListing();
        console.log("[OK] ex5 - 1 point");
        
        token.setWhitelist(evaluatorAddress, true);
        evaluator.ex6_testAllowListing();
        console.log("[OK] ex6 - 2 points");
        
        token.setWhitelist(evaluatorAddress, false);
        token.enableWhitelist(false);
        token.enableTier(true);
        evaluator.ex7_testDenyListing();
        console.log("[OK] ex7 - 1 point");
        
        token.setWhitelist(evaluatorAddress, true);
        token.setTier(evaluatorAddress, 1);
        evaluator.ex8_testTier1Listing();
        console.log("[OK] ex8 - 2 points");
        
        token.setTier(evaluatorAddress, 2);
        evaluator.ex9_testTier2Listing();
        console.log("[OK] ex9 - 2 points");
        
        vm.stopBroadcast();
        
        console.log("===========================================");
        console.log("TOUT EST VALIDE! 12 points gagnes!");
        console.log("===========================================");
    }
}
