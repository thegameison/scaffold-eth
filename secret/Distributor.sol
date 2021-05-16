pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Distributor {
    address payable wallet;
    address public token;

    mapping(address => uint256) public LRG;

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    function claim() public payable {
        getToken();
    }

    function getToken() public payable {
        require(block.timestamp - LRG[address(wallet)] >= 604800, 'You sir, are too early - wait until your next drop');
        ERC20 _token = ERC20(address(token));
        _token._mint(address(wallet), 1);
        LRG[address(wallet)] = block.timestamp;
    }


}