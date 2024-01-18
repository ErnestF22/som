
num_samples = 10;

stief_samples = generate_stiefel_sampling(4,3,5,num_samples);

% disp("stief_samples")
% disp(stief_samples)

for ii = 1:num_samples
    if ~check_is_on_stiefel(stief_samples(:,:,:,ii))
        fprintf("sample %g is NOT on Stiefel\n", ii);
        break;
    end
end


