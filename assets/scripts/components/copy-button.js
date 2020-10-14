import ButtonWithToggleText from './button-with-toggle-text'

export default class CopyButton extends ButtonWithToggleText {
	constructor(button) {
		super(button)

		const input = this.button.closest('fieldset, section').querySelector('input')

		this.button.addEventListener('click', () => {
			if (this.button.toggleTimeout) return

			navigator.clipboard.writeText(input.value).then(() => {
				this._toggleText()
				this.button.disabled = true

				this.button.toggleTimeout = setTimeout(() => {
					this._toggleText()
					this.button.toggleTimeout = null
					this.button.disabled = false
				}, 2000)
			})
		})
	}
}
