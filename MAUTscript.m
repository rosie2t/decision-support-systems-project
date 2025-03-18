M=15; % Number of experts

N=3; % Number of criteria

Nalter=3; % Number of alternatives

S=[1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9]; % Nine-level scale matrix

Pc=ones(N,N,M); % Initialization of the PWC matrix for the criteria

% Creation of the PWC matrix
for m=1:M
 Pc(:,:,m)=pairwise_MAUT(S,N);
end

% Initialization of the weight matrix for the criteria - wk (m)
w=zeros(N,M);

% Estimation of weights and relative scores from the PWCs
for m=1:M
 w(:,m)=eigenmethod_MAUT(Pc(:,:,m));
end

% Estimation of mean values of weights and relative scores for M experts
W=mean(w,2); % Mean weights for the criteria - wk

Software_alternatives = [
    5000, 20, 5; % HR Software 1
    2500, 10, 3; % HR Software 2
    7000, 15, 8  % HR Software 3
];

max_values=max(Software_alternatives,[],1); % Max value for each column

min_values=min(Software_alternatives,[],1); % Min value for each column

Cost_scale=[max_values(1),min_values(1)]; % Worst and best cost value

Training_scale=[max_values(2),min_values(2)]; % Worst and best training time value

Departments_scale=[min_values(3),max_values(3)]; % Worst and best number of sections value

Ucost_software1 = utility(Software_alternatives(1), max_values(1), min_values(1)); %0.4444
Utraining_software1 = utility(Software_alternatives(4), max_values(2), min_values(2)); %0
Udepartments_software1 = utility(Software_alternatives(7), min_values(3), max_values(3)); %0.4

Ucost_software2 = utility(Software_alternatives(2), max_values(1), min_values(1)); %1
Utraining_software2 = utility(Software_alternatives(5), max_values(2), min_values(2)); %1
Udepartments_software2 = utility(Software_alternatives(8), min_values(3), max_values(3)); %0

Ucost_software3 = utility(Software_alternatives(3), max_values(1), min_values(1)); %0
Utraining_software3 = utility(Software_alternatives(6), max_values(2), min_values(2)); %0.5
Udepartments_software3 = utility(Software_alternatives(9), min_values(3), max_values(3)); %1

Utility_software1 = [Ucost_software1;Utraining_software1;Udepartments_software1]; %Utilities for software1
Utility_software2 = [Ucost_software2;Utraining_software2;Udepartments_software2]; %Utilities for software2
Utility_software3 = [Ucost_software3;Utraining_software3;Udepartments_software3]; %Utilities for software3

Utililty_Alternatives = [Utility_software1;Utility_software2;Utility_software3]; % Utility of alternative software

Criteria_weights = W % Weights for cost, training time, and number of sections respectively

Uvalues_software1 = (Utility_software1 .* Criteria_weights); % Multiplication of weights with utilities of software1
Uvalues_software2 = (Utility_software2 .* Criteria_weights); % Multiplication of weights with utilities of software2
Uvalues_software3 = (Utility_software3 .* Criteria_weights); % Multiplication of weights with utilities of software3

Usoftware1 = 0;
Usoftware2 = 0;
Usoftware3 = 0;

for i = 1:3
  Usoftware1 = Usoftware1 + Uvalues_software1(i);
  Usoftware2 = Usoftware2 + Uvalues_software2(i);
  Usoftware3 = Usoftware3 + Uvalues_software3(i);
end

Ualternatives = [Usoftware1;Usoftware2;Usoftware3];

% Diagram for the weights of the criteria
figure(1);
bar(Criteria_weights, 'r');
xlabel('Criteria');
ylabel('Weights (%)');
set(gca, 'xticklabel', {'Cost', 'Training Time', 'Departments'});
title('Criteria Weights');

% Diagram for the utilities of the alternatives
figure(2);
bar(Ualternatives);
xlabel('Alternatives');
ylabel('Utility (%)');
set(gca, 'xticklabel', {'Software 1', 'Software 2', 'Software 3'});
title('Utilities of Alternatives');






