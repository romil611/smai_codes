%% Q1
% 
% Let the data be Linearly seperable and let $\hat{a}$ be solution vector perpendicular to the required plain. So, we know that $\hat{a}^{t}y_{i} > 0$ $\forall$ $i$.
% 
% The Gradient Descent Equation is:,
% 
% $a(k+1) = a(k) + y^{k}$
% 
% We subtracting $\alpha\hat{a}$ from both sides, 
% 
% $a(k+1) - \alpha\hat{a} = a(k) - \alpha\hat{a} + y^{k}$ 
% 
% Squarin both sides
% 
% $||a(k+1) - \alpha\hat{a}||^{2} = ||a(k) - \alpha\hat{a} + y^{k}||^{2}$
% 
% $||a(k+1) - \alpha\hat{a}||^{2} = ||a(k) - \alpha\hat{a}||^{2} + ||y^{k}||^{2} + 2(a(k) - \alpha\hat{a})^{t}y^{k}$
% 
% $y^{k}$ was a misclassified point. Hence $\hat{a}^{t}y^{k} \leq 0$, so: 
% 
% $||a(k+1) - \alpha\hat{a}||^{2} \leq ||a(k) - \alpha\hat{a}||^{2} + ||y^{k}||^{2} - 2\alpha\hat{a}^{t}y^{k}$
% 
% Now, ${a}^{t}y^{k} > 0$. Also,
% 
% We define $\beta$ as the maximum length of the pattern vector. ie. $\beta^{2} = max_{i} || y_{i} || ^ {2}$. As this is a positive value, this is the maximum we can achieve from the second term.
% 
% We define $\gamma$ as the smaller inner product of the $\hat{a}$ with any pattern vector. ie. $\gamma = min_{i} [ \hat{a}^{i}y_{i} ]$. This is the minimum we can achieve from the third term which can be subtracted.
% 
% 
% Hence our equation becomes,
% 
% $||a(k+1) - \alpha\hat{a}||^{2} \leq ||a(k) - \alpha\hat{a}||^{2} - 2\alpha\gamma + \beta^{2}$
% 
% $\alpha was a random constant so let
% 
% $\alpha = \beta^{2}/\gamma$.
% 
% Our equation reduces to,
% 
% $||a(k+1) - \alpha\hat{a}||^{2} \leq ||a(k) - \alpha\hat{a}||^{2} - \beta^{2}$
% 
% Say that after some $k_{0}$ steps, the equation converges, \\ ie. $||a(k_{0}+1) - \alpha\hat{a}||^{2} = 0$, hence,
% 
% $0 \leq ||a(k) - \alpha\hat{a}||^{2} - k_{0}\beta^{2}$ 
% 
% or we can write it as
% 
% $k_{0} = ||a(1) - \alpha\hat{a}||^{2}/\beta^{2}$$$
% 
