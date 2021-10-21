"hello Io" println # send val to method
Vehicle := Object clone
Vehicle descirption := "desc"
Vehicle new_slot = "new slot"
Vehicle slotNames

Car := Vehicle clone
Car descirption # don't have slot, will call Vehicle's slot
# clone a obj to upper caml case will set type
# Car's type is a Car
car := Vehicle clone # car's type is a Vehicle

ferrari := Car clone
method("for an argument" println)
# method() type is Block
Car drive := method("Vroom" println) # set a slot by method obj
ferrari drive # also farrari obj create before set fun slot, it can still call drive slot
ferrari getSlot("drive") # get slot's context, var or method
# it's same as call slot, if isn't exist, will find parent's slot
Car proto # Get prototype
ferrari proto

Lobby # main namespace, store all named obj

# singleton
Highlander := Object clone
Highlander clone := Highlander # redefine clone, return ifself

loop("getting dizzy" println)
i := 1
while(i <= 11, i println; i = i + 1) # i println is loop body

"this one goes up to 11" println

# var name, init val, end val, step(optional), loop body
for(i, 2, 11, i println)
for(i, 1, 11, 2, i println) # step is 2

if(true, "is true", "is false")
if(false) then("is true") else("is false") # nil
if(false) then("is true" println) else("is false" println) # exec else
OperatorTable
OperatorTable addOperator("xor", 11)

# call method get message meta info
postOffice := Object clone
postOffice packageSender := method(call sender)
postOffice packageSender # sender is Lobby
mailer := Object clone
mailer deliver := method(postOffice packageSender) # deliver method is obj which send message
mailer deliver # sender is deliver
postOffice messageTarget := method(call target) # show target obj all info, method or var
postOffice messageArgs := method(call message arguments)
postOffice messageName := method(call message name) # call fun is a slot message, message name is likely fun name

unless := method(
    (call sender doMessage(call message argAt(0))) ifFalse(
        call sender doMessage(call message argAt(1))) ifTrue(
            call sender doMessage(call message argAt(2)))
)

OperatorTable addOperator("/", 2)
 / := method()
f(i) = f(i) + f(i-1)

fibonacci := method(i,
    if(i <= 2, 1, fibonacci(i - 1) + fibonacci(i - 2))
)
arr := list(list(1,2,3), list(2,3,4))
arrSum := method(arr,
    res := 0;
    for(i, 0, arr size - 1, 
        res := res + (((arr at(i)) sum)))
)