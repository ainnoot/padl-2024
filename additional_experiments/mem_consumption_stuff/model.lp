% Choice[ER Triage, ER Sepsis Triage] | |

constraint(0, "Choice").
bind(0, arg_0, "ER Triage").
bind(0, arg_1, "ER Sepsis Triage").

% Choice[ER Registration, ER Triage] | |

constraint(1, "Choice").
bind(1, arg_0, "ER Registration").
bind(1, arg_1, "ER Triage").

% Response[ER Registration, Leucocytes] | |

constraint(2, "Response").
bind(2, arg_0, "ER Registration").
bind(2, arg_1, "Leucocytes").

% Responded Existence[Leucocytes, CRP] | |

constraint(3, "Responded Existence").
bind(3, arg_0, "Leucocytes").
bind(3, arg_1, "CRP").

% Responded Existence[ER Triage, ER Sepsis Triage] | |

constraint(4, "Responded Existence").
bind(4, arg_0, "ER Triage").
bind(4, arg_1, "ER Sepsis Triage").

% Precedence[ER Registration, ER Sepsis Triage] | |

constraint(5, "Precedence").
bind(5, arg_0, "ER Registration").
bind(5, arg_1, "ER Sepsis Triage").

% Responded Existence[ER Triage, Leucocytes] | |

constraint(6, "Responded Existence").
bind(6, arg_0, "ER Triage").
bind(6, arg_1, "Leucocytes").

% Responded Existence[ER Sepsis Triage, ER Registration] | |

constraint(7, "Responded Existence").
bind(7, arg_0, "ER Sepsis Triage").
bind(7, arg_1, "ER Registration").

% Response[ER Registration, ER Triage] | |

constraint(8, "Response").
bind(8, arg_0, "ER Registration").
bind(8, arg_1, "ER Triage").

% Responded Existence[ER Triage, ER Registration] | |

constraint(9, "Responded Existence").
bind(9, arg_0, "ER Triage").
bind(9, arg_1, "ER Registration").

% Precedence[Leucocytes, CRP] | |

constraint(10, "Precedence").
bind(10, arg_0, "Leucocytes").
bind(10, arg_1, "CRP").

% Choice[ER Sepsis Triage, Leucocytes] | |

constraint(11, "Choice").
bind(11, arg_0, "ER Sepsis Triage").
bind(11, arg_1, "Leucocytes").

% Response[ER Sepsis Triage, CRP] | |

constraint(12, "Response").
bind(12, arg_0, "ER Sepsis Triage").
bind(12, arg_1, "CRP").

% Choice[ER Triage, Leucocytes] | |

constraint(13, "Choice").
bind(13, arg_0, "ER Triage").
bind(13, arg_1, "Leucocytes").

% Choice[ER Registration, Leucocytes] | |

constraint(14, "Choice").
bind(14, arg_0, "ER Registration").
bind(14, arg_1, "Leucocytes").

% Precedence[ER Triage, CRP] | |

constraint(15, "Precedence").
bind(15, arg_0, "ER Triage").
bind(15, arg_1, "CRP").

% Alternate Response[ER Registration, Leucocytes] | |

constraint(16, "Alternate Response").
bind(16, arg_0, "ER Registration").
bind(16, arg_1, "Leucocytes").

% Precedence[ER Registration, Leucocytes] | |

constraint(17, "Precedence").
bind(17, arg_0, "ER Registration").
bind(17, arg_1, "Leucocytes").

% Response[ER Triage, CRP] | |

constraint(18, "Response").
bind(18, arg_0, "ER Triage").
bind(18, arg_1, "CRP").

% Responded Existence[CRP, ER Triage] | |

constraint(19, "Responded Existence").
bind(19, arg_0, "CRP").
bind(19, arg_1, "ER Triage").

% Choice[CRP, Leucocytes] | |

constraint(20, "Choice").
bind(20, arg_0, "CRP").
bind(20, arg_1, "Leucocytes").

% Alternate Precedence[ER Registration, ER Sepsis Triage] | |

constraint(21, "Alternate Precedence").
bind(21, arg_0, "ER Registration").
bind(21, arg_1, "ER Sepsis Triage").

% Alternate Response[ER Sepsis Triage, CRP] | |

constraint(22, "Alternate Response").
bind(22, arg_0, "ER Sepsis Triage").
bind(22, arg_1, "CRP").

% Responded Existence[ER Sepsis Triage, ER Triage] | |

constraint(23, "Responded Existence").
bind(23, arg_0, "ER Sepsis Triage").
bind(23, arg_1, "ER Triage").

% Response[ER Registration, CRP] | |

constraint(24, "Response").
bind(24, arg_0, "ER Registration").
bind(24, arg_1, "CRP").

% Alternate Response[ER Registration, ER Sepsis Triage] | |

