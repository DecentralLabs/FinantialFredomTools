# Finantial Fredom Tools

## F*k You Money V1 (FYM V1)

* Concep 
* * https://medium.com/wisehealthywealthy/how-much-money-is-f-ck-you-money-f655d12ba5b7 
* * https://www.youtube.com/watch?v=xdfeXqHFmPI
* BUSD FYM smart contract https://bscscan.com/address/0x81c845c59dbe81654f68bc4842b3829dd06f5427

### How it works?

FYM v1 is a simple BUSD lock tool, where you can deposit any BUSD amount but can only withdraw a limited amount each some specific time frequency.
For example you can deposit 1000 BUSD and setup to withdraw only 200 USD once each 30 days.

Note after you setup withdraw frequency and limit, will not be possible change those values.

### How use it?

* Go to BUSD smart contract and approve FYM contract V1 *0x81c845c59dbe81654f68bc4842b3829dd06f5427* to spend your BUSD 
* * https://bscscan.com/token/0xe9e7cea3dedca5984780bafc599bd69add087d56#writeContract
* Setup frequency and max amount to withdraw at that frequency. Note frequency is in seconds and amount is in BUSD native digits representation (need div 10**18).
* * https://bscscan.com/address/0x81c845c59dbe81654f68bc4842b3829dd06f5427#writeContract
* * For example for 200 USD per month setup `max_claim` = `200*10**18` = `200000000000000000000` and `period` = `60*60*24*30` = `2592000 seconds = 30 days`
* Deposit and withdraw are intuitive, just remember for amounts need use BUSD digits (amount*10**18)
