Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73BF17593F
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCBLLU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 06:11:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:24667 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLLU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 06:11:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="412243946"
Received: from aorourk1-mobl.ger.corp.intel.com (HELO localhost) ([10.251.86.123])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 03:11:17 -0800
Date:   Mon, 2 Mar 2020 13:11:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
Message-ID: <20200302111116.GB3979@linux.intel.com>
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
 <20200228030330.18081-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228030330.18081-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 27, 2020 at 10:03:29PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com> > 
> Synchronize with the results from the CRQs before continuing with
> the initialization. This avoids trying to send TPM commands while
> the rtce buffer has not been allocated, yet.
> 
> This patch fixes an existing race condition that may occurr if the
> hypervisor does not quickly respond to the VTPM_GET_RTCE_BUFFER_SIZE
> request sent during initialization and therefore the ibmvtpm->rtce_buf
> has not been allocated at the time the first TPM command is sent.
> 
> Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 9 +++++++++
>  drivers/char/tpm/tpm_ibmvtpm.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 78cc52690177..eee566eddb35 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -571,6 +571,7 @@ static irqreturn_t ibmvtpm_interrupt(int irq, void *vtpm_instance)
>  	 */
>  	while ((crq = ibmvtpm_crq_get_next(ibmvtpm)) != NULL) {
>  		ibmvtpm_crq_process(crq, ibmvtpm);
> +		wake_up_interruptible(&ibmvtpm->crq_queue.wq);
>  		crq->valid = 0;
>  		smp_wmb();
>  	}
> @@ -618,6 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  	}
>  
>  	crq_q->num_entry = CRQ_RES_BUF_SIZE / sizeof(*crq_q->crq_addr);
> +	init_waitqueue_head(&crq_q->wq);
>  	ibmvtpm->crq_dma_handle = dma_map_single(dev, crq_q->crq_addr,
>  						 CRQ_RES_BUF_SIZE,
>  						 DMA_BIDIRECTIONAL);
> @@ -670,6 +672,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  	if (rc)
>  		goto init_irq_cleanup;
>  
> +	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
> +				ibmvtpm->rtce_buf != NULL,
> +				HZ)) {
> +		dev_err(dev, "Initialization failed\n");

I'd change this something more descriptive "CRQ response timed out".

/Jarkko
