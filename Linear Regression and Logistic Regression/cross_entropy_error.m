function[e_in] = cross_entropy_error(x,y,w)
    [N,~] = size(y);
    e_in = 0;
    x = [ones(N,1),x];
    for i=1:N
        e_in = e_in + log(1 + exp(-y(i)*w'*x(i,:)'));
    end
    e_in = e_in / N;
end