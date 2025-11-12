// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/AllInOneSolution.sol";
import "../src/MyERC20Token.sol";

contract DeployAndValidateEx10Script is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        uint256 mainPrivateKey = vm.envUint("PRIVATE_KEY");
        
        uint256 newPrivateKey = 0x53901b0c3f67e876f0bb0b2417af2b45c1f4967c5e4d044e0c6b10c484b8bc81;
        address newWallet = 0x00228A6d015FEcAFf8845a953178043b4e9F7592;
        
        vm.startBroadcast(mainPrivateKey);
        payable(newWallet).transfer(0.01 ether);
        vm.stopBroadcast();
        console.log("Funded new wallet:", newWallet);
        
        vm.startBroadcast(newPrivateKey);
        
        AllInOneSolution solution = new AllInOneSolution(evaluatorAddress);
        console.log("Solution deployed:", address(solution));
        
        payable(address(solution)).transfer(0.002 ether);
        console.log("Funded solution contract");
        
        (bool success, ) = address(solution).call(abi.encodeWithSignature("startWorkshop()"));
        require(success, "startWorkshop failed");
        console.log("[OK] ex10_allInOne() - 2 points!");
        
        vm.stopBroadcast();
        
        console.log("===========================================");
        console.log("EX10 COMPLETE! 2 points gagnes!");
        console.log("New wallet:", newWallet);
        console.log("===========================================");
    }
}
