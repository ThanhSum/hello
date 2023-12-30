// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MessageBoard {
    struct Post {
        string content;
        uint256 timestamp;
        address author;
    }

    mapping(uint256 => Post) public postHistory;
    uint256 public postCount;

    address public owner;

    event PostUpdated(string newPostContent, address updatedBy, uint256 timestamp);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(string memory initialPostContent) {
        postCount = 1;
        postHistory[postCount] = Post(initialPostContent, block.timestamp, msg.sender);
        owner = msg.sender;
    }

    function updatePost(string memory newPostContent) public {
        require(bytes(newPostContent).length > 0, "Post should not be empty");
        postCount++;
        postHistory[postCount] = Post(newPostContent, block.timestamp, msg.sender);
        emit PostUpdated(newPostContent, msg.sender, block.timestamp);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        address previousOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(previousOwner, newOwner);
    }
}
