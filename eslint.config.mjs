import globals from "globals";
import eslint from '@eslint/js'
import tseslint from "typescript-eslint";
import prettierPlugin from "eslint-plugin-prettier";


/** @type {import('eslint').Linter.Config[]} */
export default [
  {files: ["**/*.{js,mjs,cjs,ts}"]},
  {files: ["**/*.js"], languageOptions: {sourceType: "commonjs"}},
  {languageOptions: { globals: globals.node }},
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  prettierPlugin.configs.recommended,
  {
    rules: {
      "prefer-const": "error", // Encourage l'utilisation de const lorsqu'une variable n'est pas réassignée
      "no-var": "error"        // Interdit l'utilisation de var, encourage l'utilisation de let ou const
    }
  }
];