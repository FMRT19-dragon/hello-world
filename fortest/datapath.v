module	datapath	(
					input	clk1,clk2,reset
					);
		//RNR阶段信号
wire	[164:0]		ifmt1rn;	//第一条指令来自译码的控制信息
wire	[164:0]		ifmt2rn;	//第二条指令来自译码的控制信息
wire	[164:0]		nuifmt1rn;	//第一条输入到RNR_RR_reg的控制信号
wire	[164:0]		nuifmt2rn;	//第二条输入到RNR_RR_reg的控制信号
wire	valid1rn;				//第一条指令是否有效
wire	rd1enrn;				//第一条指令的目的寄存器写使能信号(提交判断)
wire	[4:0]		rd1lrn;		//第一条指令的目的寄存器逻辑号(提交判断)
wire	rs1enrn;				//第一条指令rs是否有效
wire	rt1enrn;				//第一条指令rt是否有效
wire	[4:0]		rs1lrn;		//第一条指令的rs寄存器的逻辑号
wire	[4:0]		rt1lrn;		//第一条指令的rt寄存器的逻辑号
wire	valid2rn;				//第二条指令是否有效
wire	rd2enrn;				//第二条指令的目的寄存器写使能信号(提交判断)
wire	[4:0]		rd2lrn;		//第二条指令的目的寄存器逻辑号(提交判断)
wire	rs2enrn;				//第二条指令rs是否有效
wire	rt2enrn;				//第二条指令rt是否有效
wire	[4:0]		rs2lrn;		//第二条指令的rs寄存器的逻辑号
wire	[4:0]		rt2lrn;		//第二条指令的rt寄存器的逻辑号
wire	[5:0]		rd1prn;		//第一条指令在ROB中的编号（目的寄存器物理号）
wire	[5:0]		rd2prn;		//第二条指令在ROB中的编号（目的寄存器物理号）
wire	[5:0]		rs1prn;		//第一条指令的rs寄存器的物理号
wire	[5:0]		rt1prn;		//第一条指令的rt寄存器的物理号
wire 	rs1datacrn;				//第一条指令的rs1的数据来源（arf,rob）
wire 	rt1datacrn;				//第一条指令的rt1的数据来源（arf,rob）
wire	[5:0]		rs2prn;		//第二条指令的rs寄存器的物理号
wire	[5:0]		rt2prn;		//第二条指令的rt寄存器的物理号
wire 	rs2datacrn;				//第二条指令的rs2的数据来源（arf,rob）
wire 	rt2datacrn;				//第二条指令的rt2的数据来源（arf,rob）
wire	robfull;				////rob满信号

