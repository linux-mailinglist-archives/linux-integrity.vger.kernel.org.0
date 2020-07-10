Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32C21BD58
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJTIj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 15:08:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35760 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbgGJTIg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 15:08:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 685778EE2AF;
        Fri, 10 Jul 2020 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594408115;
        bh=TmrAzcBWb/MPHV7bm20MUfqaU7DTBEJLK9IEn4cwOI8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pYbj89lReMEsopaaRladOY/GMH9VrPwVwE8f3Whq/eWLjAEB/WP+HWEm/p+91iY60
         0HD4PvlkLB9PP+EC7wfHRpSMdj/BKbcDt933WM4M8gb392vm4YYPcRcYJh/Ptj9l2s
         ZKc072+6TkJY7RCiNmCfr/2NmQNdk4oKFohT62NM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FSydHnbl8cqn; Fri, 10 Jul 2020 12:08:35 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CA52E8EE112;
        Fri, 10 Jul 2020 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594408115;
        bh=TmrAzcBWb/MPHV7bm20MUfqaU7DTBEJLK9IEn4cwOI8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pYbj89lReMEsopaaRladOY/GMH9VrPwVwE8f3Whq/eWLjAEB/WP+HWEm/p+91iY60
         0HD4PvlkLB9PP+EC7wfHRpSMdj/BKbcDt933WM4M8gb392vm4YYPcRcYJh/Ptj9l2s
         ZKc072+6TkJY7RCiNmCfr/2NmQNdk4oKFohT62NM=
Message-ID: <1594408113.4494.16.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrey Pronin <apronin@chromium.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Date:   Fri, 10 Jul 2020 12:08:33 -0700
In-Reply-To: <20200710002209.6757-1-apronin@chromium.org>
References: <20200710002209.6757-1-apronin@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-09 at 17:22 -0700, Andrey Pronin wrote:
> This patch prevents NULL dereferencing when using chip->ops while
> sending TPM2_Shutdown command if both tpm_class_shutdown handler and
> tpm_del_char_device are called during system shutdown.
> 
> Both these handlers set chip->ops to NULL but don't check if it's
> already NULL when they are called before using it.
> 
> This issue was revealed in Chrome OS after a recent set of changes
> to the unregister order for spi controllers, such as:
>   b4c6230bb0ba spi: Fix controller unregister order
>   f40913d2dca1 spi: pxa2xx: Fix controller unregister order
> and similar for other controllers.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> chip.c
> index 8c77e88012e9..a410ca40a3c5 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
>  	struct tpm_chip *chip = container_of(dev, struct tpm_chip,
> dev);
>  
>  	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
>  		if (!tpm_chip_start(chip)) {
>  			tpm2_shutdown(chip, TPM2_SU_CLEAR);
>  			tpm_chip_stop(chip);
> @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip
> *chip)
>  
>  	/* Make the driver uncallable. */
>  	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
>  		if (!tpm_chip_start(chip)) {
>  			tpm2_shutdown(chip, TPM2_SU_CLEAR);
>  			tpm_chip_stop(chip);

I really don't think this is the right fix.  The problem is that these
two functions are trying to open code tpm_try_get_ops/tpm_put_ops (only
really for the tpm2 shutdown) because they want to NULL out the ops
before final mutex unlock.  The problem with the current open coding is
it doesn't shut down the clock if required (not really a problem for
shutdown, but might cause issues for simple rmmod).  I think this is
because no-one noticed the open coding when get/put was updated.

This code should all be abstracted into a single function and shared
with tpm_try_get_ops/tpm_put_ops so we can't have this happen in
future.  Possibly there should be a chip shutdown function which is
only active for TPM2 which does the correct try_get/shutdown/put
operation and then a separate simple get mutex, null ops, put mutex one
that's guaranteed to be called last.

James

