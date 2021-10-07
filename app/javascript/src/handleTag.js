import Tagify from '@yaireo/tagify'

export default () => {
  document.addEventListener('turbolinks:load', () => {
    const tagInput = document.getElementById('article_tag_list')
    new Tagify(tagInput, {
      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(',')
    })
  });
}
