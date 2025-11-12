// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyERC20Token.sol";

interface IEvaluator {
    function ex1_getTickerAndSupply() external;
    function submitExercice(address erc20Address) external;
    function ex2_testErc20TickerAndSupply() external;
    function ex3_testGetToken() external;
    function ex4_testBuyToken() external payable;
    function ex5_testDenyListing() external;
    function ex6_testAllowListing() external;
    function ex7_testDenyListing() external;
    function ex8_testTier1Listing() external;
    function ex9_testTier2Listing() external;
}

interface IMyToken {
    function enableWhitelist(bool enabled) external;
    function setWhitelist(address user, bool status) external;
    function enableTier(bool enabled) external;
    function setTier(address user, uint256 tier) external;
}

contract AllInOneSolution {
    address public evaluator;
    address public myToken;
    
    constructor(address _evaluator) {
        evaluator = _evaluator;
    }
    
    function startWorkshop() external {
        (bool success, ) = evaluator.call(abi.encodeWithSignature("ex10_allInOne()"));
        require(success, "ex10 failed");
    }
    
    function completeWorkshop() external {
        require(msg.sender == evaluator, "Only evaluator can call");
        
        IEvaluator eval = IEvaluator(evaluator);
        
        eval.ex1_getTickerAndSupply();
        
        (bool tickerSuccess, bytes memory tickerData) = evaluator.call(
            abi.encodeWithSignature("assignedTicker(address)", address(this))
        );
        require(tickerSuccess, "Failed to get ticker");
        string memory assignedTicker = abi.decode(tickerData, (string));
        
        (bool supplySuccess, bytes memory supplyData) = evaluator.call(
            abi.encodeWithSignature("assignedSupply(address)", address(this))
        );
        require(supplySuccess, "Failed to get supply");
        uint256 assignedSupply = abi.decode(supplyData, (uint256));
        
        MyERC20Token token = new MyERC20Token("Workshop Token", assignedTicker, assignedSupply);
        myToken = address(token);
        
        IMyToken tokenInterface = IMyToken(myToken);
        
        eval.submitExercice(myToken);
        eval.ex2_testErc20TickerAndSupply();
        eval.ex3_testGetToken();
        
        payable(evaluator).transfer(0.001 ether);
        eval.ex4_testBuyToken();
        
        tokenInterface.enableWhitelist(true);
        eval.ex5_testDenyListing();
        
        tokenInterface.setWhitelist(evaluator, true);
        eval.ex6_testAllowListing();
        
        tokenInterface.setWhitelist(evaluator, false);
        tokenInterface.enableWhitelist(false);
        tokenInterface.enableTier(true);
        eval.ex7_testDenyListing();
        
        tokenInterface.setWhitelist(evaluator, true);
        tokenInterface.setTier(evaluator, 1);
        eval.ex8_testTier1Listing();
        
        tokenInterface.setTier(evaluator, 2);
        eval.ex9_testTier2Listing();
    }
    
    receive() external payable {}
}
