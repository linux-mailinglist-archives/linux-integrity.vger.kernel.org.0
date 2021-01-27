Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594C03062D8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 18:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbhA0R7A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 12:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344337AbhA0R6u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 12:58:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C32CD64DA8;
        Wed, 27 Jan 2021 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611770289;
        bh=+O3jKv8M1tmgM/F7PEyZuJWMLRlansLUD6rwtkOxk+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDrRWWM2FyhqJJ+5rL0A19E33uaWloPjv7Vz5pLdFG1MqYjBzvTtn1pzS4VMjIDkb
         mS+tUnm/J6B3YVxSt3anIfoTsOA43m0IklYGOrp/05OfnphGHdNXbAtoGmJoLY6gSe
         gYT7eOOBlYnQeNAjiu0yP1MYzBmtLBfGN3As6QEGt+0Nvy9h9UNyu0/G7RJd71tQky
         4rQLFIks7JZmIBY5ky0cLzhy31lDoArfumDBVxII6nkAx0J7OELp8J9DBta2NbEEcq
         CRw8BAVADhVGtXbmlk7G2rCNN3HhRxpk+wIDUZE6hOqb90sNiwmcQ21kE+/R+46gJu
         Ny5h3uDGEVavQ==
Date:   Wed, 27 Jan 2021 19:58:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        James.Bottomley@hansenpartnership.com
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: Bug: TPM returned invalid status
Message-ID: <YBGpranyEwXaqAUg@kernel.org>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 25, 2021 at 09:00:54AM +0000, Tj (Elloe Linux) wrote:
> Seeing this on Lenovo E495's that have:
> 
> AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx
> 
> Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12
> SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
> systemd.unified_cgroup_hierarchy=1 nosplash
> ...
> efi: EFI v2.70 by Lenovo
> 
> efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
> SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
> ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
> 018
> ...
> DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
> ...
> tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
> ------------[ cut here ]------------
> TPM returned invalid status
> WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249

There's a patch set in cycle that should fix this:

https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/

James, where are we at with this?

/Jarkko
