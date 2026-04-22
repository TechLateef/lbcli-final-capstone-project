# Only one tx in block 243,821 signals opt-in RBF. What is its txid?
BLOCK_HASH=$(bitcoin-cli -signet getblockhash 243821)

bitcoin-cli -signet getblock "$BLOCK_HASH" 2 | jq -r '
  .tx[] | select(
    .vin[] | .sequence <= 4294967293
  ) | .txid
'