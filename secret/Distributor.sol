pragma solidity >=0.6.0 <0.7.0;ragma solidity >=0.6.0 <0.7.0;

import "./YourToken.sol";mport "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Distributor {ontract Distributor {
     public token;   address payable wallet;
    uint256 entries;   address public token;

    mapping(address => uint256) private LRG;   mapping(address => uint256) public LRG;
    mapping(address => uint256) public giveaways;
   constructor(address payable _wallet, address _token) public {
    constructor(address _token) public {       wallet = _wallet;
        token = YourToken(_token);       token = _token;
    }   }

    function claim(address wallet) public payable {   function claim() public payable {
        require(block.timestamp - LRG[address(wallet)] >= 604800, 'You sir, are too early - wait until your next drop');       getToken();
        token.mintWrapper(address(wallet), 1);   }
        LRG[address(wallet)] = block.timestamp;
    }   function getToken() public payable {
       require(block.timestamp - LRG[address(wallet)] >= 604800, 'You sir, are too early - wait until your next drop');
    // function getGiveaway() private payable {       ERC20 _token = ERC20(address(token));
    //     require(token.balanceOf(address(wallet)) >= 1, 'You dont have any tokens to enter the giveaway');       _token._mintWrapper(address(wallet), 1);
    //     token._burn(address(wallet), msg.value);       LRG[address(wallet)] = block.timestamp;
    //     giveaways[address(wallet)] += msg.value;   }
    //     entries++;
    // }   function joinGiveaway() public payable {
       require(token)
   }
}

