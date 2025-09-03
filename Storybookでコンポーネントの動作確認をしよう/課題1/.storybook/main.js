

/** @type { import('@storybook/react-webpack5').StorybookConfig } */
const config = {
  "stories": [
    "../src/**/*.mdx",
    "../src/**/*.stories.@(js|jsx|mjs|ts|tsx)"
  ],

  "addons": [
    "@storybook/preset-create-react-app",
    "@storybook/addon-docs",
    "@storybook/addon-onboarding",
    "@chromatic-com/storybook"
  ],

  "framework": {
    "name": "@storybook/react-webpack5",
    "options": {}
  },

  "staticDirs": [
    "../public"
  ],

  typescript: {
    reactDocgen: "react-docgen-typescript"
  }
};
export default config;