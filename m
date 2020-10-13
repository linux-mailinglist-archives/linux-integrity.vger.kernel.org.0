Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D528C6B9
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 03:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgJMBX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 21:23:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:25864 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgJMBX7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 21:23:59 -0400
IronPort-SDR: /TmUT338tuSYJpd2MGA53B+OmtaUhou7TtRvgWIWoljUyW+inKq9dfoHNtY5/cea+bipgOeeOh
 Q8G+sdIX7e6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152759296"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="152759296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:23:58 -0700
IronPort-SDR: z/dut+4k0eUlkd8zkUvoYtdZgvKj3plinJF2C9QhA1bTV6fCpupoSu63fP27hzBCxBEH0YwpXJ
 Z3v6zOuU8fIA==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="299452893"
Received: from lusin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.81])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:23:56 -0700
Date:   Tue, 13 Oct 2020 04:23:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201013012354.GB41176@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <87r1q4xatg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1q4xatg.fsf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 11, 2020 at 10:39:07PM -0700, Jerry Snitselaar wrote:
> 
> James Bottomley @ 2020-10-01 11:09 MST:
> 
> > The current state of the TIS TPM is that interrupts have been globally
> > disabled by various changes.  The problems we got reported the last
> > time they were enabled was interrupt storms.  With my own TIS TPM,
> > I've found that this is caused because my TPM doesn't do legacy
> > cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> > requires any TIS TPM without legacy cycles not to act on any write to
> > an interrupt register unless the locality is enabled.  This means if
> > an interrupt fires after we relinquish the locality, the TPM_EOI in
> > the interrupt routine is ineffective meaning the same interrupt
> > triggers over and over again.  This problem also means we can have
> > trouble setting up interrupts on TIS TPMs because the current init
> > code does the setup before the locality is claimed for the first time.
> >
> > James
> >
> 
> 
> I tested initially with the following commits reverted:
> 
> aa4a63dd9816 tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's" | 2020-01-06 | (Stefan Berger)
> dda8b2af395b tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts" | 2020-01-06 | (Stefan Berger)
> 
> The laptop doesn't become unusable, but I lose the trackpad and get the following:
> 
> [    3.070501] irq 31: nobody cared (try booting with the "irqpoll" option)
> [    3.070504] CPU: 2 PID: 251 Comm: rngd Not tainted 5.8.13-201.local.fc32.x86_64 #1
> [    3.070504] Hardware name: LENOVO 20NYS7K90F/20NYS7K90F, BIOS N2JET83W (1.61 ) 11/22/2019
> [    3.070505] Call Trace:
> [    3.070511]  dump_stack+0x6b/0x88
> [    3.070514]  __report_bad_irq+0x35/0xa7
> [    3.070516]  note_interrupt.cold+0xb/0x6a
> [    3.070518]  handle_irq_event+0x88/0x8a
> [    3.070519]  handle_fasteoi_irq+0x78/0x1c0
> [    3.070522]  common_interrupt+0x68/0x140
> [    3.070524]  ? asm_common_interrupt+0x8/0x40
> [    3.070525]  asm_common_interrupt+0x1e/0x40
> [    3.070527] RIP: 0033:0x7f2eea3249b5
> [    3.070529] Code: e0 48 c1 e8 3c 83 e0 01 48 31 45 f0 48 8b 45 e0 48 c1 e8 37 83 e0 01 48 31 45 f0 48 8b 45 e0 48 c1 e8 1e 83 e0 01 48 31 45 f0 <48> 8b 45 e0 48 c1 e8 1b 83 e0 01 48 31 45 f0 48 8b 45 e0 48 c1 e8
> [    3.070529] RSP: 002b:00007f2ee3ffebc0 EFLAGS: 00000202
> [    3.070530] RAX: 0000000000000001 RBX: 000000000000000a RCX: 000000000000002e
> [    3.070531] RDX: 0463400000000000 RSI: 0000000000000000 RDI: 0000000000000001
> [    3.070532] RBP: 00007f2ee3ffec10 R08: 0000000000000000 R09: 0000000000000035
> [    3.070532] R10: 00007ffde716f080 R11: 00007ffde716f080 R12: 00007f2edc004c00
> [    3.070533] R13: 00007ffde700a54f R14: 00007f2ee3ffed10 R15: 00005598a41e3680
> [    3.070534] handlers:
> [    3.070537] [<000000007b6f3232>] tis_int_handler
> [    3.070538] Disabling IRQ #31
> ...
> [   14.956342] irq 16: nobody cared (try booting with the "irqpoll" option)
> [   14.956344] CPU: 0 PID: 1013 Comm: rngd Not tainted 5.8.13-201.local.fc32.x86_64 #1
> [   14.956344] Hardware name: LENOVO 20NYS7K90F/20NYS7K90F, BIOS N2JET83W (1.61 ) 11/22/2019
> [   14.956345] Call Trace:
> [   14.956350]  dump_stack+0x6b/0x88
> [   14.956353]  __report_bad_irq+0x35/0xa7
> [   14.956354]  note_interrupt.cold+0xb/0x6a
> [   14.956355]  handle_irq_event+0x88/0x8a
> [   14.956356]  handle_fasteoi_irq+0x78/0x1c0
> [   14.956358]  common_interrupt+0x68/0x140
> [   14.956360]  ? asm_common_interrupt+0x8/0x40
> [   14.956361]  asm_common_interrupt+0x1e/0x40
> [   14.956362] RIP: 0033:0x7fcaff4399d3
> [   14.956363] Code: e0 48 c1 e8 1e 83 e0 01 48 31 45 f0 48 8b 45 e0 48 c1 e8 1b 83 e0 01 48 31 45 f0 48 8b 45 e0 48 c1 e8 16 83 e0 01 48 31 45 f0 <48> d1 65 e0 48 8b 45 f0 48 31 45 e0 83 45 d4 01 83 7d d4 40 0f 86
> [   14.956364] RSP: 002b:00007fcafe544bc0 EFLAGS: 00000246
> [   14.956364] RAX: 0000000000000000 RBX: 000000000000000a RCX: 0000000000000026
> [   14.956365] RDX: 000df20000000000 RSI: 0000000000000000 RDI: 0000000000000001
> [   14.956365] RBP: 00007fcafe544c10 R08: 0000000000000000 R09: 0000000000000035
> [   14.956366] R10: 00007ffc30bd2080 R11: 00007ffc30bd2080 R12: 00007fcaf0004c00
> [   14.956366] R13: 00007fcaf0004c00 R14: 00007fcaf0000b60 R15: 0000560216fcf0f2
> [   14.956367] handlers:
> [   14.956370] [<0000000024c0571e>] i801_isr [i2c_i801]
> [   14.956371] Disabling IRQ #16
> 
> /proc/interrupts shows:
> 
>   16:     100000          0          0          0          0          0          0          0  IR-IO-APIC   16-fasteoi   i801_smbus
>   31:          0          0     100000          0          0          0          0          0  IR-IO-APIC   31-fasteoi   tpm0
> 
> 
> I also get this behavior with your patchset applied. If I boot with
> tpm_tis.interrupts=0 it behaves.  The thought from Hans is to look at
> the dmi info and key off the vendor being Lenovo and bios date to
> decide if interrupts should be disabled. Since Dan ran also into this
> with something internal at Intel I don't know if that will be
> sufficient.
> 
> I hope to look over this patchset tomorrow.
> 
> Regards,
> Jerry

I'm sorry, I received this email only after pulling the latest with fdm.

/Jarkko
