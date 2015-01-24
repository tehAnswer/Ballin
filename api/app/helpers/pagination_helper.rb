module PaginationHelper
  def paginate(page, collection)
  	{
      :page => page,
      :per_page => BallinAPI::ITEMS_PER_PAGE,
      :total_pages => [collection.count.fdiv(BallinAPI::ITEMS_PER_PAGE).ceil, 1].max
    }
  end

end