Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECD101092
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2019 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSBSW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 20:18:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKSBSW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 20:18:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ1EP2U143257;
        Tue, 19 Nov 2019 01:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=FsCCQswC9SuVklJ/oITFrxqlPA44T9913q5BFRfQ9WE=;
 b=STDeXyCddcUYVPpRD1nWEi/ilUTPE5SnNeBXLj4cK170Sw8JPE7C+ZH70E9XyR3VNXcz
 t81129XQzCYLAPSksj4/xRCK5K5X4lkBy60O4laKsg2Q4C+BpUhjvV2AXGyJ3ceNIpxs
 AsrvF003r/lCQRK4Stllh68pV6zaD1niQgZfer49kva7o+2RXa86fJ3AFHZyI75dht6h
 MRN6XsHYqokn6Jj3X07tRRYNOXWydpcKLGeqLNX2qwSg+DNBs5ADagf/nz9Hr+iqs9fU
 qgAZPSwNH4F98KFi4N8UMtSxXW4orJqxWhCNBKIV9hou4Mwnb4J1JTXMGzkFSH6Auau+ vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92pkry4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 01:18:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ1IGgn165387;
        Tue, 19 Nov 2019 01:18:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wbxm3dwc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 01:18:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ1IF59023884;
        Tue, 19 Nov 2019 01:18:15 GMT
Received: from dhcp-10-65-168-150.vpn.oracle.com (/10.65.168.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 17:18:15 -0800
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v8 3/5] KEYS: Call the IMA hook to measure keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20191118223818.3353-4-nramas@linux.microsoft.com>
Date:   Mon, 18 Nov 2019 18:18:13 -0700
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <886A71DC-B2B9-4C25-90D6-511E86F2CA19@oracle.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-4-nramas@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190008
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Nov 18, 2019, at 3:38 PM, Lakshmi Ramasubramanian =
<nramas@linux.microsoft.com> wrote:
>=20
> Call the IMA hook from key_create_or_update function to measure
> the key when a new key is created or an existing key is updated.
>=20
> This patch adds the call to the IMA hook from key_create_or_update
> function to measure the key on key create or update.
>=20
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: James Morris <jamorris@linux.microsoft.com>
> ---
> include/linux/ima.h | 13 +++++++++++++
> security/keys/key.c |  7 +++++++
> 2 files changed, 20 insertions(+)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..6b0824b7a32f 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,6 +25,12 @@ extern int ima_post_read_file(struct file *file, =
void *buf, loff_t size,
> extern void ima_post_path_mknod(struct dentry *dentry);
> extern void ima_kexec_cmdline(const void *buf, int size);
>=20
> +#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +extern void ima_post_key_create_or_update(struct key *keyring,
> +					  struct key *key,
> +					  unsigned long flags, bool =
create);
> +#endif

The extern void ima_post_key_create_or_update will only be defined if =
CONFIG_IMA=3Dy.

> +
> #ifdef CONFIG_IMA_KEXEC
> extern void ima_add_kexec_buffer(struct kimage *image);
> #endif
> @@ -101,6 +107,13 @@ static inline void ima_add_kexec_buffer(struct =
kimage *image)
> {}
> #endif
>=20
> +#ifndef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +static inline void ima_post_key_create_or_update(struct key *keyring,
> +						 struct key *key,
> +						 unsigned long flags,
> +						 bool create) {}
> +#endif
> +
> #ifdef CONFIG_IMA_APPRAISE
> extern bool is_ima_appraise_enabled(void);
> extern void ima_inode_post_setattr(struct dentry *dentry);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..a0f1e7b3b8b9 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,6 +13,7 @@
> #include <linux/security.h>
> #include <linux/workqueue.h>
> #include <linux/random.h>
> +#include <linux/ima.h>
> #include <linux/err.h>
> #include "internal.h"
>=20
> @@ -936,6 +937,8 @@ key_ref_t key_create_or_update(key_ref_t =
keyring_ref,
> 		goto error_link_end;
> 	}
>=20
> +	ima_post_key_create_or_update(keyring, key, flags, true);

This will cause a compile error if CONFIG_IMA is not defined and =
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy.

security/keys/key.c: In function 'key_create_or_update':
security/keys/key.c:940:2: error: implicit declaration of function =
'ima_post_key_create_or_update'; did you mean 'key_create_or_update'? =
[-Werror=3Dimplicit-function-declaration]
  ima_post_key_create_or_update(keyring, key, flags, true);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  key_create_or_update
cc1: some warnings being treated as errors


> +
> 	key_ref =3D make_key_ref(key, is_key_possessed(keyring_ref));
>=20
> error_link_end:
> @@ -965,6 +968,10 @@ key_ref_t key_create_or_update(key_ref_t =
keyring_ref,
> 	}
>=20
> 	key_ref =3D __key_update(key_ref, &prep);
> +
> +	if (!IS_ERR(key_ref))
> +		ima_post_key_create_or_update(keyring, key, flags, =
false);
> +
> 	goto error_free_prep;
> }
> EXPORT_SYMBOL(key_create_or_update);
> --=20
> 2.17.1
>=20

