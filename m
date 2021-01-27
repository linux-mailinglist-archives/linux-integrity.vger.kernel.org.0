Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4A3062EA
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbhA0SBn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 13:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344044AbhA0SBm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 13:01:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 980A564D9F;
        Wed, 27 Jan 2021 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611770462;
        bh=xGl4uZ2Nns8KPP6oUyz4IEvH3y5nHbk3w/N8YVQTpD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eofuoiAugH/V3hPx/Dgj3L2j0hQB/WxKakFubGJnBkS75h2j9PXHCTRY1GydF+gAV
         WwmK3nvmkmoSXJ098AYSqEhmBEJKaHAQjCQbf673G9syRqeTJRlEet30m7nBASm+vY
         fm42z1/55+jBQaf0iYlDwz5FsKD99EVFqZa5lKpDTUVVxrLZu5XS+qFCkouszHMv6/
         AnPXaz3PI3jFUSok5kQLeQx29lvPSIKXob7eRXvZPThqQR4mq+Yjl/uJtXFZh4Lzhy
         tXiFQlp2PkcvDAIGjggKSFp9jkLaazTQhrGcFA3spe51VjLGrYXkSTREx2OkIX0rkq
         LrmfWSlH1eUyw==
Date:   Wed, 27 Jan 2021 20:00:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        James.Bottomley@hansenpartnership.com
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: Bug: TPM returned invalid status
Message-ID: <YBGqWp5FqKQJK1is@kernel.org>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBGpranyEwXaqAUg@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 07:58:08PM +0200, Jarkko Sakkinen wrote:
> On Mon, Jan 25, 2021 at 09:00:54AM +0000, Tj (Elloe Linux) wrote:
> > Seeing this on Lenovo E495's that have:
> > 
> > AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx
> > 
> > Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> > 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12
> > SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> > Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> > root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
> > systemd.unified_cgroup_hierarchy=1 nosplash
> > ...
> > efi: EFI v2.70 by Lenovo
> > 
> > efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
> > SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
> > ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
> > 018
> > ...
> > DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
> > ...
> > tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> > ------------[ cut here ]------------
> > TPM returned invalid status
> > WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249
> 
> There's a patch set in cycle that should fix this:
> 
> https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/
> 
> James, where are we at with this?

I'm interested because I'm yet to send my pr and this is generating
constantly bug reports.

/Jarkko
