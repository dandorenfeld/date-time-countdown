DateTimeCountdown::Application.routes.draw do

    get "/"     => redirect("/home")
    get "/home" => "countdown#home", :as => "home"

end
