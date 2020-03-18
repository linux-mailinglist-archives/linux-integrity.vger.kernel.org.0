Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2018A3E2
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 21:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCRUn2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 16:43:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:12608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRUn2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 16:43:28 -0400
IronPort-SDR: Z5XBmzZupuY2pX0gsQZS1NCjXnDUu17ml90/Ca90Uup0PpF3OvykjqLVmz2tK36FMVYkVwty9P
 JnvbekD/CMVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 13:43:24 -0700
IronPort-SDR: E8lgAwVq5wdZduiyLz5G/pTtWPWcpTbsCS3o1RpV488drpCa3ZPiAo0kzYW+LgabRnEno0nyGZ
 QjNIVZeyMq7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="263509707"
Received: from mbeldzik-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.127])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2020 13:43:20 -0700
Date:   Wed, 18 Mar 2020 22:43:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     George Wilson <gcwilson@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200318204318.GA48352@linux.intel.com>
References: <20200317214600.9561-1-gcwilson@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317214600.9561-1-gcwilson@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 17, 2020 at 05:46:00PM -0400, George Wilson wrote:
> tpm_ibmvtpm_send() can fail during PowerVM Live Partition Mobility resume
> with an H_CLOSED return from ibmvtpm_send_crq().  The PAPR says, 'The
> “partner partition suspended” transport event disables the associated CRQ
> such that any H_SEND_CRQ hcall() to the associated CRQ returns H_Closed
> until the CRQ has been explicitly enabled using the H_ENABLE_CRQ hcall.'
> This patch adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
> ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
> retries the ibmvtpm_send_crq() once.
> 
> Reported-by: Linh Pham <phaml@us.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
> Tested-by: Linh Pham <phaml@us.ibm.com>

I think this should have a fixes tag.

> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 78cc52690177..ba3bd503e080 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2012 IBM Corporation
> + * Copyright (C) 2012-2020 IBM Corporation
>   *
>   * Author: Ashley Lai <ashleydlai@gmail.com>
>   *
> @@ -25,6 +25,8 @@
>  #include "tpm.h"
>  #include "tpm_ibmvtpm.h"
>  
> +static int tpm_ibmvtpm_resume(struct device *dev);
> +

Instead, reposition this function before tpm_ibmvtpm_send().

>  static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
>  
>  static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
> @@ -147,6 +149,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>  	int rc, sig;
> +	bool retry = true;

Cosmetic: would be nice to have inits when possible in reverse
Christmas tree order i.e.

	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
	bool retry = true;
	int rc, sig;

It is way more pleasing for the eye when you have to read the source
code.

>  	if (!ibmvtpm->rtce_buf) {
>  		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
> @@ -179,18 +182,28 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  	 */
>  	ibmvtpm->tpm_processing_cmd = true;
>  
> +again:
>  	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
>  			IBMVTPM_VALID_CMD, VTPM_TPM_COMMAND,
>  			count, ibmvtpm->rtce_dma_handle);
> +

A dangling newline character.

>  	if (rc != H_SUCCESS) {
> +		/*
> +		 * H_CLOSED can be returned after LPM resume.  Call
> +		 * tpm_ibmvtpm_resume() to re-enable the CRQ then retry
> +		 * ibmvtpm_send_crq() once before failing.
> +		 */
> +		if (rc == H_CLOSED && retry) {
> +			tpm_ibmvtpm_resume(ibmvtpm->dev);
> +			retry = false;
> +			goto again;
> +		}
>  		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
> -		rc = 0;
>  		ibmvtpm->tpm_processing_cmd = false;
> -	} else
> -		rc = 0;
> +	}
>  
>  	spin_unlock(&ibmvtpm->rtce_lock);
> -	return rc;
> +	return 0;
>  }
>  
>  static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
> -- 
> 2.24.1
> 

/Jarkko
