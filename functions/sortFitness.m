function sortedFitness = sortFitness(A, numberOfSamples)
    
    sortedFitness = 1:50;

    for i=1:numberOfSamples
        for j=1:numberOfSamples
            if A(i) < A(j)
                temp = A(i);
                A(i) = A(j);
                A(j) = temp;

                temp = sortedFitness(i);
                sortedFitness(i) = sortedFitness(j);
                sortedFitness(j) = temp;
            end
        end
    end
end