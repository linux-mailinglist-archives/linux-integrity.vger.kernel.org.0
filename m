Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEACE641E20
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Dec 2022 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLDRGq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Dec 2022 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLDRGp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Dec 2022 12:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6111151;
        Sun,  4 Dec 2022 09:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF3DF60DEC;
        Sun,  4 Dec 2022 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB367C433D6;
        Sun,  4 Dec 2022 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670173602;
        bh=bb55Edv837nC63J0PV/JgYuCE6AufxiQG4K9NRFsA+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNo7L6AnsV6jZBMwApj0h59Z+wjj2vAcqhYM9YHRZzwjhaXeQY9+BT7QnzVRSN9sN
         OTgdUhcMbJ7twwCHU4RkMODtlg7+tc81I7vaSDhwQoA2zHKgSKhh8j8oZd9Lc6+wMc
         425eFqSQ3qVS6shQnJtfmoRu3hyLI/lAPyOH3iXmujWFDnE+L1gVzqwsJ2UMsL4t4t
         RCJcu6oXxbxxuJyNhgs0k4zP2wJhRHvJwxYTMZO1m2NcFeR7Ry8WXukbNZ8uU2khp7
         Zetkhv6vyr1nft7egry1tIn+VvLvdzc74xgYoZCx5o4KumyigFWay9QMf1BdQc2fVa
         Y4xtuMOueCN3A==
Date:   Sun, 4 Dec 2022 17:06:38 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jan =?utf-8?B?RMSFYnJvxZs=?= <jsd@semihalf.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] char: tpm: Protect tpm_pm_suspend with locks
Message-ID: <Y4zTnhgunXuwVXHe@kernel.org>
References: <20221128195651.322822-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128195651.322822-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 08:56:51PM +0100, Jason A. Donenfeld wrote:
> From: Jan Dabros <jsd@semihalf.com>
> 
> Currently tpm transactions are executed unconditionally in
> tpm_pm_suspend() function, which may lead to races with other tpm
> accessors in the system. Specifically, the hw_random tpm driver makes
> use of tpm_get_random(), and this function is called in a loop from a
> kthread, which means it's not frozen alongside userspace, and so can
> race with the work done during system suspend:
> 
> [    3.277834] tpm tpm0: tpm_transmit: tpm_recv: error -52
> [    3.278437] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
> [    3.278445] CPU: 0 PID: 1 Comm: init Not tainted 6.1.0-rc5+ #135
> [    3.278450] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> [    3.278453] Call Trace:
> [    3.278458]  <TASK>
> [    3.278460]  dump_stack_lvl+0x34/0x44
> [    3.278471]  tpm_tis_status.cold+0x19/0x20
> [    3.278479]  tpm_transmit+0x13b/0x390
> [    3.278489]  tpm_transmit_cmd+0x20/0x80
> [    3.278496]  tpm1_pm_suspend+0xa6/0x110
> [    3.278503]  tpm_pm_suspend+0x53/0x80
> [    3.278510]  __pnp_bus_suspend+0x35/0xe0
> [    3.278515]  ? pnp_bus_freeze+0x10/0x10
> [    3.278519]  __device_suspend+0x10f/0x350
> 
> Fix this by calling tpm_try_get_ops(), which itself is a wrapper around
> tpm_chip_start(), but takes the appropriate mutex.
> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Tested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
> Cc: stable@vger.kernel.org
> Fixes: e891db1a18bf ("tpm: turn on TPM on suspend for TPM 1.x")
> [Jason: reworked commit message, added metadata]
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..d69905233aff 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -401,13 +401,14 @@ int tpm_pm_suspend(struct device *dev)
>  	    !pm_suspend_via_firmware())
>  		goto suspended;
>  
> -	if (!tpm_chip_start(chip)) {
> +	rc = tpm_try_get_ops(chip);
> +	if (!rc) {
>  		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  			tpm2_shutdown(chip, TPM2_SU_STATE);
>  		else
>  			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
>  
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>  	}
>  
>  suspended:
> -- 
> 2.38.1
> 

Hi, sorry for the latency.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
