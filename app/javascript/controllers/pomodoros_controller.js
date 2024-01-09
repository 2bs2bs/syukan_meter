import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time"]

  connect() {
    this.time = 25 * 60;
    this.updateDisplay();
  }

  start() {
    // タイマーのスタートロジック
  }

  pause() {
    // タイマーの一時停止ロジック
  }

  reset() {
    // タイマーのリセットロジック
  }

  updateDisplay() {
    // 表示の更新ロジック
  }
}

// これを上にあてはめるようにきさいする
document.addEventListener('DOMContentLoaded', function () {
  let timerId;
  let time = 25 * 60; // 25分を秒で表現
  const display = document.getElementById('time');
  const startButton = document.getElementById('start');
  const pauseButton = document.getElementById('pause');
  const resetButton = document.getElementById('reset');

  function updateDisplay() {
    const minutes = Math.floor(time / 60);
    const seconds = time % 60;
    display.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  function startTimer() {
    if (!timerId) {
      timerId = setInterval(function () {
        time -= 1;
        updateDisplay();
        if (time === 0) {
          clearInterval(timerId);
          timerId = null;
          alert('Time is up!');
          // ここで必要なら休憩タイマーを開始するロジックを追加できる
        }
      }, 1000);
    }
  }

  function pauseTimer() {
    clearInterval(timerId);
    timerId = null;
  }

  function resetTimer() {
    pauseTimer();
    time = 25 * 60;
    updateDisplay();
  }

  startButton.addEventListener('click', startTimer);
  pauseButton.addEventListener('click', pauseTimer);
  resetButton.addEventListener('click', resetTimer);

  updateDisplay(); // 初期表示を更新
});