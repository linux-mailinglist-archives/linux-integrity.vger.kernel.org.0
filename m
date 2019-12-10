Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73BF119E45
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfLJWnZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 17:43:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbfLJWnY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 17:43:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAMeZBp146397
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:43:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2eu69b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:43:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 10 Dec 2019 22:43:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 22:43:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAMhF5l39190700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 22:43:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FCCCA405E;
        Tue, 10 Dec 2019 22:43:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F9DA4069;
        Tue, 10 Dec 2019 22:43:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Dec 2019 22:43:14 +0000 (GMT)
Subject: Re: [PATCH v10 4/6] KEYS: Call the IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 17:43:13 -0500
In-Reply-To: <20191204224131.3384-5-nramas@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121022-0012-0000-0000-00000373A035
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121022-0013-0000-0000-000021AF748C
Message-Id: <1576017793.4579.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_07:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-04 at 14:41 -0800, Lakshmi Ramasubramanian wrote:
> Call the IMA hook from key_create_or_update() function to measure
> the payload when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update()
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Please Cc the key/keyring maintainers, here, immediately following
your tag.

Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  include/linux/ima.h | 14 ++++++++++++++
>  security/keys/key.c | 10 ++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..3b89136bc218 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -101,6 +101,20 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  {}
>  #endif
>  
> +#if defined(CONFIG_IMA) && defined(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  const void *payload, size_t plen,
> +					  unsigned long flags, bool create);
> +#else
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 const void *payload,
> +						 size_t plen,
> +						 unsigned long flags,
> +						 bool create) {}
> +#endif  /* CONFIG_IMA && CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> +
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct dentry *dentry);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..718bf7217420 100644
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
> +	ima_post_key_create_or_update(keyring, key, payload, plen,
> +				      flags, true);
> +
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
>  error_link_end:
> @@ -965,6 +969,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  	}
>  
>  	key_ref = __key_update(key_ref, &prep);
> +
> +	if (!IS_ERR(key_ref))
> +		ima_post_key_create_or_update(keyring, key,
> +					      payload, plen,
> +					      flags, false);
> +
>  	goto error_free_prep;
>  }
>  EXPORT_SYMBOL(key_create_or_update);

