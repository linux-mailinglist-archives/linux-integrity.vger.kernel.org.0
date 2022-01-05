Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A01485A52
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiAEU4I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 15:56:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:60783 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244255AbiAEU4C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 15:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641416162; x=1672952162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/74BjyOvkge1ZZJm6N9EE+04KKrfpaii09pMcpRXciU=;
  b=h19whRJSuxf5gmKBRZmOM8izLadafEhaM8pJ/r+/3meeBCWKA90DNsbs
   wNNvkf3mBMrNLUv+oEQFdaLYINYCxOXmYC45BBl+FLPWqOMU80CdBWhP/
   VoL2+ZWmc38OUa0/4rC5CkIIWu6Xd1yaubT+yEjjl8HX8pFbEFZK2DrWY
   VD5+gOKjE6vVjeO6ez9CyMWVq2ZASFo8UQC4QcZUrY+HY2Q9HBKzdIbu5
   WqZdoiAq1+gukd4VBc4C1kf6dvTuuAXpLlbhGWHf605y70+ROWPw5IOT+
   qcoqeTWcXyhAdbAhkRMPgUILSLSl5yIIswI4cSK6b1v/3do1ZR+ZmNlsW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240078664"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="240078664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 12:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="556677885"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2022 12:55:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5DK5-000H1r-L6; Wed, 05 Jan 2022 20:55:53 +0000
Date:   Thu, 6 Jan 2022 04:55:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com
Subject: Re: [PATCH v8 08/19] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Message-ID: <202201060430.LHZbFhad-lkp@intel.com>
References: <20220104170416.1923685-9-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220104170416.1923685-9-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.16-rc8]
[cannot apply to zohar-integrity/next-integrity jmorris-security/next-testi=
ng next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespac=
e-IMA-with-audit-support-in-IMA-ns/20220105-010946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
136057256686de39cc3a07c2e39ef6bc43003ff6
config: mips-randconfig-r002-20220105 (https://download.01.org/0day-ci/arch=
ive/20220106/202201060430.LHZbFhad-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e3=
0ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/fa09a3da70380ef32e9a644c0=
8a04cc8f4630baf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-wi=
th-audit-support-in-IMA-ns/20220105-010946
        git checkout fa09a3da70380ef32e9a644c08a04cc8f4630baf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/nvmem/ security/integ=
rity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/integrity/ima/ima_fs.c:380:25: warning: unused variable 'user_n=
s'
   struct user_namespace =3D ima_user_ns_from_file(filp);
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 192, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $2
   or $1, $0, $3
   sc $1, $2
   beqz $1, 1b
   .set pop
   '
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the cra=
sh backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,security/integrity/ima/.ima_fs.o.d =
-nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I.=
/include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iin=
clude/uapi -I./include/generated/uapi -include include/linux/compiler-versi=
on.h -include include/linux/kconfig.h -include include/linux/compiler_types=
=2Eh -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD=
_ADDRESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-ma=
p=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno=
-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-ty=
pe -Wno-format-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-a=
s -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument =
-mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msof=
t-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-st=
ack-check -march=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/=
include/asm/mach-au1x00 -Iarch/mips/include/asm/mach-generic -fno-asynchron=
ous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-a=
ddress-of-packed-member -O2 -Wframe-larger-than=3D1024 -fno-stack-protector=
 -Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-vari=
able -Wno-unused-const-variable -ftrivial-auto-var-init=3Dpattern -fno-stac=
k-clash-protection -pg -falign-functions=3D64 -Wdeclaration-after-statement=
 -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-=
check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wun=
used -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribut=
e -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunus=
ed-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers=
 -Wno-sign-compare -Wno-type-limits -fsanitize=3Darray-bounds -fsanitize=3D=
unreachable -fsanitize=3Dobject-size -fsanitize=3Denum -fsanitize-coverage=
=3Dtrace-pc -I security/integrity/ima -I ./security/integrity/ima -ffunctio=
n-sections -fdata-sections -DKBUILD_MODFILE=3D"security/integrity/ima/ima" =
-DKBUILD_BASENAME=3D"ima_fs" -DKBUILD_MODNAME=3D"ima" -D__KBUILD_MODNAME=3D=
kmod_ima -c -o security/integrity/ima/ima_fs.o security/integrity/ima/ima_f=
s.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'security/integrity/im=
a/ima_fs.c'.
   4. Running pass 'Mips Assembly Printer' on function '@ima_open_policy'
   #0 0x0000557a749c4b3f Signals.cpp:0:0
   #1 0x0000557a749c2a8c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d5b6e30ed3/bin/clang-14+0x3401a8c)
   #2 0x0000557a74906667 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d5b6e30ed3/bin/clang-14+0x3345667)
   #3 0x0000557a749bb13e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d5b6e30ed3/bin/clang-14+0x33fa13e)
   #4 0x0000557a7264133b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x108033=
b)
   #5 0x0000557a7490d10c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x334c10c)
   #6 0x0000557a755ef9b8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x402e9b8)
   #7 0x0000557a755eb759 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d5b6e30ed3/bin/clang-14+0x402a759)
   #8 0x0000557a7309c82e llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x1adb82e)
   #9 0x0000557a73d332fd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000557a7416b867 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa867)
   #11 0x0000557a7416b9e1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2baa9e1)
   #12 0x0000557a7416ccbf llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x2babcbf)
   #13 0x0000557a74cd64fa clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3715=
4fa)
   #14 0x0000557a75903ea3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x4342ea3)
   #15 0x0000557a76407fd9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d5b6e30ed3/bin/clang-14+0x4e46fd9)
   #16 0x0000557a75902cff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d5b6e30ed3/bin/clang-14+0x4341cff)
   #17 0x0000557a75302001 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d5b6e30ed3/bin/clang-14+0x3d41001)
   #18 0x0000557a75299bda clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3cd8bda)
   #19 0x0000557a753cb07b (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3e0a0=
