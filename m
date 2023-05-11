Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92436FE848
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 02:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjEKACU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 20:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjEKACT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 20:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488735AB;
        Wed, 10 May 2023 17:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59D46411E;
        Thu, 11 May 2023 00:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C571C433D2;
        Thu, 11 May 2023 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683763337;
        bh=bEb5oIaBGr9a2Ckb2wtGlPrhp1CSLuKsoMxsw61yPoA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=jUJ8RkZmGixrVCEYGpR9m/MDQQ6nJla8agPhWiD2C+6wN+fNAUin+IiKKmmZrY4I3
         YY/8xi4FaqxUCtvla88QpFtol69zCHjOxDjA30XMo0eIZZdxmYJFO7Brq8VyQIu7Xu
         i7moWfVBUI6wIWhOfpbjT+FXNb2b3OWzcjPkHwS0zCvWyAgRkB8wNFdccw81asSPQF
         rtHZNH+5ungQFnqUdUW7zOsf72A3oq2L9CGjw5c9R1YVqhL5Cqd+xtcWtwXkWblnYB
         QR+CbSNLW2Vkbgf+mibkVcdeoay7QHaqQoBrY2HuELjDJAGed7rRfUZ/vejRsT6U2J
         ewsozawVx4lXw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 03:02:13 +0300
Message-Id: <CSJ0AD1CFYQP.T6T68M6ZVK49@suppilovahvero>
Cc:     <peterhuewe@gmx.de>, <hdegoede@redhat.com>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: tpm_sis IRQ storm on ThinkStation P360 Tiny
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
 <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
In-Reply-To: <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri May 5, 2023 at 6:05 PM EEST, Jerry Snitselaar wrote:
> On Fri, May 05, 2023 at 03:07:31PM +0200, Peter Zijlstra wrote:
> > Hi,
> >=20
> > I recently saw my Alderlake NUC spewing on boot:
> >=20
> > [   13.166514] irq 109: nobody cared (try booting with the "irqpoll" op=
tion)
> > [   13.166614] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 6.3.0+ #66
> > [   13.166694] Hardware name: LENOVO 30FBS0B800/330E, BIOS M4GKT18A 04/=
26/2022
> > [   13.166779] Call Trace:
> > [   13.166812]  <IRQ>
> > [   13.166840]  dump_stack_lvl+0x5b/0x90
> > [   13.166891]  __report_bad_irq+0x2b/0xc0
> > [   13.166941]  note_interrupt+0x2ac/0x2f0
> > [   13.166991]  handle_irq_event+0x6f/0x80
> > [   13.167041]  handle_fasteoi_irq+0x94/0x1f0
> > [   13.167093]  __common_interrupt+0x72/0x160
> > [   13.167112] intel_rapl_common: Found RAPL domain package
> > [   13.167141]  common_interrupt+0xb8/0xe0
> > [   13.167200] intel_rapl_common: Found RAPL domain core
> > [   13.167242]  </IRQ>
> > [   13.167297] intel_rapl_common: Found RAPL domain uncore
> > [   13.167322]  <TASK>
> > [   13.167437]  asm_common_interrupt+0x26/0x40
> > [   13.167492] RIP: 0010:cpuidle_enter_state+0xff/0x500
> > [   13.167554] Code: c0 48 0f a3 05 72 34 ad 01 0f 82 fc 02 00 00 31 ff=
 e8 35 b3 52 ff 45 84 ff 0f 85 cc 02 00 00 e8 f7 13 64 ff fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 eb 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> > [   13.167766] RSP: 0018:ffffc900001ebe90 EFLAGS: 00000206
> > [   13.167843] RAX: 000000000012a8f3 RBX: ffffe8ffff480a00 RCX: 0000000=
000000000
> > [   13.167928] RDX: 0000000000000000 RSI: ffffffff8244c6ee RDI: fffffff=
f8242ca22
> > [   13.168021] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000=
000000001
> > [   13.168105] R10: 0000000000000003 R11: 000000000000000a R12: fffffff=
f83625a80
> > [   13.168189] R13: 0000000310c8ee5e R14: 0000000000000001 R15: 0000000=
000000000
> > [   13.168289]  cpuidle_enter+0x2d/0x40
> > [   13.168339]  do_idle+0x231/0x290
> > [   13.168383]  cpu_startup_entry+0x1d/0x20
> > [   13.168432]  start_secondary+0x11b/0x140
> > [   13.168482]  secondary_startup_64_no_verify+0xf9/0xfb
> > [   13.168549]  </TASK>
> > [   13.168587] handlers:
> > [   13.168617] [<00000000497ef927>] irq_default_primary_handler threade=
d [<00000000cf102de1>] tis_int_handler
> > [   13.168767] Disabling IRQ #109
> >=20
> > this is apparently:
> >=20
> > root@alderlake:~# cat /proc/interrupts | grep 109
> > 109:          0          0          0          0          0     100002 =
         0          0          0          0          0          0          =
0          0          0          0          0          0          0        =
  0          00          0          0  IR-IO-APIC  109-fasteoi   tpm0
> >=20
> > the TPM thing, which per same dmesg above is:
> >=20
> > [   10.948058] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> >=20
> > Booting with tpm_tis.interrupts=3D0 seems to cure things, and AFAICT th=
e
> > tpm device actually works -- that is, tpm2 getcap -l and tpm2 pcrread
> > both give output, I'm presuming this is 'good'. I've never operated a
> > TPM before.
> >=20
> > The machine in question is:
> >=20
> > 	Manufacturer: LENOVO
> > 	Product Name: 30FBS0B800
> > 	Version: ThinkStation P360 Tiny
> >=20
> > So I'm thinking that perhaps Lenovo carried the bug mentioned in commit=
:
> > b154ce11ead9 ("tpm_tis: Disable interrupts on ThinkPad T490s") to more
> > products.
>
> Hi Peter,
>
> It will poll like it has for years with tpm_tis.interrupts=3D0 so that
> should be working as it was prior to 6.3 when interrupts were re-enabled
> for tpm_tis. Are you seeing this with 6.2 as well? IIRC with that Thinkpa=
d
> case is when it was first realized that interrupts had accidentally been
> disabled for tpm_tis at one point by a change.
>
> I guess myself or someone else needs to revisit catching this in
> general when the irq storm happens, and disabling interrupts for
> tpm_tis. I think last time I was incorporating some feedback from
> tglx, let my adhd get me distracted with some other issue and never
> returned to it.
>
> The diff below should (compile tested) work for the P360, but
> tpm_tis.interrupts=3D0 is a good work-around.
>
> Regards,
> Jerry
>
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7af389806643..12dfdbef574d 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -122,6 +122,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[=
] =3D {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
>  		},
>  	},
> +	{
> +		.callback =3D tpm_tis_disable_irq,
> +		.ident =3D "ThinkStation P360 Tiny",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
> +		},
> +	},
>  	{}
>  };

OK, this is correct :-) I wonder how my fix candidate passed the
compiler. Can you send this as a formal patch, which I can then
ack?

BR, Jarkko
