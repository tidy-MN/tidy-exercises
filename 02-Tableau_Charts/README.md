# 02- Tableau Charts

<br>

> :warning: 
>  
> We have a bit of an urgent situation on our hands. An evil competitor just purchased Tableau and they are shutting down the public server next week. Bad news.
>
> We need your help reproducing the mission critical dashboards before the lights go out. Let's start with the very important public [COVID Vaccine Report](https://www.health.state.mn.us/diseases/coronavirus/stats/vaccine.html). Follow the steps below to get the data and save the day with a new version of the charts made in R. 
>
> Good luck!

<br>

# Setup


1. We will clone [this repository](https://github.com/tidy-MN/tidy-exercises) by first clicking the green <kbd>**<> Code**</kbd> button and copying the HTTPS link.

2. In RStudio, start a new Project:

    - `File` > `New Project` > `Version Control` > `Git`.
    - In [Repository URL] - paste the URL of the GitHub link you copied: `https://github.com/tidy-MN/tidy-exercises.git` 
    - Accept the default project directory name, i.e "tidy-exercises", which matches the GitHub name.
    - Click `Create Project`
    - You should find yourself in a new RStudio Project with a copy of everything from GitHub. 

- Or skip all the Git stuff and download the three CSV files from https://github.com/tidy-MN/tidy-exercises/02-Tableau_Charts

- You can also do: `readr::read_csv('https://raw.githubusercontent.com/tidy-MN/tidy-exercises/main/02-Tableau_Charts/01_vax_trends.csv')`

3. Create a new R script named: `covid_charts_YOUR_INITIALS.R`


# Goal

Feel free to use any of your favorite plotting packages or try something new. Some options include `ggplot2`, `plotly`, and `leaflet`.

### 1. Use the `01_vax_trends.csv` to create a chart that shares the same information shown in the Tableau chart below. *You can ignore the dropdown filter.

<img src='https://tidy-mn.github.io/tidy-exercises/02-Tableau_Charts/images/01_vax_trends.png' width='60%' align='center'>

<br>

### 2. Create a chart showing the vax rates by age group using data in `02_agegroup_vax_rates.csv`.

<img src='https://tidy-mn.github.io/tidy-exercises/02-Tableau_Charts/images/02_vax_by_age.png' width='60%' align='center'>

<br>

### 3. Recreate the county map using the `03_county_vax_rates.csv` data.

<img src='https://tidy-mn.github.io/tidy-exercises/02-Tableau_Charts/images/03_vaccine_map.png' width='55%'>

---

# :heart_eyes_cat: **Congrats!** 

1. Save your R script to the `solutions/` folder

1. If you cloned the repository, use the `Git` tab in RStudio to **Commit** and **Push** your saved R script back to GitHub.
    - Alternatively, if you have the folder open in the browser, you can drag-n-drop the file onto the browser.

<br>

# :star: Bonus

Create an R Markdown html document with your charts.

1. Go to **File** >  **New File** > **R Markdown...** 
1. Change the title to: 'COVID-19 SITUATION UPDATE'
1. Click `OK`
1. Add your charts
    - Put your R code into an existing R chunk, or add a new one for each of your charts.
1. Add 1 more R chunk to make a table of the data in `bonus/04_product_doses.csv`      
    - <img src='https://tidy-mn.github.io/tidy-exercises/02-Tableau_Charts/images/04_product_doses.png' width='50%'> 
1. Click the ball of yarn that says `Knit` next to it.
1. Voila!

