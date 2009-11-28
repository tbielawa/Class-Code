%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% UNO
%%% Submitted 2007-04-25
%%% Team 'Three, Two, Uno!'
%%% Tim Bielawa
%%% Howard Wilde
%%% Kane Gyovai
%%% J. Davis
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

cardDeck(1).name = 'Red 1'; cardDeck(1).color = 'r'; cardDeck(1).value = 1;
cardDeck(2).name = 'Red 2'; cardDeck(2).color = 'r'; cardDeck(2).value = 2;
cardDeck(3).name = 'Red 3'; cardDeck(3).color = 'r'; cardDeck(3).value = 3;
cardDeck(4).name = 'Red 4'; cardDeck(4).color = 'r'; cardDeck(4).value = 4;
cardDeck(5).name = 'Red 5'; cardDeck(5).color = 'r'; cardDeck(5).value = 5;
cardDeck(6).name = 'Red 6'; cardDeck(6).color = 'r'; cardDeck(6).value = 6;
cardDeck(7).name = 'Red 7'; cardDeck(7).color = 'r'; cardDeck(7).value = 7;
cardDeck(8).name = 'Red 8'; cardDeck(8).color = 'r'; cardDeck(8).value = 8;
cardDeck(9).name = 'Red 9'; cardDeck(9).color = 'r'; cardDeck(9).value = 9;
cardDeck(10).name = 'Red 1'; cardDeck(10).color = 'r'; cardDeck(10).value = 1;
cardDeck(11).name = 'Red 2'; cardDeck(11).color = 'r'; cardDeck(11).value = 2;
cardDeck(12).name = 'Red 3'; cardDeck(12).color = 'r'; cardDeck(12).value = 3;
cardDeck(13).name = 'Red 4'; cardDeck(13).color = 'r'; cardDeck(13).value = 4;
cardDeck(14).name = 'Red 5'; cardDeck(14).color = 'r'; cardDeck(14).value = 5;
cardDeck(15).name = 'Red 6'; cardDeck(15).color = 'r'; cardDeck(15).value = 6;
cardDeck(16).name = 'Red 7'; cardDeck(16).color = 'r'; cardDeck(16).value = 7;
cardDeck(17).name = 'Red 8'; cardDeck(17).color = 'r'; cardDeck(17).value = 8;
cardDeck(18).name = 'Red 9'; cardDeck(18).color = 'r'; cardDeck(18).value = 9;
cardDeck(19).name = 'Red Draw Two'; cardDeck(19).color = 'r'; cardDeck(19).value = 11;
cardDeck(20).name = 'Red Draw Two'; cardDeck(20).color = 'r'; cardDeck(20).value = 12;
cardDeck(21).name = 'Red Reverse'; cardDeck(21).color = 'r'; cardDeck(21).value = 13;
cardDeck(22).name = 'Red Reverse'; cardDeck(22).color = 'r'; cardDeck(22).value = 14;
cardDeck(23).name = 'Red Skip'; cardDeck(23).color = 'r'; cardDeck(23).value = 15;
cardDeck(24).name = 'Red Skip'; cardDeck(24).color = 'r'; cardDeck(24).value = 16;
cardDeck(25).name = 'Green 1'; cardDeck(25).color = 'g'; cardDeck(25).value = 1;
cardDeck(26).name = 'Green 2'; cardDeck(26).color = 'g'; cardDeck(26).value = 2;
cardDeck(27).name = 'Green 3'; cardDeck(27).color = 'g'; cardDeck(27).value = 3;
cardDeck(28).name = 'Green 4'; cardDeck(28).color = 'g'; cardDeck(28).value = 4;
cardDeck(29).name = 'Green 5'; cardDeck(29).color = 'g'; cardDeck(29).value = 5;
cardDeck(30).name = 'Green 6'; cardDeck(30).color = 'g'; cardDeck(30).value = 6;
cardDeck(31).name = 'Green 7'; cardDeck(31).color = 'g'; cardDeck(31).value = 7;
cardDeck(32).name = 'Green 8'; cardDeck(32).color = 'g'; cardDeck(32).value = 8;
cardDeck(33).name = 'Green 9'; cardDeck(33).color = 'g'; cardDeck(33).value = 9;
cardDeck(34).name = 'Green 1'; cardDeck(34).color = 'g'; cardDeck(34).value = 1;
cardDeck(35).name = 'Green 2'; cardDeck(35).color = 'g'; cardDeck(35).value = 2;
cardDeck(36).name = 'Green 3'; cardDeck(36).color = 'g'; cardDeck(36).value = 3;
cardDeck(37).name = 'Green 4'; cardDeck(37).color = 'g'; cardDeck(37).value = 4;
cardDeck(38).name = 'Green 5'; cardDeck(38).color = 'g'; cardDeck(38).value = 5;
cardDeck(39).name = 'Green 6'; cardDeck(39).color = 'g'; cardDeck(39).value = 6;
cardDeck(40).name = 'Green 7'; cardDeck(40).color = 'g'; cardDeck(40).value = 7;
cardDeck(41).name = 'Green 8'; cardDeck(41).color = 'g'; cardDeck(41).value = 8;
cardDeck(42).name = 'Green 9'; cardDeck(42).color = 'g'; cardDeck(42).value = 9;
cardDeck(43).name = 'Green Draw Two'; cardDeck(43).color = 'g'; cardDeck(43).value = 11;
cardDeck(44).name = 'Green Draw Two'; cardDeck(44).color = 'g'; cardDeck(44).value = 12;
cardDeck(45).name = 'Green Reverse'; cardDeck(45).color = 'g'; cardDeck(45).value = 13;
cardDeck(46).name = 'Green Reverse'; cardDeck(46).color = 'g'; cardDeck(46).value = 14;
cardDeck(47).name = 'Green Skip'; cardDeck(47).color = 'g'; cardDeck(47).value = 15;
cardDeck(48).name = 'Green Skip'; cardDeck(48).color = 'g'; cardDeck(48).value = 16;
cardDeck(49).name = 'Wild'; cardDeck(49).color = 'w'; cardDeck(49).value = 17;
cardDeck(50).name = 'Wild'; cardDeck(50).color = 'w'; cardDeck(50).value = 17;
cardDeck(51).name = 'Wild'; cardDeck(51).color = 'w'; cardDeck(51).value = 17;
cardDeck(52).name = 'Wild'; cardDeck(52).color = 'w'; cardDeck(52).value = 17;
cardDeck(53).name = 'Wild Draw Four'; cardDeck(53).color = 'w'; cardDeck(53).value = 18;
cardDeck(54).name = 'Wild Draw Four'; cardDeck(54).color = 'w'; cardDeck(54).value = 18;
cardDeck(55).name = 'Blue 1'; cardDeck(55).color = 'b'; cardDeck(55).value = 1;
cardDeck(56).name = 'Blue 2'; cardDeck(56).color = 'b'; cardDeck(56).value = 2;
cardDeck(57).name = 'Blue 3'; cardDeck(57).color = 'b'; cardDeck(57).value = 3;
cardDeck(58).name = 'Blue 4'; cardDeck(58).color = 'b'; cardDeck(58).value = 4;
cardDeck(59).name = 'Blue 5'; cardDeck(59).color = 'b'; cardDeck(59).value = 5;
cardDeck(60).name = 'Blue 6'; cardDeck(60).color = 'b'; cardDeck(60).value = 6;
cardDeck(61).name = 'Blue 7'; cardDeck(61).color = 'b'; cardDeck(61).value = 7;
cardDeck(62).name = 'Blue 8'; cardDeck(62).color = 'b'; cardDeck(62).value = 8;
cardDeck(63).name = 'Blue 9'; cardDeck(63).color = 'b'; cardDeck(63).value = 9;
cardDeck(64).name = 'Blue 1'; cardDeck(64).color = 'b'; cardDeck(64).value = 1;
cardDeck(65).name = 'Blue 2'; cardDeck(65).color = 'b'; cardDeck(65).value = 2;
cardDeck(66).name = 'Blue 3'; cardDeck(66).color = 'b'; cardDeck(66).value = 3;
cardDeck(67).name = 'Blue 4'; cardDeck(67).color = 'b'; cardDeck(67).value = 4;
cardDeck(68).name = 'Blue 5'; cardDeck(68).color = 'b'; cardDeck(68).value = 5;
cardDeck(69).name = 'Blue 6'; cardDeck(69).color = 'b'; cardDeck(69).value = 6;
cardDeck(70).name = 'Blue 7'; cardDeck(70).color = 'b'; cardDeck(70).value = 7;
cardDeck(71).name = 'Blue 8'; cardDeck(71).color = 'b'; cardDeck(71).value = 8;
cardDeck(72).name = 'Blue 9'; cardDeck(72).color = 'b'; cardDeck(72).value = 9;
cardDeck(73).name = 'Blue Draw Two'; cardDeck(73).color = 'b'; cardDeck(73).value = 11;
cardDeck(74).name = 'Blue Draw Two'; cardDeck(74).color = 'b'; cardDeck(74).value = 12;
cardDeck(75).name = 'Blue Reverse'; cardDeck(75).color = 'b'; cardDeck(75).value = 13;
cardDeck(76).name = 'Blue Reverse'; cardDeck(76).color = 'b'; cardDeck(76).value = 14;
cardDeck(77).name = 'Blue Skip'; cardDeck(77).color = 'b'; cardDeck(77).value = 15;
cardDeck(78).name = 'Blue Skip'; cardDeck(78).color = 'b'; cardDeck(78).value = 16;
cardDeck(79).name = 'Yellow 1'; cardDeck(79).color = 'y'; cardDeck(79).value = 1;
cardDeck(80).name = 'Yellow 2'; cardDeck(80).color = 'y'; cardDeck(80).value = 2;
cardDeck(81).name = 'Yellow 3'; cardDeck(81).color = 'y'; cardDeck(81).value = 3;
cardDeck(82).name = 'Yellow 4'; cardDeck(82).color = 'y'; cardDeck(82).value = 4;
cardDeck(83).name = 'Yellow 5'; cardDeck(83).color = 'y'; cardDeck(83).value = 5;
cardDeck(84).name = 'Yellow 6'; cardDeck(84).color = 'y'; cardDeck(84).value = 6;
cardDeck(85).name = 'Yellow 7'; cardDeck(85).color = 'y'; cardDeck(85).value = 7;
cardDeck(86).name = 'Yellow 8'; cardDeck(86).color = 'y'; cardDeck(86).value = 8;
cardDeck(87).name = 'Yellow 9'; cardDeck(87).color = 'y'; cardDeck(87).value = 9;
cardDeck(88).name = 'Yellow 1'; cardDeck(88).color = 'y'; cardDeck(88).value = 1;
cardDeck(89).name = 'Yellow 2'; cardDeck(89).color = 'y'; cardDeck(89).value = 2;
cardDeck(90).name = 'Yellow 3'; cardDeck(90).color = 'y'; cardDeck(90).value = 3;
cardDeck(91).name = 'Yellow 4'; cardDeck(91).color = 'y'; cardDeck(91).value = 4;
cardDeck(92).name = 'Yellow 5'; cardDeck(92).color = 'y'; cardDeck(92).value = 5;
cardDeck(93).name = 'Yellow 6'; cardDeck(93).color = 'y'; cardDeck(93).value = 6;
cardDeck(94).name = 'Yellow 7'; cardDeck(94).color = 'y'; cardDeck(94).value = 7;
cardDeck(95).name = 'Yellow 8'; cardDeck(95).color = 'y'; cardDeck(95).value = 8;
cardDeck(96).name = 'Yellow 9'; cardDeck(96).color = 'y'; cardDeck(96).value = 9;
cardDeck(97).name = 'Yellow Draw Two'; cardDeck(97).color = 'y'; cardDeck(97).value = 11;
cardDeck(98).name = 'Yellow Draw Two'; cardDeck(98).color = 'y'; cardDeck(98).value = 12;
cardDeck(99).name = 'Yellow Reverse'; cardDeck(99).color = 'y'; cardDeck(99).value = 13;
cardDeck(100).name = 'Yellow Reverse'; cardDeck(100).color = 'y'; cardDeck(100).value = 14;
cardDeck(101).name = 'Yellow Skip'; cardDeck(101).color = 'y'; cardDeck(101).value = 15;
cardDeck(102).name = 'Yellow Skip'; cardDeck(102).color = 'y'; cardDeck(102).value = 16;
cardDeck(103).name = 'Wild Draw Four'; cardDeck(103).color = 'w'; cardDeck(103).value = 18;
cardDeck(104).name = 'Wild Draw Four'; cardDeck(104).color = 'w'; cardDeck(104).value = 18;