//RR阶段信号
wire	[164:0]		ifmt1rr;	//第一条来自RNR阶段的信息
wire	[164:0]		ifmt2rr;	//第二条来自RNR阶段的信息
wire	[5:0]		rs1prr;		//第一条指令的rs寄存器的物理号	
wire	[5:0]		rt1prr;		//第一条指令的rt寄存器的物理号
wire	[5:0]		rs2prr;		//第二条指令的rs寄存器的物理号
wire	[5:0]		rt2prr;		//第二条指令的rt寄存器的物理号
wire	[5:0]		rd1prr;		//第一条指令在ROB中的编号（目的寄存器物理号）
wire	[5:0]		rd2prr;		//第二条指令在ROB中的编号（目的寄存器物理号）
wire	[4:0]		rs1lrr;		//第一条指令的rs寄存器的逻辑号
wire	[4:0]		rt1lrr;		//第一条指令的rt寄存器的逻辑号
wire	[4:0]		rs2lrr;		//第二条指令的rs寄存器的逻辑号
wire	[4:0]		rt2lrr;		//第二条指令的rt寄存器的逻辑号
wire 	rs1datacrr;				//第一条指令的rs1的数据来源（arf,rob）
wire 	rt1datacrr;				//第一条指令的rt1的数据来源（arf,rob）
wire 	rs2datacrr;				//第二条指令的rs2的数据来源（arf,rob）
wire 	rt2datacrr;				//第二条指令的rt2的数据来源（arf,rob）
//wire	rs1datac;				//rs1的数据来源（arf,rob）
//wire	rt1datac;				//rt1的数据来源（arf,rob）
//wire	rs2datac;				//rs2的数据来源（arf,rob）
//wire	rt2datac;				//rt2的数据来源（arf,rob）
wire	rs1enrr;				//第一条指令rs是否有效
wire	rt1enrr;				//第一条指令rt是否有效
wire	rs2enrr;				//第二条指令rs是否有效
wire	rt2enrr;				//第二条指令rt是否有效
wire	[31:0]		rs1data_a;	//rs1来自arf的数据
wire	[31:0]		rt1data_a;	//rt1来自arf的数据
wire	[31:0]		rs2data_a;	//rs2来自arf的数据
wire	[31:0]		rt2data_a;	//rt2来自arf的数据
wire	rs1data_rv;				//rs1来自rob的数据是否有效
wire	rt1data_rv;				//rt1来自rob的数据是否有效
wire	rs2data_rv;				//rs2来自rob的数据是否有效
wire	rt2data_rv;				//rt2来自rob的数据是否有效
wire	[31:0]		rs1data_r;	//rs1来自rob的数据
wire	[31:0]		rt1data_r;	//rt1来自rob的数据
wire	[31:0]		rs2data_r;	//rs2来自rob的数据
wire	[31:0]		rt2data_r;	//rt2来自rob的数据
wire	rs1datavrr;				//rs1的数据是否有效
wire	rt1datavrr;				//rt1的数据是否有效
wire	rs2datavrr;				//rs2的数据是否有效
wire	rt2datavrr;				//rt2的数据是否有效
wire	[31:0]		rs1datarr;	//rs1的数据
wire	[31:0]		rt1datarr;	//rt1的数据
wire	[31:0]		rs2datarr;	//rs2的数据
wire	[31:0]		rt2datarr;	//rt2的数据
wire	valid1rr;				//第一条指令是否有效
wire	valid2rr;				//第二条指令是否有效
wire	[31:0]		bpc1rr;		//第一条指令的本PC
wire	[31:0]		npc1rr;		//第一条指令下一条指令的PC
wire	pdc1rr;					//第一条指令分支指令预测方向
wire	spilt1rr;				//第一条指令是否分割
wire	br_right1rr;			//第一条分支指令是否预测正确
wire	[1:0]		brtype1rr;	//第一条分支指令类型
wire	[31:0]		paddr1rr;	//第一条分支指令预测地址（写到保留站里面的）
wire	resen1rr;				//第一条指令保留站的写信号
wire	[1:0]		resnum1rr;	//第一条指令保留站编号
wire	rd1enrr;				//第一条指令的rd1写使能信号
wire	[4:0]		rd1lrr;		//第一条指令的rd1寄存器的逻辑号
wire	[3:0]		fucontrol1rr;//第一条指令fu控制信号
wire	[31:0]		imm1rr;		//第一条指令立即数
wire	memwen1rr;				//第一条指令memory的写信号（store指令）
wire	[4:0]		lsnum1rr;	//第一条指令load/store编号
wire	[31:0]		bpc2rr;		//第二条指令的本PC
wire	[31:0]		npc2rr;		//第二条指令下一条指令的PC
wire	pdc2rr;					//第二条指令分支指令预测方向
wire	spilt2rr;				//第二条指令是否分割
wire	br_right2rr;			//第二条分支指令是否预测正确
wire	[1:0]		brtype2rr;	//第二条分支指令类型
wire	[31:0]		paddr2rr;	//第二条分支指令预测地址（写到保留站里面的）
wire	resen2rr;				//第二条指令保留站的写信号
wire	[1:0]		resnum2rr;	//第二条指令保留站编号
wire	rd2enrr;				//第二条指令的rd1写使能信号
wire	[4:0]		rd2lrr;		//第二条指令的rd1寄存器的逻辑号
wire	[3:0]		fucontrol2rr;//第二条指令fu控制信号
wire	[31:0]		imm2rr;		//第二条指令立即数
wire	memwen2rr;				//第二条指令memory的写信号（store指令）
wire	[4:0]		lsnum2rr;	//第二条指令load/store编号

