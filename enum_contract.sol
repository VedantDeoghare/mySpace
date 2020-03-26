pragma solidity ^ 0.6.1;

contract contract1 {
    string public Stringvalue = "VeduisgoodBoi";
    bool public myBool = true;
    int public myInt = -1;
    uint public myUint = 10;
    
    enum State { Waiting, Active, Ready }
    State public state;
    
    constructor() public {
        state = State.Waiting;
    }
    
    function activate() public {
        state = State.Active;
    }
    
    function isActive() public view returns (bool) {
      return state == State.Active;  
    }
  
}