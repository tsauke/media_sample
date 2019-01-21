require 'rails_helper'

RSpec.feature 'UsersIndex', type: :system do
  let(:admin) { FactoryBot.create(:michael) }
  let(:non_admin) { FactoryBot.create(:archer) }

  describe 'User index' do
    before do
      non_admin
      create_list :user, 30
    end
    context 'when index including pagination and delete links' do
      before do
        log_in_with_remember(admin)
      end
      scenario 'have user link' do
        visit users_path
        expect(page).to have_selector 'h1', text: 'All users'
        expect(page).to have_selector 'div.pagination'
        User.paginate(page: 1).each do |user|
          expect(page).to have_link user.name, href: user_path(user)
          if user != admin
            expect(page).to have_link 'delete', href: user_path(user)
          end
        end
        expect { click_link 'delete', href: user_path(non_admin) }.to change { User.count }.by(-1)
      end
    end

    context 'when not index including delete links' do
      before do
        log_in_with_remember(non_admin)
      end
      scenario 'not have delete links' do
        visit users_path
        expect(page).to_not have_link 'delete'
      end
    end
  end
end