ProjectAuthor 


Created By: Richu A Kuttikattu & Lakhan Darshan


#########

IMPORTANT: Resale.sol is the main contract.

#########


Description:


Books are increasingly becoming digital. New challenges and opportunities arises with this trend.

In this project we aim to build a system where digital books behave more or less like their physical counterparts, 
while retaining the ease of use and environmental benefits of the digital world.

The current systems treat every digital copy of a given book as the same, and each of the copies
are indistinguishable between each other (eg. Kindle store).

We aim to make each and every digital copy unique, the way each and every physical copies are unique.
This brings digital scarcity, and new sets of behaviors and applications arrive with it.

In our system, a user who buys the book is the OWNER of the book, and he/she is able to sell/give the copy 
to whomsoever, the same way one is free to give physical books to friends and family. So a book bought and read can be sold
to someone else as resale, generating revenue for the owner, the book publisher gets a cut of this transaction as well,
making it an additional stream of revenue for the publisher.

An entirely new market can be dug up from this, due to the uniqueness of the copies. Copies can be auctioned off,
and users might be interested in paying a premium for certain copies (copy #1 of Fifty Shades of Grey, for example).


#############################
Installation Instrucations
#############################

Please ensure that your computer has the following prerequisites installed before proceeding:

-node npm
-truffle
-ganache-cli
-metamask-extension (preferably in google chrome) [with at least 1 ether in a couple of the accounts in Ropsten/Rinkeby/localhost]


1) Clone the repo into a local folder.
2) From the terminal navigate to 'projectauthor/client'.
3) Execute 'npm install' to install all the necessary dependencies.

[For local execution] 
1) In another terminal run 'ganache-cli'.
2) From the terminal navigate back to the root folder.
3) Execute 'truffle compile' and then 'truffle migrate'[make note of the transaction address shown on screen].
4) Navigate to 'projectauthor/client/src/contracts'.
5) Copy the abi in Resale.json and paste it at the 'abi' variable in projectAuthor.js at 'projectauthor/client/src'.
6) Update the address field in the same file with the address of the contract mentioned in step 5.
7) From the terminal navigate to 'projectauthor/client' and execute 'npm start'.[This will fire up the dApp which is a react Application on your browser].
8) Use the ganache given accounts to login to your metamask extension.


[For testnet execution]
1) Deploy contracts in 'projectauthor/contracts' on to the test net of your choice [avoid Migrations.sol].
2) Ensure your metamask account has at least 1 ether on the said network.
3) Once deployed [Resale.sol is the final contract so deploy this] copy the abi & the contract address and paste it in projectAuthor.js at 	'projectauthor/client/src'.
4) From the terminal navigate to 'projectauthor/client' and execute 'npm start'.[This will fire up the dApp which is a react Application on your browser]


