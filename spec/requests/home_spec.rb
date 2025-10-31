RSpec.describe "Home" do
  describe "GET /" do
    context "ログインしていない場合" do
      it "サインイン画面へリダイレクトする" do
        get "/"

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      let(:user) do
        User.create!(
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        )
      end

      it "200を返す" do
        sign_in user

        get "/"

        expect(response).to have_http_status(:success)
      end
    end
  end
end
