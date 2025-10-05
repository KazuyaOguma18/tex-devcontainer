# 論文生成 DevContainer

このリポジトリは、コーディングエージェントを活用して論文や技術文書の草稿を迅速に作成するための VS Code Dev Container 環境です。LaTeX（日本語・英語対応）を中心に、図表生成やテキスト整形に必要なツールがプリインストールされており、エージェントによる自動生成・編集ワークフローをそのまま実行できます。

## ディレクトリ構成

```
.
├── project/                  # 原稿本体（main.tex と各セクション）
├── outline.md                # 骨子メモ
├── outline-to-project.prompt.md  # エージェント指示用プロンプト
├── template/                 # 任意配置の LaTeX テンプレート
├── out/                      # latexmk 生成物
├── .github/                  # CI 設定（latex-engine.env 等）
├── .devcontainer/            # Dev Container 設定
├── latexmkrc                 # 共通ビルド設定（XeLaTeX デフォルト）
└── README.md
```

## セットアップ

1. VS Code と拡張機能「Dev Containers」または「Remote-Containers」をインストールします。
2. このリポジトリをクローンし、VS Code で開きます。
3. 「Reopen in Container」を実行すると、開発環境が立ち上がります。

初回ビルドには数分かかることがありますが、コンテナ構築後は同じイメージを再利用します。

## 推奨ワークフロー

### (1) 手動で執筆する場合
- `project/` 配下の `main.tex` や各セクションファイルを直接編集して原稿を整えます。
- ビルドは次のコマンドが基本です。生成物はすべて `out/` に集約されます。

  ```bash
  latexmk -C project/main.tex                       # （初回や再ビルド前に）生成物をクリーンアップ
  latexmk project/main.tex                          # デフォルト: XeLaTeX で out/main.pdf を生成
  LATEXMK_ENGINE=pdflatex latexmk project/main.tex  # pdfLaTeX で生成したい場合
  ```

- CI（GitHub Actions）のビルドエンジンは `.github/latex-engine.env` 内の `LATEX_ENGINE` を変更して切り替えられます。`project/` 内で作業するときは `latexmk -r ../latexmkrc main.tex` のように設定ファイルを参照してください。

### (2) コーディングエージェントで爆速執筆する場合
- まず `outline.md` に章構成・要点・参考文献メモを整理します。
- 利用したいクラスファイルやテンプレートがある場合は、ユーザーが事前に `template/` に配置しておきます。
- エージェントには `outline-to-project.prompt.md` を読み込ませ、指示に従って `project/` 以下の LaTeX ファイルを生成・更新してもらいます。README ではなく、プロンプトファイルに詳細な手順・注意事項をまとめています。
- 生成された差分を確認し、必要に応じて手動で修正してから上記と同じ `latexmk` コマンドでビルドします。
