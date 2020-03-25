pragma solidity ^ 0.6.1;

contract erc20Token{
    string public name;
    mapping(address => uint256) public balances;
    
    constructor(string memory _name) public
    {
        name = _name;
    }
    
    function mint() virtual public {
         balances[tx.origin] ++;
    }
}

contract MyToken is erc20Token {
     string public symbol;
     address[] public owners;
     uint256 ownerCount;
    constructor(string memory _name, string memory _symbol) public erc20Token(_name)
    {
        symbol = _symbol;
    }
    
   function mint() override public {
        super.mint();
        ownerCount++;
        owners.push(msg.sender);
    }
}
