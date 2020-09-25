import 'core-js/stable/string/includes'

// https://github.com/zloirock/core-js/issues/618#issuecomment-522618151
// https://github.com/zloirock/core-js/issues/619#issuecomment-522624271
import 'core-js/stable/symbol/iterator'

import 'core-js/stable/array/from'
import 'core-js/stable/object/entries'
import 'core-js/stable/dom-collections/for-each'

document.addEventListener('DOMContentLoaded', () => {
	// Prevent double form submission
	document.querySelectorAll('form').forEach(
		form => {
			form.addEventListener('submit', event => {
				if (form.submitting == true) {
					event.preventDefault()
					event.stopImmediatePropagation()
				} else {
					form.submitting = true
				}
			})
		}
	)

	// Prevent `.` typing in number inputs with step = 1
	document.querySelectorAll('input[type="number"][step="1"]').forEach(
		input => input.addEventListener('keypress', event => {
			if (event.key == '.') {
				event.preventDefault()
				return false
			}
		})
	)

	// `input[type="number"]` should allow only numbers
	// https://stackoverflow.com/a/469362/2630849
	const number_input_filter = value => /^-?\d*[.,]?\d*$/.test(value)
	document.querySelectorAll('input[type="number"]').forEach(number_input => {
		[
			'input', 'keydown', 'keyup', 'mousedown', 'mouseup', 'select',
			'contextmenu', 'drop'
		].forEach(event_type => {
			number_input.addEventListener(event_type, () => {
				if (number_input_filter(number_input.value)) {
					number_input.oldValue = number_input.value
					number_input.oldSelectionStart = number_input.selectionStart
					number_input.oldSelectionEnd = number_input.selectionEnd
				} else if (
					Object.prototype.hasOwnProperty.call(number_input, 'oldValue')
				) {
					number_input.value = number_input.oldValue
					number_input.setSelectionRange(
						number_input.oldSelectionStart, number_input.oldSelectionEnd
					)
				}
			})
		})
	})

	// `button` is not focused while clicked in macOS and iOS
	// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button#Clicking_and_focus
	document.querySelectorAll('button[type="submit"][name]').forEach(button => {
		const form = button.form
		const input = form.querySelector(`input[name="${button.name}"][value="${button.value}"]`)
		if (input) return

		button.addEventListener('click', () => {
			const input = document.createElement('input')
			input.type = 'hidden'
			input.name = button.name
			input.value = button.value
			form.appendChild(input)
		})
	})

	// Components

	document.querySelectorAll('input[name="configuration[background_opacity]"]')
		.forEach(rangeElement => {
			const hintElement = rangeElement.nextElementSibling

			rangeElement.addEventListener('input', event => {
				hintElement.innerText = (Number.parseFloat(event.target.value) * 100).toFixed()
			})

			rangeElement.dispatchEvent(new Event('input'))
		})
})
