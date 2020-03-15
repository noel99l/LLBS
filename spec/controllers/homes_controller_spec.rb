require 'rails_helper'
RSpec.describe HomesController, type: :controller do
    describe 'トップページ' do
      context "トップページが正しく表示される" do
        before do
          get :top
        end
        it 'ページにアクセスできること' do
           expect(response.status).to eq 200
        end
        render_views
        it '文言が正しく表示されること' do
          expect(response.body).to include("みんなで奏でる物語")
        end
      end
    end
end