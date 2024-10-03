Return-Path: <linux-integrity+bounces-3734-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480D98F972
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 00:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282701C216C9
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CBA1C2451;
	Thu,  3 Oct 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C7PbHyLO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A013D8B4;
	Thu,  3 Oct 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992780; cv=none; b=VAnqDPlP5anYzZgQo29YktHEtroXlXItEPCPX/k07ND5+I2eETFHFlHKznKumcpj65koDlbE5pUNsbBnX2bKBsG4HjPBIGRn0S1rL2SbOlvINwTwAQR8kKuk5uVyV96DU8rqCYBiqZMeXmZRn4K/HYeWwbif3qobiqyviSNO82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992780; c=relaxed/simple;
	bh=DXiQPQFGLAii9OoUuMKnfZxNEbrbXcqPa+b/Cz27oIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIC/ftKLoYJkabUn7Opc7XqR6Mjhp79SzVM4y6y1wb99JoSjE+GgHv+z3HSo059d9wrEajWqCPv1keb7dOCGuFhO2Gify7KKnE/eHAU9N4miAGqs+NgghexOhCVgIamrDIG5DWkYbEvNIXbGAV8dkeoCTDg90s8WjakHDF5tbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C7PbHyLO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493LqH8P008224;
	Thu, 3 Oct 2024 21:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
	s2ebADmBxOSpgerWxsn6BRwRhzV60VAH6MIONaRo6I=; b=C7PbHyLOjRCQN2a6x
	63UhrW7Nd2YIWjRE+weUUrAlojL0VgCqC8+m/pG8P+wueaxG00ntporBUNLq0ntL
	a7QeUn5D4PEH6eIm+3Bn4I9BV3FfC5NQUBsLGGgwUtrOuyGZ11tN0J9FOTixJJUn
	fCF0tse+9eCaeRy+3Mw2UVGquv1P3fpObnSaoKrrCmWUT6H4q27SWbxc7BLirWkQ
	yGOY8tUGeAS67QD6PN7ca0837jUNovidj+KZSsjE2NmvQNppx7w4QxkFGQ8trw6U
	2SbXjn3/wF/rDQx8Nv0HXqsIdLBxtcXn896a2tuZ/J2o5OURIr5wD3AJGtCyXnwx
	v5I/Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42235ng3r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 21:59:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493LxSHM023695;
	Thu, 3 Oct 2024 21:59:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42235ng3r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 21:59:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493Lr2uf017902;
	Thu, 3 Oct 2024 21:59:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207j8vhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 21:59:27 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493LxR6T42729776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 21:59:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626975805C;
	Thu,  3 Oct 2024 21:59:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DEC758051;
	Thu,  3 Oct 2024 21:59:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 21:59:26 +0000 (GMT)
Message-ID: <3c9a6d63-f892-4809-b48d-5fecc3817ad9@linux.ibm.com>
Date: Thu, 3 Oct 2024 17:59:25 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tpm: Workaround failed command reception on Infineon
 devices
To: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <Zv1810ZfEBEhybmg@earth.li> <Zv19Cc-oTOzv8wVO@earth.li>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <Zv19Cc-oTOzv8wVO@earth.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d7f1eatKKTN1uVldWl1CGjOyYPTapjiB
X-Proofpoint-GUID: 0447JkITXFPppUSK-nB2_wLRnOKZ8xKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410030155



On 10/2/24 1:04 PM, Jonathan McDowell wrote:
> (I'm still in the process of testing this to confirm it fixes the
> errata I've seen, but I wanted to send it out for comments to make sure
> it's a reasonable approach.)
> 
> Some Infineon devices have a issue where the status register will get
> stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around

Did you tell Infineon about it? Maybe they should have a look at their 
firmware.

What are the TPMs in your fleet doing? I heared that some TPMs 
pre-create keys in the background once users requested a few. I would 
try to create a few primary keys with different combination of key flags 
set and in different hierarchies (and flush them) to use up these 
precreated  keys and see whether that leads to any issues with the TIS 
responsiveness once presumably the device starts creating keys in the 
background...

> is to retry the command submission. Add appropriate logic to do this in

I would describe it as 'retrying to set the TPM_STS_COMMAND_READY flag 
on the TIS STS register' because you are not retring a (TPM) command 
submission, like resubmitting a TPM2_PCR_Extend for example.



> the send path.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++++-----
>   drivers/char/tpm/tpm_tis_core.h |  1 +
>   include/linux/tpm.h             |  1 +
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index f6aa0dfadb93..940abd1a868e 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -432,16 +432,27 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>   static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   {
>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int rc, status, burstcnt;
> +	int rc, status, burstcnt, retry;
> +	bool status_fix = test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);

This should probably be moved to the top.
int retry = status_fix ? 3 : 1;

>   	size_t count = 0;
>   	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>   
>   	status = tpm_tis_status(chip);
>   	if ((status & TPM_STS_COMMAND_READY) == 0) {
> -		tpm_tis_ready(chip);
> -		if (wait_for_tpm_stat
> -		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> -		     &priv->int_queue, false) < 0) {
> +		retry = status_fix ? 3 : 1;
> +
> +		while (retry > 0) {
> +			tpm_tis_ready(chip);
> +			if (wait_for_tpm_stat
> +			    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> +			     &priv->int_queue, false) >= 0) {
> +				break;
> +			}
> +
> +			retry--;
> +		}
> +
> +		if (retry == 0) {
>   			rc = -ETIME;
>   			goto out_err;
>   		}
> @@ -1147,6 +1158,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
>   	}
>   
> +	if (priv->manufacturer_id == TPM_VID_IFX)
> +		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
> +
>   	if (is_bsw()) {
>   		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
>   					ILB_REMAP_SIZE);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 13e99cf65efe..f888da57535d 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,6 +89,7 @@ enum tpm_tis_flags {
>   	TPM_TIS_INVALID_STATUS		= 1,
>   	TPM_TIS_DEFAULT_CANCELLATION	= 2,
>   	TPM_TIS_IRQ_TESTED		= 3,
> +	TPM_TIS_STATUS_WORKAROUND	= 4,
>   };
>   
>   struct tpm_tis_data {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..5f4998626a98 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -272,6 +272,7 @@ enum tpm2_cc_attrs {
>   #define TPM_VID_WINBOND  0x1050
>   #define TPM_VID_STM      0x104A
>   #define TPM_VID_ATML     0x1114
> +#define TPM_VID_IFX      0x15D1
>   
>   enum tpm_chip_flags {
>   	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),

