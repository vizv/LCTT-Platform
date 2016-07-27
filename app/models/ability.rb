class Ability
  include CanCan::Ability

  def initialize user
    return unless @user = user

    # 应用默认成员规则
    apply_member_rules

    # 应用用户拥有的其他角色规则
    Role.roles.keys.each do |role|
      send "apply_#{role}_rules" if @user.has_role? role
    end

    apply_override_rules
  end

  private

  def apply_member_rules
    # 成员可以查看项目动态
    can :index, Activity
    # 成员可以列出翻译平台中的文章
    can :index, Article, deleted_at: nil
    # 成员可以推荐文章到翻译平台
    can [:new, :create], Article, state: :suggest
    # 成员也可以查看任意没有归档文章的翻译进度
    can :show, Article, deleted_at: nil
  end

  def apply_translator_rules
    can :claim, Article, state: :new, deleted_at: nil unless @user.claimed_article?
    # 只能翻译、取消和提交认领后并处于'翻译中'状态的文章
    can [:edit, :submit, :cancel], Article, user: @user, state: :translating
  end

  def apply_proofreader_rules
    # 可以校对任何翻译完成的文章
    can :proofread, Article, state: :translated
    can :update, Article, state: :translated
  end

  def apply_publisher_rules
    # 可以发布任何校对完成的文章
    can :publish, Article, state: :proofread
    can :update, Article, state: :proofread
  end

  def apply_topicselector_rules
    # 选题可以创建文章
    can [:new, :create], Article, state: :new
    # 选题可以批准推荐
    can :edit, Article, state: :suggest
  end

  def apply_admin_rules
    # 管理可以干任何事情
    can :manage, :all
  end

  def apply_override_rules
    cannot [:show, :edit], nil
  end
end
