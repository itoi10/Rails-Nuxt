module ApplicationHelper
  # タイトル
  def full_title(page_title = '')
    base_title = 'Sample App'
    if page_title.empty?
      # 最後に評価した式が戻り値になるのでreturn不要
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
