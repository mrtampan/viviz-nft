// Simple Nft code
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;


// Zeppeline ini frameworknya smartcontract
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';


contract VivizNft is ERC721, Ownable {
    // harga minting
    uint256 public mintPrice = 0.05 ether;
    
    // Total nft yg ada di smartcontract
    uint256 public totalSupply;
    
    // Maksimal supply yg boleh dimiliki user
    uint256 public maxSupply;

    // status minting diaktifkan
    bool public isMintEnabled = true;
    
    // Mengecek semua address yg memiliki nft
    mapping(address => uint256) public mintedWallet;

    
    constructor () payable ERC721 ('Viviz NFT', 'VIVIZ'){
        maxSupply = 2;
    } 

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled; 
    }
    
    function setMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    function mint() external payable{
        // require diharuskan melewati require untuk tetap bisa menjalankan function sampe ke bawah
        require(isMintEnabled, "Minting tidak aktif");
        require(mintedWallet[msg.sender] < 1, "Melebihi Maksimal Supply");
        require(msg.value == mintPrice, "Value Salah");
        require(totalSupply < maxSupply, "Terjual Habis");
        
        // Jika berhasil, address didaftarkan memiliki nft
        mintedWallet[msg.sender]++;
        
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }

}
