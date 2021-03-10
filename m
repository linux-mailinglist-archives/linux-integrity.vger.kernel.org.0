Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1412334C70
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCJXWU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 18:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhCJXWI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 18:22:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1297664FC1;
        Wed, 10 Mar 2021 23:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615418528;
        bh=Evfm0oY+kQII8STajQrZwgNaNVf5h9GRc794NeHNvSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFxceItnGCWtp3Vx8KcoDEykaDsQDKp+TS0QG5+xRQw+ESDssx8pWm1krtwK7t+Qe
         NF3QOQwroFwblfVmjVNyj5UPEhrOUEIuTdJ907wnxdX1qw4WERtQh/3oGMd07BTSWX
         U7QCihg3hYUW5h7+hQCEnMNhlM1C7bKrxGFszo7sjUdmYme78FyNP4sw/v9EGO5ETJ
         nR4xLBhtaR/eJTG1+tEijaZJL9HDDwt8LpHtz+aqOn2HIJ/s/UludMg+0qJC9Dg8Sr
         zdCkiuGaP46KOs1z/KZjicc4Jw6VJKPNrd7cA5gOVpzqEQH+LInk/9gV5YPoofxN4M
         geNgYJiEy3NdQ==
Date:   Thu, 11 Mar 2021 01:21:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tpm: efi: Use local variable for calculating
 final log size
Message-ID: <YElUiIFkyf6txZoV@kernel.org>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
 <20210310221916.356716-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310221916.356716-2-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 05:19:14PM -0500, Stefan Berger wrote:
> When tpm_read_log_efi is called multiple times, which happens when
> one loads and unloads a TPM2 driver multiple times, then the global
> variable efi_tpm_final_log_size will at some point become a negative
> number due to the subtraction of final_events_preboot_size occurring
> each time. Use a local variable to avoid this integer underflow.
> 
> The following issue is now resolved:
> 
> Mar  8 15:35:12 hibinst kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Mar  8 15:35:12 hibinst kernel: Workqueue: tpm-vtpm vtpm_proxy_work [tpm_vtpm_proxy]
> Mar  8 15:35:12 hibinst kernel: RIP: 0010:__memcpy+0x12/0x20
> Mar  8 15:35:12 hibinst kernel: Code: 00 b8 01 00 00 00 85 d2 74 0a c7 05 44 7b ef 00 0f 00 00 00 c3 cc cc cc 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
> Mar  8 15:35:12 hibinst kernel: RSP: 0018:ffff9ac4c0fcfde0 EFLAGS: 00010206
> Mar  8 15:35:12 hibinst kernel: RAX: ffff88f878cefed5 RBX: ffff88f878ce9000 RCX: 1ffffffffffffe0f
> Mar  8 15:35:12 hibinst kernel: RDX: 0000000000000003 RSI: ffff9ac4c003bff9 RDI: ffff88f878cf0e4d
> Mar  8 15:35:12 hibinst kernel: RBP: ffff9ac4c003b000 R08: 0000000000001000 R09: 000000007e9d6073
> Mar  8 15:35:12 hibinst kernel: R10: ffff9ac4c003b000 R11: ffff88f879ad3500 R12: 0000000000000ed5
> Mar  8 15:35:12 hibinst kernel: R13: ffff88f878ce9760 R14: 0000000000000002 R15: ffff88f77de7f018
> Mar  8 15:35:12 hibinst kernel: FS:  0000000000000000(0000) GS:ffff88f87bd00000(0000) knlGS:0000000000000000
> Mar  8 15:35:12 hibinst kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar  8 15:35:12 hibinst kernel: CR2: ffff9ac4c003c000 CR3: 00000001785a6004 CR4: 0000000000060ee0
> Mar  8 15:35:12 hibinst kernel: Call Trace:
> Mar  8 15:35:12 hibinst kernel: tpm_read_log_efi+0x152/0x1a7
> Mar  8 15:35:12 hibinst kernel: tpm_bios_log_setup+0xc8/0x1c0
> Mar  8 15:35:12 hibinst kernel: tpm_chip_register+0x8f/0x260
> Mar  8 15:35:12 hibinst kernel: vtpm_proxy_work+0x16/0x60 [tpm_vtpm_proxy]
> Mar  8 15:35:12 hibinst kernel: process_one_work+0x1b4/0x370
> Mar  8 15:35:12 hibinst kernel: worker_thread+0x53/0x3e0
> Mar  8 15:35:12 hibinst kernel: ? process_one_work+0x370/0x370
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Fixes tag for this one? 

/Jarkko

> ---
>  drivers/char/tpm/eventlog/efi.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
> index 35229e5143ca..e6cb9d525e30 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -17,6 +17,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  {
>  
>  	struct efi_tcg2_final_events_table *final_tbl = NULL;
> +	int final_events_log_size = efi_tpm_final_log_size;
>  	struct linux_efi_tpm_eventlog *log_tbl;
>  	struct tpm_bios_log *log;
>  	u32 log_size;
> @@ -66,12 +67,12 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	ret = tpm_log_version;
>  
>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
> -	    efi_tpm_final_log_size == 0 ||
> +	    final_events_log_size == 0 ||
>  	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
>  		goto out;
>  
>  	final_tbl = memremap(efi.tpm_final_log,
> -			     sizeof(*final_tbl) + efi_tpm_final_log_size,
> +			     sizeof(*final_tbl) + final_events_log_size,
>  			     MEMREMAP_WB);
>  	if (!final_tbl) {
>  		pr_err("Could not map UEFI TPM final log\n");
> @@ -80,10 +81,18 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  		goto out;
>  	}
>  
> -	efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;
> +	/*
> +	 * The 'final events log' size excludes the 'final events preboot log'
> +	 * at its beginning.
> +	 */
> +	final_events_log_size -= log_tbl->final_events_preboot_size;
>  
> +	/*
> +	 * Allocate memory for the 'combined log' where we will append the
> +	 * 'final events log' to.
> +	 */
>  	tmp = krealloc(log->bios_event_log,
> -		       log_size + efi_tpm_final_log_size,
> +		       log_size + final_events_log_size,
>  		       GFP_KERNEL);
>  	if (!tmp) {
>  		kfree(log->bios_event_log);
> @@ -94,15 +103,19 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	log->bios_event_log = tmp;
>  
>  	/*
> -	 * Copy any of the final events log that didn't also end up in the
> -	 * main log. Events can be logged in both if events are generated
> +	 * Append any of the 'final events log' that didn't also end up in the
> +	 * 'main log'. Events can be logged in both if events are generated
>  	 * between GetEventLog() and ExitBootServices().
>  	 */
>  	memcpy((void *)log->bios_event_log + log_size,
>  	       final_tbl->events + log_tbl->final_events_preboot_size,
> -	       efi_tpm_final_log_size);
> +	       final_events_log_size);
> +	/*
> +	 * The size of the 'combined log' is the size of the 'main log' plus
> +	 * the size of the 'final events log'.
> +	 */
>  	log->bios_event_log_end = log->bios_event_log +
> -		log_size + efi_tpm_final_log_size;
> +		log_size + final_events_log_size;
>  
>  out:
>  	memunmap(final_tbl);
> -- 
> 2.29.2
> 
> 
