function monte_carlo_sensitivity_MAUT(N, s_values, W, Utility_Alternatives);

%Υπολογισμός των αρχικών βαθμολογιών και κατατάξεων των εναλλακτικών
original_scores = Utility_Alternatives * W;
[~, original_ranking] = sort(original_scores, 'descend');

%Αρχικοποίηση του πίνακα PRR (Probability of Rank Reversal)
PRR = zeros(length(s_values), 1);

%Επανάληψη για κάθε τιμή του s (perturbation strength)
for si = 1:length(s_values)
  s = s_values(si);
    reversal_count = 0;

%Εκτέλεση N επαναλήψεων Monte Carlo
for k = 1:N
  noise = normrnd(0, s, size(W)); %Προσθήκη θορύβου στα βάρη
  W_perturbed = W + noise;
  W_perturbed = W_perturbed / sum(W_perturbed); %Κανονικοποίηση

%Υπολογισμός νέων προτεραιοτήτων
new_scores = Utility_Alternatives * W_perturbed;
[~, new_ranking] = sort(new_scores, 'descend');

%Έλεγχος για αναστροφή κατάταξης
if ~isequal(new_ranking, original_ranking)
  reversal_count = reversal_count + 1;
end
end

%Υπολογισμός PRR
PRR(si) = reversal_count / N;
end

%Γράφημα PRR ως συνάρτηση του s
figure;
plot(s_values, PRR, "-*g");
xlabel('Perturbation Strength (s)');
ylabel('Probability of Rank Reversal (PRR)');
title('Sensitivity Analysis with Monte Carlo Simulation');
grid on;

%Εμφάνιση αρχικών και τελικών προτεραιοτήτων
disp('Original Scores and Rankings:');
disp(original_scores);
disp(original_ranking);

disp('Final PRR values:');
disp(PRR);
end

N = 10^4; %Αριθμός επαναλήψεων
s_values = 0.2:0.1:0.6; %Perturbation strengths
W = [0.4; 0.35; 0.25]; %Βάρη κριτηρίων
Utility_Alternatives = [
    0.4444, 0, 0.4;
    1, 1, 0;
    0, 0.5, 1
]; %Χρησιμότητες εναλλακτικών

monte_carlo_sensitivity_MAUT(N, s_values, W, Utility_Alternatives);

