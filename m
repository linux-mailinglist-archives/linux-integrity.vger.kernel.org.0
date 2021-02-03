Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8F30E517
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBCVo0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 16:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231868AbhBCVoZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 16:44:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B760B64DFD;
        Wed,  3 Feb 2021 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612388624;
        bh=xUU5Ge7K+jvMBkWDfVVhdnYBNkY1CmMdddep6ioLAOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CChekWKdep596mhefX937YeQwUYhcg1XzLT3KGDin2V1EQCOxpmAy7OxEb2NIGjAs
         my0ASI+SrtmuOMFxt+kKQjWU/7BFYYgGvmGkz8Fl2UlX6KcTTyAsvLJxx0qeUuPp/x
         BIrGsfkgv9P8o+XMxr5SXd68zdkwiv/HZNh4cNzMSmoWh+Is7wokDkhlIzdnTRNkZt
         EmQVIWD8JwyWoaZe7zn+J1y863YpHjBt21BtitJjWNOtyYKvqk0HJcAugPTQPMYdAb
         JCtprLN1FrDnb4nK5w4LWj1NanSY096z+rtH6lVKILbTqpmQMVPKZa9PXLSeSIybc6
         gcrk6hlXke0Mw==
Date:   Wed, 3 Feb 2021 23:43:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 1/3] tpm: fix reference counting for struct tpm_chip
Message-ID: <YBsZCP29W2Lb9gw1@kernel.org>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-2-git-send-email-LinoSanfilippo@gmx.de>
 <YBn3rdErdKNAUdgZ@kernel.org>
 <01cb09f4-2ed7-2101-24c2-17390b0d3b39@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cb09f4-2ed7-2101-24c2-17390b0d3b39@kunbus.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 03, 2021 at 03:06:30PM +0100, Lino Sanfilippo wrote:
> Hi,
> 
> 
> On 03.02.21 02:09, Jarkko Sakkinen wrote:
> > On Tue, Feb 02, 2021 at 11:09:01PM +0100, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> The following sequence of operations
> >>
> >> 1. open device /dev/tpmrm
> >> 2. remove the registered tpm chip driver
> > 
> > What is "tpm chip driver"? Please just refer to the exact thing
> > (e.g. tpm_tis_spi is the one you should refer to in your case).
> > 
> 
> I did not explicitly refer to tpm_tis_spi because the refcount issue is in the TPM
> chip driver core code and thus any TPM chip driver that creates the tpmrm device is
> concerned. 
> 
> But if it helps to make the problem clearer I will only mention the tpm_tis_spi 
> case in the next patch version.

If you encounter a bug, you should generally just refer the exact thing
where you encounter it. This will help a lot, e.g. to reproduce it.

> >> ------------[ cut here ]------------
> >> WARNING: CPU: 3 PID: 1161 at lib/refcount.c:25 kobject_get+0xa0/0xa4
> >> refcount_t: addition on 0; use-after-free.
> >> Modules linked in: tpm_tis_spi tpm_tis_core tpm mdio_bcm_unimac brcmfmac
> >> sha256_generic libsha256 sha256_arm hci_uart btbcm bluetooth cfg80211 vc4
> >> brcmutil ecdh_generic ecc snd_soc_core crc32_arm_ce libaes
> >> raspberrypi_hwmon ac97_bus snd_pcm_dmaengine bcm2711_thermal snd_pcm
> >> snd_timer genet snd phy_generic soundcore [last unloaded: spi_bcm2835]
> >> CPU: 3 PID: 1161 Comm: hold_open Not tainted 5.10.0ls-main-dirty #2
> >> Hardware name: BCM2711
> >> [<c0410c3c>] (unwind_backtrace) from [<c040b580>] (show_stack+0x10/0x14)
> >> [<c040b580>] (show_stack) from [<c1092174>] (dump_stack+0xc4/0xd8)
> >> [<c1092174>] (dump_stack) from [<c0445a30>] (__warn+0x104/0x108)
> >> [<c0445a30>] (__warn) from [<c0445aa8>] (warn_slowpath_fmt+0x74/0xb8)
> >> [<c0445aa8>] (warn_slowpath_fmt) from [<c08435d0>] (kobject_get+0xa0/0xa4)
> >> [<c08435d0>] (kobject_get) from [<bf0a715c>] (tpm_try_get_ops+0x14/0x54 [tpm])
> >> [<bf0a715c>] (tpm_try_get_ops [tpm]) from [<bf0a7d6c>] (tpm_common_write+0x38/0x60 [tpm])
> >> [<bf0a7d6c>] (tpm_common_write [tpm]) from [<c05a7ac0>] (vfs_write+0xc4/0x3c0)
> >> [<c05a7ac0>] (vfs_write) from [<c05a7ee4>] (ksys_write+0x58/0xcc)
> >> [<c05a7ee4>] (ksys_write) from [<c04001a0>] (ret_fast_syscall+0x0/0x4c)
> >> Exception stack(0xc226bfa8 to 0xc226bff0)
> >> bfa0:                   00000000 000105b4 00000003 beafe664 00000014 00000000
> >> bfc0: 00000000 000105b4 000103f8 00000004 00000000 00000000 b6f9c000 beafe684
> >> bfe0: 0000006c beafe648 0001056c b6eb6944
> >> ---[ end trace d4b8409def9b8b1f ]---
> > 
> > I guess this is happening with tpm_tis_spi. Unfortunately I don't have
> > anything available that would use it.
> > 
> > I did testing with tpm_tis but so far no success reproducing.
> 
> With tpm_tis_spi this can be reproduced constantly. I haven't tried it with tpm_tis but 
> I would expect it here to happen, too. However to trigger this bug you need something 
> (in my case its an iotedge daemon) that opens /dev/tpmrm and keeps it open and writes 
> occasionally commands to the TPM device even after you have unloaded the tpm_tis_spi module.
> 
> In your case you could try:
> 
> 1. open /dev/tpmrm with a small test program and sleep for a few seconds
> 2. do 'rmmod tpm_tis' from another console while the test program sleeps
> 3. write to the opened /dev/tpmrm in your test program after the sleep. 
> The data to write should be chosen in a way that it passes the sanity checks in 
> tpm_common_write (alternatively just comment these checks out and write 
> some random data). As soon as tpm_try_get_ops() in tpm_common_write() is called
> the bug should trigger.

Right, I used tools/testing/selftests/tpm2/test_space.sh.

I think I agree you with the regression.

> > Hope this feedback helps to improve. You really need to rewrite the whole
> > commit message. I wonder who could try to reproduce this. With a quick
> > skim I get the issue.
> 
> Thanks for the thorough review. I will try to address all of the points you
> mentioned in the next patch version. 

Thank you for your effort. It's of course highly appreciated!

> > Also you don't have James Bottomley in the CC list of the patch who is
> > the author of the original commit. Please sort that out too...
> 
> Ok, will do so.
> 
> > /Jarkko
> > 
> 
> Regards,
> Lino

/Jarkko
> 
