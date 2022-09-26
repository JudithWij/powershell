#guess the number

#add speach set the game 
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$play = 1
$speak.speak('I have a number between 1-10, can you guess it in 3 tries?')
$guessedalready = @()

#get a number and ask for a number
while ($play -eq 1) 
{   $inhead = Get-Random -Minimum 1 -Maximum 10
    [int]$num = Read-Host 'guess a number from 1-10 (10 is not included)'
    $tries = 2

    #check the number 3 tries
    while ($inhead -ne $num -and $tries -gt 0) 
    {   $guessedalready = $guessedalready + $num

        if ($num -gt $inhead)
        {
            'Sorry, your guess: ' + $num + ' was to high!'
        }
        else
        {
            'Sorry, your guess: ' + $num + ' was to low!'
        }

        [int]$num = Read-Host 'guess a number from 1-10 (10 is not included)'

        while($guessedalready -contains $num)
            {
                [int]$num = Read-Host 'You already guessed this number try again!'
            }

        $guessedalready = $guessedalready + $num
        $tries = $tries - 1
    
    }

    # Give the score
    if ($num -eq $inhead)
    {
        'You guest right!'
        $speak.Speak('You win!')
        $tries = 0
    }
    elseif ($num -gt $inhead) 
    {
        'Your number was to high!'
        'No more tries!' 
        $speak.Speak('You lost!')
    }
    else 
    {
        'Your number was to low!'
        'No more tries!' 
        $speak.Speak('You lost!')
    }

    # Want to play again?
    if($tries -eq 0 ){
        [int]$playagain = Read-Host 'Do you want to play again? Choose 1 for YES and 0 for NO'

        if($playagain -eq 1){
            $tries = 2
            $guessedalready = @()
            $play = 1
        }
        else {
            $play = 0
        }
    
    }
}

#end of game
$speak.Speak("Thank you for playing")