//DIS
wire	valid1dis;						//第一条指令有效（1代表指令有效）
wire	complete_dis_1;					//第一条指令的完成信号
wire	rd1endis;						//第一条指令寄存器的写信号
wire	[4:0]		rd1ldis;			//第一条指令的rd1寄存器的逻辑号
wire	[5:0]		rd1pdis;			//第一条指令的rd1寄存器的物理号
wire	[31:0]		rd_data_dis_1;		//第一条指令的result
wire	[1:0]		br_type1dis;		//第一条分支指令类型
wire	[31:0]		br_next_pc_dis_1;	//第一条分支指令的真正地址
wire	br_right1dis;					//第一条分支指令是否预测正确
wire	[31:0]		rob_write_pc_dis_1;	//第一条分支指令的本PC
wire 	memwen1dis;						//第一条指令memory的写信号
/**/wire 	[2:0]		sb_write_point_1;//第一条指令store编号
wire	valid2dis;						//第二条指令有效（1代表指令有效）
wire	complete_dis_2;					//第二条指令的完成信号
wire	rd2endis;						//第二条指令寄存器的写信号
wire	[4:0]		rd2ldis;			//第二条指令的rd1寄存器的逻辑号
wire	[5:0]		rd2pdis;			//第二条指令的rd1寄存器的物理号
wire	[31:0]		rd_data_dis_2;		//第二条指令的result
wire	[1:0]		br_type2dis;		//第二条分支指令类型
wire	[31:0]		br_next_pc_dis_2;	//第二条分支指令的真正地址
wire	br_right2dis;					//第二条分支指令是否预测正确
wire	rob_write_pc_dis_2;				//第二条分支指令的本PC
wire 	memwen2dis;						//第二条指令memory的写信号
/**/wire 	[2:0]		sb_write_point_2;//第二条指令store编号
wire 	[31:0]	bpc1dis;				//第一条指令指令的本PC
wire 	[31:0]	npc1dis;				//第一条指令下一条指令的PC
wire 	pdc1dis;						//第一条指令分支指令预测方向
wire 	spilt1dis,						//第一条指令指令是否分割
wire 	[31:0]	paddr1dis,				//第一条指令预测地址（写到保留站里面的）
wire 	res_en1dis,						//第一条指令保留站的写信号
wire 	[1:0]	resnum1dis,				//第一条指令保留站编号
wire 	rs1_endis,						//第一条指令rs是否有效
wire 	rt1_endis,						//第一条指令rt是否有效
wire 	[5:0]	rs1pdis,				//第一条指令的rs寄存器的物理号
wire 	[3:0]	fucontrol1dis,			//第一条指令fu控制信号
wire 	[31:0]	imm1dis,				//第一条指令立即数
wire 	[4:0]	lsnum1dis,				//第一条指令load/store编号
wire 	[31:0]	bpc2dis;				//第二条指令的本PC
wire 	[31:0]	npc2dis;				//第二条指令下一条指令的PC
wire 	pdc2dis;						//第二条指令分支指令预测方向
wire 	spilt2dis,						//第二条指令指令是否分割
wire 	[31:0]	paddr2dis,				//第二条指令预测地址（写到保留站里面的）
wire 	res_en2dis,						//第二条指令保留站的写信号
wire 	[1:0]	resnum2dis,				//第二条指令保留站编号
wire 	rs2_endis,						//第二条指令rs是否有效
wire 	rt2_endis,						//第二条指令rt是否有效
wire 	[5:0]	rs2pdis,				//第二条指令的rs寄存器的物理号
wire 	[3:0]	fucontrol2dis,			//第二条指令fu控制信号
wire 	[31:0]	imm2dis,				//第二条指令立即数
wire 	[4:0]	lsnum2dis,				//第二条指令load/store编号

//EX
wire	[31:0]		aluae;		//alu的第一个操作数
wire	[31:0]		alube;		//alu的第二个操作数
wire	[2:0]		alucontrole;//alu的控制信号
wire	[31:0]		sfuae;		//sfu的第一个操作数
wire	[31:0]		sfube;		//sfu的第二个操作数
wire	[1:0]		sfucontrole;//sfu的控制信号
wire	[31:0]		bruae;		//bru的第一个操作数
wire	[31:0]		brube;		//bru的第二个操作数
wire	[2:0]		brucontrole;//bru的控制信号
wire	pdce;					//分支指令预测方向
wire	[31:0]		paddre;		//分支指令预测地址
wire	[31:0]		aguae;		//agu的第一个操作数
wire	[31:0]		agube;		//agu的第二个操作数
wire	[3:0]		agucontrole;//agu的控制信号
wire	[31:0]		aluoute;	//alu的输出数据
wire	overflowe;				//alu溢出信号
wire	[31:0]		sfuoute;	//sfu的输出数据
wire	prighte;				//bru的预测是否正确
wire	btypee;					//bru的分支类型是否为B类型（1B）
wire	rdce;					//bru的分支指令真正的跳转方向
wire	[31:0]		addre;		//bru分支指令的真正的目标地址
wire	[31:0]		aguoute;	//agu的输出数据
wire	[5:0]		alurde;		//alu的目的寄存器物理号
wire	aluene;					//alu是否有效
wire	[5:0]		sfurde;		//sfu的目的寄存器物理号
wire	sfuene;					//sfu是否有效
wire	[5:0]		brurde;		//bru的目的寄存器物理号
wire	bruene;					//bru是否有效
wire	[5:0]		agurde;		//agu的目的寄存器
wire	aguene;					//agu是否有效

