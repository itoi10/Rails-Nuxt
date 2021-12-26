Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  # /にリクエストが来たらApplicationControllerクラスのhelloメソッドで処理する
  root 'application#hello'
end
