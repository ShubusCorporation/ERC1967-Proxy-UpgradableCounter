## Тестирование в Foundry (Часть 3)
[Приятного чтения](https://habr.com/ru/articles/765266/)


$ forge script script/DeployCounter.s.sol:DeployCounter --rpc-url ${SEPOLIA_RPC} --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
[⠑] Compiling...
No files changed, compilation skipped
Traces:
  [1093106] DeployCounter::run()
    ├─ [0] VM::startBroadcast()
    │   └─ ← [Return]
    ├─ [905703] → new CounterV1@0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37
    │   ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    │   └─ ← [Return] 4404 bytes of code
    ├─ [117407] → new ERC1967Proxy@0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A
    │   ├─ emit Upgraded(implementation: CounterV1: [0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37])
    │   ├─ [49643] CounterV1::initialize() [delegatecall]
    │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0x730BFc4f4D221a8D84787524973692C0801Fe681)
    │   │   ├─ emit Initialized(version: 1)
    │   │   └─ ← [Stop]
    │   └─ ← [Return] 212 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Return] ERC1967Proxy: [0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A]


Script ran successfully.

== Return ==
0: address 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [905703] → new CounterV1@0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37
    ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    └─ ← [Return] 4404 bytes of code

  [119907] → new ERC1967Proxy@0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A
    ├─ emit Upgraded(implementation: CounterV1: [0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37])
    ├─ [49643] CounterV1::initialize() [delegatecall]
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0x730BFc4f4D221a8D84787524973692C0801Fe681)
    │   ├─ emit Initialized(version: 1)
    │   └─ ← [Stop]
    └─ ← [Return] 212 bytes of code


==========================

Chain 11155111

Estimated gas price: 0.001000017 gwei

Estimated total gas used for script: 1596121

Estimated amount required: 0.000001596148134057 ETH

==========================

##### sepolia
✅  [Success] Hash: 0x59ec0e0f3502539e1f3e48fa3957bddd24e57e35b074e5e9e5143583e6cbfb83
Contract Address: 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A
Block: 9497546
Paid: 0.000000197319789276 ETH (197319 gas * 0.001000004 gwei)


