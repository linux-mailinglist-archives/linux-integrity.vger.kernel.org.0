Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711CEE5479
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJYTki (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:40:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbfJYTkh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:40:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PJXUuM040222
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:40:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv47qpafc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:40:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 20:40:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 20:40:31 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PJeUMc46137518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 19:40:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB325204E;
        Fri, 25 Oct 2019 19:40:30 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 310A25204F;
        Fri, 25 Oct 2019 19:40:29 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on
 key create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Fri, 25 Oct 2019 15:40:28 -0400
In-Reply-To: <20191023233950.22072-2-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102519-0008-0000-0000-00000327A1B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102519-0009-0000-0000-00004A46DA19
Message-Id: <1572032428.4532.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250177
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-23 at 16:39 -0700, Lakshmi Ramasubramanian wrote:
> Defined an ima hook to measure keys created or updated in the system.

"IMA" is an anacronym.  Unless it is a part of a function name, it
should be capitalized.

Before describing "what" you're doing, describe the problem.  For
example, "The asymmetric keys used for verifying file signatures or
certificates are currently not included in the IMA measurement list.
 This patch defines a new IMA hook named ima_key_create_or_update() to
measure keys."

> Call this ima hook from key_create_or_update function when a new key
> is created or an existing key is updated.
> 
> ima hook calls process_buffer_measurement function to measure the key
> if ima is initialized. If ima is not yet initialized, the ima hook
> currently does nothing. The change to queue the key for measurement
> and measure after ima is initialized is implemented in a later patch.

> This patch set depends on the following patch set provided by
> Nayna Jain from IBM (nayna@linux.ibm.com). That patch set is
> currently being reviewed:
> 
> [PATCH v8 5/8] ima: make process_buffer_measurement() generic
> https://lore.kernel.org/linux-integrity/1569594360-7141-7-git-send-email-nayna@linux.ibm.com/

Unnecessary information for this patch.


> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  include/linux/ima.h               |  8 ++++++++
>  security/integrity/ima/ima.h      |  3 +++
>  security/integrity/ima/ima_init.c |  1 +
>  security/integrity/ima/ima_main.c | 26 ++++++++++++++++++++++++++
>  security/keys/key.c               |  9 +++++++++
>  5 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index a20ad398d260..4df39aefcd06 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -24,6 +24,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern void ima_kexec_cmdline(const void *buf, int size);
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  unsigned long flags, bool create);
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -91,6 +94,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  }
>  
>  static inline void ima_kexec_cmdline(const void *buf, int size) {}
> +
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 unsigned long flags,
> +						 bool create) {}
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 997a57137351..2d4130ff5655 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -21,6 +21,8 @@
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
>  #include <crypto/hash_info.h>
> +#include <crypto/public_key.h>
> +#include <keys/asymmetric-type.h>
>  
>  #include "../integrity.h"
>  
> @@ -52,6 +54,7 @@ extern int ima_policy_flag;
>  extern int ima_hash_algo;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
> +extern bool ima_initialized;
>  
>  /* IMA event related data */
>  struct ima_event_data {
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5d55ade5f3b9..52847ce765a4 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -23,6 +23,7 @@
>  /* name for boot aggregate entry */
>  static const char boot_aggregate_name[] = "boot_aggregate";
>  struct tpm_chip *ima_tpm_chip;
> +bool ima_initialized;
>  
>  /* Add the boot aggregate to the IMA measurement list and extend
>   * the PCR register.
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2b60d8fd017a..8bde12385912 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -693,6 +693,32 @@ void ima_kexec_cmdline(const void *buf, int size)
>  	}
>  }
>  
> +/**
> + * ima_post_key_create_or_update - measure keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   unsigned long flags, bool create)
> +{
> +	const struct public_key *pk;
> +
> +	if (key->type != &key_type_asymmetric)
> +		return;
> +
> +	if (!ima_initialized)
> +		return;

There's no reason to define a new variable to determine if IMA is
initialized.  Use ima_policy_flag.  Like process_measurements, the
test should be in process_buffer_measurement(), not here.

> +
> +	pk = key->payload.data[asym_crypto];
> +	process_buffer_measurement(pk->key, pk->keylen,
> +				   key->description,
> +				   NONE, 0);
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..7c39054d8da6 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,6 +13,7 @@
>  #include <linux/security.h>
>  #include <linux/workqueue.h>
>  #include <linux/random.h>
> +#include <linux/ima.h>
>  #include <linux/err.h>
>  #include "internal.h"
>  
> @@ -936,6 +937,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	/* let the ima module know about the created key. */
> +	ima_post_key_create_or_update(keyring, key, flags, true);
> +
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));

This patch defines the new IMA hook.  This call and the subsequent one
below can be defined in a separate patch.  The subject line of that
patch would be "keys: Add ima_key_create_or_update call to measure
keys".

Mimi

>  
>  error_link_end:
> @@ -965,6 +969,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  	}
>  
>  	key_ref = __key_update(key_ref, &prep);
> +	if (!IS_ERR(key_ref)) {
> +		/* let the ima module know about the updated key. */
> +		ima_post_key_create_or_update(keyring, key, flags, false);
> +	}
> +
>  	goto error_free_prep;
>  }
>  EXPORT_SYMBOL(key_create_or_update);

