import { Controller } from "@hotwired/stimulus"

const WORK_DURATION  = 25; 
const BREAK_DURATION = 5;

export default class extends Controller {
  static targets = ["time", "start"]
  timerId = null;
  mode = "work"; // 作業モードと休憩モードを切り替えるためのプロパティ

  connect() {
    this.setTimer(25); // 最初は25分の作業タイマーからスタート
  }

  // タイマーの時間をセットするメソッド
  setTimer(minutes) {
    this.timeValue = minutes * 60;
    this.updateDisplay();
    this.updateButtonText(); // ボタンのテキスト更新を別メソッドに分離
  }

  updateButtonText() {
    this.startTarget.textContent = this.mode = "work" ? "作業開始" : "休憩開始";
  }

  // タイマーのスタートロジック
  start() {
    if (!this.timerId) {
      this.timerId = setInterval(() => {
        this.timeValue -= 1;
        this.updateDisplay();
        if (this.timeValue === 0) {
          clearInterval(this.timerId);
          this.timerId = null;
          alert('Time is up!');
          // タイマーが0になったら、モードを切り替えてタイマーを再設定する
          if (this.mode === "work") {
            this.mode = "break"; // 作業モードから休憩モードに切り替え
            this.setTimer(BREAK_DURATION); // 5分の休憩タイマーをセット
          } else {
            this.mode = "work"; // 休憩モードから作業モードに切り替え
            this.setTimer(WORK_DURATION); // 25分の作業タイマーをセット
          }
        }
      }, 1000);
    }
  }

  // タイマーの一時停止ロジック
  pause() {
    clearInterval(this.timerId);
    this.timerId = null;
  }

  // タイマーのリセットロジック
  reset() {
    this.pause();
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
