import Foundation


class Banking{
    var AccNo:Int
    var AccName:String
    var AccType:String
    var AccOBal:Int
    init(accno:Int, accname:String, acctype:String, accbal:Int) {
        self.AccNo = accno
        self.AccName = accname
        self.AccType = acctype
        self.AccOBal = accbal
    }
  func fileFormat() ->String
  {
    let line = String(self.AccNo)+","+self.AccName+","+String(self.AccType)+","+String(self.AccOBal)+"\n"
    return line
  }
    func printdetails()
    {
        print("Account No:\(self.AccNo)\tAccount Name:\(self.AccName)\tAccount Type:\(self.AccType)\tAccount Bal:\(self.AccOBal)")
    }
}
    
    
//create an empty array of banking
var Bankdata = [Banking]()

//defining the location of the file
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

//defining the file by its name and txt as extension
let fileURL = URL(fileURLWithPath: "bank_data", relativeTo: directoryURL).appendingPathExtension("txt")

//get the data from the defind file wich on the define location

func readingFromFile(){
do {
 // Get the saved data
 let savedData = try Data(contentsOf: fileURL)
 // Convert the data back into a string
    if String(data: savedData, encoding: .utf8) != nil {
    //print(savedString)
    let data = String(decoding: savedData, as: UTF8.self)
    let lines = data.split(whereSeparator: \.isNewline)
    for line in lines{
        //split each line into words which are fields
        let fields = line.components(separatedBy: ",")
        //create an object of banking assuming the seprated words are the inputs
        let bms = Banking(accno:Int(fields[0])!,accname:fields[1],acctype:String(fields[2]),accbal:Int(fields[3])!)
        Bankdata.append(bms)
    }
 }
} catch {
 // Catch any errors
 print("Unable to read the file")
}
}

//funtion to Deposit Money into account
func depositMoney(){

  print("\nEnter your account number ", terminator : ": ")
  let tacno = Int(readLine()!)!
  print("Enter amount ", terminator : ": ")
  let tamt = Int(readLine()!)!
    
    var found = false
    var subfound = false


    for b in Bankdata{
      if (b.AccNo == tacno ){
          found = true
        
             b.AccOBal = b.AccOBal + tamt
             print("\nMoney Deposited Successfully")
          }
    }
  
      if !found{
          print("\nAccount Doesn't Exist")
      }

}

// funtion to Withdraw Money into account
func withdrawMoney(){

  print("Enter your account number ", terminator : ": ")
  let tacno = Int(readLine()!)!
  print("Enter amount ", terminator : ": ")
  let tamt = Int(readLine()!)!
  
    var found = false
    var subfound = false

    for b in Bankdata{
      if (b.AccNo == tacno ){
          found = true
          if (b.AccOBal >= tamt) {
              subfound = true
             b.AccOBal = b.AccOBal - tamt
             print("\nMoney Withdraw Successfully")
          }
    }
  }
      if !found{
          print("\nAccount Doesn't Exist")
      }
      else if !subfound {
          print("\nInsufficient Balance In Account")
      }
}

// funtion to transfer Money from one account to another
func transferMoney(){

  print("Enter your account number ", terminator : ": ")
  let tacno = Int(readLine()!)!
  print("Enter receivers account number ", terminator : ": ")
  let tracno = Int(readLine()!)!
  print("Enter amount ", terminator : ": ")
  let tamt = Int(readLine()!)!

    var found = false
    var subfound = false

    var fnd = false
    var subfnd = false
    
    for b in Bankdata{
      if (b.AccNo == tacno ){
          found = true
          if (b.AccOBal >= tamt) {
              subfound = true
             b.AccOBal = b.AccOBal - tamt
             print("\nMoney Tranferred Successfully")
          }
    }
   }
      if !found{
          print("\nSender Account Doesn't Exist")
      }
      else if !subfound {
          print("\nInsufficient Balance In Account")
      }

    for b in Bankdata{
      if (b.AccNo == tracno ){
          fnd = true
          if (b.AccOBal >= tamt) {
              subfnd = true
             b.AccOBal = b.AccOBal + tamt
          }
    }
   }
      if !fnd{
          print("\nReceiver Account Doesn't Exist")
      }
      else if !subfnd {
          print("\nCan't Perform Transaction")
      }

 
}

