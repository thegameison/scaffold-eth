pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourToken is ERC20 {
    constructor(uint256 initialSupply) public ERC20("BruhCoin", "YTK") {
        //_mint(msg.sender, initialSupply);
    }

    
    mapping(address => uint256) private LRG;
    
    function claim() public {
        getToken();
    }
    
    function getToken() private {
        // require(block.timestamp - LRG[address(msg.sender)] >= 604800, 'You sir, are too early - wait until your next drop');
        _mint(msg.sender, 1);
        LRG[address(msg.sender)] = block.timestamp;
    }
}