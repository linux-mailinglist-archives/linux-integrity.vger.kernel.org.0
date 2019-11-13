Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297E5FB981
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 21:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfKMUOk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 15:14:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfKMUOg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 15:14:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADKE3aY107295
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:14:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8rphr0ju-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:14:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Nov 2019 20:14:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 20:14:28 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADKERc939190698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 20:14:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08E8A4053;
        Wed, 13 Nov 2019 20:14:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BBD9A4040;
        Wed, 13 Nov 2019 20:14:26 +0000 (GMT)
Received: from dhcp-9-31-103-201.watson.ibm.com (unknown [9.31.103.201])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 20:14:26 +0000 (GMT)
Subject: Re: [PATCH v6 1/3] IMA: Add KEY_CHECK func to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Nov 2019 15:14:26 -0500
In-Reply-To: <20191113184658.2862-2-nramas@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111320-0020-0000-0000-00000385EEA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111320-0021-0000-0000-000021DC00E3
Message-Id: <1573676066.4843.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130165
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 10:46 -0800, Lakshmi Ramasubramanian wrote:
> Measure keys loaded onto any keyring.
> 
> This patch defines a new IMA policy func namely KEY_CHECK to
> measure keys. Updated ima_match_rules() to check for KEY_CHECK
> and ima_parse_rule() to handle KEY_CHECK.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 6 +++++-
>  security/integrity/ima/ima.h         | 1 +
>  security/integrity/ima/ima_main.c    | 7 +++++++
>  security/integrity/ima/ima_policy.c  | 4 +++-
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 29aaedf33246..066d32797500 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,7 +29,7 @@ Description:
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> -				[KEXEC_CMDLINE]
> +				[KEXEC_CMDLINE] [KEY_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> @@ -113,3 +113,7 @@ Description:
>  		Example of appraise rule allowing modsig appended signatures:
>  
>  			appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
> +
> +		Example of measure rule using KEY_CHECK to measure all keys:
> +
> +			measure func=KEY_CHECK
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df4ca482fb53..fe6c698617bd 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -193,6 +193,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
>  	hook(KEXEC_CMDLINE)		\
> +	hook(KEY_CHECK)			\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d7e987baf127..12684e8d7124 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -655,6 +655,13 @@ void process_buffer_measurement(const void *buf, int size,
>  	int action = 0;
>  	u32 secid;
>  
> +	/*
> +	 * If IMA is not yet initialized or IMA policy is empty
> +	 * then there is no need to measure.
> +	 */
> +	if (!ima_policy_flag)
> +		return;
> +

This addition has nothing to do with defining a new IMA hook and
should be a separate patch.  This can be posted independently of this
patch set.

Mimi

>  	/*
>  	 * Both LSM hooks and auxilary based buffer measurements are
>  	 * based on policy.  To avoid code duplication, differentiate
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index f19a895ad7cd..1525a28fd705 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -373,7 +373,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEXEC_CMDLINE) {
> +	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
>  		if ((rule->flags & IMA_FUNC) && (rule->func == func))
>  			return true;
>  		return false;
> @@ -997,6 +997,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = POLICY_CHECK;
>  			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
>  				entry->func = KEXEC_CMDLINE;
> +			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
> +				entry->func = KEY_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)

