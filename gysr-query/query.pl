from graphqlclient import GraphQLClient
import json

# Use this for the coming subgraph on gysr staking and reward
ENDPOINT = "https://api.thegraph.com/subgraphs/name/gysr/staking"

client = GraphQLClient(ENDPOINT)

QUERY = """
{
  geysers(first: 10) {
    id
    stakingToken {
      id
      symbol
    }
    rewardToken {
      id
      symbol
    }
    bonusMin
    bonusMax
    bonusPeriod
  }
}

"""

result = json.loads(client.execute(QUERY))
geysers = result['data']['geysers']

for geyser in geysers:
        
    geyser_address = geyser['id']

    staking_token_address = geyser['stakingToken']['id']
    staking_token_symbol = geyser['stakingToken']['symbol']

    reward_token_address = geyser['rewardToken']['id']
    reward_token_symbol = geyser['rewardToken']['symbol']
   
    print("geyser: {0}\nstaking token address: {1}\nstaking token symbol: {2}\nreward token address: {3}\nreward token symbol: {4}\n".format(
        geyser_address,
        staking_token_address,
        staking_token_symbol,
        reward_token_address,
        reward_token_symbol
    ))
    
    print("------------")