
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
#1. data asli============
  data<-reactive({
    matrix(c("sapi","kuda","pena","itik","uang",
             "ayam","anak","asli","asal","alat",
             "dulu","babi","babu","desa","kota",
             "cumi","cara","cari","curi","yang",
             "jahe","dada","duit","dana","zona"
    ),nrow=25,ncol=1,byrow=TRUE)
  })
#2. call fungsi random buat list [data] yang mau dikeluarin============  
  call<-function(data,n=1)
  {
    tampung=data
    randomString <- c(1:n)                  # initialize vector
    for (i in 1:n)
    {randomString[i] <- sample(c(1:25),1, replace=TRUE) }
    tampung[randomString]
  }
#3. fungsi randoman untuk urutan letter
  ketek <- function(n=1, lenght=4)
  {
    
    randomString <- c(1:n)                  # initialize vector
    for (i in 1:n)
    {
      randomString[i] <- paste(sample(c(1:4),4, replace=FALSE),collapse="")
    }
    
    #1 result dalam bentuk 4 letter angka kerandom 1-4, string type
    #2 pecah 1 1 hasil randoman, masih string
    #3 ubah ke int 1 1
    #4 simpen ke dalam bentuk matrix
    kuda=randomString
    ichi=strtoi(substr(kuda,1,1))
    ni=strtoi(substr(kuda,2,2))
    san=strtoi(substr(kuda,3,3))
    yon=strtoi(substr(kuda,4,4))
    kekka=list=c(ichi,ni,san,yon)
    return(kekka)
    
  }
#4. pencet pencet generate, aktivin actionButton===============
  temp.acak<-reactiveValues(data.x=NULL)
  observeEvent(input$generate,{
    temp.acak$data.x<-call(data())
  })
  
#4.1 ini var yang mau di keluarin nanti  
  udah.di.generate<-reactive({
    if(is.null(temp.acak$data.x))return()
    uji=temp.acak$data.x
    #simpen, biar fungsi 3 yg random letter gak berubah berubah lagi valuenya
    keep.ran=ketek()
    cut.1=substr(uji,keep.ran[1],keep.ran[1])
    cut.2=substr(uji,keep.ran[2],keep.ran[2])
    cut.3=substr(uji,keep.ran[3],keep.ran[3])
    cut.4=substr(uji,keep.ran[4],keep.ran[4])
    kotak=matrix(c(cut.1,cut.2,cut.3,cut.4),ncol=4)
    kotak[1,]
  })

#5 simpen hasil randoman no 4, klo nggak berubah berubah lagi nanti================
  output$tester<-renderText(udah.di.generate())
  
#6 simpen hasil uji tadi=============================
  buat.jawaban<-reactive({
    if(is.null(temp.acak$data.x))return()
    temp.acak$data.x
  })
#6.1 variabel simpen hasil inputan jawaban============  
  jawab <-reactive({input$answer})
  
#7. pencet pencet jawaban
  butt.check<-reactiveValues(data.x=NULL)
  observeEvent(input$check,{
    butt.check$data.x<-jawab()

  })
  
  udah.di.check<-reactive({
    validate(
      need(butt.check$data.x !="","Silahkan anda menjawab terlebih dahulu")
    )
    if(is.null(butt.check$data.x))return()
    butt.check$data.x
  })
  
#8 compare and answer, then it is done
  banding.print<-reactive({

    if(buat.jawaban() == udah.di.check())
    {
      print("BENAR")
    }else
    {
      print("SALAH! Silahkan coba lagi")
    }
  })
  
  output$result<-renderText(
    
    banding.print())

  
})
