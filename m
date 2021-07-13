Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF363C699D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 07:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhGMFGC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jul 2021 01:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229470AbhGMFGC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jul 2021 01:06:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D4XlNc007476;
        Tue, 13 Jul 2021 01:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wqKVoTRr+k23xUFNBdiIsKFxsmSm7+BEJ5SMeUvMSTM=;
 b=q6ZK57uPMY7jg5pGBATsCrzvhEpZWmQgF0qoA0BpOG7EA3Rvtwv6ynbnfwgxW+wy8WsJ
 vqOoj6k4EHl6fSZvDPWGcRtLPhj9VGIxx4lWmQ4jKhiiaG5pbu13QxWA9aHO+1vEaztw
 TKiPZ6/zp3TTBe7yhJbBNVQ6Hq69sYdKrN5uxlyRCiCObpPDRoDYcjj+kJLIS71A8OvY
 ZSkP13X/Lk7C31SDewBt15BkzkJbbMUvSItW/xtC20UpDIdGUppHMT17LmCBYQ8u0rm5
 D5T2WA21AU7JNkQ8i9vllM1I6IejPXSxxHunDWlFhSAAZM/+Qh83IwDsdYopQShOupDj GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs117600-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:03:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D4ZNUm011720;
        Tue, 13 Jul 2021 01:03:11 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs1175yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:03:11 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D539el001337;
        Tue, 13 Jul 2021 05:03:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 39q2th8jfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:03:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D535is16974316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 05:03:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 373ED11C069;
        Tue, 13 Jul 2021 05:03:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9733B11C064;
        Tue, 13 Jul 2021 05:03:03 +0000 (GMT)
Received: from Nageswaras-MacBook-Pro-2.local (unknown [9.199.56.128])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Jul 2021 05:03:03 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
Message-ID: <47827aae-e80a-950d-7dc9-4c1d9803c129@linux.ibm.com>
Date:   Tue, 13 Jul 2021 10:33:02 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rCYGAG9bvFxo2z3RUqEZrfFx_VavlhkG
X-Proofpoint-ORIG-GUID: EmIid8v1OjLvnA9j_LIKHNuCPt49fR0v
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_14:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130022
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 12/07/21 9:55 pm, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> When rngd is run as root then lots of these types of message will appear
> in the kernel log if the TPM has been configure to provide random bytes:
> 
> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> 
> The issue is caused by the following call that is interrupted while
> waiting for the TPM's response.
> 
> sig = wait_event_interruptible(ibmvtpm->wq,
>                                 !ibmvtpm->tpm_processing_cmd);
> 
> The solution is to use wait_event() instead.
> 
> To recreat the issue start rngd like this:
> 
> sudo rngd -r /dev/hwrng -t
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1981473
> Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: George Wilson <gcwilson@linux.ibm.com>
> Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 903604769de9..99b0442a5fdf 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -106,16 +106,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
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
> +	wait_event(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
>   
>   	len = ibmvtpm->res_len;
>   
> @@ -206,7 +203,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   {
>   	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>   	bool retry = true;
> -	int rc, sig;
> +	int rc;
>   
>   	if (!ibmvtpm->rtce_buf) {
>   		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
> @@ -224,9 +221,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		dev_info(ibmvtpm->dev,
>   		         "Need to wait for TPM to finish\n");
>   		/* wait for previous command to finish */
> -		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
> -		if (sig)
> -			return -EINTR;
> +		wait_event(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
>   	}
>   
>   	spin_lock(&ibmvtpm->rtce_lock);
> @@ -551,7 +546,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
>   			/* len of the data in rtce buffer */
>   			ibmvtpm->res_len = be16_to_cpu(crq->len);
>   			ibmvtpm->tpm_processing_cmd = false;
> -			wake_up_interruptible(&ibmvtpm->wq);
> +			wake_up(&ibmvtpm->wq);
>   			return;
>   		default:
>   			return;
> 

-- 
Thanks and Regards
R.Nageswara Sastry
