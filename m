Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2E184ABB
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCMP36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 11:29:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:59583 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMP36 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 11:29:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 08:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="278261684"
Received: from mlitka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.148])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 08:29:52 -0700
Date:   Fri, 13 Mar 2020 17:29:50 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 2/3] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
Message-ID: <20200313152950.GC142269@linux.intel.com>
References: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
 <20200312155332.671464-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155332.671464-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 12, 2020 at 11:53:31AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
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
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 9 +++++++++
>  drivers/char/tpm/tpm_ibmvtpm.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 78cc52690177..cfe40e7b1ba4 100644
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
> +		dev_err(dev, "CRQ response timed out\n");
> +		goto init_irq_cleanup;
> +	}
> +
>  	return tpm_chip_register(chip);
>  init_irq_cleanup:
>  	do {
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> index 7983f1a33267..b92aa7d3e93e 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -26,6 +26,7 @@ struct ibmvtpm_crq_queue {
>  	struct ibmvtpm_crq *crq_addr;
>  	u32 index;
>  	u32 num_entry;
> +	wait_queue_head_t wq;
>  };
>  
>  struct ibmvtpm_dev {
> -- 
> 2.23.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
