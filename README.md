# 論文生成 DevContainer

このリポジトリは、コーディングエージェントを活用して論文や技術文書の草稿を迅速に作成するための VS Code Dev Container 環境です。LaTeX（日本語・英語対応）を中心に、図表生成やテキスト整形に必要なツールがプリインストールされており、エージェントによる自動生成・編集ワークフローをそのまま実行できます。

## ディレクトリ構成

```
.
├── project/                  # 原稿本体（main.tex と各セクション）
├── build/                    # 言語別ビルドエントリポイント（main-en.tex / main-jp.tex）
├── outline.md                # 骨子メモ
├── outline-to-project.prompt.md  # エージェント指示用プロンプト
├── template/                 # 任意配置の LaTeX テンプレート
├── out/                      # latexmk 生成物
├── .github/                  # CI 設定（latex-engine.env 等）
├── .devcontainer/            # Dev Container 設定
├── language_switch.sty       # 日英切替マクロ定義
├── latexmkrc                 # 共通ビルド設定（XeLaTeX デフォルト）
├── justfile                  # just タスクランナー（build / clean）
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
- ビルドは `just` 経由を基本にします。生成物はすべて `out/` に集約され、`project/` には置きません。

  ```bash
  just build     # 英語版を pdfLaTeX で out/main.pdf に生成
  just build jp  # 日本語版を pdfLaTeX で out/main-jp.pdf に生成
  just clean     # out/ を掃除し、誤って project/ にできた生成物も除去
  ```

- `just build` / `just build jp` はビルド用ラッパー TeX を介して `LATEXMK_ENGINE=pdflatex latexmk ...` を呼びます。`latexmkrc` により出力先は `out/` に固定されます。
- CI（GitHub Actions）のビルドエンジンは `.github/latex-engine.env` 内の `LATEX_ENGINE` を変更して切り替えられます。`project/` 内で直接 `latexmk` を叩く運用は避けてください。
- 日英を切り替える場合は、`project/main.tex` 冒頭で `\input{../language_switch.sty}` を読み込み、本文中は `\japanese{...}` / `\english{...}` を使ってそれぞれの言語表現を囲みます。通常は `just build` と `just build jp` で切り替えます。

### (2) コーディングエージェントで爆速執筆する場合
- まず `outline.md` に章構成・要点・参考文献メモを整理します。
- 利用したいクラスファイルやテンプレートがある場合は、ユーザーが事前に `template/` に配置しておきます。
- エージェントには `outline-to-project.prompt.md` を読み込ませ、指示に従って `project/` 以下の LaTeX ファイルを生成・更新してもらいます。README ではなく、プロンプトファイルに詳細な手順・注意事項をまとめています。
- バイリンガル出力が必要な場合もプロンプトに `language_switch.sty` の使い方が含まれているため、同ファイルを読み込ませるだけで `\english{}` / `\japanese{}` を使った原稿を生成できます。
- 生成された差分を確認し、必要に応じて手動で修正してから `just build` でビルドします。
