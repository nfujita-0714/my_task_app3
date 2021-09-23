require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録のテスト' do
    context 'ユーザーが登録していない場合' do
      it 'ユーザーの新規登録ができること' do
      visit new_user_path
      fill_in 'user[name]', with: 'new_user'
      fill_in 'user[email]', with: 'new@gmail.com'
      fill_in 'user[password]', with: 'newuser'
      fill_in 'user[password_confirmation]', with: 'newuser'
      click_button '登録'

      expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'タスク一覧に飛ぼうとした時、ログイン画面に推移すること' do
      visit tasks_path
      expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ユーザーがログインしている場合' do
      before do
        # FactoryBot.create(:admin_user)
        FactoryBot.create(:basic_user)
        visit new_session_path
        fill_in 'session[email]', with: 'basic_email@gmail.com'
        fill_in 'session[password]', with:'basicuser'
        click_button 'ログイン'
      end
      it '自分の詳細画面(マイページ)に飛べること' do
        expect(page).to have_content 'basic_name'
      end
      it '他人のページの詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        visit "users/1"
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトができること' do
        click_on 'ログアウト', match: :first
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者権限があるユーザーがログインしている場合'do
      FactoryBot.create(:admin_user)
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'admin_email@gmail.com'
        fill_in 'session[password]', with:'adminuser'
        click_button 'ログイン'
         FactoryBot.create(:basic_user)
         FactoryBot.create(:basic2_user)
        #  FactoryBot.create(:admin_user)
        visit tasks_path
        
      end
      it '管理画面にアクセスできること' do
        # visit admin_users_path
        visit tasks_path
        click_link '管理者用一覧ページ'
        # visit admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'ユーザの新規登録ができること' do
        visit admin_users_path
        click_link '新規ユーザー登録'
        fill_in 'user[name]', with: 'new_user'
        fill_in 'user[email]', with: 'new@gmail.com'
        fill_in 'user[password]', with: 'newuser'
        fill_in 'user[password_confirmation]', with: 'newuser'
        click_button 'アカウント登録'
        expect(page).to have_content 'new_user'
      end
      it 'ユーザの詳細画面にアクセスできること' do
        visit admin_users_path
        all('.admin_index')[1].click_on '詳細'
        expect(page).to have_content 'basic_name'
      end
      it 'ユーザの編集画面からユーザを編集できること' do
        visit admin_users_path
        all('.admin_index')[2].click_on '編集'
        fill_in 'user[name]', with: 'edit_user'
        fill_in 'user[email]', with: 'edit_mail@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'アカウント更新'
        expect(page).to have_content 'edit_user'
      end
      it 'ユーザの削除ができること' do
        visit admin_users_path

        all('.admin_index')[1].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end

    context '管理者権限がないユーザーがログインしている場合' do
      before do
        FactoryBot.create(:basic_user)
        visit new_session_path
        fill_in 'session[email]', with: 'basic_email@gmail.com'
        fill_in 'session[password]', with:'basicuser'
        click_button 'ログイン'
      end
      it '管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(page).not_to have_content '管理画面'
      end
    end
  end
end