Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A289C47BC1F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 09:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhLUIrd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 03:47:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58058 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhLUIrc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 03:47:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1807B81211;
        Tue, 21 Dec 2021 08:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29483C36AE7;
        Tue, 21 Dec 2021 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640076449;
        bh=z+hWLz9eeYZRs6D3BG6fArBnZ7wr2Rh1s9m2i6WbG8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDzIu2g9SuwaZPs5b1Pd4gxYHd/Mgpt/Wo662d8GXD2H19BbQJi5YNA7R7wNn3LK1
         czEaugp5uTg5DXI7aVIiF9w/LxW2dEEEaw4imLIvgSqFhNTwF3N5NPexO60Ixpe8NQ
         RkjgwFRxssPH8amrZfly6vB7GCpM7qsZnTkvQBq80nvLi2hBQzsohOsxeqBZAjDPDj
         ebdPAK5SYJpLYMcWpIyOzNfoWD7BC0TDxZ+6SxIYdQ6y5czKCuLqZxVNCH6/XwFX+h
         rgOQPMcV3UsjL7Y1O2BEHQ9VdLkXiAzLm8CGx/j9YSbLW5VS/YUrgt1ZmJp/szIWTA
         OKfzYlA6k9/NA==
Date:   Tue, 21 Dec 2021 10:47:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, pavrampu@in.ibm.com,
        Korrapati.Likhitha@ibm.com, gcwilson@us.ibm.com
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
Message-ID: <YcGUoJCtmqfCWER0@iki.fi>
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212012804.1555661-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 11, 2021 at 08:28:04PM -0500, Stefan Berger wrote:
> Fix the following crash on kexec by checking chip->ops for a NULL pointer
> in tpm_chip_start() and returning an error code if this is the case.
> 
> BUG: Kernel NULL pointer dereference on read at 0x00000060
> Faulting instruction address: 0xc00000000099a06c
> Oops: Kernel access of bad area, sig: 11 [#1]
> ...
> NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
>  LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
> Call Trace:
> [c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 (unreliable)
> [c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
> [c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
> [c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
> [c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
> [c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70
> 
> The referenced patch below introduced a function to shut down the VIO bus.
> The bus shutdown now calls tpm_del_char_device (via tpm_chip_unregister)
> after a call to tpm_class_shutdown, which already set chip->ops to NULL.
> The crash occurrs when tpm_del_char_device calls tpm_chip_start with the
> chip->ops NULL pointer.
> 
> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio_bus")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..cca1bde296ee 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
>  {
>  	int ret;
>  
> +	if (!chip->ops)
> +		return -EINVAL;

This triggers to all drivers, not just tpm_ibmvtpm, i.e. the fix has
side-effects.

/Jarkko

