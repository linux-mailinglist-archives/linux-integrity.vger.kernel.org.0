Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD40AF968B
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKLRFQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:05:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfKLRFP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACGvh15143033
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:14 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7yxujb2v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:13 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:05:11 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:05:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACH57BA60686580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:05:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED2CEAE055;
        Tue, 12 Nov 2019 17:05:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D805EAE045;
        Tue, 12 Nov 2019 17:05:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:05:05 +0000 (GMT)
Subject: Re: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to
 only measure keys added to the specified keyrings.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 12:05:05 -0500
In-Reply-To: <20191111193303.12781-3-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0020-0000-0000-0000038598BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0021-0000-0000-000021DBA39C
Message-Id: <1573578305.17949.42.camel@linux.ibm.com>
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

The C maximum line length is 80 characters.  The subject line is even
less than that (~50).  The Subject line here could be "ima: add
support to limit measuring keys".

On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
> IMA policy needs to support measuring only those keys linked to
> a specific set of keyrings.

Patch descriptions should be written in the imperative.  For example, 
"Limit measuring keys to those keys being loaded onto a specific
keyring."

> 
> This patch defines a new IMA policy option namely "keyrings=" that
> can be used to specify a set of keyrings. If this option is specified
> in the policy for func=KEYRING_CHECK then only the keys linked to
> the keyrings given in "keyrings=" option are measured.

This description does not seem to match the code, which for some
reason isn't included in this patch, nor in 3/10.  Please
combine/squash patches 2 & 3.  Missing from the combined patch is the
keyring matching code in ima_match_rules().

> 
> If "keyrings=" option is not specified for func=KEYRING_CHECK then
> all keys are measured.

The last sentence is unnecessary.  Please remove.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy | 10 +++++++++-
>  security/integrity/ima/ima_policy.c  |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 341df49b5ad1..be2874fa3928 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,7 +25,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> -				[appraise_flag=]
> +				[appraise_flag=] [keyrings=]
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> @@ -43,6 +43,9 @@ Description:
>  			appraise_flag:= [check_blacklist]
>  			Currently, blacklist check is only for files signed with appended
>  			signature.
> +			keyrings:= list of keyrings
> +			(eg, .builtin_trusted_keys|.ima). Only valid
> +			when action is "measure" and func is KEYRING_CHECK.
>  			template:= name of a defined IMA template type
>  			(eg, ima-ng). Only valid when action is "measure".
>  			pcr:= decimal value
> @@ -119,3 +122,8 @@ Description:
>  		all keys:
>  
>  			measure func=KEYRING_CHECK
> +
> +		Example of measure rule using KEYRING_CHECK to only measure
> +		keys added to .builtin_trusted_keys or .ima keyring:
> +
> +			measure func=KEYRING_CHECK keyrings=.builtin_trusted_keys|.ima
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9ca32ffaaa9d..a0f7ffa80736 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -34,6 +34,7 @@
>  #define IMA_EUID	0x0080
>  #define IMA_PCR		0x0100
>  #define IMA_FSNAME	0x0200
> +#define IMA_KEYRINGS	0x0400
>  
>  #define UNKNOWN		0
>  #define MEASURE		0x0001	/* same as IMA_MEASURE */
> @@ -79,6 +80,7 @@ struct ima_rule_entry {
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
> +	char *keyrings; /* Measure keys added to these keyrings */
>  	struct ima_template_desc *template;
>  };
>  

