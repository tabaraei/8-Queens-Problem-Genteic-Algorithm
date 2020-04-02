function fitness = fitnessCalculator(A, numberOfSamples)
    
    fitness = zeros(1,numberOfSamples);
    
    for k=1:numberOfSamples
        result = 0;
        for i=1:8
            for j=i+1:8
                if A(k,j)+(j-i) == A(k,i) || A(k,j)-(j-i) == A(k,i) || A(k,i) == A(k,j)
                    result = result + 1;
                end
            end
        end
        fitness(k) = 28 - result;
    end
end