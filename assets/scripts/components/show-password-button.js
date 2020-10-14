import ButtonWithToggleText from './button-with-toggle-text'

export default class ShowPasswordButton extends ButtonWithToggleText {
	constructor(button) {
		super(button)

		const input = this.button.closest('fieldset, section').querySelector('input[type="password"]')

		this.button.addEventListener('click', () => {
			input.type = input.type == 'password' ? 'text' : 'password'
			this._toggleText()
		})
	}
}
