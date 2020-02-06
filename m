Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8124B154ABF
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFSFl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 13:05:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727607AbgBFSFl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 13:05:41 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016HoGJr088904
        for <linux-integrity@vger.kernel.org>; Thu, 6 Feb 2020 13:05:40 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nnfcbym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 06 Feb 2020 13:05:40 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Feb 2020 18:05:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 18:05:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 016I5V6m60293334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 18:05:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C3ED4204F;
        Thu,  6 Feb 2020 18:05:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E201E4204B;
        Thu,  6 Feb 2020 18:05:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 18:05:29 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] ima: Implement support for uncompressed module
 appended signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Feb 2020 13:05:29 -0500
In-Reply-To: <20200206164226.24875-2-eric.snowberg@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <20200206164226.24875-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020618-0028-0000-0000-000003D8136F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020618-0029-0000-0000-0000249C766C
Message-Id: <1581012329.5585.439.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Thu, 2020-02-06 at 11:42 -0500, Eric Snowberg wrote:
> Currently IMA can validate compressed modules containing appended
> signatures.  This adds the ability to also validate uncompressed
> modules when appraise_type=imasig|modsig.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Your patch description in no way matches the code.

Mimi

> ---
>  security/integrity/digsig.c           | 9 +++++++--
>  security/integrity/ima/ima_appraise.c | 3 +++
>  security/integrity/integrity.h        | 3 ++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index ea1aae3d07b3..5e0c4d04ab9d 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -15,6 +15,7 @@
>  #include <linux/key-type.h>
>  #include <linux/digsig.h>
>  #include <linux/vmalloc.h>
> +#include <linux/verification.h>
>  #include <crypto/public_key.h>
>  #include <keys/system_keyring.h>
>  
> @@ -31,6 +32,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>  	".ima",
>  #endif
>  	".platform",
> +	".builtin_trusted_keys",
>  };
>  
>  #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> @@ -45,8 +47,11 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (!keyring[id]) {
> -		keyring[id] =
> -			request_key(&key_type_keyring, keyring_name[id], NULL);
> +		if (id == INTEGRITY_KEYRING_KERNEL)
> +			keyring[id] = VERIFY_USE_SECONDARY_KEYRING;
> +		else
> +			keyring[id] = request_key(&key_type_keyring,
> +						  keyring_name[id], NULL);
>  		if (IS_ERR(keyring[id])) {
>  			int err = PTR_ERR(keyring[id]);
>  			pr_err("no %s keyring: %d\n", keyring_name[id], err);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 300c8d2943c5..4c009c55d620 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -294,6 +294,9 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
>  	    func == KEXEC_KERNEL_CHECK)
>  		rc = integrity_modsig_verify(INTEGRITY_KEYRING_PLATFORM,
>  					     modsig);
> +	if (rc && func == MODULE_CHECK)
> +		rc = integrity_modsig_verify(INTEGRITY_KEYRING_KERNEL, modsig);
> +
>  	if (rc) {
>  		*cause = "invalid-signature";
>  		*status = INTEGRITY_FAIL;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 73fc286834d7..63f0e6bff0e0 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -145,7 +145,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1
>  #define INTEGRITY_KEYRING_PLATFORM	2
> -#define INTEGRITY_KEYRING_MAX		3
> +#define INTEGRITY_KEYRING_KERNEL	3
> +#define INTEGRITY_KEYRING_MAX		4
>  
>  extern struct dentry *integrity_dir;
>  

