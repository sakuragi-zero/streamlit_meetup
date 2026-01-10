---
description: 既存のアプリ関連フォルダ（assets, services, views, templates, tests）とapp.pyを削除して環境をリセットします。
---

> [!WARNING]
> このワークフローを実行すると、現在のアプリの実装が完全に削除されます。続行する前に必要なファイルのバックアップがあることを確認してください。

以下のコマンドを実行して、既存のプロジェクト構造をクリーンアップします。

// turbo
1. 既存のフォルダとファイルを削除します：
```bash
rm -rf assets/ services/ views/ templates/ tests/ log/ app.py *.db
```

2. 削除が完了したことを確認します：
```bash
ls -F
```