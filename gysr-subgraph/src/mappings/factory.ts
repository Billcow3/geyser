// GYSR factory event handling and mapping

import { Address, BigInt, log } from "@graphprotocol/graph-ts"
import { GeyserFactory, GeyserCreated } from "../../generated/GeyserFactory/GeyserFactory"
import { Geyser as GeyserContract } from "../../generated/GeyserFactory/Geyser"
import { ERC20 } from "../../generated/GeyserFactory/ERC20"
import { Geyser, Token } from "../../generated/schema"


export function handleGeyserCreated(event: GeyserCreated): void {

  let contract = GeyserContract.bind(event.params.geyser);

  let stakingToken = Token.load(contract.stakingToken().toHexString())

  let rewardToken = Token.load(contract.rewardToken().toHexString())

  // entity
  let geyser = new Geyser(event.params.geyser.toHexString());
  geyser.stakingToken = stakingToken.id;
  geyser.rewardToken = rewardToken.id;
  geyser.bonusMin = contract.bonusMin();
  geyser.bonusMax = contract.bonusMax();
  geyser.bonusPeriod = contract.bonusPeriod();
  geyser.createdBlock = event.block.number;
  geyser.createdTimestamp = event.block.timestamp;

  geyser.save();
}