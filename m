Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E56FE6D2
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEJWAW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJWAV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250A1FFE;
        Wed, 10 May 2023 15:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B3E613B3;
        Wed, 10 May 2023 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F02CC4339B;
        Wed, 10 May 2023 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683756017;
        bh=1MHQpmGZcXSSS+kzDgHs6bDhpvIk3cK9wU4y4fA2vZs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qWYQ47Io/qPOgqN0ky0IoAjCzxsZcxPsr2qwlvGki94ljhao3wyplrff79ifW9EOO
         M4+KLnnKzFOmUQhseAMwH1gM26TyPd+h3Ougvw+q9SCEJQDYk/7sLsez3xqDF6emn2
         yBmEot/WhP3qPjYINHvqX4u61WBYUm1oTIx2Ybpqrb8g/1CoQsySGlip8WF6Pii4MT
         Z9gttlwrnMWqSIXsKOMkFNskF4AJAQqz+PV7btH39P109jfFDIb4M8TE+tNBkLMRYF
         tQuc1yZ04wXMDuDmPjUDiuBpVb8OQTNAzmR46pHMyX2NMG+LHf3fg+5oacwnVv0FXS
         OwFlMuVVD8ieg==
Message-ID: <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org
Date:   Thu, 11 May 2023 01:00:13 +0300
In-Reply-To: <202305041325.ae8b0c43-yujie.liu@intel.com>
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lino,

Have you had time to peek into this? I just noticed the email, just
asking if some findings have been already made or not.

BR, Jarkko

On Thu, 2023-05-04 at 14:12 +0800, kernel test robot wrote:
> Hello,
>=20
> kernel test robot noticed "RIP:acpi_safe_halt" on:
>=20
> commit: e644b2f498d297a928efcb7ff6f900c27f8b788e ("tpm, tpm_tis: Enable i=
nterrupt test")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linux-next/master 84e2893b4573da3bc0c9f24e2005442e420e383=
1]
>=20
> in testcase: stress-ng
> version: stress-ng-x86_64-0.15.04-1_20230427
> with following parameters:
>=20
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	class: interrupt
> 	test: signest
> 	cpufreq_governor: performance
>=20
> compiler: gcc-11
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Link: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@in=
tel.com
>=20
>=20
> kern  :warn  : [   26.609994] CPU: 21 PID: 0 Comm: swapper/21 Not tainted=
 6.3.0-00022-ge644b2f498d2 #1
> kern  :warn  : [   26.609994] Hardware name: Inspur NF5180M6/NF5180M6, BI=
OS 06.00.04 04/12/2022
> kern  :warn  : [   26.609994] Call Trace:
> kern  :warn  : [   26.609994]  <IRQ>
> kern :warn : [   26.609994] dump_stack_lvl (lib/dump_stack.c:107 (discrim=
inator 1))
> kern :warn : [   26.609994] __report_bad_irq (kernel/irq/spurious.c:214)
> kern :warn : [   26.609994] note_interrupt (kernel/irq/spurious.c:423)
> kern :warn : [   26.609994] handle_irq_event (kernel/irq/handle.c:198 ker=
nel/irq/handle.c:210)
> kern :warn : [   26.609994] handle_fasteoi_irq (kernel/irq/chip.c:661 ker=
nel/irq/chip.c:716)
> kern :warn : [   26.609994] __common_interrupt (include/linux/irqdesc.h:1=
58 arch/x86/kernel/irq.c:231 arch/x86/kernel/irq.c:250)
> kern :warn : [   26.609994] common_interrupt (arch/x86/kernel/irq.c:240 (=
discriminator 14))
> kern  :warn  : [   26.609994]  </IRQ>
> kern  :warn  : [   26.713811]  <TASK>
> kern :warn : [   26.713811] asm_common_interrupt (arch/x86/include/asm/id=
tentry.h:636)
> kern :warn : [   26.713811] RIP: 0010:acpi_safe_halt (arch/x86/include/as=
m/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_i=
dle.c:113)
> kern :warn : [ 26.713811] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 90 65 48 8b 04 25 80 ce 02 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d f1 dc 38=
 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 =
90
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   90                      nop
>    9:   90                      nop
>    a:   90                      nop
>    b:   90                      nop
>    c:   90                      nop
>    d:   90                      nop
>    e:   90                      nop
>    f:   65 48 8b 04 25 80 ce    mov    %gs:0x2ce80,%rax
>   16:   02 00
>   18:   48 8b 00                mov    (%rax),%rax
>   1b:   a8 08                   test   $0x8,%al
>   1d:   75 0c                   jne    0x2b
>   1f:   66 90                   xchg   %ax,%ax
>   21:   0f 00 2d f1 dc 38 00    verw   0x38dcf1(%rip)        # 0x38dd19
>   28:   fb                      sti
>   29:   f4                      hlt
>   2a:*  fa                      cli             <-- trapping instruction
>   2b:   c3                      ret
>   2c:   cc                      int3
>   2d:   cc                      int3
>   2e:   cc                      int3
>   2f:   cc                      int3
>   30:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>   37:   00 00 00 00
>   3b:   0f 1f 40 00             nopl   0x0(%rax)
>   3f:   90                      nop
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   fa                      cli
>    1:   c3                      ret
>    2:   cc                      int3
>    3:   cc                      int3
>    4:   cc                      int3
>    5:   cc                      int3
>    6:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>    d:   00 00 00 00
>   11:   0f 1f 40 00             nopl   0x0(%rax)
>   15:   90                      nop
> kern  :warn  : [   26.713811] RSP: 0000:ffa00000003cfe68 EFLAGS: 00000246
> kern  :warn  : [   26.713811] RAX: 0000000000004000 RBX: ff11002088776400=
 RCX: 00000000000000a0
> kern  :warn  : [   26.713811] RDX: ff11003fc2d40000 RSI: ff110020896fbc00=
 RDI: ff110020896fbc64
> kern  :warn  : [   26.713811] RBP: 0000000000000001 R08: ffffffff82cc6620=
 R09: 0000000000000008
> kern  :warn  : [   26.713811] R10: 0000000000000006 R11: 0000000000000006=
 R12: 0000000000000001
> kern  :warn  : [   26.713811] R13: ffffffff82cc66a0 R14: 0000000000000001=
 R15: 0000000000000000
> kern  :warn  : [   26.713811] ? ct_kernel_exit+0x6b/0xb0
> kern :warn : [   26.713811] acpi_idle_enter (drivers/acpi/processor_idle.=
c:713 (discriminator 3))
> kern :warn : [   26.713811] cpuidle_enter_state (drivers/cpuidle/cpuidle.=
c:267)
> kern :warn : [   26.713811] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> kern :warn : [   26.713811] cpuidle_idle_call (kernel/sched/idle.c:219)
> kern :warn : [   26.713811] do_idle (kernel/sched/idle.c:284)
> kern :warn : [   26.713811] cpu_startup_entry (kernel/sched/idle.c:378 (d=
iscriminator 1))
> kern :warn : [   26.713811] start_secondary (arch/x86/kernel/smpboot.c:19=
8 arch/x86/kernel/smpboot.c:232)
> kern :warn : [   26.713811] secondary_startup_64_no_verify (arch/x86/kern=
el/head_64.S:358)
> kern  :warn  : [   26.713811]  </TASK>
> kern  :err   : [   26.713811] handlers:
> kern :err : [   26.713811] irq_default_primary_handler (kernel/irq/manage=
.c:1027)
> kern :warn : [   26.713811] threaded tis_int_handler (drivers/char/tpm/tp=
m_tis_core.c:756)
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
>=20

