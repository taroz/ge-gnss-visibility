# Google Earthから可視性判別
## KMLファイルを作成

1. MATLABスクリプト `generate_kml.m` の設定を入力

```MATLAB
%% 設定
llh = [35.95076110 139.35094319 82.463]; % 計算する緯度経度
```
2. `generate_kml.m` を実行
    - `ge_fov140.kml` と `ge_fov160.kml`が生成される
3. Google Earthで画像をキャプチャ
    - `ge_fov140.kml` と `ge_fov160.kml` をGoogle Earthで読み込む
    - `ツール -> 動画メーカ` から画像をキャプチャ
        - 保存したツアーで上記のkmlを選択
        - 保存先、名前を設定 `パス/ge_fov1xx.jpg` にする
        - 動画パラメータを `Custom`
        - 画像サイズを `1200 x 1200`
        - 出力形式を `JPEG画像シーケンス`
4. `generate_fisheye.m` を実行
5. `plot_satellite.m` の設定部分を入力
```MATLAB
%% 設定
fishcam_model = 'fishcam_sim'; % 魚眼カメラモデル
imfile = 'ge.jpg'; % 魚眼画像
obsfile = 'gnss.obs'; % RINEX observation
navfile = 'gnss.nav'; % RINEX navigation
llh = [35.95076110 139.35094319 82.463]; % 計算する緯度経度
az_offset = 0; % 画像回転
CNR_mask = 30; % 表示するCNRのマスク
```
6.  `plot_satellite.m` を実行