7b)
   #20 0x0000557a72642084 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d5b6e30ed3/bin/clang-14+0x1081084)
   #21 0x0000557a7263f5cb ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000557a75136b15 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000557a74906523 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3345523)
   #24 0x0000557a7513740e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000557a7510dee7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d5b=
6e30ed3/bin/clang-14+0x3b4cee7)
   #26 0x0000557a7510e8c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b4d8c7)
   #27 0x0000557a75118139 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x3b57139)
   #28 0x0000557a7256a19f main (/opt/cross/clang-d5b6e30ed3/bin/clang-14+0x=
fa919f)
   #29 0x00007fc0e7a42d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x0000557a7263f0ea _start (/opt/cross/clang-d5b6e30ed3/bin/clang-14+=
0x107e0ea)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project d5b6e30ed3acad794dd0a=
ec400e617daffc6cc3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d5b6e30ed3/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers include kernel nr_bisected scripts security source=
 usr


vim +/user_ns +380 security/integrity/ima/ima_fs.c

   374=09
   375	/*
   376	 * ima_open_policy: sequentialize access to the policy file
   377	 */
   378	static int ima_open_policy(struct inode *inode, struct file *filp)
   379	{
 > 380		struct user_namespace *user_ns =3D ima_user_ns_from_file(filp);
   381		struct ima_namespace *ns =3D &init_ima_ns;
   382=09
   383		if (!(filp->f_flags & O_WRONLY)) {
   384	#ifndef	CONFIG_IMA_READ_POLICY
   385			return -EACCES;
   386	#else
   387			if ((filp->f_flags & O_ACCMODE) !=3D O_RDONLY)
   388				return -EACCES;
   389			if (!mac_admin_ns_capable(user_ns))
   390				return -EPERM;
   391			return seq_open(filp, &ima_policy_seqops);
   392	#endif
   393		}
   394		if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
   395			return -EBUSY;
   396		return 0;
   397	}
   398=09

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
