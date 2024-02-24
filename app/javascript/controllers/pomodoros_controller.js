import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time", "start"]
  timerId = null;


  // 定数の定義
  WORK_TIME = 25 * 60; // 25分
  BREAK_TIME = 5 * 60; // 5分

  connect() {
    this.timeValue = this.WORK_TIME; // 作業タイマーをデフォルトに設定
    this.isWorkTimer = true;
    this.updateDisplay();
  }

  // タイマーのスタートロジック
  start() {
    if (!this.timerId) {
      this.timerId = setInterval(() => {
        this.timeValue -= 1;
        this.updateDisplay();
        if (this.timeValue === 0) {
          this.endTimer();
        }
      }, 1000);
    }
  }

  // タイマーの終了処理
  endTimer() {
    clearInterval(this.timerId);
    this.timerId = null;
    alert('Time is up!');
    this.timeValue = this.isWorkTimer ? this.BREAK_TIME : this.WORK_TIME; // 作業タイマーと休憩タイマーを切り替える
    this.isWorkTimer = !this.isWorkTimer; // 状態を切り替える
    this.updateDisplay();

    this.startTarget.textContent = this.isWorkTimer ? '作業開始' : '休憩開始';
  }

  // タイマーの一時停止ロジック
  pause() {
    clearInterval(this.timerId);
    this.timerId = null;
  }

  // タイマーのリセットロジック
  reset() {
    this.pause();
    this.timeValue = this.isWorkTimer ? this.WORK_TIME : this.BREAK_TIME; // 現在のモードに応じてタイムをリセット
    this.updateDisplay();
  }

  // 表示の更新ロジック
  updateDisplay() {
    const minutes = Math.floor(this.timeValue / 60);
    const seconds = this.timeValue % 60;
    this.timeTarget.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  // タイマーのスタート・一時停止ロジックの切り替え
  toggleStartPause() {
    if (!this.timerId) {
      this.start();
      this.startTarget.textContent = '一時停止';
    } else {
      this.pause();
      this.startTarget.textContent = '再開';
    }
  }
}