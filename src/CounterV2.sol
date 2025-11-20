// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract CounterV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal value;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        /*
            Это блокирует вызов initializer на самой реализации, если кто-то попытается напрямую её дернуть.
            Но через прокси _initialized ещё равен 0 (по умолчанию в прокси storage), 
            потому что _disableInitializers() не меняет storage прокси.
        */
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        //__UUPSUpgradeable_init();
    }

    /**
     * Добавляем новую функцию, чтобы проверять корректность
     * работы апргрейда
     */
    function increment() public {
        value++;
    }

    function getValue() public view returns (uint256) {
        return value;
    }

    /**
     * Меняем версию на актуальную
     */
    function version() public pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
