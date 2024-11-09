import globals from 'globals'
import js from '@eslint/js'
import stylisticJs from '@stylistic/eslint-plugin-js'
export default [
	js.configs.recommended,
	stylisticJs.configs['all-flat'],
	{
		// files: ['assets/scripts/**/*.js'],
		plugins: {
			'@stylistic/js': stylisticJs
		},
		languageOptions: {
			globals: {
				...globals.browser
			}
		},
		rules: {
			'no-var': ['error'],
			'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
			'no-console': ['warn', { allow: ['error', 'warn'] }],
			'arrow-body-style': ['warn'],
			'@stylistic/js/indent': ['error', 'tab', { SwitchCase: 1 }],
			'@stylistic/js/no-mixed-spaces-and-tabs': ['error', 'smart-tabs'],
			'@stylistic/js/linebreak-style': ['error', 'unix'],
			'@stylistic/js/max-len': ['error', { code: 100, tabWidth: 2, ignoreUrls: true }],
			'@stylistic/js/quotes': ['warn', 'single', { avoidEscape: true }],
			'@stylistic/js/semi': ['error', 'never'],
			'@stylistic/js/no-multi-spaces': ['error'],
			'@stylistic/js/keyword-spacing': ['warn', { overrides: { catch: { after: false } } }],
			'@stylistic/js/brace-style': ['error'],
			'@stylistic/js/space-before-function-paren': ['warn', 'never'],
			'@stylistic/js/function-paren-newline': ['warn', 'consistent'],
			'@stylistic/js/space-before-blocks': ['warn', 'always'],
			'@stylistic/js/block-spacing': ['warn', 'always'],
			'@stylistic/js/key-spacing': ['warn'],
			'@stylistic/js/object-curly-spacing': ['warn', 'always'],
			'@stylistic/js/space-infix-ops': ['warn'],
			'@stylistic/js/space-in-parens': ['warn'],
			'@stylistic/js/arrow-parens': ['warn', 'as-needed'],
			'@stylistic/js/arrow-spacing': ['warn'],
			'@stylistic/js/padded-blocks': ['warn', 'never'],
			'@stylistic/js/spaced-comment': ['warn', 'always', { markers: ['//'] }],
			'@stylistic/js/multiline-comment-style': ['warn', 'separate-lines'],
			'@stylistic/js/function-call-argument-newline': ['warn', 'consistent'],
			'@stylistic/js/quote-props': ['warn', 'as-needed'],
			'@stylistic/js/object-property-newline': ['warn', { allowAllPropertiesOnSameLine: true }],
			'@stylistic/js/array-element-newline': ['warn', 'consistent'],
			'@stylistic/js/dot-location': ['warn', 'property'],
			'@stylistic/js/multiline-ternary': ['warn', 'always-multiline'],
			'@stylistic/js/no-extra-parens': ['warn', 'all', { nestedBinaryExpressions: false }],
			'@stylistic/js/operator-linebreak': ['warn', 'after']
		}
	},
	{
		files: ['*.config.js'],
		languageOptions: {
			globals: {
				...globals.node
			}
		}
	},
	{
		ignores: ['public/scripts/compiled/']
	}
]
