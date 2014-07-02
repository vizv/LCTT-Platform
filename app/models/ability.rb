class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    @user_id = user._id

    Role.roles.keys.each do |role|
      send("#{role}_rules") if user.has_role? role.to_sym
    end
  end

  private

  def member_base
    # 成员可以推荐文章到翻译平台
    can :suggest, Article
    # 成员也可以查看任意文章的翻译进度
    can :show, Article
  end

  ###

  def translator_rules
    # 译者是成员
    member_base
    # 只能翻译认领后并处于'翻译中'状态的文章
    can :translate, Article, user_id: @user_id, state: :translating
  end

  def proofreader_rules
    # 校对是成员
    member_base
    # 可以校对任何翻译完成的文章
    can :proofread, Article, state: :translated
    can :update, Article, state: :translated
  end

  def publisher_rules
    # 发布是成员
    member_base
    # 可以发布任何校对完成的文章
    can :publish, Article, state: :proofread
    can :update, Article, state: :proofread
  end

  def topicselector_rules
    # 发布是成员
    member_base
    # 选题可以创建文章
    can :new, Article
    # 但不可以推荐
    cannot :suggest, Article
  end

  def admin_rules
    # 管理可以干任何事情
    can :manage, :all
    # 但不可以推荐
    cannot :suggest, Article
  end
end