while(true)
    rndDeckPrimer = randperm(length(cardDeck));
    inUseDeck = cardDeck(rndDeckPrimer);
    discardDeck = inUseDeck(1);
    topDiscard = discardDeck;
    if(topDiscard(1).value <= 9)
        break; end
end

inUseDeck = inUseDeck(2:length(inUseDeck));%resize the deck to remove the first card we used
playing = true;

disp('Welcome to Uno!');
disp('In this game player 1 is the computer, and also the dealer.');
%lets get some game parameters
while(true)
    players = input('How many players will there be including the dealer? (2->10): ');
    if((players >= 2) && (players <= 10))
        break; end
end

%preallocate the structure size to save memory
playerData(1).name = 'Computer';
playerData(players).name = '';

%welcome to mcdonalds, can I take your order?
for i = 2:players
    fprintf('Player %d enter your name: ', i)
    playerData(i).name = input('', 's');
end

%DEAL THE INITIAL HANDS
for i = 1:players
    for j = 1:7
        playerData(i).cards(j) = inUseDeck(1);
        inUseDeck = inUseDeck(2:length(inUseDeck));
    end
end

%who is playing
player = 1;

%FLAGS
forwardPlay = true; %game flow direction
drawFour = false; %the draw 4 wild card
drawTwo = false; %the draw 2 card
wildSet = false; %are you setting the color of a wild card
skipSet = false; %did some one skip you?

