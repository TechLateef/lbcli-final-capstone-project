# How many new outputs were created by block 243,825?
blockhash=$(bitcoin-cli -signet getblockhash 243825)
bitcoin-cli -signet getblock $blockhash 2 | jq '[.tx[].vout | length] | add'