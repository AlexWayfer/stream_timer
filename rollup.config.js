import json from '@rollup/plugin-json';
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';

export default {
	output: {
		format: 'iife',
		sourcemap: true,
		name: 'ST'
	},
	context: 'window',
	plugins: [
		json(),
		resolve({
			browser: true
		}),
		commonjs(),
	]
};
