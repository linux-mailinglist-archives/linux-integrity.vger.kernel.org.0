Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F614BD288
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiBTW51 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 17:57:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiBTW50 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 17:57:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2E3CA51;
        Sun, 20 Feb 2022 14:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F036060FA9;
        Sun, 20 Feb 2022 22:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93164C340EC;
        Sun, 20 Feb 2022 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645397823;
        bh=j+DoopoQDSYhruoe5UkdGXLSKDJJhsexG0oI9rn2I+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWm739kBOsr4KUdUF3/Ot2fcmIJ7JzfQlVbJq5YpNhZt0OWmUuG82VrBu0PxHHfU7
         9FSLGvv7R74lgmpaRoeNt2qsHIfIhScHn4sRIShE7VdM7RErhuHK7bXYHTY55pvtF9
         speLumPdMbb1tmXtozo/bjU0oo+PLDdup4IaJTNFHVAYP3Z5myeHaueLQjzZXvwxTN
         eq60KOVLpXCnENLRRLPpn4UFbcUhtj7RADE76OF/+U3/0hPu61S6NduEpB9sgC84w4
         ji4ifCiXSKu+Vp64eWmMVLn+VmgZmOCjR/B8RmWYJGo9U0Um/QNlbVxzBO7OGacXXa
         YAMHNbIXUBCnA==
Date:   Sun, 20 Feb 2022 23:57:41 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: init_ima() adds 8 % to boot time
Message-ID: <YhLHZeQdaIKHexVd@iki.fi>
References: <32f90c33-eeb9-64a0-b2e2-9258ba2e1820@molgen.mpg.de>
 <7d84425f36e3b04ab1adabed23f98b478b53b770.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d84425f36e3b04ab1adabed23f98b478b53b770.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 20, 2022 at 10:19:37AM -0500, Mimi Zohar wrote:
> [Cc'ing Jarkko, Petr Vorel]
> 
> Hi Paul,
> 
> On Sat, 2022-02-19 at 10:44 +0100, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > 
> > Debian builds its Linux kernel image with `CONFIG_IMA=y` since version 
> > 5.13.9 [1]. Unfortunately, on the Dell Latitude E7250 `init_ima` takes 
> > around 33 ms, adding 8 % to the boot time up to loading the initrd.
> > 
> >      [    0.000000] Linux version 5.17.0-rc4-amd64 
> > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-16) 11.2.0, GNU 
> > ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.17~rc4-1~exp1 
> > (2022-02-18)
> >      […]
> >      [    0.238520] calling  init_tis+0x0/0xde @ 1
> >      [    0.254749] tpm_tis 00:08: 1.2 TPM (device-id 0x3205, rev-id 80)
> >      [    0.285665] initcall init_tis+0x0/0xde returned 0 after 46038 usecs
> >      […]
> >      [    0.301327] calling  init_ima+0x0/0xb5 @ 1
> >      [    0.301332] ima: Allocated hash algorithm: sha256
> >      [    0.335502] ima: No architecture policies found
> >      [    0.335520] initcall init_ima+0x0/0xb5 returned 0 after 33389 usecs
> >      […]
> >      [    0.447312] Run /init as init process
> > 
> > Tracing `init_ima` with a depth of 5 shows 
> > `ima_calc_boot_aggregate_tfm()` takes 24 ms, and 
> > `ima_add_template_entry()` takes 10 ms.
> > 
> >          1.282630 |   1)   swapper-1    |               | 
> > ima_add_boot_aggregate() {
> >          1.282631 |   1)   swapper-1    |               | 
> > ima_calc_boot_agg:0regate() {
> >          1.282631 |   1)   swapper-1    |   0.153 us    | 
> > ima_alloc_tfm();
> >          1.282631 |   1)   swapper-1    | * 24404.59 us | 
> > ima_calc_boot_aggregate_tfm();
> >          1.307037 |   1)   swapper-1    |   0.482 us    | 
> > ima_free_tfm.part.0();
> >          1.307038 |   1)   swapper-1    | * 24407.06 us |        } /* 
> > ima_calc_boot_aggregate */
> >          1.307038 |   1)   swapper-1    |               | 
> > ima_alloc_init_template() {
> >          1.307038 |   1)   swapper-1    |   0.173 us    | 
> > ima_template_desc_current();
> >          1.307039 |   1)   swapper-1    |   0.836 us    | 
> > __kmalloc();
> >          1.307040 |   1)   swapper-1    |   0.580 us    | 
> > __kmalloc();
> >          1.307041 |   1)   swapper-1    |   1.555 us    | 
> > ima_eventdigest_ng_init();
> >          1.307043 |   1)   swapper-1    |   1.275 us    | 
> > ima_eventname_ng_init();
> >          1.307044 |   1)   swapper-1    |   0.256 us    | 
> > ima_eventsig_init();
> >          1.307045 |   1)   swapper-1    |   6.618 us    |        } /* 
> > ima_alloc_init_template */
> >          1.307045 |   1)   swapper-1    |               | 
> > ima_store_template() {
> >          1.307045 |   1)   swapper-1    |   5.049 us    | 
> > ima_calc_field_array_hash();
> >          1.307051 |   1)   swapper-1    | # 9316.953 us | 
> > ima_add_template_entry();
> >          1.316369 |   1)   swapper-1    | # 9323.728 us |        } /* 
> > ima_store_template */
> >          1.316369 |   1)   swapper-1    | * 33738.54 us |      } /* 
> > ima_add_boot_aggregate */
> > 
> > Tracing `ima_calc_boot_aggregate_tfm()` (attached) shows that the first 
> > `tpm1_pcr_read()` takes 16 ms in `tpm_transmit()`. Is communicating with 
> > the TPM supposed to be that slow?
> > 
> > In the last years, Linux decreased it’s boot time a lot, so do you see a 
> > way to move things out of the hot path and get `init_ima` well below 10 
> > ms? (As systems get faster and faster, having systems with standard 
> > distributions to be up below two seconds after pressing the power button 
> > should be a reasonable goal (500 ms firmware (like coreboot) + 500 ms 
> > Linux kernel + 1 s user space).
> > 
> > 
> > [1]: 
> > https://salsa.debian.org/kernel-team/linux/-/commit/6e679322d7d98d30b4a8a3d1b659c899a6e9d4df
> 
> Thank you including the initial and other TPM delays.  The main reason
> for the "boot_aggregate" is to tie the pre-OS measurements to the post
> OS measurement list.  Without the TPM based 'boot_aggregate', any IMA
> measurement list could be used to verify a TPM quote.  The
> 'boot_aggregate' is calculated, originally, based on PCRs 0 - 7 and
> more recently may include PCRs 8 & 9 as well.  The 'boot_aggregate' is
> the first record in the IMA measurement list and the first record after
> a soft reboot (kexec).  It is the one and only IMA measurement record
> not dependent on policy.
> 
> There are TPM 1.2 & 2.0 standards' requirements, but there are also
> buggy TPMs which don't adhere to them to such an extent that IMA goes
> into 'TPM-bypass' mode. Perhaps for those not interested in extending
> the concepts of trusted boot to the running OS, defining a new boot
> command line option to force IMA into this 'TPM-bypass' mode would be
> an acceptable alternative to the delay.  The IMA measurement list would
> still include a 'boot_aggregate' record, but one containing 0's.

I support the opt-in boot option.

If the full hardware specifications are known for a device, you might want
to use this.

/Jarkko
