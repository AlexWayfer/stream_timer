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

		// Toggle only-countup timer

		form.querySelectorAll('.only-countup input[type="checkbox"]').forEach(checkbox => {
			const
				timeline = checkbox.closest('.timeline'),
				displayCountdownInformation = timeline.querySelector('.display-countdown-information'),
				displayCountupTime = timeline.querySelector('.display-countup-time')

			checkbox.addEventListener('change', event => {
				const isChecked = event.target.checked

				timeline.classList.toggle('only-countup', isChecked)

				timeline.querySelector('fieldset.countdown').disabled = isChecked
				timeline.querySelector('fieldset.countup .time-inputs').disabled = !isChecked

				displayCountdownInformation.querySelectorAll('input')
					.forEach(input => input.disabled = isChecked)
				displayCountdownInformation.classList.toggle('hidden', isChecked)

				displayCountupTime.querySelectorAll('input')
					.forEach(input => input.disabled = isChecked)
				displayCountupTime.classList.toggle('hidden', isChecked)
			})

			checkbox.dispatchEvent(new Event('change'))
		})

		// Toggle display countup time

		form.querySelectorAll('.display-countup-time input[type="checkbox"]').forEach(checkbox => {
			const countupFieldset = checkbox.closest('fieldset.countup')

			checkbox.addEventListener('change', event => {
				const isChecked = event.target.checked

				countupFieldset.classList.toggle('display-time', isChecked)
			})

			checkbox.dispatchEvent(new Event('change'))
		})
	}
}
