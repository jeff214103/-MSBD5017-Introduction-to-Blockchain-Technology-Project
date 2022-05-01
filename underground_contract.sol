pragma solidity >=0.4.22 <0.9.0;
contract UndergroundContract {

    struct Construction {
        uint permitID;
        string permitType;
        string authorityName;
        string authorityGroup;
        string location;
        string startDate;
        string endDate;
        uint votes;
    }

    event Voted ();
    event NewConstruction ();
    mapping(uint => Construction) public constructions;
    mapping(address => bool) public votes;

    uint public permitCount;

    constructor() public{
        permitCount = 0;
    }

    function vote(uint _permitID) public {
        require(!votes[msg.sender] , "Voter has voted.");
        require(_permitID > 0 && _permitID <= permitCount, "Permit ID is out of range.");

        votes[msg.sender] = true;
        constructions[_permitID].votes++;

        emit Voted();
    }


    function addConstruction(string memory _permitType,string memory _authorityName,string memory _authorityGroup,string memory _location,string memory _startDate,string memory _endDate) public {
        permitCount++;

        Construction memory construction = Construction(permitCount,_permitType,_authorityName,_authorityGroup,_location,_startDate,_endDate,0);
        constructions[permitCount] = construction;

        emit NewConstruction();
    }
}

