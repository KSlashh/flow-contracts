import FungibleToken from 0xFUNGIBLETOKEN

// import FungibleToken from 0xee82856bf20e2aa6 // on emulator
// import FungibleToken from 0x9a0766d93b6608b7 // on testnet
// import FungibleToken from 0xf233dcee88fe0abe // on mainnet

pub fun main(
    owner: Address,
    vaultPath: Path
): UFix64 {
    let vaultPublicPath PublicPath = (vaultPath as? PublicPath)!
    var acct = getAccount(owner)
    let balanceRef = acct.getCapability(vaultPublicPath)
        .borrow<&{FungibleToken.Balance}>()
        ?? panic("Could not borrow a reference to the acct balance")

    return balanceRef.balance
}