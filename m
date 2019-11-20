Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538B81046F5
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfKTX2w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 18:28:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTX2w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 18:28:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKNEFri015139;
        Wed, 20 Nov 2019 23:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=CdzZnJKmlnfplz6BPMdnpS6c/iWtIJs6iTnJB7AgV9o=;
 b=sAyr73Gfn7ermabR8UgtIGPg8BygvcGdudjolNDjLLdZVe8bMohMo821wEzlp5O7qSvJ
 6MMRuBuoT2Dskip82x3BLc7Z5MWTM+mDDfgUWRND5fRw8gj1dRCXgcAJf8KRPd93uODA
 kV31hxGtolhIKkxb9UKNQE3Of3Fkw9BaR/R6Rw/UvKrDKsdXuToij/XSRqcnRTrbKyuc
 /rJXjRAI8EBbwleRtPSZhLAsj+c84s732N6uHZevH+NnrFgQyyrA0YWU5lH6OLgDj5BA
 orTxOBzBcgSaR14jVIhejB2aF7lWed0yli8BHRYon6HDIq2EV6dvUGR2vqTvopQcqP++ Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqrnkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 23:28:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKNEHPD130520;
        Wed, 20 Nov 2019 23:28:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wcemjja6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 23:28:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKNSiA8004811;
        Wed, 20 Nov 2019 23:28:45 GMT
Received: from dhcp-10-65-163-83.vpn.oracle.com (/10.65.163.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 15:28:44 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20191118223818.3353-3-nramas@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 16:28:42 -0700
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200196
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200196
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Nov 18, 2019, at 3:38 PM, Lakshmi Ramasubramanian =
<nramas@linux.microsoft.com> wrote:
>=20
> Measure asymmetric keys used for verifying file signatures,
> certificates, etc.
>=20
> This patch defines a new IMA hook namely =
ima_post_key_create_or_update()
> to measure asymmetric keys.
>=20
> The IMA hook is defined in a new file namely ima_asymmetric_keys.c
> which is built only if CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is =
enabled.
>=20
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: James Morris <jamorris@linux.microsoft.com>
> ---
> security/integrity/ima/Makefile              |  1 +
> security/integrity/ima/ima_asymmetric_keys.c | 51 ++++++++++++++++++++
> 2 files changed, 52 insertions(+)
> create mode 100644 security/integrity/ima/ima_asymmetric_keys.c
>=20
> diff --git a/security/integrity/ima/Makefile =
b/security/integrity/ima/Makefile
> index 31d57cdf2421..207a0a9eb72c 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -12,3 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) +=3D ima_appraise.o
> ima-$(CONFIG_IMA_APPRAISE_MODSIG) +=3D ima_modsig.o
> ima-$(CONFIG_HAVE_IMA_KEXEC) +=3D ima_kexec.o
> obj-$(CONFIG_IMA_BLACKLIST_KEYRING) +=3D ima_mok.o
> +obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) +=3D =
ima_asymmetric_keys.o
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c =
b/security/integrity/ima/ima_asymmetric_keys.c
> new file mode 100644
> index 000000000000..f6884641a622
> --- /dev/null
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * File: ima_asymmetric_keys.c
> + *       Defines an IMA hook to measure asymmetric keys on key
> + *       create or update.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <crypto/public_key.h>
> +#include <keys/asymmetric-type.h>
> +#include "ima.h"
> +
> +/**
> + * ima_post_key_create_or_update - measure asymmetric keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key =
*key,
> +				   unsigned long flags, bool create)
> +{
> +	const struct public_key *pk;
> +
> +	/* Only asymmetric keys are handled by this hook. */
> +	if (key->type !=3D &key_type_asymmetric)
> +		return;
> +
> +	/* Get the public_key of the given asymmetric key to measure. */
> +	pk =3D key->payload.data[asym_crypto];
> +
> +	/*
> +	 * keyring->description points to the name of the keyring
> +	 * (such as ".builtin_trusted_keys", ".ima", etc.) to
> +	 * which the given key is linked to.
> +	 *
> +	 * The name of the keyring is passed in the "eventname"
> +	 * parameter to process_buffer_measurement() and is set
> +	 * in the "eventname" field in ima_event_data for
> +	 * the key measurement IMA event.
> +	 */
> +	process_buffer_measurement(pk->key, pk->keylen,
> +				   keyring->description, KEY_CHECK, 0);

