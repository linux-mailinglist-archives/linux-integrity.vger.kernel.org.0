Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5794BEB8B
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 21:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiBUUGQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 15:06:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBUUGP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 15:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D51237C6;
        Mon, 21 Feb 2022 12:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78BC2B815A6;
        Mon, 21 Feb 2022 20:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01A4C340E9;
        Mon, 21 Feb 2022 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645473948;
        bh=altu+U1/3ri4Dn3ihYdl52MdZAnh/l+MxbnJTLMjq1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFOSqqRk87MCF/kneZ21dXHmCOTaFwabWjhBn+xJ/sXhWcU5DuwP7kOh82YEG6EsE
         /utrkYpdRlhnnNY0gSJ+3Vu5gzaWtvrVwMxvJNQJI166w7krK+mTmK+dgQRFZK9LD9
         BT5SbxJXakiUDfHwSwijnj6dWeVUQa1QqYyJaIkt+2NXDi2YX+2/LixEbxO1lFG6M8
         u0rquwvxcXwhSsiUEWUcIS/tWdge2LCYmSxxvLY94DNkhgojF56dHsoo13Zdej/tRp
         j3UxZvb7x9SfybVQbQUNpApXi7yWcdU9kwlq8q/+YckkIaP2QCe4xZwS7TIxdUB/6O
         PUmU5atskShfQ==
Date:   Mon, 21 Feb 2022 21:06:23 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: init_ima() adds 8 % to boot time
Message-ID: <YhPwvxBsuR/N7xoF@iki.fi>
References: <32f90c33-eeb9-64a0-b2e2-9258ba2e1820@molgen.mpg.de>
 <7d84425f36e3b04ab1adabed23f98b478b53b770.camel@linux.ibm.com>
 <YhLHZeQdaIKHexVd@iki.fi>
 <07a65960197c4b50f996abdf2b062e836ce1226d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07a65960197c4b50f996abdf2b062e836ce1226d.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 20, 2022 at 06:19:59PM -0500, Mimi Zohar wrote:
