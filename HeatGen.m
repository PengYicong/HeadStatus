function G = HeatGen(data,M,N,step,min)
    G = zeros(M,N);
    for i = 1:M
        for j = 1:N
            for k = 1:size(data,1)
                if (data(k,1) <= min + i*step) && (data(k,1) > min + (i-1)*step)
                    if (data(k,2) <= min + j*step) && (data(k,2) > min + (j-1)*step)
                        G(i,j) = G(i,j) + 10;
                        if (i > 1) && (j > 1) && (i < M) && (j < N)
                            G(i-1,j-1) = G(i-1,j-1) + 1;
                            G(i-1,j+1) = G(i-1,j+1) + 1;
                            G(i+1,j-1) = G(i+1,j-1) + 1;
                            G(i+1,j+1) = G(i+1,j+1) + 1;
                            G(i+1,j) = G(i+1,j) + 3;
                            G(i,j+1) = G(i,j+1) + 3;
                            G(i-1,j) = G(i-1,j) + 3;
                            G(i,j-1) = G(i,j-1) + 3;
                        end
                    end
                end
            end
        end
    end
end