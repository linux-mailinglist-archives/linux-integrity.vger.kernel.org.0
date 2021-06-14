Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594DB3A7091
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhFNUmb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 16:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234068AbhFNUmb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 16:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D65561107;
        Mon, 14 Jun 2021 20:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623703228;
        bh=D5hHz4f0ZXHDsXEgC9BGS0Phl3rPa/SkweiGcHnxwDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1TFZKGhbG4hK2/r0NM6YbmJSzv608FQnhWGZa/bJ5Xr4GqgA2iYRy3RTm7ed22X2
         XsHI+4ma0ozUjwDkiihWVxguOJQp0yGuq6f6dfK4WIWM64W8P3EiAAjZ10/FIsdh5G
         2nEd3v+XhszypLv9GPe36hZfCfjjn86Dg+GHXIIys1YLkDfSUccn78CjfJUXpgeL5O
         z/olImdnIsHMYaL7ru7L+lHNUcO2iseUouuOf15xKP5nZO3MvmreM1LTsJuFaAmVpw
         X6oJBc/a2NPyeQeuGUSwa5hyfoD/BoZ2ZJemvV8Bi4gERCfg7EkIeJ39gGLLJhIfO6
         2/+DcKQzvp8tA==
Date:   Mon, 14 Jun 2021 23:40:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <20210614204025.o46slg6qibdknqza@kernel.org>
References: <YCv0KFIdtmG8F1kT@kernel.org>
 <d5fd8a6b-5eb9-0b50-d66c-e9f4cc84b215@debian.org>
 <YC2YyO7mJ7E73Voy@kernel.org>
 <ed73c137-373d-9767-25e6-309534652354@debian.org>
 <20210603052857.44zppwdfz4aror34@kernel.org>
 <07fb4429-d0cc-c471-1baa-a1a1eb2e8ae6@debian.org>
 <20210609124327.xkaf3bkcvyw2yxkn@kernel.org>
 <bfb9fdc7-668a-ff9c-1f5d-152df2ca106e@debian.org>
 <20210610122909.qaczp6nbish6wzbt@kernel.org>
 <48721227-6518-779e-c6f2-692c4d7b5c92@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48721227-6518-779e-c6f2-692c4d7b5c92@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 04:00:27PM +0200, Laurent Bigonville wrote:
> Le 10/06/21 à 14:29, Jarkko Sakkinen a écrit :
> > On Thu, Jun 10, 2021 at 01:35:47PM +0200, Laurent Bigonville wrote:
> > > # dmesg |grep -i tpm
> > > 
> > > [   13.019986] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
> > > [   15.016198] tpm tpm0: tpm_try_transmit: send(): error -62
> > > [   15.016208] tpm tpm0: A TPM error (-62) occurred attempting to determine
> > > the timeouts
> > > [   15.016239] tpm_tis: probe of 00:06 failed with error -62
> > > [   15.053255] tpm_inf_pnp 00:06: Found TPM with ID IFX0102
> > If possible, can you check what happens when you apply the attached patch.
> > I'm not proposing it as a bug fix but it just simplifies the flow a lot,
> > and might help to observe something.
> > 
> With the patch on the top of HEAD of master and the patch from your branch,
> I'm getting this:
> 
> [   13.140548] tpm tpm0: invalid TPM_STS.x 0xa0, dumping stack for forensics
> [   13.140617] CPU: 4 PID: 462 Comm: systemd-udevd Tainted: G          I
> E     5.13.0-rc5+ #7
> [   13.140621] Hardware name: System manufacturer System Product Name/P6T
> DELUXE V2, BIOS 0406    04/24/2009
> [   13.140623] Call Trace:
> [   13.140628]  dump_stack+0x76/0x94
> [   13.140637]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
> [   13.140643]  tpm_transmit+0x15f/0x3d0 [tpm]
> [   13.140657]  tpm_transmit_cmd+0x25/0x90 [tpm]
> [   13.140666]  tpm2_probe+0xe2/0x140 [tpm]

It's weird because it's the first transaction with the TPM, not likely
to have any sort of mismatch in power gating.

I'm suspecting this:

	if (wait_startup(chip, 0) != 0) {
		rc = -ENODEV;
		goto out_err;
	}

I did not find anything from [*] stating that reading Access Register,
could cause any change in the burstCount (0xa0) but still might be worth
of testing to couple that with

	release_locality(chip, 0);

I.e. add that just after the first snippet.

[*] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

/Jarkko
