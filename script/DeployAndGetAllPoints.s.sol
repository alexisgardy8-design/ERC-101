// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyERC20Token.sol";

interface IEvaluator {
    function submitExercice(address erc20Address) external;
    function ex2_testErc20TickerAndSupply() external;
    function ex3_testGetToken() external;
    function ex4_testBuyToken() external;
    function ex5_testDenyListing() external;
    function ex6_testAllowListing() external;
    function ex7_testDenyListing() external;
    function ex8_testTier1Listing() external;
    function ex9_testTier2Listing() external;
}

contract DeployAndGetAllPointsScript is Script {
    function run() external {
        address evaluatorAddress = vm.envAddress("EVALUATOR_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy new ERC20 token with assigned ticker and supply
        MyERC20Token token = new MyERC20Token(
            "Workshop Token", 
            "pzqjamk4", 
            856267762000000000000000000
        );
        
        console.log("Token deployed at:", address(token));
        
        IEvaluator evaluator = IEvaluator(evaluatorAddress);
        uint256 totalPoints = 5; // Already have 4 + 1 for deployment
        
        // Submit the new contract
        evaluator.submitExercice(address(token));
        console.log("[SUCCESS] Contract submitted");
        
        // Ex2: Test ERC20 ticker and supply (2 points)
        evaluator.ex2_testErc20TickerAndSupply();
        console.log("[SUCCESS] ex2_testErc20TickerAndSupply() - 2 points");
        totalPoints += 2;
        
        // Ex3: Test getToken function (2 points)
        evaluator.ex3_testGetToken();
        console.log("[SUCCESS] ex3_testGetToken() - 2 points");
        totalPoints += 2;
        
        // Ex4: Test buyToken function (2 points)
        // Send some ETH to evaluator for testing
        payable(evaluatorAddress).transfer(0.001 ether);
        evaluator.ex4_testBuyToken();
        console.log("[SUCCESS] ex4_testBuyToken() - 2 points");
        totalPoints += 2;
        
        // Ex5: Test deny listing (1 point)
        token.enableWhitelist(true);
        evaluator.ex5_testDenyListing();
        console.log("[SUCCESS] ex5_testDenyListing() - 1 point");
        totalPoints += 1;
        
        // Ex6: Test allow listing (2 points)
        token.setWhitelist(evaluatorAddress, true);
        evaluator.ex6_testAllowListing();
        console.log("[SUCCESS] ex6_testAllowListing() - 2 points");
        totalPoints += 2;
        
        // Ex7: Test tier deny listing (1 point)
        token.setWhitelist(evaluatorAddress, false);
        token.enableWhitelist(false);
        token.enableTier(true);
        evaluator.ex7_testDenyListing();
        console.log("[SUCCESS] ex7_testDenyListing() - 1 point");
        totalPoints += 1;
        
        // Ex8: Test tier 1 listing (2 points)
        token.setWhitelist(evaluatorAddress, true);
        token.setTier(evaluatorAddress, 1);
        evaluator.ex8_testTier1Listing();
        console.log("[SUCCESS] ex8_testTier1Listing() - 2 points");
        totalPoints += 2;
        
        // Ex9: Test tier 2 listing (2 points)
        token.setTier(evaluatorAddress, 2);
        evaluator.ex9_testTier2Listing();
        console.log("[SUCCESS] ex9_testTier2Listing() - 2 points");
        totalPoints += 2;
        
        vm.stopBroadcast();
        
        console.log("\n=== WORKSHOP COMPLETE! ===");
        console.log("Total points obtenus:", totalPoints, "/ 20");
        console.log("Token address:", address(token));
        console.log("Ticker: pzqjamk4");
        console.log("Supply: 856267762000000000000000000");
        console.log("=========================");
        
        if (totalPoints >= 18) {
            console.log("EXCELLENT! PRESQUE TOUS LES POINTS OBTENUS!");
        } else if (totalPoints >= 15) {
            console.log("TRES BIEN! MAJORITE DES POINTS OBTENUS!");
        } else {
            console.log("BIEN! PROGRES SIGNIFICATIF!");
        }
    }
}