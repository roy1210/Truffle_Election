var Election = artifacts.require("./Election.sol");

module.exports = function(deployer) {
  deployer.deploy(Election);
};

//一行目のartifacts.require() は node の require や ES6 の import と同じように、ファイルをインポートしています。三行目はdeploy 用の関数を export しています。この関数では deployer という引数が渡ってくるので、デプロイしたい Contract を渡せばデプロイ対象として認識されます。
