Return-Path: <linux-integrity+bounces-4270-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B679E0DD1
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD6F282583
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B501DF72E;
	Mon,  2 Dec 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dmkMk9/H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619811DF721;
	Mon,  2 Dec 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174756; cv=none; b=saLNSsWzY643xRm6DPdayjJC42SyAid6hzxSAbps4r5gD3OGUW5Nvk1hoHmW8KRtQxYcsUMEDHyxewDdLAoH6kynJUakBvLq5+RwWnw4q05nTOWygZn3jb1W8srMoP5rlb3q5kFKcafagHXqfZs1AE/o9OtwmN53Uvw7FenK/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174756; c=relaxed/simple;
	bh=MxxnESwlAsGsMeRlnLkQOi0jCYp6/OfOZ7tWJhF3Ckk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXU6zSTVqpD8lrYcDgT3u4eyAQE0JMHHgKvVRPGe0sTT0niC9KKZ4LpuRZTaFxaf6ZEHz5y2gEFoKQgE5irZ4RI8LvGUfvtJjusfmuMs+btgES068KtIjRDnT1CN9ji77kBXTvwhshMoB6zJQflYMRqzBCS5t+bBmu12nhdEpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dmkMk9/H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2KKxYX018924;
	Mon, 2 Dec 2024 21:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ee6al
	ndV8Bmp3oPbzutUiJ2uVGMQf+c8oWwwtt5gC8=; b=dmkMk9/HrSKnUTK5eAH1st
	y9XFnBa6YScmytRw2PCRi2c2WAOomwfyimDih7gMOjvg/kiC1fKU366kjnFoLnIo
	on1gtadCDOZue1YjZfsy0B++DMBRFQa3s6wZE3IWhkk4FlFIPm4+Btq9bUbCDZc6
	HO3HYkpALI2n7C/2xYswgf/o2EDKFiFT6XrnCefr/DkdacJlrUq0E6+0Ermf7koL
	hNNPeQyRs/pUItvX6hpBzClaRrlDUNb/HN9JywcWLGszslgmTTAIFefVd5wOvHip
	H8XHbzGvGvgY9yIFTJYJFHqYWtmE41S/wDSCjopiq8Gcy6ECQrFiB8WUM0NI2iTg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgfkec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 21:25:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2L8P5U029494;
	Mon, 2 Dec 2024 21:25:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddy9t65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 21:25:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2LPfrh25493978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 21:25:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 074FC58058;
	Mon,  2 Dec 2024 21:25:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D02C58059;
	Mon,  2 Dec 2024 21:25:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 21:25:40 +0000 (GMT)
Message-ID: <438e2a17-a16f-4d3d-b115-7ebf625f64fb@linux.ibm.com>
Date: Mon, 2 Dec 2024 16:25:39 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241127210234.121546-1-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241127210234.121546-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SqRqmUuEhqHtH963Ye3lgk4gq9G0CJco
X-Proofpoint-GUID: SqRqmUuEhqHtH963Ye3lgk4gq9G0CJco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020177



