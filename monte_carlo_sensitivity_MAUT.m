function monte_carlo_sensitivity_MAUT(N, s_values, W, Utility_Alternatives);

%Calculate the original scores
original_scores = Utility_Alternatives * W;
[~, original_ranking] = sort(original_scores, 'descend');

%Initialize the table PRR (Probability of Rank Reversal)
PRR = zeros(length(s_values), 1);

%For every value of s (perturbation strength)
for si = 1:length(s_values)
  s = s_values(si);
    reversal_count = 0;

%Calculate N times Monte Carlo
for k = 1:N
  noise = normrnd(0, s, size(W)); %Add noise to weights
  W_perturbed = W + noise;
  W_perturbed = W_perturbed / sum(W_perturbed); %Normalization

%Calculate new scores
new_scores = Utility_Alternatives * W_perturbed;
[~, new_ranking] = sort(new_scores, 'descend');

%Check
if ~isequal(new_ranking, original_ranking)
  reversal_count = reversal_count + 1;
end
end

%Calculate PRR
PRR(si) = reversal_count / N;
end

%Diagram PRR based on s
figure;
plot(s_values, PRR, "-*g");
xlabel('Perturbation Strength (s)');
ylabel('Probability of Rank Reversal (PRR)');
title('Sensitivity Analysis with Monte Carlo Simulation');
grid on;

%Display original and final scores
disp('Original Scores and Rankings:');
disp(original_scores);
disp(original_ranking);

disp('Final PRR values:');
disp(PRR);
end

N = 10^4; %Times of repetition
s_values = 0.2:0.1:0.6; %Perturbation strengths
W = [0.4; 0.35; 0.25]; %Weights of criteria
Utility_Alternatives = [
    0.4444, 0, 0.4;
    1, 1, 0;
    0, 0.5, 1
]; %Utility of Alternatives

monte_carlo_sensitivity_MAUT(N, s_values, W, Utility_Alternatives);