> On Sun, 2022-02-20 at 23:57 +0100, Jarkko Sakkinen wrote:
> > On Sun, Feb 20, 2022 at 10:19:37AM -0500, Mimi Zohar wrote:
> > > [Cc'ing Jarkko, Petr Vorel]
> > > 
> > > Hi Paul,
> > > 
> > > On Sat, 2022-02-19 at 10:44 +0100, Paul Menzel wrote:
> > > > Dear Linux folks,
> > > > 
> > > > 
> > > > Debian builds its Linux kernel image with `CONFIG_IMA=y` since version 
> > > > 5.13.9 [1]. Unfortunately, on the Dell Latitude E7250 `init_ima` takes 
> > > > around 33 ms, adding 8 % to the boot time up to loading the initrd.
> > > > 
> > > >      [    0.000000] Linux version 5.17.0-rc4-amd64 
> > > > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-16) 11.2.0, GNU 
> > > > ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.17~rc4-1~exp1 
> > > > (2022-02-18)
> > > >      […]
> > > >      [    0.238520] calling  init_tis+0x0/0xde @ 1
> > > >      [    0.254749] tpm_tis 00:08: 1.2 TPM (device-id 0x3205, rev-id 80)
> > > >      [    0.285665] initcall init_tis+0x0/0xde returned 0 after 46038 usecs
> > > >      […]
> > > >      [    0.301327] calling  init_ima+0x0/0xb5 @ 1
> > > >      [    0.301332] ima: Allocated hash algorithm: sha256
> > > >      [    0.335502] ima: No architecture policies found
> > > >      [    0.335520] initcall init_ima+0x0/0xb5 returned 0 after 33389 usecs
> > > >      […]
> > > >      [    0.447312] Run /init as init process
> > > > 
> > > > Tracing `init_ima` with a depth of 5 shows 
> > > > `ima_calc_boot_aggregate_tfm()` takes 24 ms, and 
> > > > `ima_add_template_entry()` takes 10 ms.
> > > > 
> > > >          1.282630 |   1)   swapper-1    |               | 
> > > > ima_add_boot_aggregate() {
> > > >          1.282631 |   1)   swapper-1    |               | 
> > > > ima_calc_boot_agg:0regate() {
> > > >          1.282631 |   1)   swapper-1    |   0.153 us    | 
> > > > ima_alloc_tfm();
> > > >          1.282631 |   1)   swapper-1    | * 24404.59 us | 
> > > > ima_calc_boot_aggregate_tfm();
> > > >          1.307037 |   1)   swapper-1    |   0.482 us    | 
> > > > ima_free_tfm.part.0();
> > > >          1.307038 |   1)   swapper-1    | * 24407.06 us |        } /* 
> > > > ima_calc_boot_aggregate */
> > > >          1.307038 |   1)   swapper-1    |               | 
> > > > ima_alloc_init_template() {
> > > >          1.307038 |   1)   swapper-1    |   0.173 us    | 
> > > > ima_template_desc_current();
> > > >          1.307039 |   1)   swapper-1    |   0.836 us    | 
> > > > __kmalloc();
> > > >          1.307040 |   1)   swapper-1    |   0.580 us    | 
> > > > __kmalloc();
> > > >          1.307041 |   1)   swapper-1    |   1.555 us    | 
> > > > ima_eventdigest_ng_init();
> > > >          1.307043 |   1)   swapper-1    |   1.275 us    | 
> > > > ima_eventname_ng_init();
> > > >          1.307044 |   1)   swapper-1    |   0.256 us    | 
> > > > ima_eventsig_init();
> > > >          1.307045 |   1)   swapper-1    |   6.618 us    |        } /* 
> > > > ima_alloc_init_template */
> > > >          1.307045 |   1)   swapper-1    |               | 
> > > > ima_store_template() {
> > > >          1.307045 |   1)   swapper-1    |   5.049 us    | 
> > > > ima_calc_field_array_hash();
> > > >          1.307051 |   1)   swapper-1    | # 9316.953 us | 
> > > > ima_add_template_entry();
> > > >          1.316369 |   1)   swapper-1    | # 9323.728 us |        } /* 
> > > > ima_store_template */
> > > >          1.316369 |   1)   swapper-1    | * 33738.54 us |      } /* 
> > > > ima_add_boot_aggregate */
> > > > 
> > > > Tracing `ima_calc_boot_aggregate_tfm()` (attached) shows that the first 
> > > > `tpm1_pcr_read()` takes 16 ms in `tpm_transmit()`. Is communicating with 
> > > > the TPM supposed to be that slow?
> > > > 
> > > > In the last years, Linux decreased it’s boot time a lot, so do you see a 
> > > > way to move things out of the hot path and get `init_ima` well below 10 
> > > > ms? (As systems get faster and faster, having systems with standard 
> > > > distributions to be up below two seconds after pressing the power button 
> > > > should be a reasonable goal (500 ms firmware (like coreboot) + 500 ms 
> > > > Linux kernel + 1 s user space).
> > > > 
> > > > 
> > > > [1]: 
> > > > https://salsa.debian.org/kernel-team/linux/-/commit/6e679322d7d98d30b4a8a3d1b659c899a6e9d4df
> > > 
> > > Thank you including the initial and other TPM delays.  The main reason
> > > for the "boot_aggregate" is to tie the pre-OS measurements to the post
> > > OS measurement list.  Without the TPM based 'boot_aggregate', any IMA
> > > measurement list could be used to verify a TPM quote.  The
> > > 'boot_aggregate' is calculated, originally, based on PCRs 0 - 7 and
> > > more recently may include PCRs 8 & 9 as well.  The 'boot_aggregate' is
> > > the first record in the IMA measurement list and the first record after
> > > a soft reboot (kexec).  It is the one and only IMA measurement record
> > > not dependent on policy.
> > > 
> > > There are TPM 1.2 & 2.0 standards' requirements, but there are also
> > > buggy TPMs which don't adhere to them to such an extent that IMA goes
> > > into 'TPM-bypass' mode. Perhaps for those not interested in extending
> > > the concepts of trusted boot to the running OS, defining a new boot
> > > command line option to force IMA into this 'TPM-bypass' mode would be
> > > an acceptable alternative to the delay.  The IMA measurement list would
> > > still include a 'boot_aggregate' record, but one containing 0's.
> > 
> > I support the opt-in boot option.
> > 
> > If the full hardware specifications are known for a device, you might want
> > to use this.
> 
> The default would be to extend the TPM with the 'boot_aggregate', with
> an option to opt-out of extending the TPM.

Ah, right, thanks for correction. By "opt-in" I meant "opt-out" :-)

BR, Jarkko
