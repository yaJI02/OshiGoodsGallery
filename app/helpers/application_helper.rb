module ApplicationHelper
  def default_meta_tags(page_title = '')
    {
      site: '推しグッズギャラリー',
      title: page_title.empty? ? '' : "#{page_title}",
      reverse: true,
      separator: '|',
      description: '推しのグッズを共有して交流するサイト♪',
      canonical: request.original_url,   #優先するurlを指定する
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('moon-icon-v.png') },
        { href: image_url('moon-icon-v.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: '推しグッズギャラリー',
        title: page_title.empty? ? '推しグッズギャラリー' : "推しグッズギャラリー | #{page_title}",
        type: 'website',
        url: request.original_url,
        image: image_url('sample.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('sample.jpg'),
      }
    }
  end
end
