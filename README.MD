# Yocto Custom Image Example

## Описание
Автоматизация сборки дистирбутива embedded linux с помощью yocto.

## How to use

### 0 Build Docker
Для сборки используется docker образ, содержащий в себе toolchain для сборки, а также все необходимые зависимости

    docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t yocto-build-env .

### 1 Run Docker

	chmod +x run_build_env.sh
	./run_build_env.sh
	
Запущен docker в интерактивном режиме, файлы сборки шарятся с хостовой ОС

### 2 Build Image

	./build.sh
	

### Issues and fixes
Сборка проверялась на хосте WSL.
В зависимости от хостовой ОС, периферии и использовании WSL во время сборки Yocto может выбрасывать разные ошибки, мало имеющие связи с реальностью.
Точная причина ошибок неизвестна, предполагается, что всему виной внутренние особенности WSL. Цитата из оффициальной документации:

	"It is compatible but neither officially supported nor validated with WSL 2"

Зачастую достаточно просто перезапустить скрипт сборки ./build.sh.

Также полезно в таких ситуациях пересобрать пакет полностью:

	bitbake -c clean <package_name>
	
		or
	
    bitbake -c cleanall <package_name>

В случае, если не помогло - необходимо копать в сторону настроек local.conf и разбираться с рецептами пакетов.

Полезные комманды:

Вывести список рецептов

    bitbake-layers show-recipes

Вывести список слоев

    bitbake-layers show-layers

Вывести путь к файлу рецепта

    bitbake -e <recipe_name> | grep ^FILE=