// funtion to pay bill from account
func payBill(){

  print("Enter your account number ", terminator : ": ")
  let tacno = Int(readLine()!)!
  print("Enter bill amount ", terminator : ": ")
  let tamt = Int(readLine()!)!
  var found = false
  var subfound = false


  for b in Bankdata{
    if (b.AccNo == tacno ){
        found = true
        if (b.AccOBal >= tamt) {
            subfound = true
           b.AccOBal = b.AccOBal - tamt
           print("\nUtility Bill Paid Successfully")
        }
  }
}
    if !found{
        print("\nAccount Doesn't Exist")
    }
    else if !subfound {
        print("\nInsufficient Balance In Account")
    }
}

//Funtion to view account Details
func showDetails(){

  print("\nEnter account number to view details ", terminator : ": " )
  let tacno = Int(readLine()!)!
  var found = false

  for b in Bankdata{
    if b.AccNo == tacno{
        found = true
        print("\nAccount No : \(b.AccNo)\nAccount Name : \(b.AccName)\nAccount Type : \(b.AccType)\nAccount Bal : \(b.AccOBal)")
    }
  }
    if !found{
        print("\nAccount Doesn't Exist")
    }

}

//reading form keyboard and filling array
func filling(){
    
    print("=================================")
    print("Welcome To Bank Management System")
    print("=================================")

    while(true){
        
        print("\nWhat Do You Want To Do ?\n")
        print("1. Open New Bank Account")
        print("2. Transactions (Deposit,Withdraw or Transfer)")
        print("3. Pay Utility Bills")
        print("4. View Account Information")
        print("5. Save And Exit")
        print("\t")

        
        let option = readLine()!
        
        if option == "1"
        {
            print("Enter Account No:")
            let no = Int(readLine()!)!
            print("Enter Account Holder Name:")
            let name = readLine()!
            print("Enter Account Type")
            let type = readLine()!
            print("Enter Opening Balance:")
            let bal = Int(readLine()!)!
            let obj = Banking(accno: no, accname: name, acctype: type, accbal: bal)
            Bankdata.append(obj)
            print("\nCongratulations !\nNew Account Opened.\n")
            
           /* print("Do you want to return to main menu? y/n")
           let answer = readLine()!
            if answer == "y"{
                break
                }
            else{
                break
            }*/
        
        }
        else if option == "2"
        {

            print("\n1. Deposit Money")
            print("\n2. Withdraw Money")
            print("\n3. Transfer Money\n")

            let subopt = readLine()!
            
            if subopt == "1"
            {
                depositMoney()
            }
            else if subopt == "2"
            {
                withdrawMoney()
            }
            else if subopt == "3"
            {
                transferMoney()
            }
            else
            {
                print("\nInvalid Choice!\n")
            }
            
        }
        
        else if option == "3"
        {
            print("\nPlease Select Which Utility Bill You Want To Pay\n")
            print("1. Hydro")
            print("2. Gas\n")

            let subopt = readLine()!

            if subopt == "1"
            {
              payBill()
            }
            else if subopt == "2"
            {
              payBill()
            }
            else
            {
                print("\nPlease Enter Valid Option\n")
            }
        }
        
        else if option == "4"
        {
            print("\nTo View Your Account Information Please Enter Details:\n")

            showDetails()
            
        }
        
        else if option == "5"
        {
           print("\nAre You Sure You Want To Exit?  y/n")
            let answer = readLine()!
             if answer == "y"{
                 break
                 }

        }

        else
        {
            print("\nPlease Enter Valid Option\n")

        }
        
        }
        
    }


//function to save data to a file
func savingData(){
    // calling the filling function
    filling()
    //merging all lines form the array in one string
    var myString:String = ""
    for pr in Bankdata{
        myString += pr.fileFormat()
    }
    //convert from string to data
    let data = myString.data(using: .utf8)
    do {
        //write the data into the file
        try data?.write(to: fileURL)
     print("File saved: \(fileURL.absoluteURL)")
    } catch {
     // Catch any errors
     print(error.localizedDescription)
    }
}


//this function returns the bank object or nil
func searchByName(name:String) ->Banking?
{
    for prd in Bankdata {
        if prd.AccName == name{
            return prd
        }
    }
    return nil
}
readingFromFile()



/*func updatebalance(name:String) -> Banking?
{
    print("Your update balance is :")
    //let price = Double(readLine()!)//ahiya je update thai ne ave e balance print karavanu che hoy e
    let n1 = searchByName(name: name)

}*/
//updatebalance(name: <#String#>)
savingData()