constraint(25, "Alternate Response").
bind(25, arg_0, "ER Registration").
bind(25, arg_1, "ER Sepsis Triage").

% Chain Precedence[ER Triage, ER Sepsis Triage] | |

constraint(26, "Chain Precedence").
bind(26, arg_0, "ER Triage").
bind(26, arg_1, "ER Sepsis Triage").

% Alternate Response[ER Triage, ER Sepsis Triage] | |

constraint(27, "Alternate Response").
bind(27, arg_0, "ER Triage").
bind(27, arg_1, "ER Sepsis Triage").

% Precedence[ER Registration, ER Triage] | |

constraint(28, "Precedence").
bind(28, arg_0, "ER Registration").
bind(28, arg_1, "ER Triage").

% Alternate Precedence[ER Registration, ER Triage] | |

constraint(29, "Alternate Precedence").
bind(29, arg_0, "ER Registration").
bind(29, arg_1, "ER Triage").

% Precedence[ER Triage, Leucocytes] | |

constraint(30, "Precedence").
bind(30, arg_0, "ER Triage").
bind(30, arg_1, "Leucocytes").

% Alternate Precedence[ER Triage, ER Sepsis Triage] | |

constraint(31, "Alternate Precedence").
bind(31, arg_0, "ER Triage").
bind(31, arg_1, "ER Sepsis Triage").

% Responded Existence[CRP, ER Sepsis Triage] | |

constraint(32, "Responded Existence").
bind(32, arg_0, "CRP").
bind(32, arg_1, "ER Sepsis Triage").

% Responded Existence[ER Registration, CRP] | |

constraint(33, "Responded Existence").
bind(33, arg_0, "ER Registration").
bind(33, arg_1, "CRP").

% Precedence[ER Registration, CRP] | |

constraint(34, "Precedence").
bind(34, arg_0, "ER Registration").
bind(34, arg_1, "CRP").

% Response[Leucocytes, CRP] | |

constraint(35, "Response").
bind(35, arg_0, "Leucocytes").
bind(35, arg_1, "CRP").

% Alternate Response[ER Triage, Leucocytes] | |

constraint(36, "Alternate Response").
bind(36, arg_0, "ER Triage").
bind(36, arg_1, "Leucocytes").

% Choice[Leucocytes, ER Triage] | |

constraint(37, "Choice").
bind(37, arg_0, "Leucocytes").
bind(37, arg_1, "ER Triage").

% Responded Existence[ER Registration, ER Triage] | |

constraint(38, "Responded Existence").
bind(38, arg_0, "ER Registration").
bind(38, arg_1, "ER Triage").

% Chain Precedence[ER Registration, ER Triage] | |

constraint(39, "Chain Precedence").
bind(39, arg_0, "ER Registration").
bind(39, arg_1, "ER Triage").

% Chain Response[ER Registration, ER Triage] | |

constraint(40, "Chain Response").
bind(40, arg_0, "ER Registration").
bind(40, arg_1, "ER Triage").

% Responded Existence[Leucocytes, ER Sepsis Triage] | |

constraint(41, "Responded Existence").
bind(41, arg_0, "Leucocytes").
bind(41, arg_1, "ER Sepsis Triage").

% Responded Existence[ER Sepsis Triage, Leucocytes] | |

constraint(42, "Responded Existence").
bind(42, arg_0, "ER Sepsis Triage").
bind(42, arg_1, "Leucocytes").

% Choice[ER Registration, ER Sepsis Triage] | |

constraint(43, "Choice").
bind(43, arg_0, "ER Registration").
bind(43, arg_1, "ER Sepsis Triage").

% Responded Existence[Leucocytes, ER Triage] | |

constraint(44, "Responded Existence").
bind(44, arg_0, "Leucocytes").
bind(44, arg_1, "ER Triage").

% Precedence[ER Sepsis Triage, CRP] | |

constraint(45, "Precedence").
bind(45, arg_0, "ER Sepsis Triage").
bind(45, arg_1, "CRP").

% Choice[Leucocytes, ER Sepsis Triage] | |

constraint(46, "Choice").
bind(46, arg_0, "Leucocytes").
bind(46, arg_1, "ER Sepsis Triage").

% Alternate Response[ER Sepsis Triage, Leucocytes] | |

constraint(47, "Alternate Response").
bind(47, arg_0, "ER Sepsis Triage").
bind(47, arg_1, "Leucocytes").

% Response[ER Triage, Leucocytes] | |

constraint(48, "Response").
bind(48, arg_0, "ER Triage").
bind(48, arg_1, "Leucocytes").

% Responded Existence[ER Sepsis Triage, CRP] | |

constraint(49, "Responded Existence").
bind(49, arg_0, "ER Sepsis Triage").
bind(49, arg_1, "CRP").

