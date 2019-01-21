require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:michael) }
  let(:other_user) { FactoryBot.create(:archer) }

  describe 'Get #index' do
    context 'ログインしていないとき' do
      it 'redirect to index' do
        get :index
        # expect(response.status).to eq 302
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe 'Get #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'Get #edit and Patch #update' do
    context 'ログインしていないとき編集をリダイレクト' do
      before do
        get :edit, params: { id: user }
      end
      it 'redirect to login url' do
        expect(flash).to be_present
        expect(response).to redirect_to(login_url)
      end
    end

    context 'ログインしていないとき更新をリダイレクト' do
      before do
        patch :update, params: { id: user, user: FactoryBot.attributes_for(:user) }
      end
      it 'success update' do
        expect(response.status).to eq 302
        expect(flash).to be_present
      end
      it 'redirect to login url' do
        expect(response).to redirect_to(login_url)
      end
    end

    context '間違ったユーザーが編集と更新しようとしたとき' do
      before do
        log_in_as(other_user)
      end
      it 'edit redirect to root_url' do
        get :edit, params: { id: user }
        expect(flash).to be_empty
        expect(response).to redirect_to(root_url)
      end

      it 'update redirect to root_url' do
        patch :update, params: { id: user, user: FactoryBot.attributes_for(:user) }
        expect(flash).to be_empty
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'Delete destroy' do
    context 'ログインしていないとき' do
      before do
        delete :destroy, params: { id: user }
      end
      it 'redirect destroy' do
        expect(response).to redirect_to(login_url)
      end
    end

    context '管理者以外としてログインしたとき' do
      let(:third) { FactoryBot.create(:lana) }
      before do
        log_in_as(other_user)
        third
      end
      it 'is not reduce User count' do
        expect(other_user.admin?).to_not be_truthy
        delete :destroy, params: { id: third }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'ログイン時' do
      let(:third) { FactoryBot.create(:lana) }
      before do
        log_in_as(user)
        third
      end
      it 'reduce User count -1' do
        delete :destroy, params: { id: third }
        expect(response).to redirect_to(users_url)
      end
    end
  end
end