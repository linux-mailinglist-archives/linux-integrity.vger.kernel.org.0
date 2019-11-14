Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1663EFC94D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 15:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKNOyg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 09:54:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbfKNOyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 09:54:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEEcjgu060815
        for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2019 09:54:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w97g2ctrj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2019 09:54:34 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Nov 2019 14:54:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 14:54:30 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEEsTiB35192900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 14:54:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08DB342041;
        Thu, 14 Nov 2019 14:54:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD0714203F;
        Thu, 14 Nov 2019 14:54:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.133.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 14:54:27 +0000 (GMT)
Subject: Re: [PATCH v7 3/5] KEYS: Call the IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Nov 2019 09:54:27 -0500
In-Reply-To: <20191114031202.18012-4-nramas@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111414-0028-0000-0000-000003B6DFC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111414-0029-0000-0000-00002479EDB6
Message-Id: <1573743267.4793.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 19:12 -0800, Lakshmi Ramasubramanian wrote:
> Call the IMA hook from key_create_or_update function to measure
> the key when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

No need to Cc David Howells on the entire patch set.  Just Cc him,
here, after your tag.

With this patch, keys are now being measured.  With the boot command
line, we can verify the measurement entry against /proc/cmdline.  How
can the key measurement entry be verified?  Please include that
information, here, in this patch description.

Also, can the key data, now included in the measurement list, be used
to verify signatures in the ima-sig or ima-modsig templates?  Is there
a way of correlating a signature with a key?  Perhaps include a
kselftest as an example.

Mimi

> ---
>  include/linux/ima.h | 13 +++++++++++++
>  security/keys/key.c |  7 +++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..0af88b781ab6 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern void ima_kexec_cmdline(const void *buf, int size);
>  
> +#ifdef CONFIG_KEYS
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  unsigned long flags, bool create);
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
> @@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  {}
>  #endif
>  
> +#ifndef CONFIG_KEYS
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 unsigned long flags,
> +						 bool create) {}
> +#endif
> +
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct dentry *dentry);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..a0f1e7b3b8b9 100644
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
> @@ -936,6 +937,8 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	ima_post_key_create_or_update(keyring, key, flags, true);
> +
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
>  error_link_end:
> @@ -965,6 +968,10 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  	}
>  
>  	key_ref = __key_update(key_ref, &prep);
> +
> +	if (!IS_ERR(key_ref))
> +		ima_post_key_create_or_update(keyring, key, flags, false);
> +
>  	goto error_free_prep;
>  }
>  EXPORT_SYMBOL(key_create_or_update);

