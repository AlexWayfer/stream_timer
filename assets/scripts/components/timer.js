export default class Timer {
	constructor(container) {
		this.textBeforeElement = container.querySelector('.text-before')

		this.hoursContainerElement = container.querySelector('.hours-container')
		this.hoursElement = this.hoursContainerElement.querySelector('.hours')
		this.minutesElement = container.querySelector('.minutes')
		this.secondsElement = container.querySelector('.seconds')

		this._hours = parseInt(this.hoursElement.innerText)
		this._minutes = parseInt(this.minutesElement.innerText)
		this._seconds = parseInt(this.secondsElement.innerText)

		const functionName = container.dataset.onlyCountup ? '_countUp' : '_countDown'
		this.interval = setInterval(() => this[functionName](), 1000)
	}

	get hours() {
		return this._hours
	}

	set hours(value) {
		this._hours = value

		const hoursClassList = this.hoursContainerElement.classList

		if (value == 0) {
			if (!hoursClassList.contains('hidden')) hoursClassList.add('hidden')
		} else {
			this.hoursElement.innerText = this._padding(value)
			if (hoursClassList.contains('hidden')) hoursClassList.remove('hidden')
		}
	}

	get minutes() {
		return this._minutes
	}

	set minutes(value) {
		this._minutes = value
		this.minutesElement.innerText = this._padding(value)
	}

	get seconds() {
		return this._seconds
	}

	set seconds(value) {
		this._seconds = value
		this.secondsElement.innerText = this._padding(value)
	}

	_padding(value) {
		return value.toString().padStart(2, '0')
	}

	_countDown() {
		if (this.seconds > 0) {
			this.seconds--
		} else if (this.minutes > 0) {
			this.minutes--
			this.seconds = 59
		} else if (this.hours > 0) {
			this.hours--
			this.minutes = 59
			this.seconds = 59
		} else {
			clearInterval(this.interval)
			this.seconds++
			this.interval = setInterval(() => this._countUp(), 1000)
			this.textBeforeElement.innerText = this.textBeforeElement.dataset.countupTextBefore
		}
	}

	_countUp() {
		if (this.seconds === 59) {
			this.seconds = 0
			this.minutes++
			if (this.minutes === 59) {
				this.minutes = 0
				this.hours++
			}
		} else {
			this.seconds++
		}
	}
}
