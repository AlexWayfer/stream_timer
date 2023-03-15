export class Show {
	constructor(container) {
		const actualTimer = container.querySelector('p:not(.countdown-information)')

		this.countdownInformationElement = container.querySelector('p.countdown-information')

		this.textBeforeElement = actualTimer.querySelector('.text-before')

		this.timeElement = actualTimer.querySelector('.time')

		this.hoursContainerElement = this.timeElement.querySelector('.hours-container')
		this.hoursElement = this.hoursContainerElement.querySelector('.hours')
		this.minutesElement = this.timeElement.querySelector('.minutes')
		this.secondsElement = this.timeElement.querySelector('.seconds')

		const specificTimeDifference = new Date() - Date.parse(container.dataset.specificTime)

		if (specificTimeDifference) {
			const
				differenceInSeconds = Math.floor(Math.abs(specificTimeDifference) / 1000),
				differenceInMinutes = Math.floor(differenceInSeconds / 60),
				differenceInHours = Math.floor(differenceInMinutes / 60)

			this.hours = differenceInHours
			this.minutes = differenceInMinutes % 60
			this.seconds = differenceInSeconds % 60
		} else {
			this.hours = parseInt(this.hoursElement.innerText)
			this.minutes = parseInt(this.minutesElement.innerText)
			this.seconds = parseInt(this.secondsElement.innerText)
		}

		this.displayCountupTime = container.dataset.displayCountupTime

		const functionName =
			(specificTimeDifference && specificTimeDifference > 0) || container.dataset.onlyCountup ?
				'_countUp' :
				'_countDown'

		if (functionName == '_countUp') this._changeTextToCountup()

		this.interval = setInterval(() => this[functionName](), 1000)

		container.querySelector(':scope > div').classList.remove('transparent')
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

			this._changeTextToCountup()

			if (!this.displayCountupTime) return

			this.seconds++
			this.interval = setInterval(() => this._countUp(), 1000)
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

	_changeTextToCountup() {
		this.textBeforeElement.innerText = this.textBeforeElement.dataset.countupTextBefore

		if (this.countdownInformationElement) {
			this.countdownInformationElement.classList.remove('hidden')
		}

		if (!this.displayCountupTime) {
			this.timeElement.classList.add('hidden')
		}
	}
}
