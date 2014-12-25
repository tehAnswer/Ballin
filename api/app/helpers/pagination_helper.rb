module PaginationHelper
  def paginate(page, collection)
    {
      :page => page,
      :per_page => BallinAPI::ITEMS_PER_PAGE,
      :total_pages => (collection.size / BallinAPI::ITEMS_PER_PAGE).ceil
    }

  end

end