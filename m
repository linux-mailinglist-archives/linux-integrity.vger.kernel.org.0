Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6F1AB46E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbgDOXvp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 19:51:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38132 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389942AbgDOXvo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 19:51:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 982DA8EE26A;
        Wed, 15 Apr 2020 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1586994701;
        bh=C/zKypDp3UH98QkaSoh3+FV7Ojqt5gxKTrm99cjs3rE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=BRey6Iic5cRpJar0BNWdrRm1gTZSMhXucT+5rnE7Dzr4yffIebf2ioTuylo+Hng3O
         pEzhVDRrrzUngoK3+suwoInN84UL00w6y10Cmaw5AzsBpFAs0qkmM6WIYfaR8B60cm
         WRyyrfnb6+6jv9lZUELkgyKipAsSsEEYkH+NpFD0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XaCgeA_AwEmc; Wed, 15 Apr 2020 16:51:41 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 07C548EE0CF;
        Wed, 15 Apr 2020 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1586994701;
        bh=C/zKypDp3UH98QkaSoh3+FV7Ojqt5gxKTrm99cjs3rE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=BRey6Iic5cRpJar0BNWdrRm1gTZSMhXucT+5rnE7Dzr4yffIebf2ioTuylo+Hng3O
         pEzhVDRrrzUngoK3+suwoInN84UL00w6y10Cmaw5AzsBpFAs0qkmM6WIYfaR8B60cm
         WRyyrfnb6+6jv9lZUELkgyKipAsSsEEYkH+NpFD0=
Message-ID: <1586994699.3931.18.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Wed, 15 Apr 2020 16:51:39 -0700
In-Reply-To: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We've encountered a particular model of STMicroelectronics TPM that
> transiently returns a bad value in the status register. This causes
> the kernel to believe that the TPM is ready to receive a command when
> it actually isn't, which in turn causes the send to time out in
> get_burstcount(). In testing, reading the status register one extra
> time convinces the TPM to return a valid value.

Interesting, I've got a very early upgradeable nuvoton that seems to be
behaving like this.

> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c
> b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca031e23..277a21027fc7 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
>  	if (rc < 0)
>  		return 0;
> +	/*
> +	 * Some STMicroelectronics TPMs have a bug where the status
> register is
> +	 * sometimes bogus (all 1s) if read immediately after the
> access
> +	 * register is written to. Bits 0, 1, and 5 are always
> supposed to read
> +	 * as 0, so this is clearly invalid. Reading the register a
> second time
> +	 * returns a valid value.
> +	 */
> +	if (unlikely(status == 0xff)) {
> +		rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> &status);
> +		if (rc < 0)
> +			return 0;
> +	}

You theorize that your case is fixed by the second read, but what if it
isn't and the second read also returns 0xff?  Shouldn't we have a line
here saying

if (unlikely(status == 0xff))
	status = 0;

So if we get a second 0xff we just pretend the thing isn't ready?

James

>  	return status;
>  }

