// Copyright © 2018 Stormbird PTE. LTD.

import Foundation
import UIKit

struct TokenInstanceAction {
    enum ActionType {
        case erc20Send
        case erc20Receive
        case nftRedeem
        case nftSell
        case nonFungibleTransfer
        case tokenScript(contract: AlphaWallet.Address, title: String, viewHtml: String, attributes: [AttributeId: AssetAttribute], transactionFunction: FunctionOrigin?)
    }
    var name: String {
        switch type {
        case .erc20Send:
            return R.string.localizable.send()
        case .erc20Receive:
            return R.string.localizable.receive()
        case .nftRedeem:
            return R.string.localizable.aWalletTokenRedeemButtonTitle()
        case .nftSell:
            return R.string.localizable.aWalletTokenSellButtonTitle()
        case .nonFungibleTransfer:
            return R.string.localizable.aWalletTokenTransferButtonTitle()
        case .tokenScript(_, let title, _, _, _):
            return title
        }
    }
    var attributes: [AttributeId: AssetAttribute] {
        switch type {
        case .erc20Send, .erc20Receive:
            return .init()
        case .nftRedeem, .nftSell, .nonFungibleTransfer:
            return .init()
        case .tokenScript(_, _, _, let attributes, _):
            return attributes
        }
    }
    var transactionFunction: FunctionOrigin? {
        switch type {
        case .erc20Send, .erc20Receive:
            return nil
        case .nftRedeem, .nftSell, .nonFungibleTransfer:
            return nil
        case .tokenScript(_, _, _, _, let transactionFunction):
            return transactionFunction
        }
    }
    var contract: AlphaWallet.Address? {
        switch type {
        case .erc20Send, .erc20Receive:
            return nil
        case .nftRedeem, .nftSell, .nonFungibleTransfer:
            return nil
        case .tokenScript(let contract, _, _, _, _):
            return contract
        }
    }
    var hasTransactionFunction: Bool {
        return transactionFunction != nil
    }
    //TODO storing this means we can't live-reload the action view screen
    let viewHtml: String
    let type: ActionType

    init(type: ActionType) {
        self.type = type
        switch type {
        case .erc20Send, .erc20Receive:
            self.viewHtml = ""
        case .nftRedeem:
            self.viewHtml = ""
        case .nftSell:
            self.viewHtml = ""
        case .nonFungibleTransfer:
            self.viewHtml = ""
        case .tokenScript(_, _, let viewHtml, _, _):
            self.viewHtml = wrapWithHtmlViewport(viewHtml)
        }
    }
}
