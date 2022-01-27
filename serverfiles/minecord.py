#!/usr/bin/env python3
import signal
import time
import os
import re
from watchdog.events import RegexMatchingEventHandler
from watchdog.observers import Observer
from discord_webhook import DiscordWebhook
from dotenv import load_dotenv

# 環境変数を読み込む
load_dotenv()
WEBHOOK_URL = os.environ["WEBHOOK_URL"]


def on_modified(event):
    if os.path.getsize(event.src_path) != 0:
        with open(event.src_path, "r") as file:
            last_line = file.readlines()[-1]
            # It's say, not /say. In other words, it is a server command only.
            if re.match('say', last_line):
                server_say_word = re.search(
                    '(?<=say )(.*)', last_line).group()
                webhook = DiscordWebhook(
                    url=WEBHOOK_URL, content=server_say_word)
                webhook.execute()
            elif re.match('\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}:\d{3} INFO] Player connected', last_line):
                connected_player_name = re.search(
                    '(?<=Player connected: )(.*)(?=, xuid:)', last_line).group()
                print(connected_player_name+'がゲームに参加しました。')
                webhook = DiscordWebhook(
                    url=WEBHOOK_URL, content=connected_player_name+'がゲームに参加しました。')
                webhook.execute()
            elif re.match('\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}:\d{3} INFO] Player disconnected', last_line):
                disconnected_player_name = re.search(
                    '(?<=Player disconnected: )(.*)(?=, xuid:)', last_line).group()
                print(disconnected_player_name+"がゲームから退出しました。")
                webhook = DiscordWebhook(
                    url=WEBHOOK_URL, content=disconnected_player_name+'がゲームから退出しました。')
                webhook.execute()


def handler(_signum, _frame):
    observer.stop()
    observer.join()
    exit(0)


print(os.getpid())
event_handler = RegexMatchingEventHandler('^\.\/\d{12}\.log$')
event_handler.on_modified = on_modified
path = "."
observer = Observer()
observer.schedule(event_handler, path, recursive=False)
observer.start()
signal.signal(signal.SIGTERM, handler)

while True:
    time.sleep(1)
