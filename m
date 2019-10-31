Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242D3EAFDE
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 13:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJaMLC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 08:11:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfJaMLC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 08:11:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCAWvC139442
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:11:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyxn2hpy2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 08:11:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 12:10:58 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 12:10:54 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VCAruh55115786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 12:10:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7908B4C05A;
        Thu, 31 Oct 2019 12:10:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D764C046;
        Thu, 31 Oct 2019 12:10:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.194.174])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 12:10:52 +0000 (GMT)
Subject: Re: [PATCH v3 3/9] KEYS: Added KEYRING_CHECK policy for key
 measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Date:   Thu, 31 Oct 2019 08:10:51 -0400
In-Reply-To: <20191031011910.2574-4-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19103112-0016-0000-0000-000002BF7A2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103112-0017-0000-0000-00003320DD85
Message-Id: <1572523851.5028.45.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> An IMA policy to manage measurement of keys is not supported.
> A new IMA policy is needed to manage the measurement of keys.
> A policy option is also needed to allow measurement of keys
> linked to a given set of keyrings only.
> 
> This patch defines KEYRING_CHECK and keyrings in IMA policy
> for this purpose. 

"KEYRING_CHECK" and "keyrings" are not related.   One is a "func"
name, while the other is an IMA policy option.  This should be broken
up into two different patches.  When defining a new policy option, the
only code in that patch should be the new policy option.

> 
> KEYRING_CHECK can be added in the IMA policy to measure keys.
> keyrings can be, optionally, set to only measure keys
> added or updated to a given set of keyrings. If keyrings is not
> specified for KEYRING_CHECK, keys added or updated in
> all keyrings are measured.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 15 +++++++++++++++
>  security/integrity/ima/ima.h         |  1 +
>  security/integrity/ima/ima_main.c    |  2 +-
>  security/integrity/ima/ima_policy.c  |  2 +-
>  security/integrity/ima/ima_queue.c   |  2 +-
>  5 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index fc376a323908..757faf1a1a27 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,10 +25,12 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> +				[keyrings=]
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE]
> +				[KEYRING_CHECK]

This patch is measuring keys, not keyrings.


>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> @@ -38,6 +40,9 @@ Description:
>  			fowner:= decimal value
>  		lsm:  	are LSM specific
>  		option:	appraise_type:= [imasig]
> +			keyrings: = list of keyrings to measure
> +			(eg, .builtin_trusted_keys|.ima). Only valid
> +			when action is "measure" and func is KEYRING_CHECK.
>  			template:= name of a defined IMA template type
>  			(eg, ima-ng). Only valid when action is "measure".
>  			pcr:= decimal value
> @@ -105,3 +110,13 @@ Description:
>  
>  			measure func=KEXEC_KERNEL_CHECK pcr=4
>  			measure func=KEXEC_INITRAMFS_CHECK pcr=5
> +
> +		Example of measure rules using KEYRING_CHECK
> +			To measure keys added to
> +			.builtin_trusted_keys or .ima keyring:
> +
> +			measure func=KEYRING_CHECK keyrings=.builtin_trusted_keys|.ima
> +
> +			To measure keys added to all keyrings:
> +
> +			measure func=KEYRING_CHECK

The patch that introduces the new IMA "func" should document the new
IMA "func".  The patch that introduces the new "keyring=" policy
option should document the new IMA policy option.  Examples could be
included in each of the patches descriptions.


> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b9600070e415..12e9ec6847b5 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -191,6 +191,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
>  	hook(KEXEC_CMDLINE)		\
> +	hook(KEYRING_CHECK)		\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 18e1bc105be7..72ae0878ec5d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -718,7 +718,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	pk = key->payload.data[asym_crypto];
>  	process_buffer_measurement(pk->key, pk->keylen,
>  				   keyring->description,
> -				   NONE, 0);
> +				   KEYRING_CHECK, 0);
>  }
>  
>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 6df7f641ff66..0cc49f2d5233 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if (func == KEXEC_CMDLINE) {
> +	if ((func == KEXEC_CMDLINE) || (func == KEYRING_CHECK)) {
>  		if ((rule->flags & IMA_FUNC) && (rule->func == func))
>  			return true;
>  		return false;
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index f2503f10abf4..5625381c5a97 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -317,7 +317,7 @@ void ima_measure_queued_keys(void)
>  		process_buffer_measurement(entry->public_key,
>  					   entry->public_key_len,
>  					   entry->keyring_name,
> -					   NONE, 0);
> +					   KEYRING_CHECK, 0);

Changing a newly defined call should be an indication that the patch
ordering is wrong.  If the new "func" was defined prior or with the
new IMA hook, then this change wouldn't be needed.

Mimi


>  		list_del(&entry->list);
>  		ima_free_measure_key_entry(entry);
>  	}

