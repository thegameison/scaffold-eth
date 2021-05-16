pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourToken is ERC20 {
    address public immutable owner;

    // Sets owner to specified address
    constructor() public ERC20("AllenCoin", "ALC") {
        owner = 0xcea42909CF5e70A81aa33B48D0e9771A8A29F5c5;
    }

    // Wrappers for external access
    function mintWrapper(address wallet, uint256 amt) external { _mint(address(wallet), amt); }
    function burnWrapper(address wallet, uint256 amt) external { _burn(address(wallet), amt); }
    function ownerWrapper() view external returns (address) { return owner; }




    
    
}