# 01 - Penguin Mismatch :penguin:

<br>

> Your research team in Antartica has been sharing a **penguin** data set for years with the exact format and column names found in `correct_format.csv`.
>
> You've just been sent a new file named `new_file.csv` from a collaborator. Unfortunately it doesn't match your formatting requirements. Follow the steps below to get the data into the required format and keep that penguin data **up-to-date**.

<br>

## Goal

1. Create a new project and **Clone** [this repository](https://github.com/tidy-MN/tidy-exercises) by clicking the green <kbd>**<> Code**</kbd> button and copying the HTTPS link

1. In RStudio, start a new Project:

    - `File` > `New Project` > `Version Control` > `Git`.
    - In “Repository URL”, paste the URL of your new GitHub link you copied: `https://github.com/tidy-MN/tidy-exercises.git` 
    - Accept the default project directory name, i.e "tidy-exercises", which coincides with the GitHub repo name.
    - Click `Create Project`
    - You should find yourself in a new local RStudio Project that is a copy of everything from GitHub. 
    - Look in RStudio’s file browser pane for the two CSV files for the exercise.

1. *(Or skip all this Git stuff for now and just download the two CSV files at https://github.com/tidy-MN/tidy-exercises/01-Penguins)* 

1. Create a new R script named `table_mismatch_YOUR_INITIALS.R`

1. Change the column names in `new_file.csv` to match the column names in `correct_format.csv`. 

1. Save the updated file to a CSV named `01_new_file_formatted.csv`

1. Save your script to the `solutions/` folder

1. If you cloned the repository, use the `Git` tab in RStudio to **Commit** and **Push** your saved R script back to GitHub

<br>

## :star: Bonus

Combine the two tables `correct_format` and `01_new_file_formatted` and save the combined dataframe as `02_combined_data.csv`.
