pragma solidity >=0.6.0 <0.7.0;

import "./YourToken.sol";

contract Distributor {
    YourToken private token;

    mapping(address => uint256) private LRG;

    constructor(address _token) public {
        token = YourToken(_token);
    }

    function claim(address wallet) public {
        require(block.timestamp - LRG[address(wallet)] >= 604800, 'You are too early - wait until your next drop');
        token.mintWrapper(address(wallet), 1);
        LRG[address(wallet)] = block.timestamp;
    }

    function balance(address wallet) public returns (uint256) {
        return token.balanceOf(wallet);
    }


}