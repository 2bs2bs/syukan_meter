import { Controller } from "@hotwired/stimulus"

const WORK_DURATION = 25;
const BREAK_DURATION = 5;

export default class extends Controller {
  static targets = ["time", "start"]

  timerId = null;
  mode = "work";

  connect() {
    this.loadFromSession();
    this.updateDisplay();
    this.updateButtonText();
  }

  setTimer(minutes) {
    this.timeValue = minutes * 60;
    this.updateDisplay();
    this.updateButtonText();
    this.saveToSession();
  }

  updateButtonText() {
    this.startTarget.textContent = this.mode === "work" ? "作業開始" : "休憩開始";
  }

  start() {
    if (!this.timerId) {
      this.timerId = setInterval(() => {
        this.timeValue -= 1;
        this.updateDisplay();

        this.saveToSession();

        if (this.timeValue === 0) {
          clearInterval(this.timerId);
          this.timerId = null;
          alert('Time is up!');

          this.mode = this.mode === "work" ? "break" : "work";
          this.setTimer(this.mode === "work" ? WORK_DURATION : BREAK_DURATION);

          if (this.mode === "work") {
            this.createPomodoro();
          }
        }
      }, 1000);
    }
  }

  createPomodoro(){
    fetch('/pomodoros',{
      method: 'Post',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ start_at: startTime, ended_at: endTime })
    })
    .then(response => response.json())
    .then(date => {
      // レスポンスに基づいた処理を追加
    })
    .catch(error => console.error('Error creating Pomodoro:', error));
  }

  pause() {
    clearInterval(this.timerId);
    this.timerId = null;
    this.saveToSession();
  }

  reset() {
    this.pause();
    this.mode = "work";
    this.setTimer(WORK_DURATION);
  }

  updateDisplay() {
    const minutes = Math.floor(this.timeValue / 60);
    const seconds = this.timeValue % 60;
    this.timeTarget.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  toggleStartPause() {
    if (!this.timerId) {
      this.start();
      this.startTarget.textContent = '一時停止';
    } else {
      this.pause();
      this.startTarget.textContent = '再開';
    }
  }

  loadFromSession() {
    const savedTime = parseInt(sessionStorage.getItem('timeValue'), 10);
    const savedMode = sessionStorage.getItem('mode');
    this.mode = savedMode || "work";
    this.timeValue = savedTime || WORK_DURATION * 60;
  }

  saveToSession() {
    sessionStorage.setItem('timeValue', this.timeValue);
    sessionStorage.setItem('mode', this.mode);
  }
}
