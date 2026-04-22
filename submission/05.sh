# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb

TXID="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"

# Get the input's previous txid and vout
PREV_TXID=$(bitcoin-cli -signet getrawtransaction $TXID true | jq -r '.vin[0].txid')
PREV_VOUT=$(bitcoin-cli -signet getrawtransaction $TXID true | jq -r '.vin[0].vout')

# Get the input value from the previous tx
INPUT_VALUE=$(bitcoin-cli -signet getrawtransaction $PREV_TXID true | jq --argjson vout "$PREV_VOUT" '.vout[$vout].value')

# Sum all outputs
OUTPUT_VALUE=$(bitcoin-cli -signet getrawtransaction $TXID true | jq '[.vout[].value] | add')

# Fee in satoshis
echo "$INPUT_VALUE $OUTPUT_VALUE" | awk '{printf "%d\n", ($1 - $2) * 100000000}'