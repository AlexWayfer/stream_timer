export default class ConfigurationForm {
	constructor(form) {
		// Bind range input and span with its value

		form.querySelectorAll('input[type="range"]').forEach(rangeElement => {
			const hintElement = rangeElement.parentElement.querySelector('.range-value')

			rangeElement.addEventListener('input', event => {
				hintElement.innerText = (Number.parseFloat(event.target.value) * 100).toFixed()
			})

			rangeElement.dispatchEvent(new Event('input'))
		})

		// Enhance configuration key fieldset

		form.querySelectorAll('fieldset.configuration_key').forEach(fieldset => {
			const
				input = fieldset.querySelector('input[type="password"]'),
				showButton = fieldset.querySelector('button.show'),
				copyButton = fieldset.querySelector('button.copy')

			// Implement "Show" button for configuration key

			showButton.addEventListener('click', () => {
				input.type = input.type == 'password' ? 'text' : 'password'
				this._toggleButtonText(showButton)
			})

			// Implement "Copy" button for configuration key

			copyButton.addEventListener('click', () => {
				if (this.copyButtonToggleTimeout) return

				navigator.clipboard.writeText(input.value).then(() => {
					this._toggleButtonText(copyButton)
					this.copyButtonToggleTimeout = setTimeout(() => {
						this._toggleButtonText(copyButton)
						this.copyButtonToggleTimeout = null
					}, 2000)
				})
			})
		})
	}

	_toggleButtonText(button) {
		const oldText = button.innerText
		button.innerText = button.dataset.toggleText
		button.dataset.toggleText = oldText
	}
}