On 11/27/24 4:02 PM, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution integrity is optionally enforced by the interpreter.
> 
> Update the audit messages to differentiate between kernel and userspace
> enforced integrity.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima_appraise.c | 84 ++++++++++++++++++++-------
>   security/integrity/ima/ima_main.c     | 22 +++++++
>   2 files changed, 86 insertions(+), 20 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 656c709b974f..b5f8e49cde9d 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -8,6 +8,7 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/file.h>
> +#include <linux/binfmts.h>
>   #include <linux/fs.h>
>   #include <linux/xattr.h>
>   #include <linux/magic.h>
> @@ -16,6 +17,7 @@
>   #include <linux/fsverity.h>
>   #include <keys/system_keyring.h>
>   #include <uapi/linux/fsverity.h>
> +#include <linux/securebits.h>
>   
>   #include "ima.h"
>   
> @@ -276,7 +278,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
>    */
>   static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   			struct evm_ima_xattr_data *xattr_value, int xattr_len,
> -			enum integrity_status *status, const char **cause)
> +			enum integrity_status *status, const char **cause,
> +			bool is_check)
>   {
>   	struct ima_max_digest_data hash;
>   	struct signature_v2_hdr *sig;
> @@ -292,9 +295,11 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   		if (*status != INTEGRITY_PASS_IMMUTABLE) {
>   			if (iint->flags & IMA_DIGSIG_REQUIRED) {
>   				if (iint->flags & IMA_VERITY_REQUIRED)
> -					*cause = "verity-signature-required";
> +					*cause = !is_check ? "verity-signature-required" :
> +						"verity-signature-required(userspace)";
>   				else
> -					*cause = "IMA-signature-required";
> +					*cause = !is_check ? "IMA-signature-required" :
> +						"IMA-signature-required(userspace)";
>   				*status = INTEGRITY_FAIL;
>   				break;
>   			}
> @@ -314,7 +319,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   		else
>   			rc = -EINVAL;
>   		if (rc) {
> -			*cause = "invalid-hash";
> +			*cause = !is_check ? "invalid-hash" :
> +				"invalid-hash(userspace)";
>   			*status = INTEGRITY_FAIL;
>   			break;
>   		}
> @@ -325,14 +331,16 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   
>   		mask = IMA_DIGSIG_REQUIRED | IMA_VERITY_REQUIRED;
>   		if ((iint->flags & mask) == mask) {
> -			*cause = "verity-signature-required";
> +			*cause = !is_check ? "verity-signature-required" :
> +				"verity-signature-required(userspace)";
>   			*status = INTEGRITY_FAIL;
>   			break;
>   		}
>   
>   		sig = (typeof(sig))xattr_value;
>   		if (sig->version >= 3) {
> -			*cause = "invalid-signature-version";
> +			*cause = !is_check ? "invalid-signature-version" :
> +				"invalid-signature-version(userspace)";
>   			*status = INTEGRITY_FAIL;
>   			break;
>   		}
> @@ -353,7 +361,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   						     iint->ima_hash->digest,
>   						     iint->ima_hash->length);
>   		if (rc) {
> -			*cause = "invalid-signature";
> +			*cause = !is_check ? "invalid-signature" :
> +				"invalid-signature(userspace)";
>   			*status = INTEGRITY_FAIL;
>   		} else {
>   			*status = INTEGRITY_PASS;
> @@ -364,7 +373,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   
>   		if (iint->flags & IMA_DIGSIG_REQUIRED) {
>   			if (!(iint->flags & IMA_VERITY_REQUIRED)) {
> -				*cause = "IMA-signature-required";
> +				*cause = !is_check ? "IMA-signature-required" :
> +					"IMA-signature-required(userspace)";
>   				*status = INTEGRITY_FAIL;
>   				break;
>   			}
> @@ -372,7 +382,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   
>   		sig = (typeof(sig))xattr_value;
>   		if (sig->version != 3) {
> -			*cause = "invalid-signature-version";
> +			*cause = !is_check ? "invalid-signature-version" :
> +				"invalid-signature-version(userspace)";
>   			*status = INTEGRITY_FAIL;
>   			break;
>   		}
> @@ -382,7 +393,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   				       container_of(&hash.hdr,
>   					       struct ima_digest_data, hdr));
>   		if (rc) {
> -			*cause = "sigv3-hashing-error";
> +			*cause = !is_check ? "sigv3-hashing-error" :
> +				"sigv3-hashing-error(userspace)";
>   			*status = INTEGRITY_FAIL;
>   			break;
>   		}
> @@ -392,7 +404,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   					     xattr_len, hash.digest,
>   					     hash.hdr.length);
>   		if (rc) {
> -			*cause = "invalid-verity-signature";
> +			*cause = !is_check ? "invalid-verity-signature" :
> +				"invalid-verify-signature(userspace)";
>   			*status = INTEGRITY_FAIL;
>   		} else {
>   			*status = INTEGRITY_PASS;
> @@ -401,7 +414,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   		break;
>   	default:
>   		*status = INTEGRITY_UNKNOWN;
> -		*cause = "unknown-ima-data";
> +		*cause = !is_check ? "unknown-ima-data" :
> +			"unknown-ima-data(userspace)";
>   		break;
>   	}
>   
> @@ -469,6 +483,18 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
>   	return rc;
>   }
>   
> +static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)

is_check is bool, so this should probably also return bool

> +{
> +	struct linux_binprm *bprm = NULL;
> +
> +	if (func == BPRM_CHECK) {
> +		bprm = container_of(&file, struct linux_binprm, file);
> +		if (bprm->is_check)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>   /*
>    * ima_appraise_measurement - appraise file measurement
>    *
> @@ -489,11 +515,24 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>   	enum integrity_status status = INTEGRITY_UNKNOWN;
>   	int rc = xattr_len;
>   	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
> +	bool is_check = false;

no need to initialize it


