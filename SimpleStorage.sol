// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    uint256 public  favouriteNumber;

    mapping(string => uint256) public nameFavouriteNumber;

    struct People {
        uint256 favouriteNumber;
        string name;
    }

    People[] public people;
    
    function store (uint256 _favouriteNumber) public virtual {
        favouriteNumber = _favouriteNumber;
    }

    function retreive() public view returns(uint256){
        return favouriteNumber;
    }

    function addPerson(string memory _name, uint _favouriteNumber) public {
        people.push(People(_favouriteNumber, _name));
        nameFavouriteNumber[_name] = _favouriteNumber;
    }
}