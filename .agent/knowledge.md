# Streamlit 開発ナレッジ共有

Streamlitを用いたデータ可視化アプリ開発において、頻発する問題とその回避策をまとめました。

## 1. デザイン：ガラス質感（Glassmorphism）の実現

Streamlitの標準UIは強力な背景色（白）を持っているため、単に CSS で `backdrop-filter` を指定するだけでは期待通りの透明感が得られない場合があります。

### 解決策
- **コンテナの透明化**: Streamlitのメインコンテナ (`[data-testid="stAppViewContainer"]`) やヘッダーを `background: rgba(0,0,0,0) !important` で明示的に透明化する必要があります。
- **Base64による背景埋め込み**: 背景画像の相対パスがブラウザから正しく参照できない問題を避けるため、画像を Python 側で Base64 エンコードして CSS に直接注入すると動作が安定します。
- **フォントカラーの強制**: 透明感のあるデザインでは背景画像によって文字が見づらくなるため、`!important` を用いて視認性の高い色を指定し、`text-shadow` を活用してください。

## 2. 地図可視化：GeoJSON とデータの紐付け

Plotly などの地図コンポーネントでヒートマップが表示されない原因の多くは、GeoJSON 内の「キー名」の不一致です。

### 解決策
- **GeoJSON の構造確認**: GeoJSON の `properties` 内にどのようなキーがあるか（`name`, `nam_ja`, `id` など）を必ず事前に `head` コマンドなどで確認してください。
- **featureidkey の指定**: `px.choropleth` 等の `featureidkey` 引数に、GeoJSON 内の正しいパス（例: `properties.nam_ja`）を指定します。

## 3. データ連携：DuckDB と Parquet の活用

小～中規模のデータでは DuckDB と Parquet の組み合わせが非常に高速ですが、データ型の不一致（特に日付やカテゴリ型）が起こることがあります。

### 解決策
- **Parquet 直接クエリ**: Parquet ファイルは DuckDB の `read_parquet()` を用いて直接読み込むことで、Pandas との橋渡しにおけるオーバーヘッドを最小限に抑えられます。
- **データ型の明示**: クエリ内で必要に応じて `CAST(column AS TYPE)` を行い、不整合を防ぎます。
