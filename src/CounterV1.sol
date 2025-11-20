// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * Создаём абсолютно тривиальный контракт, который может
 * доставать одну переменную из хранилища
 * и возвращать одно константное значение
 */
contract CounterV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    /**
     * Мы предупреждаем о том, что запускать конструктор нельзя,
     * так как мы работаем с обновляемым контрактом
     */
    constructor() {
        /*
            Это блокирует вызов initializer на самой реализации, если кто-то попытается напрямую её дернуть.
            Но через прокси _initialized ещё равен 0 (по умолчанию в прокси storage), 
            потому что _disableInitializers() не меняет storage прокси.
        */
        _disableInitializers();
    }

    /*
        Ты вызываешь initialize() через прокси при деплое:

        ERC1967Proxy proxy = new ERC1967Proxy(address(counter), data);

        - address(counter) — адрес реализации (CounterV1)
        - data — это abi.encodeCall(CounterV1.initialize, ())

        Прокси конструктор делает примерно так:

        if (data.length > 0) {
            (bool success,) = _implementation.delegatecall(data);
            require(success);
        }

        Как работает delegatecall:

        delegatecall исполняет код реализации в контексте прокси
        Все переменные состояния (_owner из OwnableUpgradeable) записываются в прокси, а не в реализацию
        msg.sender при delegatecall = тот, кто вызвал прокси

        Ты деплоишь прокси через Foundry скрипт:

        vm.startBroadcast();
        CounterV1 counter = new CounterV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(counter), data);
        vm.stopBroadcast();

        В этот момент vm.startBroadcast() заменяет msg.sender на адрес твоего приватного ключа, который ты передал через команду:

        forge script script/DeployCounter.s.sol:DeployCounter --rpc-url $SEPOLIA_RPC --private-key $PRIVATE_KEY --broadcast

        Следовательно, msg.sender в initialize() = твой адрес, с которого делается деплой
        Именно этот адрес становится owner прокси:

        __Ownable_init(msg.sender); // owner = твой адрес
    */
    function initialize() public initializer {
        __Ownable_init(msg.sender); //делаем transferOwnership на msg.sender
        //__UUPSUpgradeable_init(); // Ничего не делаем :)
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    /*
       Эта функция вызывается каждый раз, когда прокси пытается вызвать upgradeTo() или upgradeToAndCall().
       Она проверяет, имеет ли вызывающий право обновлять реализацию.

       Когда ты вызываешь скрипт апгрейда:
       proxy.upgradeToAndCall(address(newCounter), "");

       Прокси вызывает реализацию через delegatecall, а внутри UUPS выполняется _authorizeUpgrade(newImplementation)
       Внутри _authorizeUpgrade срабатывает onlyOwner → проверка msg.sender == owner
       Если проверка прошла — апгрейд разрешается, прокси меняет ссылку на новую реализацию.
    */

    /**
     * Данная функция является обизательной, так как она объявлена в
     * абстрактном классе UUPSUpgradeable, но не определена
     * Здесь нам нужно лишь указать, какие ограничения мы ставим на
     * возможность обновлять наш контракт
     * В нашем случае используем onlyOwner
     * @param newImplementation адрес нового проксируемого адреса
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
