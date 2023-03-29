# TurtleBot3 VS Code Workspace

TurtleBot3 の環境を半自動的に構築するワークスペース。
[VSCode ROS2 Workspace Template](https://github.com/athackst/vscode_ros2_workspace) を使用しています。

## 使い方

1. Docker とVS Code のインストール、VS Code に拡張機能remote containers をインストール
   * [docker](https://docs.docker.com/engine/install/)
   * [vscode](https://code.visualstudio.com/)
   * [vscode remote containers plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. このリポジトリをClone またはDownload
   * `git clone https://github.com/kimushun1101/turtlebot3_vscode_ws.git`
   * `code▼` から`Download ZIP` して展開
3. このフォルダをVS Code を開き、ウィンドウ左下の`><` をクリックして`Reopen in container` をクリック
   * うまく行かない場合、Docker が起動しているか確認
   * Docker の環境ができるまで数分かかる
4. Turtlebot3 のソースコードと依存ソフトをインストール  
   `Terminal` → `Run Task..` → `setup`
5. ビルドする`Ctrl + Shif + B`
6. Turtlebot3 のサンプルを試す
   1. シミュレータを起動：`Ctrl + J` でターミナルを開き`./scripts/turtlebot3_world.bash`  
     最初は時間がかかりturtlebot3 のモデルの読み込みに失敗するが、`Ctrl + C` してから再実行すれば大丈夫なはず。
   2. SLAM を実行：`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/slam.bash`
   3. キーボードから速度指令値を入力：`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/teleop.bash`
   4. 地図を保存：速度入力のソフトを`Ctrl + C` で終了して`./scripts/save.bash`
   5. 自律走行：一度全てのターミナルを破棄して`Ctrl + J` でターミナルを開き`./scripts/turtlebot3_world.bash` でシミュレータを起動、その後`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/navigation.bash`

## FAQ

### WSL2

#### The gui doesn't show up

This is likely because the DISPLAY environment variable is not getting set properly.

1. Find out what your DISPLAY variable should be

      In your WSL2 Ubuntu instance

      ```
      echo $DISPLAY
      ```

2. Copy that value into the `.devcontainer/devcontainer.json` file

      ```jsonc
      	"containerEnv": {
		      "DISPLAY": ":0",
         }
      ```

#### I want to use vGPU

If you want to access the vGPU through WSL2, you'll need to add additional components to the `.devcontainer/devcontainer.json` file in accordance to [these directions](https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md)

```jsonc
	"runArgs": [
		"--network=host",
		"--cap-add=SYS_PTRACE",
		"--security-opt=seccomp:unconfined",
		"--security-opt=apparmor:unconfined",
		"--volume=/tmp/.X11-unix:/tmp/.X11-unix",
		"--volume=/mnt/wslg:/mnt/wslg",
		"--volume=/usr/lib/wsl:/usr/lib/wsl",
		"--device=/dev/dxg",
      		"--gpus=all"
	],
	"containerEnv": {
		"DISPLAY": "${localEnv:DISPLAY}", // Needed for GUI try ":0" for windows
		"WAYLAND_DISPLAY": "${localEnv:WAYLAND_DISPLAY}",
		"XDG_RUNTIME_DIR": "${localEnv:XDG_RUNTIME_DIR}",
		"PULSE_SERVER": "${localEnv:PULSE_SERVER}",
		"LD_LIBRARY_PATH": "/usr/lib/wsl/lib",
		"LIBGL_ALWAYS_SOFTWARE": "1" // Needed for software rendering of opengl
	},
```
