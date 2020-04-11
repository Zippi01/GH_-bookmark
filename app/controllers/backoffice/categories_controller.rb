class Backoffice::CategoriesController < BackOfficeController
  before_action :find_category, except: [:new, :create, :index]

   def index
     @categories = Category.all.order(created_at: :desc)
   end

   def new
     @category = Category.new
   end

   def create
     @category = Category.new(category_params)
     if @category.save
       redirect_to admin_categories_path
     else
       render :new
     end
   end

   def edit; end

   def update
     if @category.update_attributes(category_params)
       redirect_to admin_categories_path
     else
       format.html { render :edit }
     end
   end

   def destroy
     @category.destroy
     redirect_to admin_categories_path
   end

   private

   def find_category
     @category = Category.find(params[:id])
   end

   def category_params
     params.require(:category).permit(:name)
   end
end
