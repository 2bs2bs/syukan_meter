import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time", "start"]
  timerId = null;

  connect() {
    this.timeValue = 25 * 60; // 25minをsecで表現
    this.updateDisplay();
  }

  // タイマーのスタートロジック
  start() {
    if(!this.timerId){
      this.timerId = setInterval(() => {
        this.timeValue -= 1;
        this.updateDisplay();
        if(this.timeValue === 0){
          clearInterval(this.timerId);
          this.timerId = null;
          alert('Time is up!');
          //ここで必要なら休憩タイマーを開始するロジックを追加できる
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
      this.startTarget.textContent = 'Pause';
    } else {
      this.pause();
      this.startTarget.textContent = 'Start';
    }
  }
}
