import ExampleToken from "../../contracts/ExampleToken.cdc"
import FungibleToken from "../../contracts/FungibleToken.cdc"

// replace all "ExampleToken" with the specific token

// example parameters:
// var vaultStoragePath = /storage/exampleTokenVault
// var vaultBalancePath = /public/exampleTokenBalance
// var vaultReceiverPath = /public/exampleTokenReceiver 
transaction(
    vaultStoragePath: StoragePath,
    vaultBalancePath: PublicPath,
    vaultReceiverPath: PublicPath
) {
    prepare(acct: AuthAccount) {

        let vault <- ExampleToken.createEmptyVault()

        acct.save<@ExampleToken.Vault>(<-vault, to: vaultStoragePath)
        log("Empty vault stored, storagePath: ")
        log(vaultStoragePath)


        let receiverRef = 
        acct.link<&{FungibleToken.Receiver}>
            (vaultReceiverPath , target: vaultStoragePath)
        log("Receiver reference created, publicPath: ")
        log(vaultReceiverPath)

        assert(
            acct.getCapability<&{FungibleToken.Receiver}>(vaultReceiverPath).check(), 
            message: "Receiver Reference was not created correctly")


        let balanceRef = 
        acct.link<&{FungibleToken.Balance}>
            (vaultBalancePath , target: vaultStoragePath)
        log("Balance reference created, publicPath: ")
        log(vaultBalancePath)

        assert(
            acct.getCapability<&{FungibleToken.Balance}>(vaultBalancePath).check(), 
            message: "Balance Reference was not created correctly")
    }
}