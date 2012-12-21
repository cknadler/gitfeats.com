class UsersController < ApplicationController
  def show

    # Using .find_by_nickname! to allow for vanity URLs to be miscapitalized.
    # For example: gitfeats.com/cknadler & gitfeats.com/CKnadler are both valid.
    @user = User.find_by_nickname!(params[:nickname])

    # TODO: Refactor
    @feats = @user.completed_feats.reverse
    @all_feat_count = Feat.count
    @percent = ((@feats.count.to_f/@all_feat_count.to_f)*100).to_i
    @total = roundup(@feats.count, 3)
  end

  # TODO: Refactor search
  def search
    @user = User.find_by_nickname(params[:query]) unless params[:query].nil?
    
    if params[:query].nil?
      redirect_to :root

    # if empty query, redirect them back. <~ there has to be a better way
    elsif params[:query].empty?
      redirect_to(:back)

    # else if the search for user fails, go back and tell them
    elsif @user.nil?
      redirect_to(:back, 
                  notice: "Could not find user #{params[:query]}")

    # else take them to the users page
    else
      redirect_to @user
    end
  end 

  private

  def roundup(num, ceiling)
    return num if num % ceiling  == 0
    return num + ceiling - (num % ceiling)
  end
end
