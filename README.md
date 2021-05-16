AllenCoin
---

## Your Token - Contract Sandbox

This is AllenCoin, a ERC20 token to foster public good in communities. This was built for the UW Blockchain Hacks 2021 hackathon, and was created using Austin Griffith's scaffold-eth repository and its token-sandbox branch

AllenCoin serves as a token to reward fellow AllenCoin users for good deeds, creating social connections. Every so often, AllenCoin mints new tokens for all users. Using these tokens, AllenCoin users can send tokens to each other for any purpose they see fit, such as homework help or working on projects together.
Using AllenCoin, users can enter into giveaways hosted by the owner of AllenCoin. This functionality was inspired from ACM social events we have attended.

We see AllenCoin as not just a cryptocurrency, but rather a way to grow communities, encourage engagement, and build social connections.

```bash
git clone https://github.com/austintgriffith/scaffold-eth.git your-token-sandbox

cd your-token-sandbox

git checkout token-sandbox

yarn install

#(ignore node gyp errors)

yarn start

# this will eventually bring up http://localhost:3000

# in another terminal:

yarn run chain

#in a third terminal

yarn run deploy

# you will have an app with a form that talks to your token that is deployed locally 
