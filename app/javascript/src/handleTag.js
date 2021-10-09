import Tagify from '@yaireo/tagify'

export default () => {
  document.addEventListener('turbolinks:load', () => {
    const tagInput = document.getElementById('article_tag_list')

    if (tagInput === null) return false;

    const tagify = new Tagify(tagInput, {
      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(','),
      whitelist: [],
      dropdown: {
        classname: 'custom-tagify-look card',
        maxItems: 5,
      }
    })
    let controller;

    tagify.on('input', onInput)

    const isProduction = process.env.NODE_ENV === 'production';

    function onInput(e) {
      const value = e.detail.value

      tagify.whitelist = null

      controller && controller.abort()
      controller = new AbortController()

      tagify.loading(true).dropdown.hide()

      fetch(`${isProduction ? '' : 'http://localhost:3000'}/tags?name=${value}`, { signal: controller.signal })
        .then(RES => RES.json())
        .then(function (newWhitelist) {
          tagify.whitelist = newWhitelist.data
          tagify.loading(false).dropdown.show(value)
        })
    }
  });
}
