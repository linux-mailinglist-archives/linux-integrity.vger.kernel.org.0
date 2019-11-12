Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7AF9686
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfKLRFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:05:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbfKLRFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACGvjH6127765
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7xmrnn85-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:05:01 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:04:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACH4wwf40960480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:04:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9F5111C050;
        Tue, 12 Nov 2019 17:04:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9898311C04A;
        Tue, 12 Nov 2019 17:04:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:04:56 +0000 (GMT)
Subject: Re: [PATCH v5 01/10] IMA: Added KEYRING_CHECK func in IMA policy to
 measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 12:04:56 -0500
In-Reply-To: <20191111193303.12781-2-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0012-0000-0000-000003630ADF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0013-0000-0000-0000219E7C21
Message-Id: <1573578296.17949.41.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
> IMA policy needs to support a func to enable measurement of
> asymmetric keys.
> 
> This patch defines a new IMA policy func namely KEYRING_CHECK to
> measure asymmetric keys.

This new feature measures "keys" based on policy, not "keyrings".
 Please change the name to KEY_CHECK.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 6 ++++++
>  security/integrity/ima/ima.h         | 1 +
>  security/integrity/ima/ima_policy.c  | 4 +++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 29aaedf33246..341df49b5ad1 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -30,6 +30,7 @@ Description:
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE]
> +				[KEYRING_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> @@ -113,3 +114,8 @@ Description:
>  		Example of appraise rule allowing modsig appended signatures:
>  
>  			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
> +
> +		Example of measure rule using KEYRING_CHECK to measure
> +		all keys:
> +
> +			measure func=KEYRING_CHECK
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df4ca482fb53..7f23405b2718 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -193,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
>  	hook(KEXEC_CMDLINE)		\
> +	hook(KEYRING_CHECK)		\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index f19a895ad7cd..9ca32ffaaa9d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -373,7 +373,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEXEC_CMDLINE) {
> +	if ((func == KEXEC_CMDLINE) || (func == KEYRING_CHECK)) {
>  		if ((rule->flags & IMA_FUNC) && (rule->func == func))
>  			return true;
>  		return false;
> @@ -997,6 +997,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = POLICY_CHECK;
>  			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
>  				entry->func = KEXEC_CMDLINE;
> +			else if (strcmp(args[0].from, "KEYRING_CHECK") == 0)
> +				entry->func = KEYRING_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)




