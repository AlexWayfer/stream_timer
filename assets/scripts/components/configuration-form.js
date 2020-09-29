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

		// Show button scripts

		form.querySelectorAll('button.show').forEach(showButton => {
			const input = showButton.closest('fieldset').querySelector('input[type="password"]')

			showButton.addEventListener('click', () => {
				input.type = input.type == 'password' ? 'text' : 'password'
				this._toggleButtonText(showButton)
			})
		})

		// Copy button scripts

		form.querySelectorAll('button.copy').forEach(copyButton => {
			const input = copyButton.closest('fieldset').querySelector('input')

			copyButton.addEventListener('click', () => {
				if (copyButton.toggleTimeout) return

				navigator.clipboard.writeText(input.value).then(() => {
					this._toggleButtonText(copyButton)
					copyButton.disabled = true
					copyButton.toggleTimeout = setTimeout(() => {
						this._toggleButtonText(copyButton)
						copyButton.toggleTimeout = null
						copyButton.disabled = false
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
