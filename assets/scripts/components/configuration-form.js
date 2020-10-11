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
				form = checkbox.closest('form'),
				timeline = form.querySelector('.timeline')

			checkbox.addEventListener('change', event => {
				const isChecked = event.target.checked

				timeline.classList.toggle('only-countup', isChecked)

				timeline.querySelector('fieldset.countdown').disabled = isChecked
				timeline.querySelector('fieldset.countup .time-inputs').disabled = !isChecked
			})

			checkbox.dispatchEvent(new Event('change'))
		})

	}
}
