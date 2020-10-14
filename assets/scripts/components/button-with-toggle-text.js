export default class ButtonWithToggleText {
	constructor(button) {
		this.button = button
	}

	_toggleText() {
		const oldText = this.button.innerText
		this.button.innerText = this.button.dataset.toggleText
		this.button.dataset.toggleText = oldText
	}
}
