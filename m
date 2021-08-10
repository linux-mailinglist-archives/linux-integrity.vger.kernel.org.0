Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC73E825C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 20:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhHJSHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 14:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239351AbhHJSFJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 14:05:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3DE560E09;
        Tue, 10 Aug 2021 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628618337;
        bh=Cr9R1HwNiLcb2/9udQyjfu9g8wdlTQKPfK0qsaBcKmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvkLCcXCLH/BXu25BLnQ6wa/OBSgEqmCMlUp2N0oJ/TmSTAgKOPpTcMTxce/dFrp1
         0kbzwY3aP7UPfy87J6oljCCt/AiScETUutlYm1w95QrKQSf8is8GX3Y7jN0Byx59t5
         yPouQsUk6AtSB9dn/GEbeJo3dFPQKTORq8dLXEQw/H9F1aE1vUqWm0EJnuY5BPHpEW
         nn7ZrjGm6ofKlXRG9VyDaiJEzE0i+3Saien1c1Tbncjpg0VVYWTI0NHLMpQ/OnviHV
         wHEJsFsroZ1tbbHrtpNbJLsQxSzEgFAUH+vCZclor6jmP8Xt6aap+fqlkGBHZgpdsE
         IMnB3Hdjk+l1g==
Date:   Tue, 10 Aug 2021 20:58:55 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     nasastry@in.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to
 tpm_status and define flag
Message-ID: <20210810175855.fixtw5jks4gbmkua@kernel.org>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 09, 2021 at 03:21:59PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
> the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: George Wilson <gcwilson@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 15 ++++++++-------
>  drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 7a9eca5768f8..5d795866b483 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -215,11 +215,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
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
> @@ -232,7 +233,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  	 * set the processing flag before the Hcall, since we may get the
>  	 * result (interrupt) before even being able to check rc.
>  	 */
> -	ibmvtpm->tpm_processing_cmd = true;
> +	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
>  
>  again:
>  	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
> @@ -250,7 +251,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  			goto again;
>  		}
>  		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
> -		ibmvtpm->tpm_processing_cmd = false;
> +		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>  	}
>  
>  	spin_unlock(&ibmvtpm->rtce_lock);
> @@ -266,7 +267,7 @@ static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
>  {
>  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>  
> -	return ibmvtpm->tpm_processing_cmd;
> +	return ibmvtpm->tpm_status;
>  }
>  
>  /**
> @@ -454,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.send = tpm_ibmvtpm_send,
>  	.cancel = tpm_ibmvtpm_cancel,
>  	.status = tpm_ibmvtpm_status,
> -	.req_complete_mask = true,
> +	.req_complete_mask = TPM_STATUS_BUSY,
>  	.req_complete_val = 0,
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
> @@ -547,7 +548,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
>  		case VTPM_TPM_COMMAND_RES:
>  			/* len of the data in rtce buffer */
>  			ibmvtpm->res_len = be16_to_cpu(crq->len);
> -			ibmvtpm->tpm_processing_cmd = false;
> +			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>  			wake_up_interruptible(&ibmvtpm->wq);
>  			return;
>  		default:
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> index 51198b137461..252f1cccdfc5 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
>  	wait_queue_head_t wq;
>  	u16 res_len;
>  	u32 vtpm_version;
> -	u8 tpm_processing_cmd;
> +	u8 tpm_status;
> +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */

Declare this already in the fix, and just leave the rename here.

>  };
>  
>  #define CRQ_RES_BUF_SIZE	PAGE_SIZE
> -- 
> 2.31.1
> 
> 

Otherwise, these look fine.

/Jarkko
