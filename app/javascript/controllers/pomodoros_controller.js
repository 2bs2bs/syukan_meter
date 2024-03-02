import { Controller } from "@hotwired/stimulus"

const WORK_DURATION  = 25; 
const BREAK_DURATION = 5;

function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}

function setCookie(name, value, days) {
  let expires = "";
  if (days) {
    const date = new Date();
    date.setTime(date.getTime() + (days*24*60*60*1000));
    expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}

export default class extends Controller {
  static targets = ["time", "start"]

  timerId = null;
  mode = "work"; // 作業モードと休憩モードを切り替えるためのプロパティ

  connect() {
    const savedTime = getCookie('timeValue');
    const savedMode = getCookie('mode');
    this.mode = savedMode || "work";
    this.timeValue = parseInt(savedTime, 10) || WORK_DURATION * 60;
    this.updateDisplay();
    this.updateButtonText();
  }

  // タイマーの時間をセットするメソッド
  setTimer(minutes) {
    this.timeValue = minutes * 60;
    this.updateDisplay();
    this.updateButtonText();
    setCookie('timeValue', this.timeValue, 1);
    setCookie('mode', this.mode, 1);
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
  
        // タイマーの状態を1秒ごとに保存
        setCookie('timeValue', this.timeValue, 1);
        setCookie('mode', this.mode, 1);
  
        if (this.timeValue === 0) {
          clearInterval(this.timerId);
          this.timerId = null;
          alert('Time is up!');
  
          if (this.mode === "work") {
            this.mode = "break";
            this.setTimer(BREAK_DURATION); 
          } else {
            this.mode = "work";
            this.setTimer(WORK_DURATION);
          }
        }
      }, 1000);
    }
  }

  // タイマーの一時停止ロジック
  pause() {
    clearInterval(this.timerId);
    this.timerId = null;
    setCookie('timeValue', this.timeValue, 1);
  }
  

  // タイマーのリセットロジック
  reset() {
    this.pause();
    this.timeValue = this.mode === "work" ? WORK_DURATION * 60 : BREAK_DURATION * 60;
    this.updateDisplay();
    setCookie('timeValue', this.timeValue, 1);
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
