#!/usr/bin/env python3
"""
AI動向レポートをLINEに配信するスクリプト
MCP (Model Context Protocol) を使用してLINEメッセージを送信

使用方法:
    python3 send_to_line.py [要約ファイルパス]
    
引数:
    要約ファイルパス: 送信するテキストファイルのパス（省略時は標準の場所を使用）
"""

import subprocess
import json
import sys
import os

def send_line_message(message_text):
    """
    manus-mcp-cli を使用してLINEにテキストメッセージを送信
    
    Args:
        message_text (str): 送信するメッセージテキスト
    
    Returns:
        bool: 送信成功時True、失敗時False
    """
    try:
        # LINEメッセージ送信用のJSON引数を構築
        input_data = {
            "message": {
                "type": "text",
                "text": message_text
            }
        }
        
        # manus-mcp-cli を使用してメッセージ送信
        cmd = [
            "manus-mcp-cli",
            "tool",
            "call",
            "broadcast_text_message",
            "--server",
            "line",
            "--input",
            json.dumps(input_data)
        ]
        
        print("📤 LINEにメッセージを送信中...")
        
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=True
        )
        
        print("✅ 送信成功！")
        if result.stdout:
            print(f"出力: {result.stdout}")
        return True
        
    except subprocess.CalledProcessError as e:
        print(f"❌ 送信失敗: {e}")
        if e.stderr:
            print(f"エラー出力: {e.stderr}")
        return False
    except Exception as e:
        print(f"❌ 予期しないエラー: {e}")
        return False

def main():
    """メイン処理"""
    # コマンドライン引数から要約ファイルパスを取得
    if len(sys.argv) > 1:
        summary_file = sys.argv[1]
    else:
        # デフォルトの場所
        summary_file = "/home/ubuntu/line_summary.txt"
    
    # ファイルの存在確認
    if not os.path.exists(summary_file):
        print(f"❌ ファイルが見つかりません: {summary_file}")
        sys.exit(1)
    
    try:
        # 要約テキストファイルを読み込み
        with open(summary_file, "r", encoding="utf-8") as f:
            message_text = f.read()
        
        print(f"📄 要約ファイルを読み込みました: {summary_file}")
        print(f"📏 文字数: {len(message_text)}文字")
        
        # 文字数チェック（LINEの制限は5000文字）
        if len(message_text) > 5000:
            print("⚠️  警告: メッセージが5000文字を超えています。切り詰めます。")
            message_text = message_text[:4900] + "\n\n...(文字数制限のため省略)"
        
        print("-" * 50)
        print(message_text[:200] + "..." if len(message_text) > 200 else message_text)
        print("-" * 50)
        
        # LINEに送信
        success = send_line_message(message_text)
        
        if success:
            print("\n🎉 AI動向レポートのLINE配信が完了しました！")
            sys.exit(0)
        else:
            print("\n⚠️  LINE配信に失敗しました")
            sys.exit(1)
            
    except Exception as e:
        print(f"❌ エラーが発生しました: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
