Return-Path: <linux-integrity+bounces-5420-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56893A707C3
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556873AB5B1
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29925F98B;
	Tue, 25 Mar 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MZCgjoVe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4825F986;
	Tue, 25 Mar 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922612; cv=none; b=phBxi3S2+xlTfZzLFgB13/MP6AJvSdgoJYIK6wEL5sBuHJnVlxBAc4Zz2EyOXI3DSVaTPZz8Q/cZ5SciTQs0YpAEhTp7vkWJ53XNc+Hy0vX3R5PExhAAc00DQznbpy6TyUjEYBp37MbZBHdLGMCZWO9WyzBnfLKRt3hV2fkcKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922612; c=relaxed/simple;
	bh=w9BBWOgSO/rGkVzgU/ZNodDjACEIv3l9gGHZ2yNZ4Kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6PJcS4OcZNlO/4B6r9XSSvw6QvVtgsIjesG1xLVzdiOpR9Gt0VCrvRpwzJ6bDXsS7itEIm5hNpCzOdkgjAR7C/yqSweGlTgEnecNcvKE5HJTqBLkTCzY/E8V6GhMbA66YQEH2xq6e814/xn/0nKvPcpKXaq9fqwxrPIZ+PMbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MZCgjoVe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9Qx7f024088;
	Tue, 25 Mar 2025 17:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ffp4PO
	3ojizHrqbGvLCBZPWbAyU8EVjNnz0/qg/oYMM=; b=MZCgjoVeNKgKaWIv+9jkVp
	eq281PhuIQaUasCOFkjLqhi2QOIQ6BB1oJFGAz5WWqHlx8gNBs8e+nfgJupKP6ez
	FAbcV6iq9eNwGrC1AKD9wZ4ZFP2I61TtAj/6Rr0G1vvs2T3ybEIp4oSjC7quNTdF
	eJ8F+EV53LEcqQA/p+RkcPsX7eUIyGlYV7QWr/fguJ5wle2EziPcY+cyxhgJ66DR
	4EUtr0G9kWvPs8mUGZ1QvMSW+AMQYoar85aVos/j298TdsQXru3g5+Mj4iQcrz5Q
	4fU18vFCO/tffURNtdTqYSlT6dJkQzwQPb71L68FcrU3hj/bk/8xzAQMehV1Gxxw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw25c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:09:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PGrEK4007426;
	Tue, 25 Mar 2025 17:09:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw258-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:09:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PFr3q2025455;
	Tue, 25 Mar 2025 17:09:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x04jct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 17:09:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PH9sSf14549736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 17:09:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE1A58059;
	Tue, 25 Mar 2025 17:09:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70B1658055;
	Tue, 25 Mar 2025 17:09:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.132.195])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 17:09:53 +0000 (GMT)
Message-ID: <3cd5975b7a5773e1d3f1017c35b2e48222eb2d4a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 08/13] ima: track the set of PCRs ever extended
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 25 Mar 2025 13:09:53 -0400
In-Reply-To: <20250323140911.226137-9-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-9-nstange@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7nH4B76iea20nszB2qiZHx8Mze8BcI6Q
X-Proofpoint-GUID: OtCSeARAVbLVoC1eupEewqNkvIguZTV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250119

On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
> Right now, PCR banks with unsupported hash algorithms are getting
> invalidated over and over again for each new measurement list entry
> recorded.
>=20
> A subsequent patch will make IMA to invalidate PCR banks associated with
> unsupported hash algorithms only once at a PCR's first use. To prepare fo=
r
> that, make it track the set of PCRs ever extended.
>=20
> Maintain the set of touched PCRs in an unsigned long bitmask,
> 'ima_extended_pcrs_mask'.
>=20
> Amend the IMA_INVALID_PCR() #define to check that a given PCR can get
> represented in that bitmask. Note that this is only for improving code
> maintainablity, it does not actually constain the set of allowed PCR
> indices any further.
>=20
> Make ima_pcr_extend() to maintain the ima_extended_pcrs_mask, i.e. to set
> the currently extented PCR's corresponding bit.
>=20
> Note that at this point there's no provision to restore the
> ima_extended_pcrs_mask value after kexecs yet, that will be the subject o=
f
> later patches.
>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Hi Nicolai,

IMA extends measurements in the default TPM PCR based on the Kconfig
CONFIG_IMA_MEASURE_PCR_IDX option.  Normally that is set to PCR 10.  The IM=
A
policy rules may override the default PCR with a per policy rule specific P=
CR.

INVALID_PCR() checks the IMA policy rule specified is a valid PCR register.

Is the purpose of this patch to have a single per TPM bank violation or mul=
tiple
violations, one for each PCR used within the TPM bank?

thanks,

Mimi

> ---
>  security/integrity/ima/ima.h       |  8 ++++++--
>  security/integrity/ima/ima_queue.c | 17 +++++++++++++----
>  2 files changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 1158a7b8bf6b..f99b1f81b35c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -20,6 +20,7 @@
>  #include <linux/hash.h>
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
> +#include <linux/minmax.h>
>  #include <crypto/hash_info.h>
> =20
>  #include "../integrity.h"
> @@ -62,6 +63,8 @@ extern int ima_hash_algo_idx __ro_after_init;
>  extern int ima_extra_slots __ro_after_init;
>  extern struct ima_algo_desc *ima_algo_array __ro_after_init;
> =20
> +extern unsigned long ima_extended_pcrs_mask;
> +
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  extern const char boot_aggregate_name[];
> @@ -198,8 +201,9 @@ struct ima_iint_cache {
>  	struct ima_digest_data *ima_hash;
>  };
> =20
> -#define IMA_INVALID_PCR(a) (((a) < 0) || \
> -	(a) >=3D (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
> +#define IMA_INVALID_PCR(a) (((a) < 0) ||				    \
> +	(a) >=3D (8 * min(sizeof_field(struct ima_iint_cache, measured_pcrs), \
> +			sizeof(ima_extended_pcrs_mask))))
> =20
> =20
>  extern struct lsm_blob_sizes ima_blob_sizes;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 0cc1189446a8..6e8a7514d9f6 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -51,6 +51,11 @@ static DEFINE_MUTEX(ima_extend_list_mutex);
>   */
>  static bool ima_measurements_suspended;
> =20
> +/*
> + * Set of PCRs ever extended by IMA.
> + */
> +unsigned long ima_extended_pcrs_mask;
> +
>  /* lookup up the digest value in the hash table, and return the entry */
>  static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  						       int pcr)
> @@ -144,15 +149,19 @@ unsigned long ima_get_binary_runtime_size(void)
> =20
>  static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>  {
> -	int result =3D 0;
> +	int result;
> =20
>  	if (!ima_tpm_chip)
> -		return result;
> +		return 0;
> =20
>  	result =3D tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
> -	if (result !=3D 0)
> +	if (result !=3D 0) {
>  		pr_err("Error Communicating to TPM chip, result: %d\n", result);
> -	return result;
> +		return result;
> +	}
> +
> +	ima_extended_pcrs_mask |=3D BIT(pcr);
> +	return 0;
>  }
> =20
>  /*


