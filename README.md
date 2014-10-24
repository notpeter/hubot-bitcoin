## hubot-bitcoin [![NPM version](https://badge.fury.io/js/hubot-bitcoin.png)](http://badge.fury.io/js/hubot-bitcoin)

A [Hubot](https://github.com/github/hubot) plugin to tell you the current price of Bitcoin.

### Usage

    hubot bicoin                            returns price in usd
    hubot bicoin gbp                        returns price in gbp
    hubot bitcoin price in eur              returns price in eur

    hubot bitcoin - bitcoin price in usd
    hubot bitcoin [currency] - bitcoin price in

### Installation
1. cd into your hubot dir, run `npm install --save hubot-bitcoin` (adds it as a dependency in package.json).
2. Add `"hubot-bitcoin"` to your `external-scripts.json` file.
3. Restart Hubot.
