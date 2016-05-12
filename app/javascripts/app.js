var accounts;
var account;
var accountID = 0

var campaign





function setChangeAccount(newAccount) {
  accountID = newAccount;
  account = accounts[accountID];
  displayAccounts();
}

function displayAccounts() {
//  var accountList = accounts
//    .map((x, i) => ('<button onclick="setChangeAccount(' + i + ')">' + i + '</button>' + ' : ' + x) + (i == accountID ? '     <------ you are this guy' : ''))
//    .join('<br>')
//  $("#accounts").html(accountList)
}

window.onload = function() {
  web3.eth.getAccounts(function(err, accs) {
    if (err != null) {
      alert("There was an error fetching your accounts.");
      return;
    }

    if (accs.length == 0) {
      alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
      return;
    }

    campaign = Campaign.deployed();

    accounts = accs;
    account = accounts[accountID];

    displayAccounts();

  });
}