% Alternate Response[ER Triage, CRP] | |

constraint(50, "Alternate Response").
bind(50, arg_0, "ER Triage").
bind(50, arg_1, "CRP").

% Responded Existence[CRP, ER Registration] | |

constraint(51, "Responded Existence").
bind(51, arg_0, "CRP").
bind(51, arg_1, "ER Registration").

% Precedence[ER Sepsis Triage, Leucocytes] | |

constraint(52, "Precedence").
bind(52, arg_0, "ER Sepsis Triage").
bind(52, arg_1, "Leucocytes").

% Choice[Leucocytes, ER Registration] | |

constraint(53, "Choice").
bind(53, arg_0, "Leucocytes").
bind(53, arg_1, "ER Registration").

% Precedence[ER Triage, ER Sepsis Triage] | |

constraint(54, "Precedence").
bind(54, arg_0, "ER Triage").
bind(54, arg_1, "ER Sepsis Triage").

% Response[ER Sepsis Triage, Leucocytes] | |

constraint(55, "Response").
bind(55, arg_0, "ER Sepsis Triage").
bind(55, arg_1, "Leucocytes").

% Choice[ER Triage, CRP] | |

constraint(56, "Choice").
bind(56, arg_0, "ER Triage").
bind(56, arg_1, "CRP").

% Choice[ER Sepsis Triage, CRP] | |

constraint(57, "Choice").
bind(57, arg_0, "ER Sepsis Triage").
bind(57, arg_1, "CRP").

% Choice[ER Triage, ER Registration] | |

constraint(58, "Choice").
bind(58, arg_0, "ER Triage").
bind(58, arg_1, "ER Registration").

% Choice[CRP, ER Registration] | |

constraint(59, "Choice").
bind(59, arg_0, "CRP").
bind(59, arg_1, "ER Registration").

% Choice[Leucocytes, CRP] | |

constraint(60, "Choice").
bind(60, arg_0, "Leucocytes").
bind(60, arg_1, "CRP").

% Choice[ER Registration, CRP] | |

constraint(61, "Choice").
bind(61, arg_0, "ER Registration").
bind(61, arg_1, "CRP").

% Choice[ER Sepsis Triage, ER Triage] | |

constraint(62, "Choice").
bind(62, arg_0, "ER Sepsis Triage").
bind(62, arg_1, "ER Triage").

% Responded Existence[ER Registration, ER Sepsis Triage] | |

constraint(63, "Responded Existence").
bind(63, arg_0, "ER Registration").
bind(63, arg_1, "ER Sepsis Triage").

% Responded Existence[Leucocytes, ER Registration] | |

constraint(64, "Responded Existence").
bind(64, arg_0, "Leucocytes").
bind(64, arg_1, "ER Registration").

% Choice[CRP, ER Triage] | |

constraint(65, "Choice").
bind(65, arg_0, "CRP").
bind(65, arg_1, "ER Triage").

% Alternate Response[ER Registration, CRP] | |

constraint(66, "Alternate Response").
bind(66, arg_0, "ER Registration").
bind(66, arg_1, "CRP").

% Choice[ER Sepsis Triage, ER Registration] | |

constraint(67, "Choice").
bind(67, arg_0, "ER Sepsis Triage").
bind(67, arg_1, "ER Registration").

% Responded Existence[ER Registration, Leucocytes] | |

constraint(68, "Responded Existence").
bind(68, arg_0, "ER Registration").
bind(68, arg_1, "Leucocytes").

% Response[ER Registration, ER Sepsis Triage] | |

constraint(69, "Response").
bind(69, arg_0, "ER Registration").
bind(69, arg_1, "ER Sepsis Triage").

% Alternate Response[ER Registration, ER Triage] | |

constraint(70, "Alternate Response").
bind(70, arg_0, "ER Registration").
bind(70, arg_1, "ER Triage").

% Chain Response[ER Triage, ER Sepsis Triage] | |

constraint(71, "Chain Response").
bind(71, arg_0, "ER Triage").
bind(71, arg_1, "ER Sepsis Triage").

% Responded Existence[ER Triage, CRP] | |

constraint(72, "Responded Existence").
bind(72, arg_0, "ER Triage").
bind(72, arg_1, "CRP").

% Response[ER Triage, ER Sepsis Triage] | |

constraint(73, "Response").
bind(73, arg_0, "ER Triage").
bind(73, arg_1, "ER Sepsis Triage").

% Responded Existence[CRP, Leucocytes] | |

constraint(74, "Responded Existence").
bind(74, arg_0, "CRP").
bind(74, arg_1, "Leucocytes").

% Choice[CRP, ER Sepsis Triage] | |

constraint(75, "Choice").
bind(75, arg_0, "CRP").
bind(75, arg_1, "ER Sepsis Triage").
