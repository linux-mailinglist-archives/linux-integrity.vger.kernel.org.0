Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216E306D2E
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 07:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhA1GA3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 01:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhA1GAT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 01:00:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA4C664DD8;
        Thu, 28 Jan 2021 05:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611813578;
        bh=7ew+zuxpljCmbQtnP0GG0eR+4ZBDfS8L+N7GFr9HejI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muIPRi7P/gxwHftXKemPxajXOSICRoS5VgSttQoGWP9opq4l1wA2Ipxa7CpeAmOFJ
         p0QZXuMjELKyYAGW2jLc/OVBCV4bLBSiF/DdduDo12UjpnIt77iLxRndL20pzO0PDC
         IcOvdvD8oaUI5Gm/BT8y6ll2uczkz2wsVVp71Ni7dKXX3nlAxpGbYpvgc60mQ29h1B
         DyVqTrunFOF41h8GbiSCEEFIsQut8DKOzc9vfSlWBdqaPNmMzWD+8F1LzU2Oe583ar
         IhLdPoIJWjSFeWgwyWIe8Q2w+MU9gNrQTSiw0ltC7aQqMyZYIPK3jP46P37nVYD+T7
         +TlbYeKcToZow==
Date:   Thu, 28 Jan 2021 07:59:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: Bug: TPM returned invalid status
Message-ID: <YBJSxocry4hn5QV+@kernel.org>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org>
 <YBGqWp5FqKQJK1is@kernel.org>
 <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 10:11:56AM -0800, James Bottomley wrote:
> On Wed, 2021-01-27 at 20:00 +0200, Jarkko Sakkinen wrote:
> > On Wed, Jan 27, 2021 at 07:58:08PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Jan 25, 2021 at 09:00:54AM +0000, Tj (Elloe Linux) wrote:
> > > > Seeing this on Lenovo E495's that have:
> > > > 
> > > > AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx
> > > > 
> > > > Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> > > > 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu)
> > > > 2.34) #12 SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> > > > Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> > > > root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows
> > > > 2016" systemd.unified_cgroup_hierarchy=1 nosplash
> > > > ...
> > > > efi: EFI v2.70 by Lenovo
> > > > 
> > > > efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
> > > > SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
> > > > ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
> > > > 018
> > > > ...
> > > > DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 )
> > > > 12/23/2019
> > > > ...
> > > > tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> > > > ------------[ cut here ]------------
> > > > TPM returned invalid status
> > > > WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249
> > > 
> > > There's a patch set in cycle that should fix this:
> > > 
> > > https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/
> > > 
> > > James, where are we at with this?
> > 
> > I'm interested because I'm yet to send my pr and this is generating
> > constantly bug reports.
> 
> It's part of the enable interrupts series, which there's a lot of
> discussion over.  However, that single patch can be broken out of the
> series if you like.  The specific blocker was the screaming interrupt
> on the Lenovo that Jerry was looking at.  He propose a quirk to fix its
> so perhaps we're now ready to move the entire series forward?

Why only 1/5 and not 1/5 and 2/5?

/Jarkko
