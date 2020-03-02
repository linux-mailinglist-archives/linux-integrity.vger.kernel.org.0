Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150121761AD
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 18:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBR5m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 12:57:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgCBR5m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 12:57:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022HpmGk021165;
        Mon, 2 Mar 2020 12:57:35 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbf2emc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 12:57:34 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 022Hu7G8020505;
        Mon, 2 Mar 2020 17:57:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 2yffk645n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 17:57:33 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022HvWpg55378334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 17:57:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F9AC6062;
        Mon,  2 Mar 2020 17:57:32 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F9F9C6057;
        Mon,  2 Mar 2020 17:57:31 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.68.102])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 17:57:30 +0000 (GMT)
Subject: Re: [PATCH v5 2/3] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
 <20200228030330.18081-3-stefanb@linux.vnet.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <fa5101bb-9ea3-3825-67b6-a227a696abc9@linux.vnet.ibm.com>
Date:   Mon, 2 Mar 2020 12:57:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228030330.18081-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_06:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020118
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/27/20 10:03 PM, Stefan Berger wrote:
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
> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 9 +++++++++
>   drivers/char/tpm/tpm_ibmvtpm.h | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 78cc52690177..eee566eddb35 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -571,6 +571,7 @@ static irqreturn_t ibmvtpm_interrupt(int irq, void *vtpm_instance)
>   	 */
>   	while ((crq = ibmvtpm_crq_get_next(ibmvtpm)) != NULL) {
>   		ibmvtpm_crq_process(crq, ibmvtpm);
> +		wake_up_interruptible(&ibmvtpm->crq_queue.wq);
>   		crq->valid = 0;
>   		smp_wmb();
>   	}
> @@ -618,6 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   	}
>
>   	crq_q->num_entry = CRQ_RES_BUF_SIZE / sizeof(*crq_q->crq_addr);
> +	init_waitqueue_head(&crq_q->wq);
>   	ibmvtpm->crq_dma_handle = dma_map_single(dev, crq_q->crq_addr,
>   						 CRQ_RES_BUF_SIZE,
>   						 DMA_BIDIRECTIONAL);
> @@ -670,6 +672,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   	if (rc)
>   		goto init_irq_cleanup;
>
> +	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
> +				ibmvtpm->rtce_buf != NULL,
> +				HZ)) {
> +		dev_err(dev, "Initialization failed\n");
> +		goto init_irq_cleanup;
> +	}
> +
>   	return tpm_chip_register(chip);
>   init_irq_cleanup:
>   	do {
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> index 7983f1a33267..b92aa7d3e93e 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -26,6 +26,7 @@ struct ibmvtpm_crq_queue {
>   	struct ibmvtpm_crq *crq_addr;
>   	u32 index;
>   	u32 num_entry;
> +	wait_queue_head_t wq;
>   };
>
>   struct ibmvtpm_dev {

Acked-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

      - Nayna


