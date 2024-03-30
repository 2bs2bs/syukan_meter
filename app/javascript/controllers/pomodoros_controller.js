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
    this.checkTimerStatus();
    this.updateButtonText();
    console.log('connect')
  }

  setTimer(minutes) {
    this.initialTimeValue = minutes * 60;
    this.timeValue = minutes * 60;
    this.updateDisplay();
    this.updateButtonText();
    this.saveToSession();
  }

  checkTimerStatus() {
    const startTime = sessionStorage.getItem('startTime');
    if (startTime) {
      const elapsedTime = Math.floor((Date.now() - parseInt(startTime, 10)) / 1000);
      const remainingTime = this.initialTimeValue - elapsedTime;
      if (remainingTime > 0) {
        // タイマーがまだ動いている場合
        this.startTarget.textContent = '一時停止';
      }
    }
  }

  updateButtonText() {
    this.startTarget.textContent = this.mode === "work" ? "作業開始" : "休憩開始";
  }

  start() {
    console.log(this.initialTimeValue);
    if (!this.timerId) {
      const savedTimeValue = sessionStorage.getItem('timeValue');
      if (savedTimeValue){
        this.timeValue = parseInt(savedTimeValue, 10);
      }
      this.startTime = Date.now() - (this.initialTimeValue - this.timeValue) * 1000; //タイマー開始時刻を記録
      const elapsedTime = Math.floor((Date.now() - this.startTime) / 1000);
      this.timeValue = this.initialTimeValue - elapsedTime;
      sessionStorage.setItem('startTime', this.startTime.toString());
      this.timerId = setInterval(this.updateTimer.bind(this), 1000);
      this.startTarget.textContent = '一時停止'
    }
  }

  updateTimer(){
    const elapsedTime = Math.floor((Date.now() - this.startTime) / 1000);
    this.timeValue = this.initialTimeValue - elapsedTime;
    this.updateDisplay();
    this.saveToSession();

    if(this.timeValue <= 0){
      clearInterval(this.timerId);
      this.timerId = null;
      alert('Time is up!');
      this.mode = this.mode === "work" ? "break" : "work";
      this.setTimer(this.mode === "work" ? WORK_DURATION : BREAK_DURATION);
      if(this.mode === "break"){
        this.createPomodoro();
      }
    }
  }

  createPomodoro(){
    console.log('pomodoro create');
    this.updatePomodoroCount();

    const endTime = new Date().toISOString();

    fetch('/pomodoros',{
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ pomodoro: { start_at: new Date(this.startTime).toISOString(), end_at: endTime } })
    })
    .then(response => response.json())
    .then(data => {
      // レスポンスに基づいた処理を追加
    })
    .catch(error => console.error('Error creating Pomodoro:', error));
  }

  pause() {
    console.log('pause')
    console.log(this.timerId)
    if (this.timerId){
      clearInterval(this.timerId);
      this.timerId = null;
      sessionStorage.setItem('timeValue', this.timeValue.toString());
      this.saveToSession();
      console.log('Timer paused');
    }
  }

  reset() {
    this.pause();
    if (this.mode === "break"){
      this.setTimer(BREAK_DURATION);
    } else {
      this.setTimer(WORK_DURATION);
    }
  }

  updateDisplay() {
    const minutes = Math.floor(this.timeValue / 60);
    const seconds = this.timeValue % 60;
    this.timeTarget.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  toggleStartPause() {
    if (!this.timerId) {
      this.start();
    } else {
      this.pause();
      this.startTarget.textContent = '再開';
    }
  }

  loadFromSession() {
    const savedTime = parseInt(sessionStorage.getItem('timeValue'), 10);
    const savedMode = sessionStorage.getItem('mode');
    const savedStartTime = parseInt(sessionStorage.getItem('startTime'), 10)

    this.mode = savedMode || "work";
    this.timeValue = savedTime || WORK_DURATION * 60;
    this.initialTimeValue = this.timeValue;

    // セッションストレージから保存されたstartTimeを読み込む
    if(savedStartTime){
      this.startTime = savedStartTime;
      // 現在時刻と保存された開始時刻から経過時間を計算
      const elapsedTime = Math.floor((Date.now() - this.startTime) / 1000);
      // 経過時間を考慮してtimeValueを更新
      this.timeValue = Math.max(this.initialTimeValue - elapsedTime, 0);

      // タイマーが0になっていなければ、タイマーを再開する
      if(this.timeValue > 0 && !this.timerId){
        this.start();
      }
    }
  }

  saveToSession() {
    sessionStorage.setItem('timeValue', this.timeValue.toString());
    sessionStorage.setItem('mode', this.mode);
    sessionStorage.setItem('startTime', this.startTime.toString());
  }

  // 今日タイマー完了が一回目ならモーダル表示を行う
  updatePomodoroCount() {
    const today = new Date().toLocaleDateString();
    const pomodoroCount = localStorage.getItem(today) || 0;
    console.log(pomodoroCount);

    if (pomodoroCount == 0) {
      showModal();
      console.log("モーダル表示");
    }
  
    // 当日の呼び出し回数を更新
    localStorage.setItem(today, parseInt(pomodoroCount) + 1);
  }
}
