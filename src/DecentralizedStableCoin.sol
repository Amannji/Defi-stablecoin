// SPDX-License-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
pragma solidity ^0.8.18;

// imports
import {Ownable} from "@openzepplin/contracts/access/Ownable.sol" ;
import {ERC20Burnable, ERC20} from "@openzepplin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// Collateral: Exogenous(ETH & BTC)
// Minting: Algorithmic
// Relative Stability: Pegged to USD

// interfaces, libraries, contracts
contract DecentralizedStableCoin is ERC20Burnable, Ownable{

    error DecentralizedStableCoin_MustBeMoreThanZero();
    error DecentralizedStableCoin_BurnAmountExceedsBalance();
    error DecentralizedStableCoin_NotZeroAddress();

    constructor() ERC20("DecentralizedStableCoin","DSC"){}

    function burn(uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0){
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        if(balance < _amount){
            revert DecentralizedStableCoin_BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) public onlyOwner returns(bool){
        if(_to == address(0)){
            revert DecentralizedStableCoin_NotZeroAddress();
        }
        if(_amount <= 0){
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        _mint(_to,_amount);
        return true;
    }

}




// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions