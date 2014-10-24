# Description:
#   Find the latest Bitcoin price in specified currency
#
# Dependencies:
#   "cheerio": ""
#
# Configuration:
#   None
#
# Commands:
#   hubot bitcoin                            returns price in usd
#   hubot bitcoin gbp                        returns price in gbp
#   hubot bitcoin price in eur              returns price in eur
#
# Author:
#   Fred Wu
#   Peter Tripp <petertripp@gmail.com>

cheerio = require('cheerio')

module.exports = (robot) ->
  robot.respond /bitcoin(?:\s)?(?:price\s)?(?:in\s)?(.*)?/i, (msg) ->
    currency = if (msg.match[1]) then msg.match[1].trim().toUpperCase() else 'USD'
    bitcoinPrice(msg, currency)

bitcoinPrice = (msg, currency) ->
  msg
    .http("http://bitcoinprices.com/")
    .get() (err, res, body) ->
      msg.send "#{getPrice(currency, body)}"

getPrice = (currency, body) ->
  $ = cheerio.load(body)

  lastPrice   = null
  highPrice   = null
  lowPrice    = null
  priceSymbol = null

  $('table.currencies td.symbol').each (i) ->
    if $(this).text() == currency
      priceSymbol = $(this).next().next().next().next().next().next().text()
      lastPrice = "#{priceSymbol}#{$(this).next().next().next().next().next().text()}"
      highPrice = "#{priceSymbol}#{$(this).next().next().next().text()}"
      lowPrice  = "#{priceSymbol}#{$(this).next().next().next().next().text()}"
      false

  if lastPrice == null
    "Can't find the price for #{currency}. :("
  else
    "#{currency}: #{lastPrice} (H: #{highPrice} | L: #{lowPrice})"
