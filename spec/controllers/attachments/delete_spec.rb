require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  before { @user = create(:user) }
  let(:question) { create(:question, user: @user) }
  let!(:attachment) { create(:attachment, attachable: question) }
  sign_in_user

  describe 'DELETE #destroy' do 
    context 'Authenticated user delete own attachment' do 
      before { sign_in attachment.attachable.user }

      it 'delete attachment' do 
        expect { delete :destroy, params: { id: attachment }, format: :js}.to change(Attachment, :count).by(-1)
      end
    end


    context 'Not author tries to delete attachment' do 
      sign_in_user

      it 'try delete attachment' do 
        expect{ delete :destroy, params: { id: attachment }, format: :js}.to_not change(Attachment, :count)
      end
    end 

    context 'Unathenticated user tries to delete attachment' do 
      it 'trying to delete attachment' do 
        expect{ delete :destroy, params: { id: attachment }, format: :js}.to_not change(Attachment, :count)
      end
    end
  end
end 