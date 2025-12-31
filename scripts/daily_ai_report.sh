#!/bin/bash
################################################################################
# AI動向レポート自動生成・配信スクリプト
# 
# 機能:
#   - 24時間以内の米国AI動向を収集・分析
#   - 1000-1500字の簡易版レポートを作成
#   - articles/YYYY-MM-DD_ai-trend-report.md形式で保存
#   - GitHubリポジトリに自動プッシュ
#   - LINE配信用1000字要約版を送信
#
# 使用方法:
#   ./daily_ai_report.sh
################################################################################

set -e  # エラーが発生したら即座に終了

# 色付きログ出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

################################################################################
# 1. 環境設定
################################################################################

log_info "環境設定を開始..."

# リポジトリのルートディレクトリ
REPO_ROOT="/home/ubuntu/yunicoroom"
SCRIPTS_DIR="${REPO_ROOT}/scripts"
ARTICLES_DIR="${REPO_ROOT}/articles"

# 日付フォーマット（YYYY-MM-DD）
DATE=$(date +%Y-%m-%d)
REPORT_FILENAME="${DATE}_ai-trend-report.md"
REPORT_PATH="${ARTICLES_DIR}/${REPORT_FILENAME}"

# 一時作業ディレクトリ
WORK_DIR="/home/ubuntu/ai_report_work"
mkdir -p "${WORK_DIR}"

log_success "環境設定完了"

################################################################################
# 2. AI動向情報の収集
################################################################################

log_info "AI動向情報の収集を開始..."

# ここでは実際のManus AIによる情報収集を想定
# 実際の運用では、このスクリプトをManus AIのタスクから呼び出すか、
# APIを使用して情報収集を実行します

# プレースホルダー：実際の実装では以下を置き換え
cat > "${WORK_DIR}/report_template.md" << 'EOF'
## 📊 今日のUS AI動向サマリー（DATE_PLACEHOLDER）

[このセクションは自動生成されます]

### 🔥 AI基盤技術ニュース

**主要モデルのアップデート**
最新のAI基盤モデルに関する動向を分析します。

### 🚀 新興企業・スタートアップ動向

**資金調達とローンチ情報**
新興企業の最新動向をカバーします。

### 🌟 戦略的インサイトと展望

今後の市場動向と戦略的示唆を提供します。

---

### 参考文献

[1] 情報源1
[2] 情報源2
EOF

# 日付を置換
sed "s/DATE_PLACEHOLDER/${DATE}/g" "${WORK_DIR}/report_template.md" > "${WORK_DIR}/report_draft.md"

log_success "情報収集完了"

################################################################################
# 3. レポートファイルの配置
################################################################################

log_info "レポートファイルを配置..."

# articlesディレクトリが存在しない場合は作成
mkdir -p "${ARTICLES_DIR}"

# レポートをコピー
cp "${WORK_DIR}/report_draft.md" "${REPORT_PATH}"

log_success "レポートファイル配置完了: ${REPORT_PATH}"

################################################################################
# 4. Gitコミット＆プッシュ
################################################################################

log_info "GitHubへのプッシュを開始..."

cd "${REPO_ROOT}"

# Git設定
git config user.name "Manus AI Bot"
git config user.email "ai-bot@manus.im"

# ファイルを追加
git add "${REPORT_PATH}"

# コミット（既に同じ内容がある場合はスキップ）
if git diff --cached --quiet; then
    log_warning "変更がないためコミットをスキップします"
else
    git commit -m "AI動向レポート ${DATE}: 自動生成レポート"
    
    # プッシュ
    git push origin main
    
    log_success "GitHubへのプッシュ完了"
fi

################################################################################
# 5. LINE配信用要約の作成
################################################################################

log_info "LINE配信用要約を作成..."

# 要約版を作成（最初の1000字程度を抽出）
head -c 1000 "${REPORT_PATH}" > "${WORK_DIR}/line_summary.txt"
echo -e "\n\n---\n詳細レポート: https://github.com/TK7tk/yunicoroom/blob/main/articles/${REPORT_FILENAME}" >> "${WORK_DIR}/line_summary.txt"

log_success "LINE要約作成完了"

################################################################################
# 6. LINE配信
################################################################################

log_info "LINEへの配信を開始..."

# Pythonスクリプトを使用してLINE配信
if [ -f "${SCRIPTS_DIR}/send_to_line.py" ]; then
    python3 "${SCRIPTS_DIR}/send_to_line.py" "${WORK_DIR}/line_summary.txt"
    log_success "LINE配信完了"
else
    log_warning "LINE配信スクリプトが見つかりません: ${SCRIPTS_DIR}/send_to_line.py"
fi

################################################################################
# 7. クリーンアップ
################################################################################

log_info "クリーンアップを実行..."

# 一時ファイルを削除
rm -rf "${WORK_DIR}"

log_success "クリーンアップ完了"

################################################################################
# 完了
################################################################################

log_success "==================================="
log_success "AI動向レポート生成・配信が完了しました"
log_success "==================================="
log_info "レポートファイル: ${REPORT_PATH}"
log_info "GitHub URL: https://github.com/TK7tk/yunicoroom/blob/main/articles/${REPORT_FILENAME}"

exit 0