##### sepolia
✅  [Success] Hash: 0x7079c17b720bf0d49e7ba77a10b108f93db40d311b3e51c03dbefe71db7cae22
Contract Address: 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37
Block: 9497546
Paid: 0.000001030471121868 ETH (1030467 gas * 0.001000004 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.000001227790911144 ETH (1227786 gas * avg 0.001000004 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
##
Start verification for (2) contracts
Start verifying contract `0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37` deployed on sepolia
EVM version: prague
Compiler version: 0.8.30

Submitting verification for [src/CounterV1.sol:CounterV1] 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37.
Error: Encountered an error verifying this contract:
Response: `NOTOK`
Details:
                        `Missing/Invalid API Key`


First attempt to upgrade was failed:

$ forge script script/UpgradeCounter.s.sol:UpgradeCounter --rpc-url $SEPOLIA_RPC --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY --ffi -vvvv
Warning: Found unknown config section in foundry.toml: [fs_permissions]
This notation for profiles has been deprecated and may result in the profile not being registered in future versions.
Please use [profile.fs_permissions] instead or run `forge config --fix`.
[⠒] Compiling...
No files changed, compilation skipped
Traces:
  [2665343] → new UpgradeCounter@0x5b73C5498c1E3b4dbA84de0F1833c4a029d90519
    └─ ← [Return] 13200 bytes of code

  [3675] UpgradeCounter::run()
    ├─ [0] VM::readDir("./broadcast", 3) [staticcall]
    │   └─ ← [Revert] vm.readDir: the path broadcast is not allowed to be accessed for read operations
    └─ ← [Revert] vm.readDir: the path broadcast is not allowed to be accessed for read operations


Error: script failed: vm.readDir: the path broadcast is not allowed to be accessed for read operations
To fix add the following to the foundry.toml: `fs_permissions = [{ access = "read", path = "./broadcast" }]`


Second attempt to upgrade the Counter was successful:

$ forge script script/UpgradeCounter.s.sol:UpgradeCounter --rpc-url $SEPOLIA_RPC --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY --ffi -vvvv
[⠒] Compiling...
No files changed, compilation skipped
Traces:
  [1642193] UpgradeCounter::run()
    ├─ [0] VM::readDir("./broadcast", 3) [staticcall]
    │   └─ ← [Return] [("", "D:/Sources/SOLIDITY/2/broadcast\\DeployCounter.s.sol", 1, true, false), ("", "D:/Sources/SOLIDITY/2/broadcast\\DeployCounter.s.sol\\11155111", 2, true, false), ("", "D:/Sources/SOLIDITY/2/broadcast\\DeployCounter.s.sol\\11155111\\run-latest.json", 3, false, false)]
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::readFile("D:/Sources/SOLIDITY/2/broadcast/DeployCounter.s.sol/11155111/run-latest.json") [staticcall]
    │   └─ ← [Return] <file>
    ├─ [0] VM::toString(0) [staticcall]
    │   └─ ← [Return] "0"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[0]") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::toString(0) [staticcall]
    │   └─ ← [Return] "0"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[0].contractName") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::parseJsonString("<stringified JSON>", "$.transactions[0].contractName") [staticcall]
    │   └─ ← [Return] "CounterV1"
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[1]") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[1].contractName") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::parseJsonString("<stringified JSON>", "$.transactions[1].contractName") [staticcall]
    │   └─ ← [Return] "ERC1967Proxy"
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::parseJsonAddress("<stringified JSON>", "$.transactions[1].contractAddress") [staticcall]
    │   └─ ← [Return] 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A
    ├─ [0] VM::toString(2) [staticcall]
    │   └─ ← [Return] "2"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[2]") [staticcall]
    │   └─ ← [Return] false
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::toString(11155111 [1.115e7]) [staticcall]
    │   └─ ← [Return] "11155111"
    ├─ [0] VM::readFile("D:/Sources/SOLIDITY/2/broadcast/DeployCounter.s.sol/11155111/run-latest.json") [staticcall]
    │   └─ ← [Return] <file>
    ├─ [0] VM::parseJsonUint("<stringified JSON>", ".timestamp") [staticcall]
    │   └─ ← [Return] 1761516332548 [1.761e12]
    ├─ [0] VM::toString(0) [staticcall]
    │   └─ ← [Return] "0"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[0]") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::toString(0) [staticcall]
    │   └─ ← [Return] "0"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[0].contractName") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::parseJsonString("<stringified JSON>", "$.transactions[0].contractName") [staticcall]
    │   └─ ← [Return] "CounterV1"
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[1]") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[1].contractName") [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::parseJsonString("<stringified JSON>", "$.transactions[1].contractName") [staticcall]
    │   └─ ← [Return] "ERC1967Proxy"
    ├─ [0] VM::toString(1) [staticcall]
    │   └─ ← [Return] "1"
    ├─ [0] VM::parseJsonAddress("<stringified JSON>", "$.transactions[1].contractAddress") [staticcall]
    │   └─ ← [Return] 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A
    ├─ [0] VM::toString(2) [staticcall]
    │   └─ ← [Return] "2"
    ├─ [0] VM::keyExistsJson("<JSON file>", "$.transactions[2]") [staticcall]
    │   └─ ← [Return] false
    ├─ [0] VM::startBroadcast()
    │   └─ ← [Return]
    ├─ [940342] → new CounterV2@0xd79B1870992324c2755b4C245dA8206FE1906587
    │   ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    │   └─ ← [Return] 4577 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    ├─ [0] VM::startBroadcast()
    │   └─ ← [Return]
    ├─ [14326] 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A::upgradeToAndCall(CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587], 0x)
    │   ├─ [9346] 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37::upgradeToAndCall(CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587], 0x) [delegatecall]
    │   │   ├─ [440] CounterV2::proxiableUUID() [staticcall]
    │   │   │   └─ ← [Return] 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    │   │   ├─ emit Upgraded(implementation: CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587])
    │   │   └─ ← [Stop]
    │   └─ ← [Return]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Return] 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A


Script ran successfully.

== Return ==
0: address 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [940342] → new CounterV2@0xd79B1870992324c2755b4C245dA8206FE1906587
    ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    └─ ← [Return] 4577 bytes of code

  [16826] 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A::upgradeToAndCall(CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587], 0x)
    ├─ [11846] 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37::upgradeToAndCall(CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587], 0x) [delegatecall]
    │   ├─ [440] CounterV2::proxiableUUID() [staticcall]
    │   │   └─ ← [Return] 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    │   ├─ emit Upgraded(implementation: CounterV2: [0xd79B1870992324c2755b4C245dA8206FE1906587])
    │   └─ ← [Stop]
    └─ ← [Return]


==========================

Chain 11155111

Estimated gas price: 0.001000024 gwei

Estimated total gas used for script: 1441040

Estimated amount required: 0.00000144107458496 ETH

==========================

##### sepolia
✅  [Success] Hash: 0xe268a8c6d7b1a21e5b1c3209c526edc9956f5843476847100064edb30870b087
Contract Address: 0xd79B1870992324c2755b4C245dA8206FE1906587
Block: 9497789
Paid: 0.00000106757174316 ETH (1067560 gas * 0.001000011 gwei)


