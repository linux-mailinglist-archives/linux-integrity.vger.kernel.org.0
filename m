Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2203E5325
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 07:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhHJF6u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 01:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231716AbhHJF6t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 01:58:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A5Y6He090552;
        Tue, 10 Aug 2021 01:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3MmnVrdD1xqpcE8h5t331LzNT9phObbJHwZanysa7EU=;
 b=PTkkDtgz+Xfu/ct4nDcLhZU7dNiy4jRc1hDpBT+BasBBJTbnBEgTCFo+4CBlsy5Id38y
 zMXbfl9D+k++gZxfms129hd5MLGW1adBiaI4h6s2k7cJZ67OdeJnMvTqRDo63yVsKU/g
 k6vv7abIrJ4NNthbsjFMdOFy2v0iv7G6tJQEJMRNoQxlq0/aq/7h+YxtRzsvePzzABsw
 UOK5Lz3cI4mdfbVDOlMjTWv0SeVTDf8Z/xA1NhGCELYOUuVLxNr1unetLDtrh0J3oENu
 1f83SQJF7dPE6Fuu1CjcNd+ulH9Zlzj8NaMDo5UjR6EG1aIrSH2jRFGEGD+V8WMbHMcp Sg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abg7kc11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 01:58:26 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17A5s7QH031773;
        Tue, 10 Aug 2021 05:58:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3a9hehdape-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 05:58:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17A5wJGP59638116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 05:58:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE273AE04D;
        Tue, 10 Aug 2021 05:58:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CF6AE051;
        Tue, 10 Aug 2021 05:58:17 +0000 (GMT)
Received: from Nageswaras-MacBook-Pro-2.local (unknown [9.43.76.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Aug 2021 05:58:17 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] tpm: ibmvtpm: Avoid error message when process
 gets signal while waiting
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>, jarkko@kernel.org
Cc:     nasastry@in.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-2-stefanb@linux.vnet.ibm.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
Message-ID: <0047b861-c660-e126-a198-ebe77ca3c057@linux.ibm.com>
Date:   Tue, 10 Aug 2021 11:28:15 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210809192159.2176580-2-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b3fLbRVj6INsErUfUPsbGL-BDpSqQCBz
X-Proofpoint-ORIG-GUID: b3fLbRVj6INsErUfUPsbGL-BDpSqQCBz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_01:2021-08-06,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100034
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/08/21 12:51 am, Stefan Berger wrote:
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
> sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> 
> Rather than waiting for the response in the low level driver, have it use
> the polling loop in tpm_try_transmit() that uses a command's duration to
> poll until a result has been returned by the TPM, thus ending when the
> timeout has occurred but not responding to signals and ctrl-c anymore. To
> stay in this polling loop extend tpm_ibmvtpm_status() to return
> 'true' for as long as the vTPM is indicated as being busy in
> tpm_processing_cmd. Since the loop requires the TPM's timeouts, get them
> now using tpm_get_timeouts() after setting the TPM2 version flag on the
> chip.
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


Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

Tested with /dev/hwrng and /dev/tpm0 and not seen any tpm errors from 
the kernel.

> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 20 ++++++++++++--------
>   drivers/char/tpm/tpm_ibmvtpm.h |  2 +-
>   2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 903604769de9..7a9eca5768f8 100644
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
> @@ -269,7 +264,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
>   
>   static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
>   {
> -	return 0;
> +	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> +
> +	return ibmvtpm->tpm_processing_cmd;
>   }
>   
>   /**
> @@ -457,7 +454,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>   	.send = tpm_ibmvtpm_send,
>   	.cancel = tpm_ibmvtpm_cancel,
>   	.status = tpm_ibmvtpm_status,
> -	.req_complete_mask = 0,
> +	.req_complete_mask = true,
>   	.req_complete_val = 0,
>   	.req_canceled = tpm_ibmvtpm_req_canceled,
>   };
> @@ -688,8 +685,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
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
> index b92aa7d3e93e..51198b137461 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.h
> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> @@ -41,7 +41,7 @@ struct ibmvtpm_dev {
>   	wait_queue_head_t wq;
>   	u16 res_len;
>   	u32 vtpm_version;
> -	bool tpm_processing_cmd;
> +	u8 tpm_processing_cmd;
>   };
>   
>   #define CRQ_RES_BUF_SIZE	PAGE_SIZE
> 

-- 
Thanks and Regards
R.Nageswara Sastry
