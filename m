Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E01722AE
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgB0QAg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:00:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:63612 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgB0QAg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:00:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="242082847"
Received: from asliwa-mobl.ger.corp.intel.com (HELO localhost) ([10.252.26.84])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2020 08:00:32 -0800
Date:   Thu, 27 Feb 2020 18:00:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
Message-ID: <20200227160031.GA5140@linux.intel.com>
References: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
 <20200227002654.7536-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227002654.7536-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 26, 2020 at 07:26:52PM -0500, Stefan Berger wrote:
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
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")

Fixes ought to be before sob.

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

/Jarkko
