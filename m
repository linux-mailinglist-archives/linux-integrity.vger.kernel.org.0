Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540796EEB00
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 01:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjDYXed (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Apr 2023 19:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjDYXec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Apr 2023 19:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6964C17A;
        Tue, 25 Apr 2023 16:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34038631FF;
        Tue, 25 Apr 2023 23:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B055C433EF;
        Tue, 25 Apr 2023 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682465670;
        bh=K1s+noYHRNni1Pq8/RE/Mli4hvd2z61+wK3Y1vv2LyM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=IvyVDNCDCp2/r5VUoQebr/oJMDXprGJWwwUPukWZJTyggmDDXq2zfulSb8y5dg3S+
         ity3qLWMdUtRj2O7fQVWOoUcT6wIbHMuf5Ng9ZXVSeKwxpDcNgPO9nBj9c5fJNsRzQ
         1/wPHzv7d4OYTly4E7Vb1DB7MAIbXJ0WkaJVZ5LYE2Ycl+kztWZAYZ8gF1e3OSzYWT
         45lUd9QwH9I3gSxrpKHJARTqNcEVu68C50jshkFFkizf0AE5nmIcDTQ0XTurTuV+ou
         Cf4JFjB++Jc/5fT8ylTV0sTaSUooMn3ENKxf/NVHnCBghFauxj735kaHOEmrMx+t/3
         tnwGYgaMPdoTw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 26 Apr 2023 02:34:25 +0300
Message-Id: <CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero>
Cc:     "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, "Jan Dabros" <jsd@semihalf.com>,
        <regressions@lists.linux.dev>,
        "LKML" <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Johannes Altmanninger" <aclopte@gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: aerc 0.14.0
References: <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
 <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
 <ZBBxMl5rVjY9FGS9@kernel.org> <ZBBxxftnXHVOjm92@kernel.org>
 <ZBB8R9H3CyQnNfCt@zx2c4.com> <ZBCDeleGG/fFlkt+@kernel.org>
 <ZEKlzaQhjd8sbE7I@kernel.org>
 <CAHmME9q9DZyYo7G__ks=XSrS4kS8sUUZ+eF3c1VSnGCAvfBR+Q@mail.gmail.com>
 <CS48U6SYIBVB.V05DUEX5I01F@suppilovahvero>
In-Reply-To: <CS48U6SYIBVB.V05DUEX5I01F@suppilovahvero>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Apr 23, 2023 at 6:34 PM EEST, Jarkko Sakkinen wrote:
> On Fri Apr 21, 2023 at 9:27 PM EEST, Jason A. Donenfeld wrote:
> > Did you use the patch I sent you and suspend and resume according to
> > the instructions I gave you? If not, I don't have much to add.
>
> Finally, I got it reproduced at my side with TPM 1.2:
>
> [    0.379677] tpm_tis 00:00: 1.2 TPM (device-id 0x1, rev-id 1)
> [   32.453447] tpm tpm0: tpm_transmit: tpm_recv: error -5
> [   33.450601] tpm tpm0: Unable to read header
> [   33.450607] tpm tpm0: tpm_transmit: tpm_recv: error -62
>
> I'll look at this further after I've sent v6.3 PR.

OK, so this gives the exact tpm_transmit call where it fails:

$ sudo bpftrace -e 'kprobe:tpm_transmit { @[kstack] =3D count(); }'
[sudo] password for jarkko:
Attaching 1 probe...
^C

@[
    tpm_transmit+1
    tpm1_pcr_read+177
    tpm1_do_selftest+287
    tpm_tis_resume+443
    pnp_bus_resume+102
    dpm_run_callback+81
    device_resume+173
    dpm_resume+238
    dpm_resume_end+17
    suspend_devices_and_enter+473
    enter_state+563
    pm_suspend+68
    state_store+43
    kobj_attr_store+15
    sysfs_kf_write+59
    kernfs_fop_write_iter+304
    vfs_write+590
    ksys_write+115
    __x64_sys_write+25
    do_syscall_64+88
    entry_SYSCALL_64_after_hwframe+114
]: 1
@[
    tpm_transmit+1
    tpm1_do_selftest+179
    tpm_tis_resume+443
    pnp_bus_resume+102
    dpm_run_callback+81
    device_resume+173
    dpm_resume+238
    dpm_resume_end+17
    suspend_devices_and_enter+473
    enter_state+563
    pm_suspend+68
    state_store+43
    kobj_attr_store+15
    sysfs_kf_write+59
    kernfs_fop_write_iter+304
    vfs_write+590
    ksys_write+115
    __x64_sys_write+25
    do_syscall_64+88
    entry_SYSCALL_64_after_hwframe+114
]: 1
@[
    tpm_transmit+1
    tpm1_pm_suspend+203
    tpm_pm_suspend+131
    __pnp_bus_suspend+65
    pnp_bus_suspend+19
    dpm_run_callback+81
    __device_suspend+329
    dpm_suspend+432
    dpm_suspend_start+155
    suspend_devices_and_enter+370
    enter_state+563
    pm_suspend+68
    state_store+43
    kobj_attr_store+15
    sysfs_kf_write+59
    kernfs_fop_write_iter+304
    vfs_write+590
    ksys_write+115
    __x64_sys_write+25
    do_syscall_64+88
    entry_SYSCALL_64_after_hwframe+114
]: 1
@[
    tpm_transmit+1
    tpm1_get_random+206
    tpm_get_random+70
    tpm_hwrng_read+21
    hwrng_fillfn+234
    kthread+230
    ret_from_fork+41
]: 75897

So it is the very first PCR read in tpm1_do_selftest.

There is a bug at plain sight in tpm1_tis_resume(): before
tpm_tis_resume() calls tpm1_do_selftest(), it only requests
and relinquishes locality. This is not sufficient: it should
also disable clkrun protocol.

tpm1_do_selftest() is called also during the driver initialization
successfully, the difference being that clkrun protocol is disabled.

I'm compiling now a kernel with a test fix that calls tpm_chip_start()
and tpm_chip_stop() as a substitute for request/relinquish locality.
These should be used anyway instead of ad-hoc code.

BR, Jarkko

BR, Jarkko
