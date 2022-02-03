// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/BEP20.sol";
import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/IBEP20.sol";
import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/SafeBEP20.sol";
import '@pancakeswap/pancake-swap-lib/contracts/math/SafeMath.sol';




contract FuckYouMoney{
    using SafeBEP20 for IBEP20;
    using SafeMath for uint256;

    // Declaring a structure
   struct FYMEntry { 
      address wallet;
      uint256 balance;
      uint256 max_claim;
      uint256 period;
      uint256 last_claim;
   }

    uint256 MAX_INT = 115792089237316195423570985008687907853269984665640564039457584007913129639935;

    IBEP20 private _usd_token;
    mapping(address => FYMEntry) public fym_data;

    constructor() public {

        uint256 chain_id = getChainId();
        if(chain_id == 97){
            // testnet bsc
            _usd_token = IBEP20(0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684); // USDT testnet
        }else{
            // mainnet bsc
            _usd_token = IBEP20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56); // BUSD mainnet
        }
    }

    function getChainId() private view returns (uint256 chainId) {
        assembly {
            chainId := chainid()
        }
    }

    function setup(uint256 max_claim, uint256 period) public {

        FYMEntry storage fym = fym_data[msg.sender];

        require(fym.balance == 0, "Can't setup same wallet twice!");

        fym.max_claim = max_claim;
        fym.period = period;

        //_usd_token.approve(address(this), MAX_INT);
    }

    function deposit_usd(uint256 amount) public {

        FYMEntry storage fym = fym_data[msg.sender];
        require(fym.max_claim != 0, "Setup required before deposit!");

        _usd_token.transferFrom(msg.sender, address(this), amount);
        
        fym.balance = fym.balance.add(amount);
    }

    function claim_payout(uint256 amount) public {
        FYMEntry storage fym = fym_data[msg.sender];

        require(amount > 0, "Amount should be > 0");
        require(fym.max_claim > 0, "Setup required before deposit!");
        require(fym.last_claim.add(fym.period) < block.timestamp, "Claim period uncompleted!");

        uint256 total = fym.max_claim.min(amount).min(fym.balance);

        require(total > 0, "Not payout funds");

        fym.balance = fym.balance.sub(total);
        fym.last_claim = block.timestamp;
        _usd_token.transferFrom(address(this), msg.sender, total);

    }

}
