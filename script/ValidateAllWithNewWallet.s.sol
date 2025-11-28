// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IEvaluator {
    function ex3_testGetToken() external;
    function ex4_testBuyToken() external;
    function ex5_testDenyListing() external;
    function ex6_testAllowListing() external;
    function ex7_testDenyListing() external;
    function ex8_testTier1Listing() external;
    function ex9_testTier2Listing() external;
}

contract ValidateAllWithNewWalletScript is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        uint256 newPrivateKey = 0x53901b0c3f67e876f0bb0b2417af2b45c1f4967c5e4d044e0c6b10c484b8bc81;
        
        vm.startBroadcast(newPrivateKey);
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        
        try evaluator.ex3_testGetToken() {
            console.log("[OK] ex3 - 2 points");
        } catch {
            console.log("[FAIL] ex3 failed");
        }
        
        try evaluator.ex4_testBuyToken() {
            console.log("[OK] ex4 - 2 points");
        } catch {
            console.log("[FAIL] ex4 failed");
        }
        
        try evaluator.ex5_testDenyListing() {
            console.log("[OK] ex5 - 1 point");
        } catch {
            console.log("[FAIL] ex5 failed");
        }
        
        try evaluator.ex6_testAllowListing() {
            console.log("[OK] ex6 - 2 points");
        } catch {
            console.log("[FAIL] ex6 failed");
        }
        
        try evaluator.ex7_testDenyListing() {
            console.log("[OK] ex7 - 1 point");
        } catch {
            console.log("[FAIL] ex7 failed");
        }
        
        try evaluator.ex8_testTier1Listing() {
            console.log("[OK] ex8 - 2 points");
        } catch {
            console.log("[FAIL] ex8 failed");
        }
        
        try evaluator.ex9_testTier2Listing() {
            console.log("[OK] ex9 - 2 points");
        } catch {
            console.log("[FAIL] ex9 failed");
        }
        
        vm.stopBroadcast();
    }
}