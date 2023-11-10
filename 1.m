R = 2.5;  
N = 20;    

outputSignal = recursiveImpulseResponse(R, N);

plot(outputSignal);
title('Output Signal');
xlabel('n');
ylabel('y[n]');


% Transfer function H1(z)
numerator = 1;
denominator = [1, -R];

% Plot pole-zero plot
figure;
zplane(numerator, denominator);
title('Pole-Zero Plot');


% Set the threshold for daily infections
threshold = 1e6;

% Find the number of days required to reach the threshold
N = 1000;  % Set an arbitrary upper limit for N
outputSignal = recursiveImpulseResponse(R, N);

% Find the index where the output signal exceeds the threshold
indexThreshold = find(outputSignal >= threshold, 1);


output = solveDifferenceEquation(R, 20);

% Display the result
disp('Time-domain equation for the number of newly infected people:');
plot(output)
xlabel('n');
ylabel('sum[n]');

function y = recursiveImpulseResponse(R, N)
    % R0: coefficient
    % N: length of the output signal
    
    % Initialize output signal
    y = zeros(1, N);
    
    % Impulse response
    delta = zeros(1, N);
    delta(1) = 1;  
    y(1) = 1;
    % Apply the recursive equation
    for n = 2:N
        y(n) = delta(n) + R * y(n - 1);
    end
end

function d = solveDifferenceEquation(R0, N)
    % R0: coefficient
    % N: length of the output signal
    
    d = zeros(1,N) ;
    d(1) = 1 ;
    % Iteratively solve the difference equation
    y = recursiveImpulseResponse(R0, N) ;

    for n = 2: N 
        d(n) = y(n) + d(n-1) ;
    end 
end
