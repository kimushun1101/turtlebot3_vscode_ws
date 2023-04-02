# TurtleBot3 VS Code Workspace

TurtleBot3 の環境を半自動的に構築するワークスペース。
[VSCode ROS2 Workspace Template](https://github.com/athackst/vscode_ros2_workspace) を使用しています。

## 使い方

1. (Windows の場合) [WSL](#wsl) をインストール
   * OS は何でもよいと思われるが[Ubuntu](https://www.microsoft.com/store/productId/9PDXGNCFSCZV) でテストした。
2. Docker とVS Code のインストール、VS Code に拡張機能remote containers をインストール
   * [docker](https://docs.docker.com/engine/install/)  
   * [vscode](https://code.visualstudio.com/)
   * [vscode remote containers plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)  
3. このリポジトリをClone してVS Code で開く（Windows の場合はWSL で実行）
   ```
   git clone https://github.com/kimushun1101/turtlebot3_vscode_ws.git
   code turtlebot3_vscode_ws
   ```
4. (Windows の場合) 環境変数DISPLAY の設定 
   1. WSL2 のターミナルで以下のコマンドを実行
   ```
   echo $DISPLAY
   ```
   例えば，`:0` など出力されるはず
   2. このワークスペースにある`.devcontainer/devcontainer.json` の20行目を`$DISPLAY` の結果に編集  
   ```jsonc
      "DISPLAY": ":0",
   ```
5. VS Code ウィンドウ左下の`><` をクリックして`Reopen in container` をクリック
   * うまく行かない場合、Docker が起動しているか確認
   * Docker の環境ができるまで数分かかる
6. Turtlebot3 のソースコードと依存ソフトをインストール
   * `Terminal` → `Run Task..` → `setup`
   * これはもっと時間がかかる
   * `Terminal` → `Run Task..` は頻繁に使用するのキーボードショートカットに設定するとよい  
     `Ctrl + K` → `Ctrl + S` → `tasks: run task` を編集，例えば`Ctrl + Shift + T` に設定
7. ビルドする`Ctrl + Shif + B`
8. Turtlebot3 のサンプルを試す
   1. シミュレータを起動：`Ctrl + J` でターミナルを開き`./scripts/turtlebot3_world.bash`  
     最初は時間がかかりturtlebot3 のモデルの読み込みに失敗するが、`Ctrl + C` してから再実行すれば大丈夫なはず。
   2. SLAM を実行：`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/slam.bash`
   3. キーボードから速度指令値を入力：`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/teleop.bash`
   4. 地図を保存：速度入力のソフトを`Ctrl + C` で終了して`./scripts/save.bash`
   5. 自律走行：一度全てのターミナルを破棄して`Ctrl + J` でターミナルを開き`./scripts/turtlebot3_world.bash` でシミュレータを起動、その後`Ctrl + Shift + 5` で新しいターミナルを増やし`./scripts/navigation.bash`
9.  `src` 以下に自作パッケージを作成
   `Terminal` → `Run Task..` から
   * cmake パッケージを新規作成 : `new ament_cmake package`
   * python パッケージを新規作成 : `new ament_python package`
   * ソースコード管理サーバからClone : `src/ros2.repos` を編集して`setup`

