Rails.application.routes.draw do
  # /にリクエストが来たらApplicationControllerクラスのhelloメソッドで処理する
  root 'application#hello'
end
