Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185EF319BA7
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBLJH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 04:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhBLJGp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 04:06:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E1E64DF2;
        Fri, 12 Feb 2021 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613120764;
        bh=np7SqXCjziD+AGzYpWTOoztirigRiGQnjccnbJOBAJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrEokEg/IvbwcxMoHDRNjACc7I0WZC7VbiE+UV4N3t4t8Mid9nYT1+ptKhjAYxIkc
         rZiYAZnSsL013WBzeUiWkNAZjQZ3NzqXrxxPWqv/lt/r/caHFBMZh0dJ3yKWBddFI5
         R35qjn+nQ4QyAQf9wojUloiBPfZp7P2fenPThf6D4EpaN72M0RyISATETrboJgJxPY
         wqRZD+HsZkEOeiDolfKeGUrQ8mdGHJjYCgdGgf2STJ2sTakm9RpQLLpOUj1HWKgN4e
         Z6nZt/zm4BXrt0UQBTsjSMwleiIOkOFZX9JqCK4dQS4R5kgOvJmvs16T26KltD5WiC
         u37KPnnVleSPQ==
Date:   Fri, 12 Feb 2021 11:05:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid -EINTR error when IMA talks to TPM
Message-ID: <YCZE8nf9ylXJTo4k@kernel.org>
References: <20210209221339.875739-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221339.875739-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 09, 2021 at 05:13:39PM -0500, Stefan Berger wrote:
> When IMA is taking measurements during compilation for example and a
> user presses ctrl-c to abort the compilation, lots of these types of
> messages will appear in the kernel log:
> 
> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> [ 7406.275242] ima: Error Communicating to TPM chip, result: -4
> 
> The issue is caused by the fact that the IBM vTPM driver's recv()
> function is called immediately after send() without waiting for
> status on whether a response was received. It currently waits for
> the current command to finish using this call that ends up throwing
> these error messages because it is 'interruptible':

Why it is an issue?

> sig = wait_event_interruptible(ibmvtpm->wq,
>                                !ibmvtpm->tpm_processing_cmd);
> 
> Instead, it should be using the polling loop in tpm_try_transmit()
> that uses a command's duration to poll until a result has been
> returned by the TPM, thus ending when the timeout has occurred but
> not responding to users' ctrl-c request anymore. To stay in this
> polling loop we now extend tpm_ibmvtpm_status() to return
> PM_STATUS_BUSY for as long as the vTPM is busy. Since we will need
> the timeouts in this loop now we get the TPM 1.2 and TPM 2 timeouts
> with tpm_get_timeouts().
> 
> We change tpm_processing_cmd to tpm_status and set the TPM_STATUS_BUSY
> flag while the vTPM is busy processing a command.

Please, never use "we". The commit message should describe in
imperative form the action taken.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: George Wilson <gcwilson@linux.ibm.com>

Your SOB should be last.

> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
>  drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 994385bf37c0..6290bd8889e4 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -106,17 +106,12 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>  	u16 len;
> -	int sig;
>  
>  	if (!ibmvtpm->rtce_buf) {
>  		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
>  		return 0;
>  	}
>  
> -	sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> -	if (sig)
> -		return -EINTR;
> -
>  	len = ibmvtpm->res_len;
>  
>  	if (count < len) {
> @@ -220,11 +215,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  		return -EIO;
>  	}
>  
> -	if (ibmvtpm->tpm_processing_cmd) {
> +	if ((ibmvtpm->tpm_status & TPM_STATUS_BUSY)) {
>  		dev_info(ibmvtpm->dev,
>  		         "Need to wait for TPM to finish\n");
>  		/* wait for previous command to finish */
> -		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> +		sig = wait_event_interruptible(ibmvtpm->wq,
> +				(ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);
>  		if (sig)
>  			return -EINTR;
>  	}
> @@ -237,7 +233,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  	 * set the processing flag before the Hcall, since we may get the
>  	 * result (interrupt) before even being able to check rc.
>  	 */
> -	ibmvtpm->tpm_processing_cmd = true;
> +	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
>  
>  again:
>  	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
> @@ -255,7 +251,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  			goto again;
>  		}
>  		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
> -		ibmvtpm->tpm_processing_cmd = false;
> +		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>  	}
>  
>  	spin_unlock(&ibmvtpm->rtce_lock);
> @@ -269,7 +265,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
>  
>  static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
>  {
> -	return 0;
> +	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> +
> +	return ibmvtpm->tpm_status;
>  }
>  
>  /**
> @@ -459,7 +457,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.send = tpm_ibmvtpm_send,
>  	.cancel = tpm_ibmvtpm_cancel,
>  	.status = tpm_ibmvtpm_status,
> -	.req_complete_mask = 0,
> +	.req_complete_mask = TPM_STATUS_BUSY,
>  	.req_complete_val = 0,
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
> @@ -552,7 +550,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
>  		case VTPM_TPM_COMMAND_RES:
>  			/* len of the data in rtce buffer */
>  			ibmvtpm->res_len = be16_to_cpu(crq->len);
> -			ibmvtpm->tpm_processing_cmd = false;
> +			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>  			wake_up_interruptible(&ibmvtpm->wq);
>  			return;
>  		default:
> @@ -690,8 +688,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  		goto init_irq_cleanup;
>  	}
>  
> -	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +
> +	if (!strcmp(id->compat, "IBM,vtpm20"))
>  		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	rc = tpm_get_timeouts(chip);
> +	if (rc)
> +		goto init_irq_cleanup;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		rc = tpm2_get_cc_attrs_tbl(chip);
>  		if (rc)
>  			goto init_irq_cleanup;
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> index b92aa7d3e93e..252f1cccdfc5 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
>  	wait_queue_head_t wq;
>  	u16 res_len;
>  	u32 vtpm_version;
> -	bool tpm_processing_cmd;
> +	u8 tpm_status;
> +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
>  };
>  
>  #define CRQ_RES_BUF_SIZE	PAGE_SIZE
> -- 
> 2.29.2
> 
> 
