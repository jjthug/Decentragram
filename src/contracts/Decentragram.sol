pragma solidity ^0.5.0;

contract Decentragram {

string public name = "Decentragram";

mapping(uint=>Image) public images;

uint public imageCount;


struct Image{
uint id;
string hash;
string description;
uint tipAmount;
address payable author;
}

event ImageCreated(
uint id,
string hash,
string description,
uint tipAmount,
address payable author
);

event ImageTipped(
uint id,
string hash,
string description,
uint tipAmount,
address payable author
);

event imageDeleted(
uint id,
string hash,
string description,
uint tipAmount,
address payable author
);


//Create Image
function uploadImage(string memory hash, string memory desc) public {


  require (bytes(hash).length > 0);

  require(bytes(desc).length > 0);

  require(msg.sender != address(0x0));
  
  imageCount++;

  images[imageCount] = Image(imageCount, hash, desc,0 , msg.sender);

  emit ImageCreated(imageCount, hash, desc,0 , msg.sender);

}

//Delete Image
// function removeImage(uint id) public{
// require(id>=0 && id<=imageCount && images[id].author == msg.sender);

// Image memory image = images[id];
// image.hash = '';
// image.desc = '';
// image.tipAmount =0;
// image.author = address(0x0);

// images[id] = image;

// }

//Tip image owner
function tipImageOwner(uint id) public payable {

  require(id>=0 && id<=imageCount);
  Image storage image = images[id];

  address payable author = image.author;

  address(author).transfer(msg.value);

  image.tipAmount += msg.value;

  images[id] = image;

  emit ImageTipped(id, image.hash, image.description, image.tipAmount, author);
}


}