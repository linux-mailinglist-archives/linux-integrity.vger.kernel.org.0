Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B93334C79
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhCJXZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 18:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhCJXZD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 18:25:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 229F06186A;
        Wed, 10 Mar 2021 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615418703;
        bh=JtSGztaLHp+SDjYjqr5VsKw0N4JxONlTc3ny6BtrX6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8VuFMMM4xAspUG35vA0IkSZXV0Yp3136+/3ZW67lRyHZldC7r2sLkXXfu13I/3qE
         ydfx7UcTRJvS8Y3Zg2o0ZuSNTO8Rgu38vLPy4e4BVLiFSsNGd2w5e4U+41z0oB3+4p
         Y69jmuVA1QHms81JVkbIGF+xczsWlqzP+YB3jG866kbF6l15EqauV6j/XPAdJXfShe
         kH15QpqcFVFQrSj1Q84kMtA6Zl5f4ebxHifwUYQI3q8h+r+qW4jKScKCsQB+w7EEoO
         +Sxle53g8llIN7kJadJGXbsaYhKa0qsqFPiSGvCwgn6E34cDACu608Sv68OHB0Wxn/
         UPgZq9Mus12gg==
Date:   Thu, 11 Mar 2021 01:24:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjg59@google.com
Subject: Re: [PATCH v2 1/3] tpm: efi: Use local variable for calculating
 final log size
Message-ID: <YElVN0kwMIyeF9gQ@kernel.org>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
 <20210310221916.356716-2-stefanb@linux.ibm.com>
 <YElUiIFkyf6txZoV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YElUiIFkyf6txZoV@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 11, 2021 at 01:21:47AM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 10, 2021 at 05:19:14PM -0500, Stefan Berger wrote:
> > When tpm_read_log_efi is called multiple times, which happens when
> > one loads and unloads a TPM2 driver multiple times, then the global
> > variable efi_tpm_final_log_size will at some point become a negative
> > number due to the subtraction of final_events_preboot_size occurring
> > each time. Use a local variable to avoid this integer underflow.
> > 
> > The following issue is now resolved:
> > 
> > Mar  8 15:35:12 hibinst kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > Mar  8 15:35:12 hibinst kernel: Workqueue: tpm-vtpm vtpm_proxy_work [tpm_vtpm_proxy]
> > Mar  8 15:35:12 hibinst kernel: RIP: 0010:__memcpy+0x12/0x20
> > Mar  8 15:35:12 hibinst kernel: Code: 00 b8 01 00 00 00 85 d2 74 0a c7 05 44 7b ef 00 0f 00 00 00 c3 cc cc cc 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
> > Mar  8 15:35:12 hibinst kernel: RSP: 0018:ffff9ac4c0fcfde0 EFLAGS: 00010206
> > Mar  8 15:35:12 hibinst kernel: RAX: ffff88f878cefed5 RBX: ffff88f878ce9000 RCX: 1ffffffffffffe0f
> > Mar  8 15:35:12 hibinst kernel: RDX: 0000000000000003 RSI: ffff9ac4c003bff9 RDI: ffff88f878cf0e4d
> > Mar  8 15:35:12 hibinst kernel: RBP: ffff9ac4c003b000 R08: 0000000000001000 R09: 000000007e9d6073
> > Mar  8 15:35:12 hibinst kernel: R10: ffff9ac4c003b000 R11: ffff88f879ad3500 R12: 0000000000000ed5
> > Mar  8 15:35:12 hibinst kernel: R13: ffff88f878ce9760 R14: 0000000000000002 R15: ffff88f77de7f018
> > Mar  8 15:35:12 hibinst kernel: FS:  0000000000000000(0000) GS:ffff88f87bd00000(0000) knlGS:0000000000000000
> > Mar  8 15:35:12 hibinst kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Mar  8 15:35:12 hibinst kernel: CR2: ffff9ac4c003c000 CR3: 00000001785a6004 CR4: 0000000000060ee0
> > Mar  8 15:35:12 hibinst kernel: Call Trace:
> > Mar  8 15:35:12 hibinst kernel: tpm_read_log_efi+0x152/0x1a7
> > Mar  8 15:35:12 hibinst kernel: tpm_bios_log_setup+0xc8/0x1c0
> > Mar  8 15:35:12 hibinst kernel: tpm_chip_register+0x8f/0x260
> > Mar  8 15:35:12 hibinst kernel: vtpm_proxy_work+0x16/0x60 [tpm_vtpm_proxy]
> > Mar  8 15:35:12 hibinst kernel: process_one_work+0x1b4/0x370
> > Mar  8 15:35:12 hibinst kernel: worker_thread+0x53/0x3e0
> > Mar  8 15:35:12 hibinst kernel: ? process_one_work+0x370/0x370
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Fixes tag for this one? 

Or just sanity check, I think it is:

Fixes: 166a2809d65b ("tpm: Don't duplicate events from the final event log in the TCG2 log")

Also, I guess all of the patches ought to have stable cc, right?

/Jarkko
