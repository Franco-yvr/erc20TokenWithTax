// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract PlaceholderName is ERC20 {
    address public _fundNumberOne = 0x0000000000000000000000000000000000000000;
    address public _fundNumberTwo = 0x0000000000000000000000000000000000000000;
    address public _fundNumberThree = 0x0000000000000000000000000000000000000000;
    address public _burnAddress = 0x000000000000000000000000000000000000dEaD;

    constructor() ERC20('Placeholder Name', 'PHN') {
        _mint(msg.sender, 1000000000000 * 10 ** 18);
    }
    
    function _transfer(address sender, address recipient, uint256 amount) internal override {
        require(amount%100 == 0, 'Decimals must be divisible by 100 to obtain 1% tax');
        uint256 taxAmount = amount / 100;
        super._transfer(sender, _fundNumberOne, taxAmount);
        super._transfer(sender, _fundNumberTwo, taxAmount);
        super._transfer(sender, _fundNumberThree, taxAmount);
        super._transfer(sender, _burnAddress, taxAmount);
        amount -= taxAmount * 4;
        super._transfer(sender, recipient, amount);
    }
}
