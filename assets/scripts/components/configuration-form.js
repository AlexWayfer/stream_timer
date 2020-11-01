export default class ConfigurationForm {
	constructor(form) {
		const
			timeline = form.querySelector('fieldset.timeline'),
			countdownFieldset = timeline.querySelector('fieldset.countdown'),
			countupFieldset = timeline.querySelector('fieldset.countup'),
			onlyCountupCheckbox = timeline.querySelector('.only-countup input[type="checkbox"]'),
			specificTimeCheckbox = timeline.querySelector('label.specific-time input[type="checkbox"]'),
			specificTimeInput =
				countdownFieldset.querySelector('input[name*="[specific_time]"]:not([type="hidden"])'),
			displayCountdownInformation = countupFieldset.querySelector('.display-countdown-information'),
			displayCountupTime = countupFieldset.querySelector('.display-countup-time'),
			displayCountupTimeCheckbox = displayCountupTime.querySelector('input[type="checkbox"]')

		// Bind range input and span with its value

		form.querySelectorAll('input[type="range"]').forEach(rangeElement => {
			const hintElement = rangeElement.parentElement.querySelector('.range-value')

			rangeElement.addEventListener('input', event => {
				hintElement.innerText = (Number.parseFloat(event.target.value) * 100).toFixed()
			})

			rangeElement.dispatchEvent(new Event('input'))
		})

		// Toggle only-countup timer

		onlyCountupCheckbox.addEventListener('change', event => {
			const isChecked = event.target.checked

			timeline.classList.toggle('only-countup', isChecked)

			countdownFieldset.disabled = isChecked
			countupFieldset.querySelector('.time-inputs').disabled = !isChecked

			displayCountdownInformation.querySelectorAll('input')
				.forEach(input => input.disabled = isChecked)
			displayCountdownInformation.classList.toggle('hidden', isChecked)

			displayCountupTime.querySelectorAll('input')
				.forEach(input => input.disabled = isChecked)
			displayCountupTime.classList.toggle('hidden', isChecked)

			if (isChecked) {
				specificTimeCheckbox.checked = false
				specificTimeCheckbox.dispatchEvent(new Event('change'))
			}
		})

		onlyCountupCheckbox.dispatchEvent(new Event('change'))

		// Toggle specific time

		specificTimeCheckbox.addEventListener('change', event => {
			const
				isChecked = event.target.checked,
				displayCountdownInformationCheckbox =
					displayCountdownInformation.querySelector('input[type="checkbox"]')

			countdownFieldset.querySelector('.time-inputs').disabled = isChecked
			specificTimeInput.classList.toggle('hidden', !isChecked)
			specificTimeInput.disabled = !isChecked
			specificTimeInput.required = isChecked

			displayCountdownInformationCheckbox.checked = !isChecked
			displayCountdownInformationCheckbox.disabled = isChecked
		})

		specificTimeCheckbox.dispatchEvent(new Event('change'))

		// Toggle display countup time

		displayCountupTimeCheckbox.addEventListener('change', event => {
			const isChecked = event.target.checked

			countupFieldset.classList.toggle('display-time', isChecked)
		})

		displayCountupTimeCheckbox.dispatchEvent(new Event('change'))
	}
}
