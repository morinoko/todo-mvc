module ItemsHelper
  def li_class_for_item(item)
    'completed' if item.complete?
  end
  
  def li_for_item(item)
    tag.li class: li_class_for_item(item), id: "item_#{item.id}" do
      yield
    end
  end
end
