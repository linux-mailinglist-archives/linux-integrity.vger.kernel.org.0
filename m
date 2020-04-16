Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882E21AB7E1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 08:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407793AbgDPGWT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 02:22:19 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36657 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407768AbgDPGWQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 02:22:16 -0400
Received: from [192.168.0.4] (ip5f5af6d1.dynamic.kabel-deutschland.de [95.90.246.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F29F206442D0;
        Thu, 16 Apr 2020 08:22:11 +0200 (CEST)
Subject: Re: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
To:     Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     kernel-team@fb.com
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
Date:   Thu, 16 Apr 2020 08:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Omar,


Am 16.04.20 um 02:23 schrieb Omar Sandoval:
> From: Omar Sandoval <osandov@fb.com>

Thank you for the patch.

> We've encountered a particular model of STMicroelectronics TPM that

Please add models you are encountering this with to the commit message.

> transiently returns a bad value in the status register. This causes the

Have you contacted STMMicroelectronics?

> kernel to believe that the TPM is ready to receive a command when it
> actually isn't, which in turn causes the send to time out in
> get_burstcount(). In testing, reading the status register one extra time
> convinces the TPM to return a valid value.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca031e23..5a2f6acaf768 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -238,6 +238,25 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>   	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
>   	if (rc < 0)
>   		return 0;
> +	/*
> +	 * Some STMicroelectronics TPMs have a bug where the status register is
> +	 * sometimes bogus (all 1s) if read immediately after the access
> +	 * register is written to. Bits 0, 1, and 5 are always supposed to read
> +	 * as 0, so this is clearly invalid. Reading the register a second time
> +	 * returns a valid value.
> +	 */
> +	if (unlikely(status == 0xff)) {

I’d like to see a debug message here, saying the TPM is buggy. Maybe the 
model can be printed to, and that the TPM manufacturer should be contacted.

> +		rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> +		if (rc < 0)
> +			return 0;
> +		/*
> +		 * The status is somehow still bad. This hasn't been observed in
> +		 * practice, but clear it just in case so that it doesn't appear
> +		 * to be ready.
> +		 */
> +		if (unlikely(status == 0xff))
> +			status = 0;
> +	}
>   
>   	return status;
>   }


Kind regards,

Paul
