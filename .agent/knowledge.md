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

## 4. 依存ライブラリの管理（ImportErrorの回避）

Streamlitアプリは実行時に動的にインポートを行うため、必要なパッケージ（`plotly`, `pandas` など）が環境に含まれていない場合でも、アプリを起動してページにアクセスするまでエラーが顕在化しないことがあります。

### 解決策
- **`/check-env` の活用**: 開発開始時に必ず依存ライブラリがインストールされているか確認してください。
- **エラーログのバッファリング対策**: エラー検出ワークフロー実行時は、ログがバッファリングされてファイルに即時書き込まれない可能性があるため、`PYTHONUNBUFFERED=1` を設定して起動することを推奨します。

## 5. Plotly プロパティ名の注意点

Plotlyのバージョンによって、あるいはPython版とJS版の違いにより、プロパティ名が異なる場合があります。特に古いサンプルコードを参考にする際は注意が必要です。

### 解決策
- **スネークケースの推奨**: Python版 Plotly では、`titlefont` ではなく `title_font` のようにスネークケースが標準となっている箇所が多くあります。
- **エラーメッセージの確認**: `Bad property path` エラーが出た場合、Plotlyが表示する「Did you mean...?」の提案が正解であることが多いです。

## 6. Layout: HTML Wrapperの誤用（空要素の発生）

Streamlitにおいて、`st.markwon` で `<div>` 開始タグと `</div>` 終了タグを個別に呼び出して、その間に Streamlit ウィジェット（`st.plotly_chart` 等）を配置しようとしても、期待通りにウィジェットは `div` 内に含まれません。Streamlit の仕組み上、`st.markdown` はそのコンポーネント自体で完結するHTMLを生成するだけであり、後続の Python コードで生成されるコンポーネントを内包することはできません。

### 間違いの例
```python
st.markdown('<div class="card">', unsafe_allow_html=True)
st.plotly_chart(fig) # 実際には div の外（後）に出力される
st.markdown('</div>', unsafe_allow_html=True)
```

このコードを実行すると、空の `<div class="card"></div>` が描画された後に、グラフが描画されます。スタイルが適用された空枠だけが表示される「お化けウィジェット」の原因となります。

### 解決策
- **単一の st.markdown 内で完結させる**: 純粋な HTML コンテンツであれば、1つの `st.markdown` 呼び出しにすべて含めます。
- **st.container の活用**: グルーピングが必要な場合は `st.container()` を使用します（ただし、標準機能だけでは自由なクラス付与はできません）。
- **スタイルの適用方法**: ウィジェットを HTML でラップするのではなく、CSS セレクタを工夫して（例: `data-testid` 属性など）スタイルを適用するか、背景色などはグラフ自体の設定（Plotly の `paper_bgcolor` など）で行います。
