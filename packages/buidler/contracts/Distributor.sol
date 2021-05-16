pragma solidity >=0.6.0 <0.7.0;

import "./YourToken.sol";

contract Distributor {
     public token;
    uint256 entries;

    mapping(address => uint256) private LRG;
    mapping(address => uint256) public giveaways;

    constructor(address _token) public {
        token = YourToken(_token);
    }

    function claim(address wallet) public payable {
        require(block.timestamp - LRG[address(wallet)] >= 604800, 'You sir, are too early - wait until your next drop');
        token.mintWrapper(address(wallet), 1);
        LRG[address(wallet)] = block.timestamp;
    }

    // function getGiveaway() private payable {
    //     require(token.balanceOf(address(wallet)) >= 1, 'You dont have any tokens to enter the giveaway');
    //     token._burn(address(wallet), msg.value);
    //     giveaways[address(wallet)] += msg.value;
    //     entries++;
    // }


}