%array of COLORS for the computer
colors(1).value = 'g';
colors(2).value = 'b';
colors(3).value = 'y';
colors(4).value = 'r';

for m = 1:length(playerData)
    for n = 1:length(playerData(m).cards)
        disp(playerData(m).cards(n))
    end
end

%main game loop
while(playing)
    fprintf('\nThe current top discard is: %s\n', topDiscard(1).name)

    if(drawFour)
        playerData(player).cards(length((playerData(player).cards))+1:length(playerData(player).cards)+4) = inUseDeck(1:4);
        discardDeck(length(discardDeck)+1:length(discardDeck)+4) = inUseDeck(1:4);
        fprintf('Player %s has just revieved 4 cards: \n', playerData(player).name)
        for h = 1:4
            fprintf('%s\n', inUseDeck(h).name)
        end
        inUseDeck = inUseDeck(5:length(inUseDeck));
        drawFour = ~drawFour;
    end
    if(drawTwo)
        playerData(player).cards(length((playerData(player).cards))+1:length(playerData(player).cards)+2) = inUseDeck(1:2);
        discardDeck(length(discardDeck)+1:length(discardDeck)+2) = inUseDeck(1:2);
        fprintf('Player %s has just revieved 2 cards: \n', playerData(player).name)
        for h = 1:2
            fprintf('%s\n', inUseDeck(h).name)
        end
        inUseDeck = inUseDeck(3:length(inUseDeck));
        drawTwo = ~drawTwo;
    end
    
    if(player == 1)
        fprintf('Computer plays its hand...\n');
        for y = 1:length(playerData(player).cards)%color match
            if ((playerData(player).cards(y).color == topDiscard.color) || (playerData(player).cards(y).value == topDiscard.value) && (topDiscard.value <= 9))
                break;
            end
            %now we have our hand index for the computers matched card
            %we must update the topDiscard, move it into the discardDeck
            %and remove that card from our hand
        end

        if(playerData(player).cards(y).color == 'w') %is the one we picked a wild card?
            rnd = randperm(4);
            colorPicked = colors(rnd(1)).value; %It needs a color then!
            discardDeck(length(discardDeck)+1) = topDiscard;
            topDiscard.color = colorPicked;
            topDiscard.value = playerData(player).cards(y).value;
            switch(colorPicked)
                case 'g'
                    topDiscard.name = 'Wild (Green)';
                case 'y'
                    topDiscard.name = 'Wild (Yellow)';
                case 'b'
                    topDiscard.name = 'Wild (Blue)';
                case 'r'
                    topDiscard.name = 'Wild (Red)';
            end
            
            if(playerData(player).cards(cardToPlay).value == 17)
                drawTwo = true;
            end
            if(playerData(player).cards(cardToPlay).value == 18)
                drawFour = true;
            end
        else
            discardDeck(length(discardDeck)+1) = topDiscard;
            topDiscard = playerData(player).cards(y);
            g = 1:length(playerData(player).cards); %makes a 1.2.3....N vector
            g(y) = 0; %set the one we don't want anymore to 0
            playerData(player).cards = playerData(player).cards(find(g ~= 0));
        end

        if((topDiscard.value == 11) || (topDiscard.value == 12))%check to see if it's a DRAW TWO card
            drawTwo = true;
        end
        if((topDiscard.value == 13) || (topDiscard.value == 14))%check to see if it's a REVERSE card
            forwardPlay = ~forwardPlay;
        end
        if((topDiscard.value == 15) || (topDiscard.value == 16))%check to see if it's a SKIP card
            skipSet = true;
        end    
        if(isempty(playerData(player).cards))
            playing = false;
        end
        fprintf('\n---------------------------------------------------\n') %friendly message
    else
        fprintf('Player %s\''s turn\n', playerData(player).name)
        fprintf('You have these cards in your hand\n\n')

        for j = 1:length(playerData(player).cards)
            if ((playerData(player).cards(j).color == topDiscard.color) || (playerData(player).cards(j).value == topDiscard.value) || (playerData(player).cards(j).color == 'w'))
                fprintf('(%d) %s - PLAYABLE \n', j, playerData(player).cards(j).name)
            else
                fprintf('(%d) %s \n', j, playerData(player).cards(j).name)
            end
        end
        fprintf('(0) Draw Card\n')
        cardToPlay = input('What card would you like to play? ');
        
        while(true)
            if(cardToPlay == 0)
                insertCard = inUseDeck(1); %take first card out of the deck we're using
                inUseDeck = inUseDeck(2:length(inUseDeck)); %take the first card out and resize deck
                playerData(player).cards(length(playerData(player).cards)+1) = insertCard; % put removed card into your hand
                break;
            end
            
            if ((cardToPlay > length(playerData(player).cards)) || (cardToPlay < 0) || (playerData(player).cards(cardToPlay).color ~= topDiscard.color) && ((playerData(player).cards(cardToPlay).value ~= topDiscard.value)) && (playerData(player).cards(cardToPlay).color ~= 'w'))
                cardToPlay = input('Choose a valid card please: ');
                continue; %they might have selected a wild card. if so we need to go through this checking loop again and check for other things to set
            elseif ((playerData(player).cards(cardToPlay).color == 'w') && (wildSet ~= true)) % are you a wild card?
                while(true)
                    wildSet = false;
                    disp(' ')
                    disp('(g) for green; (y) for yellow, (b) for blue, and (r) for red')
                    disp(' ')
                    colorToPlay = input('Choose a color for your Wild Card: ', 's');
                    %make sure they selected a valid color
                    if((colorToPlay == 'g') || (colorToPlay == 'y') || (colorToPlay == 'b') || (colorToPlay == 'r'))
                        wildSet = true;
                        break; %end loop
                    else
                        continue; %start over
                    end
                end
                if(playerData(player).cards(cardToPlay).value == 17)
                    drawTwo = true;
                end
                if(playerData(player).cards(cardToPlay).value == 18)
                    drawFour = true;
                end
            %end wild card parameter checking (Above)
            else %final card declaration code bracket
                topDiscard = playerData(player).cards(cardToPlay);
                if(playerData(player).cards(cardToPlay).color == 'w')
                    topDiscard.color = colorToPlay; %for a wild card we have to manually set the color so we can check it.
                    switch(colorToPlay)
                        case 'g'
                            topDiscard.name = 'Wild (Green)';
                        case 'y'
                            topDiscard.name = 'Wild (Yellow)';
                        case 'b'
                            topDiscard.name = 'Wild (Blue)';
                        case 'r'
                            topDiscard.name = 'Wild (Red)';
                    end
                end
                
                if((topDiscard.value == 11) || (topDiscard.value == 12))%check to see if it's a DRAW TWO card
                    drawTwo = true;
                end
                if((topDiscard.value == 13) || (topDiscard.value == 14))%check to see if it's a REVERSE card
                    forwardPlay = ~forwardPlay;
                end
                if((topDiscard.value == 15) || (topDiscard.value == 16))%check to see if it's a SKIP card
                    skipSet = true;
                end
                discardDeck(length(discardDeck)+1) = topDiscard;
                g = 1:length(playerData(player).cards); %makes a 1.2.3....N vector
                g(cardToPlay) = 0; %set the one we don't want anymore to 0
                playerData(player).cards = playerData(player).cards(find(g ~= 0)); %replace the players cards with all but the ones that = 0
                fprintf('Card has been played\n---------------------------------------------------\n') %friendly message
                wildSet = false; %turn off the flag used when setting wild card parameters
                if(isempty(playerData(player).cards))
                    playing = false;
                end
                break;
            end
        end
    end

    %use to increment player
    %if playing checks to see if there isn't a winner.
    if(playing)
        if(skipSet) %are we skipping some one?
            skip = 2;
        else %we are not.. dang
            skip = 1;
        end    
        if(~forwardPlay) % is it backwards time?
            rev = (-1);
        else
            rev = 1; %nope *phew*
        end    
        player = player + (1*rev*skip);
        %time to check for errors and 'normalize' our playing order again.
        if(player == players +2)
            player = 2;
        elseif(player == players + 1)
            player = 1;
        elseif(player == 0)
            player = players;
        elseif(players == -1)
            player = players-1;
        end
    else
        break;
    end
    if(skipSet)
        fprintf('Player %s has been skipped!', playerData(player).name)
        skipset = false;
    end
end % end game loop

fprintf('\n%s is the Winner!\n', playerData(player).name)