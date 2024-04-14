module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Syukan meter'

    page_title.empty? ? base_title : " #{page_title} | #{base_title} "
  end

  def flash_message_classes(message_type)
    case message_type
    when 'success'
      'text-green-800 bg-green-50 dark:text-green-400'
    when 'danger'
      'text-red-800  bg-red-50 dark:text-red-400'
    else
      'text-blue-800 bg-blue-50 dark:text-blue-400'
    end
  end

  def default_meta_tags
    {
      site: 'Syukan-meter',
      title: '習慣化支援サービス',
      reverse: true,
      charset: 'utf-8',
      description: '習慣化をサポートします！ポモドーロタイマーを活用し良い習慣を身につけていきましょう！習慣時間にLINE通知を行うこともできます！',
      keywords: '習慣,ポモドーロタイマー,カレンダー',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('Syukan-meter.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        # site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('Syukan-meter.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end