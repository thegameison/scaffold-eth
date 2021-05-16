pragma solidity >=0.6.0 <0.7.0;

import "./YourToken.sol";

contract Distributor {
    YourToken private token;

    // Keeps track of last claim by an address
    mapping(address => uint256) private lastClaim;

    constructor(address _token) public {
        token = YourToken(_token);
    }

    // Mints a token if a week has passed since the last claim
    function claim(address wallet) public {
        require(block.timestamp - lastClaim[address(wallet)] >= 604800, 'You are too early - wait until your next drop');
        token.mintWrapper(address(wallet), 1);
        lastClaim[address(wallet)] = block.timestamp;
    }

}