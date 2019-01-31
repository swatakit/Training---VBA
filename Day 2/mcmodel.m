% MCMODEL Calculates the price of an European Call Option
%
% Uses Monte Carlo simulations to model the equation of the form
% c = exp(-rT)*E(max(ST-K,0))
% where ST is the stock price at maturity and is calculated using 
% Geometric Brownian Motion as follows: 

% Initialize parameters
r = 0.05;           % interest
sigma = 0.115;      % volatility: measure for uncertainty
T = 0.75;           % maturity: time to expiration date 
                    % (normalized to year: 1 equals one year)
S0 = 30;            % Current stock price
K = 28;             % strike price (exercise price)

paths=150;

% Calculate incremental time and step size
dt = 1/252; % 1 trading day
steps = round(T/dt);

% Calculate simulated stock prices
SInit = S0 * ones(1,paths);

nu = r - sigma.^2/2;
Z = randn(steps,paths);
DeltaS = exp(nu*dt+sigma*sqrt(dt)*Z);

ST = cumprod([SInit; DeltaS]);
figure
plot(linspace(0,T,steps+1)',ST)
title('Monte Carlo Simulation Results')
xlabel('Time to maturity [Years]')
ylabel('Asset Price [US-$]')

% Calculate the option price
payoff = max(ST(end,:)-K,0);
expected_payoff = mean(payoff); % Expected payoff
c = exp(-r*T)*expected_payoff; % call price
