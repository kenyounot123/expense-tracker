const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/assets/stylesheets/**/*.css'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Poppins', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'bg': '#302D43',
        'bg-light': '#e5dbfc',
        'bg-landings': '#1b1733',
        'positive': '#8e7ff5',
        'positive-light': '#6B4EE6',
        'accent': '#CD4FF7',
        'accent-light': '#9B30BD',
        'secondary-accent': '#FDE047',
        'dark': '#171421',
        'green': '#7ff58e',
        'green-light': '#2E9D4E',
        'red': '#d40f0f',
        'red-light': '#D32F2F',
        'light-positive': '#aba1f0',
      },
      borderRadius: {
        'card': '1rem',
      },
      boxShadow: {
        'card': '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  darkMode: 'media',
}
