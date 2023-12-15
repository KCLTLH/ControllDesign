function plot_constant_lines_z(zeta, omegan, T)
    % plot lines of constant damping ratio (zeta), time constant 
    % (1/zeta*omegan) and omegan on the z-plane
    nyquist_freq = pi/T;
    freqs = linspace(-nyquist_freq, nyquist_freq, 50000);
    
    % constant time constant is a vertical line in s-plane at -zeta*omegan
    timeconstant_line_s = -zeta*omegan*ones(size(freqs)) + 1i*freqs;
    timeconstant_line_z = exp(timeconstant_line_s*T);
    plot(real(timeconstant_line_z), imag(timeconstant_line_z), ...
         '--', 'Color', [0.8500 0.3250 0.0980], 'DisplayName', ['\zeta\omega_n=', num2str(zeta*omegan, '%.3f')]);
    hold on;
    
    % constant damping ratio zeta is a radial line from origin in s-plane
    damping_line_splane = -abs(freqs)./tan(acos(zeta)) + 1i*freqs;
    damping_line_zplane = exp(damping_line_splane*T);
    plot(real(damping_line_zplane), imag(damping_line_zplane), ...
         '-', 'Color', [0.4940 0.1840 0.5560], 'DisplayName', ['\zeta=', num2str(zeta, '%.3f')]);
    
    hold off;
    xlabel('Real Axis');
    ylabel('Imaginary Axis');
    legend('Location', 'northwest');
end


