Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB73DE1C52
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405193AbfJWNWW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 09:22:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405588AbfJWNWW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 09:22:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDKIxF098905
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:22:20 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtp0u4nkh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:22:20 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 14:22:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 14:22:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NDMDQe131422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:22:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 909A6AE05A;
        Wed, 23 Oct 2019 13:22:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3780AE06A;
        Wed, 23 Oct 2019 13:22:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 13:22:11 +0000 (GMT)
Subject: Re: [PATCH v1 3/6] KEYS: ima hook to measure builtin_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 09:22:11 -0400
In-Reply-To: <20191023001818.3684-4-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102313-0028-0000-0000-000003AE1CDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102313-0029-0000-0000-000024704B61
Message-Id: <1571836931.5104.95.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-10-22 at 17:18 -0700, Lakshmi Ramasubramanian wrote:
> Add a new ima hook to measure keys added to builtin_trusted_keys
> keyring.

There is no IMA hook in this patch.

> 
> Updated ima_match_rules function to handle the new ima hook.
> This is used to determine if ima policy requires measurement
> of keys added to builtin_trusted_keys keyring.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 1 +
>  security/integrity/ima/ima.h         | 1 +
>  security/integrity/ima/ima_api.c     | 1 +
>  security/integrity/ima/ima_policy.c  | 5 ++++-
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index fc376a323908..25566c74e679 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,6 +29,7 @@ Description:
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE]
> +				[BUILTIN_TRUSTED_KEYS]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b6847ee1f47a..0d2908036882 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -189,6 +189,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
>  	hook(KEXEC_CMDLINE)		\
> +	hook(BUILTIN_TRUSTED_KEYS)	\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index f614e22bf39f..cc04706b7e7a 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -175,6 +175,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *	subj,obj, and type: are LSM specific.
>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
>   *	| KEXEC_CMDLINE
> + *	| BUILTIN_TRUSTED_KEYS
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 6df7f641ff66..944636076152 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEXEC_CMDLINE) {
> +	if ((func == KEXEC_CMDLINE) || (func == BUILTIN_TRUSTED_KEYS)) {
>  		if ((rule->flags & IMA_FUNC) && (rule->func == func))
>  			return true;
>  		return false;
> @@ -959,6 +959,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = POLICY_CHECK;
>  			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
>  				entry->func = KEXEC_CMDLINE;
> +			else if (strcmp(args[0].from,
> +					"BUILTIN_TRUSTED_KEYS") == 0)
> +				entry->func = BUILTIN_TRUSTED_KEYS;
>  			else
>  				result = -EINVAL;
>  			if (!result)

Any new options need to be displayed as well.

Mimi

