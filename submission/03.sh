# Which tx in block 216,351 spends the coinbase output of block 216,128?

BLOCK_128_HASH=$(bitcoin-cli -signet getblockhash 216128)
COINBASE_TXID=$(bitcoin-cli -signet getblock "$BLOCK_128_HASH" 2 | jq -r '.tx[0].txid')

BLOCK_351_HASH=$(bitcoin-cli -signet getblockhash 216351)

bitcoin-cli -signet getblock "$BLOCK_351_HASH" 2 | jq -r --arg txid "$COINBASE_TXID" '
  .tx[] | select(.vin[] | .txid == $txid) | .txid
'