I=E2=80=99m interested in using this patch series, however I get the =
following on every boot:

[    1.185105] Loading compiled-in X.509 certificates
[    1.190240] BUG: kernel NULL pointer dereference, address: =
0000000000000000
[    1.191835] #PF: supervisor read access in kernel mode
[    1.193041] #PF: error_code(0x0000) - not-present page
[    1.194224] PGD 0 P4D 0
[    1.194832] Oops: 0000 [#1] SMP PTI
[    1.195654] CPU: 1 PID: 1 Comm: swapper/0 Not tainted =
5.4.0-rc7.imakeys.rc1.x86_64 #1
[    1.197667] Hardware name:=20
[    1.198987] RIP: 0010:ima_match_policy+0x69/0x4e0
[    1.200072] Code: 48 89 45 90 65 48 8b 04 25 28 00 00 00 48 89 45 d0 =
31 c0 4d 85 ff 74 08 e8 94 14 00 00 49 89 07 48 8b 05 8a 43 7f 01 45 31 =
e4 <48> 8b 18 48 39 d8 0f 84 25 02 00 00 41 8d 46 f5 45 89 e0 4c 8b 65
[    1.204401] RSP: 0018:ffffb9f30001bac8 EFLAGS: 00010246
[    1.205622] RAX: 0000000000000000 RBX: ffff9e659de81800 RCX: =
000000000000000c
[    1.207275] RDX: 0000000000000000 RSI: ffffffff9b13cdf8 RDI: =
ffffffff9b13cdf8
[    1.208938] RBP: ffffb9f30001bb48 R08: ffffffff9b529200 R09: =
0000000000000000
[    1.210560] R10: ffff9e6447d06c00 R11: 0000000082c49530 R12: =
0000000000000000
[    1.212279] R13: 0000000000000000 R14: 000000000000000c R15: =
ffffb9f30001bbb0
[    1.213944] FS:  0000000000000000(0000) GS:ffff9e65b7a80000(0000) =
knlGS:0000000000000000
[    1.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.217114] CR2: 0000000000000000 CR3: 000000014240a001 CR4: =
0000000000760ee0
[    1.218734] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[    1.220481] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[    1.222139] PKRU: 55555554
[    1.222749] Call Trace:
[    1.223344]  ? crypto_destroy_tfm+0x5f/0xb0
[    1.224315]  ima_get_action+0x2c/0x30
[    1.225148]  process_buffer_measurement+0x1da/0x230
[    1.226306]  ima_post_key_create_or_update+0x3b/0x40
[    1.227459]  key_create_or_update+0x371/0x5c0
[    1.228494]  load_system_certificate_list+0x99/0xfa
[    1.229588]  ? system_trusted_keyring_init+0xfb/0xfb
[    1.230705]  ? do_early_param+0x95/0x95
[    1.231574]  do_one_initcall+0x4a/0x1fa
[    1.232444]  ? do_early_param+0x95/0x95
[    1.233313]  kernel_init_freeable+0x1c2/0x267
[    1.234300]  ? rest_init+0xb0/0xb0
[    1.235075]  kernel_init+0xe/0x110
[    1.235842]  ret_from_fork+0x24/0x50
[    1.236659] Modules linked in:
[    1.237358] CR2: 0000000000000000
[    1.238112] ---[ end trace 163f3f61dfaef23f ]=E2=80=94


I believe this is because ima_rules used within ima_match_policy has not =
been initialized yet, when process_buffer_measurement is called above.



