pragma solidity >=0.6.0 <0.7.0;

import "./YourToken.sol";

contract Giveaway {
    YourToken private token;
    uint256 public entries;
    address public prevWinner;

    address[] private giveaways;
    mapping(address => bool) private whiteList;

    modifier onlyOwner {
        require(msg.sender == token.ownerWrapper(), 'Access Denied');
        _;
    }

    modifier onlyAdmin {
        require(whiteList[msg.sender], 'Access Denied');
        _;
    }

    constructor(address _token) public {
        token = YourToken(_token);
    }

    function getGiveaway(address wallet) public payable {
        require(token.balanceOf(address(wallet)) >= 1, 'You dont have any tokens to enter the giveaway');
        token.burnWrapper(address(wallet), msg.value);
        int val = int(msg.value);
        for (int i = 0; i < val; i++) {
            giveaways.push(address(wallet));
        }
        entries += msg.value;
    }

    function whiteListAdd(address receivr) public onlyOwner {
        whiteList[receivr] = true;
    }

    function doGiveaway() public onlyAdmin {
        prevWinner = giveaways[block.timestamp % entries];
        entries = 0;
        delete giveaways;
    }


}