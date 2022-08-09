module CategoryHelper
  def load_category
    @category = Category.all.pluck(:name, :id)
  end
end
