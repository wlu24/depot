# This code does 2 things
#   - use the I18n module to set the default locale
#   - defines a list of associations between display names and locale names
#
#encoding: utf-8
I18n.default_locale = :en

LANGUAGES = [
  ['English',                  'en'],
  ["Espa&ntilde;ol".html_safe, 'es']
]
