require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "ニックネームが空では登録できない" do
        @user.username = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Username can't be blank")
      end

      it "メールアドレスが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスが一意性であること" do
        existing_user = FactoryBot.create(:user, email: 'test@example.com')
        @user.email = 'test@example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "メールアドレスは、@を含む必要がある" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードが6文字以上でなければ登録できない" do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "英字のみのパスワードでは登録できない" do
        @user.password = 'onlyletters'
        @user.password_confirmation = 'onlyletters'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含む必要があります")
      end

      it "数字のみのパスワードでは登録できない" do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含む必要があります")
      end

      it "全角文字を含むパスワードでは登録できない" do
        @user.password = 'abc123全角文字' # 全角文字を含むパスワード
        @user.password_confirmation = 'abc123全角文字'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含む必要があります")
      end

      it "パスワードとパスワード（確認）が一致していなければ登録できない" do
        @user.password = '1234567'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "本名（全角）の名字が空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
  
      it "本名（全角）の名前が空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
  
      it "姓（last_name）が全角でない場合は登録できない" do
        @user.last_name = 'Yamada' # 半角英字の姓
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角（漢字・ひらがな・カタカナ）での入力が必須です")
      end

      it "名（first_name）が全角でない場合は登録できない" do
        @user.first_name = 'Taro' # 半角英字の名
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）での入力が必須です")
      end

      it "姓（last_name）がカタカナでない場合は登録できない" do
        @user.last_name = 'Yamada' # ひらがなの姓
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角（漢字・ひらがな・カタカナ）での入力が必須です")
      end

      it "名（first_name）がカタカナでない場合は登録できない" do
        @user.first_name = 'Tarou' # ひらがなの名
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）での入力が必須です")
      end

    it "本名カナ（全角）の名字が空では登録できない" do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana は全角（カタカナ）での入力が必須です")
    end

    it "本名カナ（全角）の名前が空では登録できない" do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana は全角（カタカナ）での入力が必須です")
    end

      it "姓（last_name_kana）が全角カタカナでない場合は登録できない" do
        @user.last_name_kana = '山田' # ひらがなの姓カナ
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角（カタカナ）での入力が必須です")
      end

      it "名（first_name_kana）が全角カタカナでない場合は登録できない" do
        @user.first_name_kana = '太郎' # ひらがなの名カナ
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角（カタカナ）での入力が必須です")
      end

      it "姓（last_name_kana）が全角ひらがなでない場合は登録できない" do
        @user.last_name_kana = 'やまだ' # ひらがなの姓カナ
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角（カタカナ）での入力が必須です")
      end

      it "名（first_name_kana）が全角ひらがなでない場合は登録できない" do
        @user.first_name_kana = 'たろう' # ひらがなの名カナ
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角（カタカナ）での入力が必須です")
      end

      it "生年月日が空では登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end