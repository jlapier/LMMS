desc "Add schema information (as comments) to model files"

task :annotate_models do
   require 'annotate_models'
   AnnotateModels.do_annotations
end