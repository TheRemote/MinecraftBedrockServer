# MinecraftBedrockServer

UbuntuのMinecraft統合版サーバー管理のスクリプトです。サーバーの実行コマンドを変えればJava版のサーバーにも使えます。

## 出来ること

- systemctlでサーバーを操作できます。もしクラッシュしたら自動的に再スタートされます。
- screenでサーバー権限のMinecraftコマンドをいつでも標準入力できます。標準入力・標準出力のログをとれます。
- cronで定期的にバックアップ・再起動できます。
- 複数のサーバーを建てられます。
- setup.sh以外のコードは割とシンプルかなと思います。
- webhookでサーバーの状況とユーザーの入退出をDiscordに出せます。

## To do
- `sudo pip`とか`sudo screen`はあんまりよくないみたいなのでユーザー権限で実行できるように対応を検討中
- 現在の設定を読み込めるようにする

## Requirement
- `sudo pip install watchdog`
- `sudo pip install discord_webhook`
- `sudo pip install python-dotenv`

## サーバーの設定

1. サーバーのセットアップを開始する

    ```sh
    cd MinecraftBedrockServer
    ./setup.sh
    ```

    ```txt
    Enter the server name to be configured, separated by a space: KuuServer KuuPrivateServer GeyserMC
    Enter KuuServer execution command (LD_LIBRARY_PATH=. ./bedrock_server)
    Enter the webhook URL of the discord you want to output the status of KuuServer: https://discord.com/api/webhooks/foo
    Install KuuServer.service into /etc/systemd/system/
    Reload systemd manager configuration
    Enable KuuServer.service

    Enter KuuPrivateServer execution command (LD_LIBRARY_PATH=. ./bedrock_server)
    Enter the webhook URL of the discord you want to output the status of KuuPrivateServer: https://discord.com/api/webhooks/bar
    Install KuuPrivateServer.service into /etc/systemd/system/
    Reload systemd manager configuration
    Enable KuuPrivateServer.service

    Enter GeyserMC execution command (LD_LIBRARY_PATH=. ./bedrock_server) java -Xms1G -Xmx1G -jar paper-1.18.1-175.jar --nogui
    Enter the webhook URL of the discord you want to output the status of GeyserMC:
    Install GeyserMC.service into /etc/systemd/system/
    Reload systemd manager configuration
    Enable GeyserMC.service

    Export the root crontab
    Completed setup
    ```

    ホームディレクトリにサーバーディレクトリが作成される

2. 追加の設定

    統合版の複数のサーバーを実行したい場合は先に19132ポートを使用するサーバーを起動するように、systemdのユニットにAfterまたはBeforeディレクティブでユニットを指定する。

3. サーバー本体を設置

    統合版<https://www.minecraft.net/en-us/download/server/bedrock>やJava版のサーバー本体をダウンロードして、ホームのサーバー名ディレクトリ直下に展開する。複数サーバーをたてる際にはポートが重複しないように注意してserver.propertiesを設定する。

## 使い方

1. サーバーの開始

    ```sh
    sudo systemctl start servername
    ```

2. サーバーの状態をチェックする

    ```sh
    sudo systemctl status servername
    ```

3. セッションの状態をチェックする

    ```sh
    sudo screen -ls
    ```

4. セッションのアタッチ

    ```sh
    sudo screen -r servername
    ```

5. セッションのデタッチ: `Ctrl+a d`

- 設定した全サーバーの停止とバックアップと再スタート

    ```sh
    ~/.MinecraftBedrockServer/stop_backup_and_restart.sh
    ```

- 個別のサーバーの停止とバックアップ

    ```sh
    ~/servername/stop_and_backup_for_restart.sh
    ```

- サーバーの再スタートまたは再開

    ```sh
    sudo systemctl restart servername
    ```

- バックアップせずにサーバーを停止

    ```sh
    sudo systemctl stop servername
    ```

## アンインストール

1. サーバーデーモンの削除
   ```sh
    sudo systemctl disable 不要なサーバー名
    sudo rm /etc/systemd/system/不要なサーバー名.service
    sudo rm -r ~/不要なサーバー名
    ```
2. cronで行われる内容の編集
    - いくつかのサーバーを削除したい場合
        ```sh
        vim ~/.MinecraftBedrockServer/stop_backup_and_restart.sh
        ```
        以下の行を削除
        ```txt
        /home/ユーザー名/不要なサーバー名/stop_and_backup_for_restart.sh
        systemctl restart 不要なサーバー名
        ```
    - すべてのサーバーを削除したい場合
        ```sh
        sudo rm -r ~/.MinecraftBedrockServer
        ```
        ```sh
        sudo crontab -e
        ```
        以下の行を削除
        ```txt
        0 5 * * * /home/ユーザー名/.MinecraftBedrockServer/stop_backup_and_restart.sh
        ```
