Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039830C7C3
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhBBR3p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 12:29:45 -0500
Received: from mail.hallyn.com ([178.63.66.53]:44016 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236736AbhBBR1i (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 12:27:38 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 66CB8AD9; Tue,  2 Feb 2021 11:26:51 -0600 (CST)
Date:   Tue, 2 Feb 2021 11:26:51 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH] tpm: WARN_ONCE() -> pr_warn_once() in tpm_tis_status()
Message-ID: <20210202172651.GA2821@mail.hallyn.com>
References: <20210202153317.57749-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202153317.57749-1-jarkko@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 05:33:17PM +0200, jarkko@kernel.org wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> An unexpected status from TPM chip is not irrecovable failure of the
> kernel. It's only undesirable situation. Thus, change the WARN_ONCE
> instance inside tpm_tis_status() to pr_warn_once().
> 
> In addition: print the status in the log message because it is actually
> useful information lacking from the existing log message.
> 
> Suggested-by:  Guenter Roeck <linux@roeck-us.net>
> Cc: stable@vger.kernel.org
> Fixes: 6f4f57f0b909 ("tpm: ibmvtpm: fix error return code in tpm_ibmvtpm_probe()")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 431919d5f48a..21f67c6366cb 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -202,7 +202,7 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  		 * acquired.  Usually because tpm_try_get_ops() hasn't
>  		 * been called before doing a TPM operation.
>  		 */
> -		WARN_ONCE(1, "TPM returned invalid status\n");
> +		pr_warn_once("TPM returned invalid status: 0x%x\n", status);
>  		return 0;
>  	}

Actually in this case I don't understand why _once, especially based on
the comment.  Would ratelimited not be better?  So we can see if it
happens repeatedly?  Even better would be if we could see when it next
gave a valid status after an invalid one.
