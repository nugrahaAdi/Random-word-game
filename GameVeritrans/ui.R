
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)



sidebar<-dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "home", icon=icon("home")),
    menuItem("Game", tabName = "game", icon=icon("gamepad"))
  )
)#closure sidebar yg di wrap di bawha nanti
body<- dashboardBody(
  tags$head(
    tags$style(HTML("
          @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      
      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }
      table,tr,td {
        allign : center;
        witdh:100%;
        padding: 5px;
      }

    "))
  ),
  tabItems(
    tabItem(tabName = "home",
            fluidRow(
              box(width=12,
                  tags$h1("Welcome !"),br(),
                "Selamat datang pada game acak kata",br(),
                "Game ini dinyatakan", tags$b("sukses"),"apabila memenuhi kriteria sebagai berikut :",br(),
                tags$li("Pemain bisa memasukan data"),
                tags$li("Program harus bisa menilai mana jawaban yang benar dan yang salah"),
                tags$li("Jika jawaban benar, program harus memberikan pesan sukses"),
                tags$li("Jika jawaban salah, program harus memberikan pesan error"),
                tags$li("Kata yang dijadikan soal harus random, artinya kemunculan kata tidak bisa diprediksi"),
                tags$li("Silahkan menggunakan bahasa pemograman yang disukai, saya pilih bahasa R"),
                "Untuk melanjutkan seilahkan memilih menu ",tags$b("Game"), "disamping",
                tags$i("Selamat mencoba")
              )
            )
      
    ),
    tabItem(tabName = "game",
            fluidRow(
              box(width = "6",
                #textOutput("tester")
                #actionButton("generate", "Generate words")
                tags$table(
                  tags$tr(
                    tags$td(actionButton("generate", "Generate word")),
                    tags$td(textOutput("tester"))
                  ),
                  tags$tr(
                    tags$td(actionButton("check", "Check word")),
                    tags$td(textInput("answer",label="", value = ""))
                  )
                )
              ),#closure box input output
              box(width=6, title = "Checker",solidHeader = TRUE,status="warning", collapsible = TRUE,
                  textOutput("result")
                  )
              )
            )
  )#closure tabitemSSSS
)#closure body yang di wrap dibawah nanti



#wrappernya 
dashboardPage(skin="blue",

  dashboardHeader(title="Random words !?"),
  sidebar,
  body
)



