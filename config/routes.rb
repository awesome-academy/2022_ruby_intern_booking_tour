Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    # routes
  end
end
