pragma solidity ^ 0.6.1;

contract erc20Token{
    string public name;
    mapping(address => uint256) public balances;
    
    function mint() public {
         balances[tx.origin] ++;
    }
}

contract contract4
{
    address payable wallet;
    address token;
    
    event Purchase(address indexed _buyer, uint256 amount);
    
    constructor(address payable _wallet, address _token) public{
        wallet = _wallet;
        token = _token;
    }
    
    function buyToken() public payable {
        erc20Token(address(token)).mint();
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }
}
