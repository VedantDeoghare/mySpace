pragma solidity ^ 0.6.1;

contract contract2 {
    
    uint256 public PeopleCount;
   mapping(uint => Person) public people;
   address owner;
   
   modifier onlyOwner() {
       require(msg.sender == owner);
       _;
   }
   
    struct Person {
        uint _id;
        string _firstname;
        string _lastname;
    }
    
   constructor() public
   {
       owner = msg.sender;
   }
    
    function addPerson(string memory _firstname, string memory _lastname) public onlyOwner {
        incrementCount();
        people[PeopleCount] =Person(PeopleCount,_firstname,_lastname);

    }
    
    function incrementCount() internal {
        PeopleCount += 1;
    }
}