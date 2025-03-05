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
        'bg': 'var(--bg)',
        'bg-light': 'var(--bg)',
        'bg-landings': 'var(--bg-landings)',
        'positive': 'var(--positive)',
        'positive-light': 'var(--positive)',
        'accent': 'var(--accent)',
        'accent-light': 'var(--accent)',
        'secondary-accent': 'var(--secondary-accent)',
        'dark': 'var(--dark)',
        'green': 'var(--green)',
        'green-light': 'var(--green)',
        'red': 'var(--red)',
        'red-light': 'var(--red)',
        'light-positive': 'var(--light-positive)',
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
