class ItemObserver
  def after_save(item)
    Slug[item.slug] = post.id.to_s
    return true
  end

  def after_destroy(item)
    Slug.destroy(item.id)
    return true
  end

end
