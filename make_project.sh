## The following script creates a new project space for a given project. It follows the reccomendations from Noble WS (2009) A Quick Guide to Organizing Computational Biology Projects. PLoS Comput Biol 5(7): e1000424. doi:10.1371/journal.pcbi.1000424. See /diag/home/stsmith/doc/Noble_2009_Directory_structure_for_a_sample_project.tiff

## Diag is organized into home nad cloud directoires, with the latter being designed for larger file sizes. Therefore, will establish a "split" design wherein the smaller files will reside on home and the larger on cloud, with simlinks to each from the opposite side. The home direcotry contains master control scrips as well. 

## There's also the consideration of qsub: the output dirs and the defaul output streams should be changed to be output to the approporate cloud directories. This might be taken care of by either a flag option into qsub or by a variable name (or both) so that the cloud and home directories can be easily pointed to. 

## The order to creation will be: 
## 1. Create main project folder. This should be in root of both home and cloud (redundant to have projects then root because most everything on diag will be a project with the exception of bin/src, doc and scratch)
## 2. Create the following subjirectories within the main (with home bases in parenthasies and symlinked from the opposite side): 
## -doc (home)
## -data (cloud)
## -src (home)
## -bin (home) 
## -results (cloud) -> within results should be a notebook
## 3. Symlink the appriopriate cross references within the dir's home base
## 4. Add src and bin to path to make project-specific scripts more easily referenced. 
## 5. Add src, bin (and results?) and doc to github tracking- ignore all else- i.e., init the project folder, add .gitignore to the folder. The skeleton gitignore will be stored in /diag/home/stsmith/bin/github/gitignore_skeleton 

## Project name & variables
PROJECT_NAME=$1
source /diag/home/stsmith/.globalvars ## includes pointers to home, cloud and gitignore directories. 
LOG_FILE=$HOME/$PROJECT_NAME/$PROJECT_NAME".make_project.log"

echo "Creating $PROJECT_NAME..."
## 1. Create main project folder.
mkdir $HOME/$PROJECT_NAME
mkdir $CLOUD/$PROJECT_NAME
printf "Created home and cloud project directory folders:\n$HOME/$PROJECT_NAME\n$CLOUD/$PROJECT_NAME\nCreated on `date`\n" > $LOG_FILE

## 2 & 3. Create the following subjirectories within the main (with home bases in parenthasies and symlinked from the opposite side): 
## -doc (home)
mkdir $HOME/$PROJECT_NAME/doc
ln -s $HOME/$PROJECT_NAME/doc $CLOUD/$PROJECT_NAME/doc
## -data (cloud)
mkdir $CLOUD/$PROJECT_NAME/data
ln -s $CLOUD/$PROJECT_NAME/data $HOME/$PROJECT_NAME/data
## -src (home)
mkdir $HOME/$PROJECT_NAME/src
ln -s $HOME/$PROJECT_NAME/src $CLOUD/$PROJECT_NAME/src
## -bin (home) 
mkdir $HOME/$PROJECT_NAME/bin
ln -s $HOME/$PROJECT_NAME/bin $CLOUD/$PROJECT_NAME/bin
## -results (cloud) -> within results should be a notebook
mkdir $CLOUD/$PROJECT_NAME/results
echo "Notebook for "$PROJECT_NAME", created "`date` > $CLOUD/$PROJECT_NAME/results/notebook.txt
ln -s $CLOUD/$PROJECT_NAME/results $HOME/$PROJECT_NAME/results

printf "\n\n#########################\nCreated sub directory folders: doc, data, src, bin and results in cloud & home (symlinked)\n" >> $LOG_FILE
echo $HOME/$PROJECT_NAME/doc >> $LOG_FILE
echo $CLOUD/$PROJECT_NAME/data >> $LOG_FILE
echo $HOME/$PROJECT_NAME/src >> $LOG_FILE
echo $HOME/$PROJECT_NAME/bin >> $LOG_FILE
echo $CLOUD/$PROJECT_NAME/results >> $LOG_FILE

## 4. Add src and bin to path to make project-specific scripts more easily referenced. 
echo "## src and bin paths for the project "$PROJECT_NAME >> $HOME/.bashrc
echo "PATH=\$PATH:$HOME/$PROJECT_NAME/bin/:$HOME/$PROJECT_NAME/src" >> $HOME/.bashrc
export PATH=$PATH:$HOME/$PROJECT_NAME/bin/:$HOME/$PROJECT_NAME/src

printf "\n\n#########################\nAdded project bin and src directories to bashrc PATH:\n----------------------------------\n" >> $LOG_FILE
echo $PATH >> $LOG_FILE
printf "\n----------------------------------\n" >> $LOG_FILE

## 5. Add src, bin (and results?) and doc to github tracking- ignore all else- i.e., init the project folder, add .gitignore to the folder. The skeleton gitignore will be stored in /diag/home/stsmith/bin/github/gitignore_skeleton
cd $HOME/$PROJECT_NAME/
git init
cp $GITIGNORE .gitignore
echo "#### Project-Specific Files/Folders/extensions: ###" >> .gitignore


printf "\n\n#########################\nInititalized $HOME/$PROJECT_NAME/ with git. Added $GITIGNORE file to project root. Contnents of gitignore:\n----------------------------------\n" >> $LOG_FILE
cat .gitignore >> $LOG_FILE 
printf "\n----------------------------------\n" >> $LOG_FILE 
## Done making prject
printf "\n\n#########################\nCreation of $PROJECT_NAME, its subfolders, and path variables complete!\n" >> $LOG_FILE
echo "Creation of $PROJECT_NAME, its subfolders, and path variables complete!"