##### sepolia
✅  [Success] Hash: 0xc6efe1e8a4e365a610a5aac5389756819b67f0dd1f6bd79658b3abc96bcfd370
Block: 9497789
Paid: 0.000000038526423786 ETH (38526 gas * 0.001000011 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.000001106098166946 ETH (1106086 gas * avg 0.001000011 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
##
Start verification for (1) contracts
Start verifying contract `0xd79B1870992324c2755b4C245dA8206FE1906587` deployed on sepolia
EVM version: prague
Compiler version: 0.8.30

Submitting verification for [src/CounterV2.sol:CounterV2] 0xd79B1870992324c2755b4C245dA8206FE1906587.
Error: Encountered an error verifying this contract:
Response: `NOTOK`
Details:
                        `Missing/Invalid API Key`



- Я уже все задеплоил и проапгрейдил, но верификация в Etherscan не прошла Можно ли запустить ее отдельно?

🔍 Пример для твоего контракта
Ты задеплоил:

CounterV1 → 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37
CounterV2 → 0xd79B1870992324c2755b4C245dA8206FE1906587

Тогда можно выполнить:

forge verify-contract 0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37 src/CounterV1.sol:CounterV1 \
  --chain sepolia \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  --watch

и потом:

forge verify-contract 0xd79B1870992324c2755b4C245dA8206FE1906587 src/CounterV2.sol:CounterV2 \
  --chain sepolia \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  --watch



Давай разберём на твоём примере — контракт Counter, который ты задеплоил и потом проапгрейдил через прокси (ERC1967Proxy).

⚙️ Твоя структура после апгрейда:

Контракт	 !   Адрес	                                      ! Назначение
-------------------------------------------------------------------------------------------------------------------------------
CounterV1	 !   0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37	  ! первая реализация (implementation)
CounterV2	 !   0xd79B1870992324c2755b4C245dA8206FE1906587	  ! обновлённая реализация
ERC1967Proxy ! 	 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A	  ! адрес, через который пользователь взаимодействует с контрактом    


🧭 Шаг 1. Открываем прокси на Etherscan
Перейди по адресу:
🔗 https://sepolia.etherscan.io/address/0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A


- Там сообщение Are you the contract creator? Verify and Publish your contract source code today!
  Похоже, нужно проверифицировать? Я проверифицировал только CounterV1 и CounterV2


🔧 Как верифицировать прокси (ERC1967Proxy)

Forge позволяет верифицировать и его, как обычный контракт.
Попробуй выполнить:

forge verify-contract 0x3dB60F3D138cA31c82783A283368Fe7cf27E7F1A \
  lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol:ERC1967Proxy \
  --chain sepolia \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  --constructor-args $(cast abi-encode "constructor(address,bytes)" \
    0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37 \
    0x8129fc1c) \
  --watch

🧠 Разбор параметров:

0x3dB60F3D... — адрес самого прокси
ERC1967Proxy.sol:ERC1967Proxy — путь и имя контракта
0xEe50EEFa37AFc1E4788D9B8F045Fe0D47E4a3E37 — адрес реализации (CounterV1, с которой прокси стартовал)
0x8129fc1c — это hex-код вызова функции initialize() (без аргументов)
— именно эти данные передавались в конструктор при деплое прокси


Первый запрос в Alchemy:
`curl https://eth-sepolia.g.alchemy.com/v2/i-DWPJsNvn7o-1Zo89HQW -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", false],"id":0}'`


Переменная окружения SEPOLIA_RPC в вашем примере используется для хранения URL RPC-сервера, через который ваш скрипт или приложение будет взаимодействовать с блокчейном Ethereum в сети Sepolia.

1. Что такое RPC в контексте блокчейнов?

В контексте блокчейнов RPC предоставляет интерфейс для взаимодействия с сетью блокчейна. То есть, это протокол, который позволяет вам отправлять запросы на серверы, хранящие данные блокчейна, и получать ответы, такие как:

  - Состояние блокчейна (например, баланс адреса).
  - Отправка транзакций.
  - Получение данных о блоках или транзакциях.

Для работы с блокчейном, например с Ethereum, вам нужен доступ к RPC-серверу, который соединяется с самой сетью Ethereum. В вашем случае это сервер сети Sepolia — тестовой сети Ethereum.

2. Роль сервиса Alchemy

Alchemy — это сервис, предоставляющий инфраструктуру для взаимодействия с блокчейнами. Он предлагает высокоскоростные и надежные RPC-узлы для различных блокчейнов, включая Ethereum и другие сети. Вместо того, чтобы самостоятельно развертывать собственный узел Ethereum, вы можете использовать Alchemy для более удобного доступа к блокчейну через их API. Это позволяет вам делать запросы и отправлять транзакции в блокчейн без необходимости управления инфраструктурой.

Alchemy предоставляет URL RPC, как в вашем примере (https://eth-sepolia.g.alchemy.com/v2/i-DWPJsNvn7o-1Zo89HQW), который можно использовать для взаимодействия с сетью Sepolia через их серверы.
