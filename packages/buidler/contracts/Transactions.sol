pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Transactions {
    IERC20 public token;
    address public sendr;
    address public receivr;
    uint public amt;


    constructor () public {
        /*token = IERC20(_token);
        sendr = _sendr;
        receivr = _receivr;
        amt = _amt; */
    }

    function sendCoin (address _receivr, uint _amt) public {
        address sendr = msg.sender;
        require (token.allowance(sendr, address(this)) >= amt, "Money doesn't grow on trees");

        token.transferFrom(sendr, _receivr, _amt);

        // _safeTransferFrom(token, sendr, receivr, amt);
    }

    /*function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    } */

}