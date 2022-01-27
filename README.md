# MinecraftBedrockServer

UbuntuのMinecraft統合版サーバー管理のスクリプトです。サーバーの実行コマンドを変えればJava版のサーバーにも使えます。

## 出来ること

- systemctlでサーバーを操作できます。もしクラッシュしたら自動的に再スタートされます。
- screenでサーバー権限のMinecraftコマンドをいつでも標準入力できます。標準入力・標準出力のログをとれます。
- cronで定期的にバックアップ・再起動できます。
- 複数のサーバーを建てられます。
- setup.sh以外のコードは割とシンプルかなと思います。
- webhookでサーバーの状況とユーザーの入退出をDiscordに出せます。


## Requirement
- `pip install --system watchdog`
- `pip install --system discord_webhook`
- `pip install --systempython-dotenv`

## サーバーの設定

1. サーバーのセットアップを開始する

    ```bash
    cd MinecraftBedrockServer
    ./setup.sh
    ```

    ホームディレクトリにサーバーディレクトリが作成される

2. 追加の設定

    統合版の複数のサーバーを実行したい場合は先に19132ポートを使用するサーバーを起動するように、systemdのユニットにAfterまたはBeforeディレクティブでユニットを指定する。

3. サーバー本体を設置

    統合版<https://www.minecraft.net/en-us/download/server/bedrock>やJava版のサーバー本体をダウンロードして、ホームのサーバー名ディレクトリ直下に展開する。複数サーバーをたてる際にはポートが重複しないように注意してserver.propertiesを設定する。

## 使い方

1. サーバーの開始

    ```bash
    sudo systemctl start servername
    ```

2. サーバーの状態をチェックする

    ```bash
    sudo systemctl status servername
    ```

3. セッションの状態をチェックする

    ```bash
    sudo screen -ls
    ```

4. セッションのアタッチ

    ```bash
    sudo screen -r servername
    ```

5. セッションのデタッチ: `Ctrl+a d`

- 設定した全サーバーの停止とバックアップと再スタート

    ```bash
    ~/.MinecraftBedrockServer/stop_backup_and_restart.sh
    ```

- 個別のサーバーの停止とバックアップ

    ```bash
    ~/servername/stop_and_backup_for_restart.sh
    ```

- サーバーの再スタートまたは再開

    ```bash
    sudo systemctl restart servername
    ```

- バックアップせずにサーバーを停止

    ```bash
    sudo systemctl stop servername
    ```

## アンインストール

1. サーバーデーモンの削除
   ```bash
    sudo systemctl disable 不要なサーバー名
    sudo rm /etc/systemd/system/不要なサーバー名.service
    sudo rm -r ~/不要なサーバー名
    ```
2. cronで行われる内容の編集
    - いくつかのサーバーを削除したい場合
        ```bash
        vim ~/.MinecraftBedrockServer/stop_backup_and_restart.sh
        ```
        以下の行を削除
        ```txt
        /home/ユーザー名/不要なサーバー名/stop_and_backup_for_restart.sh
        systemctl restart 不要なサーバー名
        ```
    - すべてのサーバーを削除したい場合
        ```bash
        sudo rm -r ~/.MinecraftBedrockServer
        ```
        ```bash
        sudo crontab -e
        ```
        以下の行を削除
        ```txt
        0 5 * * * /home/ユーザー名/.MinecraftBedrockServer/stop_backup_and_restart.sh
        ```
