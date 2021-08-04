Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8383DFB13
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 07:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhHDFb0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 01:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232010AbhHDFbZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 01:31:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17454JtB105733;
        Wed, 4 Aug 2021 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NblZU99XF51OF6LVM6E3ZmyfEhrdUxiEedGEnfofF/E=;
 b=joWxsMl6UP9DdNm0KBnuJZ/ekpPhY/3LzOjDbLmc4LsWRCY8z5IUYURO/5/gZq5VFPWt
 vQXSZj3sOzY69I/Min3goGBtNy5LagswcvI14nS5j1BkAKKMeoOhQuibLVyEMV7jsY2m
 IZda102KHM6rfM3gkRAOvf4Of9N6sGeqF2MpohzUDJbJLZa8QjO9YZe/+E8OGmk3YLTz
 QDLIv891c896sioBi1jlnHZeZY+xzYXGofSiJTlyFzFDtISEojB+EF+In5tAJinKVZuU
 r/2HgAbdXFSoKrXlqztvRKHhmQuKIaDW2j7RIfPUidd77hoZae1Zihkngn4e6kSxEgU4 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r5vtf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 01:31:12 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17454WYB106529;
        Wed, 4 Aug 2021 01:31:12 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r5vted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 01:31:12 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1745IUAP015553;
        Wed, 4 Aug 2021 05:31:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3a4x58qmvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 05:31:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1745V61N56230364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Aug 2021 05:31:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8A2A405C;
        Wed,  4 Aug 2021 05:31:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7F76A4054;
        Wed,  4 Aug 2021 05:31:01 +0000 (GMT)
Received: from Nageswaras-MacBook-Pro-2.local (unknown [9.211.35.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Aug 2021 05:31:01 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>, jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210803202622.1537040-1-stefanb@linux.vnet.ibm.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
Message-ID: <59736f0a-6090-2e95-805c-1f38b2c09d0c@linux.ibm.com>
Date:   Wed, 4 Aug 2021 11:00:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210803202622.1537040-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _vh0e6afxLKgUFxjHQZPh-Mhef-YGB6H
X-Proofpoint-ORIG-GUID: 585esrirbLpr7a1ucgYsf_uJ0By8zyIq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-04_01:2021-08-03,2021-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108040027
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 04/08/21 1:56 am, Stefan Berger wrote:
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
>                                 !ibmvtpm->tpm_processing_cmd);
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

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

Tested the patch applying on kernel version 5.14.0-rc3

1. Ran with recreate commands i.e.
rngd -r /dev/hwrng -t
rngd -r /dev/tpm0 -t

2. Ran the above rngd commands along with "stress-ng - dispatching hogs: 
32 af-alg, 32 bsearch, 32 context, 32 cpu, 32 crypt, 32 hsearch, 32 
longjmp, 32 lsearch, 32 matrix, 32 qsort, 32 str, 32 stream, 32 tsearch, 
32 vecmath, 32 wcs" for 2 hours

Thanks!!
> ---
> 
> v2:
>   - reworded commit text
> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
>   drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
>   2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 903604769de9..5d795866b483 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -106,17 +106,12 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>   {
>   	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>   	u16 len;
> -	int sig;
>   
>   	if (!ibmvtpm->rtce_buf) {
>   		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
>   		return 0;
>   	}
>   
> -	sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> -	if (sig)
> -		return -EINTR;
> -
>   	len = ibmvtpm->res_len;
>   
>   	if (count < len) {
> @@ -220,11 +215,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		return -EIO;
>   	}
>   
> -	if (ibmvtpm->tpm_processing_cmd) {
> +	if ((ibmvtpm->tpm_status & TPM_STATUS_BUSY)) {
>   		dev_info(ibmvtpm->dev,
>   		         "Need to wait for TPM to finish\n");
>   		/* wait for previous command to finish */
> -		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> +		sig = wait_event_interruptible(ibmvtpm->wq,
> +				(ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);
>   		if (sig)
>   			return -EINTR;
>   	}
> @@ -237,7 +233,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   	 * set the processing flag before the Hcall, since we may get the
>   	 * result (interrupt) before even being able to check rc.
>   	 */
> -	ibmvtpm->tpm_processing_cmd = true;
> +	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
>   
>   again:
>   	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
> @@ -255,7 +251,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   			goto again;
>   		}
>   		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
> -		ibmvtpm->tpm_processing_cmd = false;
> +		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>   	}
>   
>   	spin_unlock(&ibmvtpm->rtce_lock);
> @@ -269,7 +265,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
>   
>   static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
>   {
> -	return 0;
> +	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> +
> +	return ibmvtpm->tpm_status;
>   }
>   
>   /**
> @@ -457,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>   	.send = tpm_ibmvtpm_send,
>   	.cancel = tpm_ibmvtpm_cancel,
>   	.status = tpm_ibmvtpm_status,
> -	.req_complete_mask = 0,
> +	.req_complete_mask = TPM_STATUS_BUSY,
>   	.req_complete_val = 0,
>   	.req_canceled = tpm_ibmvtpm_req_canceled,
>   };
> @@ -550,7 +548,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
>   		case VTPM_TPM_COMMAND_RES:
>   			/* len of the data in rtce buffer */
>   			ibmvtpm->res_len = be16_to_cpu(crq->len);
> -			ibmvtpm->tpm_processing_cmd = false;
> +			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
>   			wake_up_interruptible(&ibmvtpm->wq);
>   			return;
>   		default:
> @@ -688,8 +686,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   		goto init_irq_cleanup;
>   	}
>   
> -	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +
> +	if (!strcmp(id->compat, "IBM,vtpm20"))
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	rc = tpm_get_timeouts(chip);
> +	if (rc)
> +		goto init_irq_cleanup;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>   		rc = tpm2_get_cc_attrs_tbl(chip);
>   		if (rc)
>   			goto init_irq_cleanup;
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> index b92aa7d3e93e..252f1cccdfc5 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
>   	wait_queue_head_t wq;
>   	u16 res_len;
>   	u32 vtpm_version;
> -	bool tpm_processing_cmd;
> +	u8 tpm_status;
> +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
>   };
>   
>   #define CRQ_RES_BUF_SIZE	PAGE_SIZE
> 

-- 
Thanks and Regards
R.Nageswara Sastry
