Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7F3E1D6D
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbhHEUpF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 16:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhHEUpF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 16:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09D3761104;
        Thu,  5 Aug 2021 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628196290;
        bh=ky6Qlnkz4Y07RmFf91Q9kfz78wwFWh1HM9aI96tKtJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFMPX/DjiFY0lalXb1/HWQPdpxZwIj73WKxX1QAO1sVs4T9VN5IpTIUUZAuW+Xe5Y
         Hdi50M8x/4fg7L1CiFE1VBWUjLKKlmGEbPNMZkx0AsHybOQGxwuFGv3qXE+BbX/ULP
         lBKqKvB3MnG3Ldfp71ke1EKXpSfW0KFPqLf954mGsAKHl4fKVL4FSd7Mu4rKIOmCDc
         9bmW/wvuSRzSFZd//QxD7KvfliMVY+ci2WN3t/FOoM45YZ155/+tJSemLeWt2fvWSq
         mI7w36R0wlrFhbffk4gfPAOBEcggaUey8jbSuJWFrPhQ3XG/lmuhbYlZ8z5kqNc1BQ
         6imBSizFzO2eg==
Date:   Thu, 5 Aug 2021 23:44:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
Message-ID: <20210805204447.o43rftv7mo56keir@kernel.org>
References: <20210803202622.1537040-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803202622.1537040-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 03, 2021 at 04:26:22PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> When rngd is run as root then lots of these types of message will appear
> in the kernel log if the TPM has been configured to provide random bytes:
> 
> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> 
> The issue is caused by the following call that is interrupted while
> waiting for the TPM's response.
> 
> sig = wait_event_interruptible(ibmvtpm->wq,
>                                !ibmvtpm->tpm_processing_cmd);
> 
> Rather than waiting for the response in the low level driver, have it use
> the polling loop in tpm_try_transmit() that uses a command's duration to
> poll until a result has been returned by the TPM, thus ending when the
> timeout has occurred but not responding to signals and ctrl-c anymore. To
> stay in this polling loop extend tpm_ibmvtpm_status() to return
> TPM_STATUS_BUSY for as long as the vTPM is busy. Since the loop requires
> the TPM's timeouts, get them now using tpm_get_timeouts() after setting
> the TPM2 version flag on the chip.
> 
> Rename the tpm_processing_cmd to tpm_status in ibmvtpm_dev and set the
> TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> 
> To recreat the resolved issue start rngd like this:
> 
> sudo rngd -r /dev/hwrng -t
> sudo rngd -r /dev/tpm0 -t
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1981473
> Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: George Wilson <gcwilson@linux.ibm.com>
> Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> 
> v2:
>  - reworded commit text
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
>  drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 903604769de9..5d795866b483 100644
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
> @@ -457,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.send = tpm_ibmvtpm_send,
>  	.cancel = tpm_ibmvtpm_cancel,
>  	.status = tpm_ibmvtpm_status,
> -	.req_complete_mask = 0,
> +	.req_complete_mask = TPM_STATUS_BUSY,
>  	.req_complete_val = 0,
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
> @@ -550,7 +548,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
>  		case VTPM_TPM_COMMAND_RES:
>  			/* len of the data in rtce buffer */
>  			ibmvtpm->res_len = be16_to_cpu(crq->len);
> -			ibmvtpm->tpm_processing_cmd = false;
> +			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>  			wake_up_interruptible(&ibmvtpm->wq);
>  			return;
>  		default:
> @@ -688,8 +686,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
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
> 2.31.1
> 
> 

Please do not do the rename in the bug fix. If you really want to rename,
then this must be split into two commits.

/Jarkko
