Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DECA30630C
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhA0SMj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 13:12:39 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:48862 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhA0SMi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 13:12:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 671581280055;
        Wed, 27 Jan 2021 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611771117;
        bh=m39Z1MmkMmfI3b9S1SC2PpdKOtRG1E2U2UEz2L3tCvs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=T6NafzU/NYHSxnaMkywwudf5sMLSoXNfhX5JmuTpRM1s8kCcxCqU5P+Gp2/yKeEYc
         Im1Ia+I+Pmg9FfMoppqeKEQ4KtogvtZsZfFd4+f1UFY4/sJISOxmio8htyPqHhpEHu
         mD0Px3Cb9/mV5YLv5XLV34kLXwBaUchPC+rQHU9E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xSgLLz4JuzlZ; Wed, 27 Jan 2021 10:11:57 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 15F381280054;
        Wed, 27 Jan 2021 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611771117;
        bh=m39Z1MmkMmfI3b9S1SC2PpdKOtRG1E2U2UEz2L3tCvs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=T6NafzU/NYHSxnaMkywwudf5sMLSoXNfhX5JmuTpRM1s8kCcxCqU5P+Gp2/yKeEYc
         Im1Ia+I+Pmg9FfMoppqeKEQ4KtogvtZsZfFd4+f1UFY4/sJISOxmio8htyPqHhpEHu
         mD0Px3Cb9/mV5YLv5XLV34kLXwBaUchPC+rQHU9E=
Message-ID: <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
Subject: Re: Bug: TPM returned invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Date:   Wed, 27 Jan 2021 10:11:56 -0800
In-Reply-To: <YBGqWp5FqKQJK1is@kernel.org>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
         <YBGpranyEwXaqAUg@kernel.org> <YBGqWp5FqKQJK1is@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-01-27 at 20:00 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 27, 2021 at 07:58:08PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Jan 25, 2021 at 09:00:54AM +0000, Tj (Elloe Linux) wrote:
> > > Seeing this on Lenovo E495's that have:
> > > 
> > > AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx
> > > 
> > > Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> > > 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu)
> > > 2.34) #12 SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> > > Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> > > root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows
> > > 2016" systemd.unified_cgroup_hierarchy=1 nosplash
> > > ...
> > > efi: EFI v2.70 by Lenovo
> > > 
> > > efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
> > > SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
> > > ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
> > > 018
> > > ...
> > > DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 )
> > > 12/23/2019
> > > ...
> > > tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> > > ------------[ cut here ]------------
> > > TPM returned invalid status
> > > WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249
> > 
> > There's a patch set in cycle that should fix this:
> > 
> > https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/
> > 
> > James, where are we at with this?
> 
> I'm interested because I'm yet to send my pr and this is generating
> constantly bug reports.

It's part of the enable interrupts series, which there's a lot of
discussion over.  However, that single patch can be broken out of the
series if you like.  The specific blocker was the screaming interrupt
on the Lenovo that Jerry was looking at.  He propose a quirk to fix its
so perhaps we're now ready to move the entire series forward?

James


