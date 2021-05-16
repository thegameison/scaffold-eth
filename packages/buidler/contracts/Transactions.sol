pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Transactions {
    IERC20 private token;


    constructor (address _token) public {
        token = IERC20(_token);
    }

    function sendCoin (address _receivr) public payable {
        require(token.balanceOf(msg.sender) >= msg.value, 'You need more funds to send that much!');
        token.approve(msg.sender, msg.value + 1);
        token.transferFrom(msg.sender, _receivr, msg.value);

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