Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A02D6A8A
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfJNUDQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 16:03:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:40082 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbfJNUDQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 16:03:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 13:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="395302463"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2019 13:03:10 -0700
Date:   Mon, 14 Oct 2019 23:03:09 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] ftpm: add shutdown call back
Message-ID: <20191014200309.GM15552@linux.intel.com>
References: <20191011145721.59257-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011145721.59257-1-pasha.tatashin@soleen.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 11, 2019 at 10:57:21AM -0400, Pavel Tatashin wrote:
> From: thiruan <thiruan@microsoft.com>
> 
> add shutdown call back to close existing session with fTPM TA
> to support kexec scenario.
> 
> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Use the correct tag in the short summary (tpm/tpm_ftpm_tee).

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 6640a14dbe48..c245be6f4015 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -328,6 +328,27 @@ static int ftpm_tee_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/**
> + * ftpm_tee_shutdown - shutdown the TPM device
> + * @pdev: the platform_device description.
> + *
> + * Return:
> + * 	none.

Do not document return values for a void function. The last three lines
do not serve any purpose.

> + */
> +static void ftpm_tee_shutdown(struct platform_device *pdev)
> +{
> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> +
> +	/* Free the shared memory pool */
> +	tee_shm_free(pvt_data->shm);

Is it unexpected that calling tee_shm_free() free's a shared memory
pool? A comment here implies exactly that.

> +	/* close the existing session with fTPM TA*/
> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);

Ditto.

> +
> +	/* close the context with TEE driver */
> +	tee_client_close_context(pvt_data->ctx);

Ditto.

> +}
> +
>  static const struct of_device_id of_ftpm_tee_ids[] = {
>  	{ .compatible = "microsoft,ftpm" },
>  	{ }
> @@ -341,6 +362,7 @@ static struct platform_driver ftpm_tee_driver = {
>  	},
>  	.probe = ftpm_tee_probe,
>  	.remove = ftpm_tee_remove,
> +	.shutdown = ftpm_tee_shutdown,
>  };
>  
>  module_platform_driver(ftpm_tee_driver);
> -- 
> 2.23.0
> 

/Jarkko
