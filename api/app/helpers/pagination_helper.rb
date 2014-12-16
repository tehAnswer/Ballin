module PaginationHelper
  def paginate(collection)
    current_page_num = collection.current_page
    last_page_num = collection.total_pages

    {
      :first => first_page,
      :previous => previous_page(current_page_num),
      :self => current_page(current_page_num),
      :next => next_page(current_page_num, last_page_num),
      :last => last_page(last_page_num)
    }
  end

  def first_page
    { :href => url_for(:page => 1) }
  end

  def previous_page(current_page_num)
    return nil if current_page_num <= 1
    { :href => url_for(:page => current_page_num-1) }
  end

  def current_page(current_page_num)
    { :href => url_for(:page => current_page_num) }
  end

  def next_page(current_page_num, last_page_num)
    return nil if current_page_num >= last_page_num
    { :href => url_for(:page => current_page_num+1) }
  end

  def last_page(last_page_num)
    { :href => url_for(:page => last_page_num) }
  end
end