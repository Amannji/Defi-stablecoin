// SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity ^0.8.18;

import {DecentralizedStableCoin} from '../../src/DecentralizedStableCoin.sol';
import {DSCEngine} from '../../src/DSCEngine.sol';
import {Test, console} from 'forge-std/Test.sol';
import {DeployDSC} from '../../script/DeployDSC.s.sol';
import {HelperConfig} from '../../script/HelperConfig.s.sol';
import {ERC20Mock} from '@openzepplin/contracts/mocks/ERC20Mock.sol';

contract DSCEngineTest is Test{
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address weth;
    address ethUsdPriceFeed;

    address public USER = makeAddr("user");
    uint256 public constant AMOUNT_COLLATERAL = 10 ether;
    uint256 public constant STARTING_ERC20_BALANCE = 10 ether;



    ////////////////////////////////////////// 
    //// depositCollateral Tests ////////////
    ///////////////////////////////////////// 

    function testRevertsIfCollateralZero() public {
        vm.startPrank(USER);
        ERC20Mock(weth).approve(address(dsce), AMOUNT_COLLATERAL);

        vm.expectRevert(DSCEngine.DSCEngine_NeedsMoreThanZero.selector);
        dsce.depositCollateral(weth,0);
        vm.stopPrank();
    }



    function setUp() public{
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        
        (ethUsdPriceFeed, , weth, , ) = config.activeNetworkConfig();
        ERC20Mock(weth).mint(USER,STARTING_ERC20_BALANCE);
    }

    /////////////////////////
    ///// Price Tests //////
    ///////////////////////


function testGetUsdValue() public{
 uint256 ethAmount = 15e18;
 uint256 expectedUsd = 30000e18;
 uint256 actualUsd = dsce.getUsdValue(weth, ethAmount);
 assertEq(expectedUsd, actualUsd);
}



}