//WB
wire	[31:0]		aluoutw;	//alu的输出数据
wire	[5:0]		alurdw;		//alu的目的寄存器物理号
wire	aluenw;					//alu是否有效
wire	[31:0]		sfuoutw;	//sfu的输出数据
wire	[5:0]		sfurdw;		//sfu的目的寄存器物理号
wire	sfuenw;					//sfu是否有效
wire	prightw;				//bru的预测是否正确
wire	btypew;					//bru的分支类型是否为B类型（1B）
wire	rdcw;					//bru的分支指令真正的跳转方向
wire	[31:0]		addrw;		//分支指令的真正的目标地址
wire	[5:0]		brurdw;		//bru的目的寄存器物理号
wire	bruenw;					//bru是否有效
wire	[31:0]		aguoutw;	//agu的输出数据
wire	[5:0]		agurdw;		//agu的目的寄存器
wire	aguenw;					//agu是否有效
wire	brrightwen;				//br_right的写使能
wire	raddrwen;				//raddr的写使能
//for COM
wire	valid1w;				//第一条指令是否有效
wire	[1:0]		brtype1w;	//第一条分支指令类型
wire	brright1w;				//第一条分支指令是否预测正确
wire	rdc1w;					//第一条分支指令真正的跳转方向
wire	[31:0]		raddr1w;	//第一条分支指令的真正的目标地址
wire	[31:0]		pc1w;		//第一条指令的PC,（分割指令的下一个PC）
wire	valid2w;				//第二条指令是否有效
wire	[1:0]		brtype2w;	//第二条分支指令类型
wire	brright2w;				//第二条分支指令是否预测正确
wire	rdc2w;					//第二条分支指令真正的跳转方向
wire	[31:0]		raddr2w;	//第二条分支指令的真正的目标地址
wire	[31:0]		pc2w;		//第二条指令的PC,（分割指令的下一个PC）
wire	rd1enw;					//第一条指令的rd1写使能信号				
wire	[31:0]		result1w;	//第一条指令的计算结果
wire	rd2enw;					//第二条指令的rd1写使能信号
wire	[31:0]		result2w;	//第二条指令的计算结果
wire	[4:0]		rd1lw;		//第一条指令的rd1寄存器的逻辑号
wire	[5:0]		rd1pw;		//第一条指令的rd1寄存器的物理号
wire	[4:0]		rd2lw;		//第二条指令的rd1寄存器的逻辑号
wire	[5:0]		rd2pw;		//第二条指令的rd1寄存器的物理号
wire	[5:0]		rd1pn;		//第一条指令rd1的最新映射物理号
wire	[5:0]		rd2pn;		//第二条指令rd2的最新映射物理号
wire	memwen1w;				//第一条指令memory的写信号（store指令）
wire	[2:0]		sbnum1w;	//第一条store buffer的编号
wire	memwen2w;				//第二条指令memory的写信号（store指令）
wire	[2:0]		sbnum2w;	//第二条store buffer的编号
wire	srat_1en1w;				//第一条指令修改srat_1的使能位
wire	arfen1w;				//第一条指令修改arf的使能位
wire	write1w;				//第一条指令store buffer的状态位写使能
wire	srat_1en2w;				//第二条指令修改srat_1的使能位
wire	arfen2w;				//第二条指令修改arf的使能位
wire	write2w;				//第二条指令store buffer的状态位写使能

//COM
wire	valid1c;				//第一条指令是否有效
wire	[4:0]		rd1lc;		//第一条指令的rd1寄存器的逻辑号
wire	[5:0]		rd1pc;		//第一条指令的rd1寄存器的物理号
wire	[1:0]		br_type1c;	//第一条分支指令类型
wire	right1c;				//第一条分支指令是否预测正确
wire	rdc1c;					//第一条分支指令真正的跳转方向
wire	[31:0]	raddr1c;		//第一条分支指令的真正的目标地址
wire	[31:0]	pc1c;			//第一条指令的PC,（分割指令的下一个PC）
wire	[31:0]	result1c;		//第一条指令的计算结果
wire	[2:0]	sbnum1c;		//第一条store buffer的编号
wire	srat_1en1c;				//提交阶段第一条指令修改srat_1的使能位
wire	arfen1c;				//提交阶段第一条指令修改arf的使能位
wire	write1c;				//提交阶段第一条指令store buffer的状态位写使能
wire	valid2c;				//第二条指令是否有效
wire	[4:0]		rd2lc;		//第二条指令的rd1寄存器的逻辑号
wire	[5:0]		rd2pc;		//第二条指令的rd1寄存器的物理号
wire	[1:0]		br_type2c;	//第二条分支指令类型
wire	right2c;				//第二条分支指令是否预测正确
wire	rdc2c;					//第二条分支指令真正的跳转方向
wire	[31:0]	raddr2c;		//第二条分支指令的真正的目标地址
wire	[31:0]	pc2c;			//第二条指令的PC,（分割指令的下一个PC）
wire	[31:0]	result2c;		//第二条指令的计算结果
wire	[2:0]	sbnum2c;		//第二条store buffer的编号
wire	srat_1en2c;				//提交阶段第二条指令修改srat_1的使能位
wire	arfen2c;				//提交阶段第二条指令修改arf的使能位
wire	write2c;				//提交阶段第二条指令store buffer的状态位写使能

endmodule