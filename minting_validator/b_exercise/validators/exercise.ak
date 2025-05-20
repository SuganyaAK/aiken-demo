use aiken/crypto.{Blake2b_256, Hash}
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}
use exercise/types/action.{Action, Burn, Mint}
use exercise/types/redeemer.{MyRedeemer}
use exercise/util

validator check_redeemer {
  mint(redeemer: ByteArray, _policy_id: PolicyId, _tx: Transaction) {
    todo @"Allow minting/burning when `redeemer` equals to ``Hello, World!``"
  }

  else(_) {
    fail
  }
}

validator check_redeemer_2 {
  mint(redeemer: MyRedeemer, policy_id: PolicyId, tx: Transaction) {
    trace @"redeemer": redeemer

    let MyRedeemer {
      output_reference: (transaction_id, output_index),
      is_minting,
    } = redeemer

    let Transaction { mint, inputs, .. } = tx
    let mint_qty = mint |> util.mint_qty(policy_id)

    if is_minting? {
      and {
        (mint_qty > 0)?,
        util.consume_utxo(
          inputs,
          OutputReference { transaction_id, output_index },
        )?,
      }
    } else {
      (mint_qty < 0)?
    }
  }

  else(_) {
    fail
  }
}

// pub type MyRedeemer {
//   output_reference: (ByteArray, Int),
//   is_minting: Bool,
// }

// pub type Action {
//   Mint
//   Burn
// }

validator nft(
  transaction_id: Hash<Blake2b_256, Transaction>,
  output_index: Int,
) {
  mint(redeemer action: Action, policy_id: PolicyId, tx: Transaction) {
    todo @"Validate minting/burning based on `action`"

    let Transaction { mint, input, .. } = tx
    when action is {
      Mint -> and {
          (mint_qty == 1)?,
          consume_utxo(tx.input, OutputReference(transaction_id, output_index))?,
        }
    }
    // If `action` is `Action.Mint`:
    // - check mint qty must equal to 1
    // - check `OutputReference(transaction_id, output_index)` UTxO must be consumed
    //
    // If `action` is `Action.Burn`:
    // - check mint qty must equal to -1
  }

  else(_) {
    fail
  }
}
