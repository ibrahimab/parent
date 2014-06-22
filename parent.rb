require_relative 'lib/parent.rb'

class Post
  attr_accessor :title
  
  def initialize(title)
    @title = title
  end
  
  def edit(title)
    @title = title
  end
  
  def destroy
    @title = nil
  end
end

class ApplicationController
  extend Parent::Child::ClassMethods
end

class PostsController < ApplicationController
  acts_as_child
  def show
    @post = Post.new('Post #1')
    allow(@post, :create)
    print allowed?(@post, :create).inspect + "\n"
  end
  
  def edit
    @post.edit('Post #2')
    print allowed?(@post, :create).inspect
  end
end

controller = PostsController.new
controller.show
controller.edit