# MinecraftBedrockServer

UbuntuのMinecraft統合版サーバー管理のスクリプトです。サーバーの実行コマンドを変えればJava版のサーバーにも使えます。

## 出来ること

- systemctlでサーバーを操作できます。もしクラッシュしたら自動的に再スタートされます。
- screenでサーバー権限のMinecraftコマンドをいつでも標準入力できます。標準入力・標準出力のログをとれます。
- cronで定期的にバックアップ・再起動できます。
- 複数のサーバーを建てられます。
- setup.sh以外のコードは割とシンプルかなと思います。

## サーバーの設定

1. サーバーのセットアップを開始する

    ```bash
    cd MinecraftBedrockServer
    ./setup.sh
    ```

    実行例:

    ```txt
    Enter the server name to be configured, separated by a space: KuuServerRC KuuPrivateServer BuildCraft
    Enter KuuServerRC execution command (LD_LIBRARY_PATH=. ./bedrock_server)
    Install KuuServerRC.service into /etc/systemd/system/
    Reload systemd manager configuration
    Do you want to enable automatic startup of the KuuServerRC? [Y/n] Y
    Enable KuuServerRC.service
    Created symlink /etc/systemd/system/multi-user.target.wants/KuuServerRC.service → /etc/systemd/system/KuuServerRC.service.

    Enter KuuPrivateServer execution command (LD_LIBRARY_PATH=. ./bedrock_server)
    Install KuuPrivateServer.service into /etc/systemd/system/
    Reload systemd manager configuration
    Do you want to enable automatic startup of the KuuPrivateServer? [Y/n] Y
    Enable KuuPrivateServer.service
    Created symlink /etc/systemd/system/multi-user.target.wants/KuuPrivateServer.service → /etc/systemd/system/KuuPrivateServer.service.

    Enter BuildCraft execution command (LD_LIBRARY_PATH=. ./bedrock_server) java -Xmx1024M -Xms1024M -jar forge-xxx-universal.jar
    Install BuildCraft.service into /etc/systemd/system/
    Reload systemd manager configuration
    Do you want to enable automatic startup of the BuildCraft? [Y/n] Y
    Enable BuildCraft.service
    Created symlink /etc/systemd/system/multi-user.target.wants/BuildCraft.service → /etc/systemd/system/BuildCraft.service.

    Do you want to stop, back up, and reboot at 5am? [Y/n] Y
    Export the root crontab
    Add the contents to root's crontab and overwrite it
    Completed setup
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
