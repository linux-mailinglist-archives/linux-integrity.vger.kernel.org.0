Return-Path: <linux-integrity+bounces-7187-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3186B89234
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645683A976E
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC2B2E7BC0;
	Fri, 19 Sep 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MX+YY1ql"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAB27E041;
	Fri, 19 Sep 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278783; cv=none; b=WC6s+CNd61cuBT5gpQx61sC77kUg6oT/MvKtVwCNRNRVb9WFbV5nChC0rrwKlLWDGwoa6Cvmbn2NN6/IhtbI8a8yhW1HLJlA/4sBmRrOSPHM7cNLc5uKKezOrg0IwjhDGPGMgRDXe5jycxvn++bZpMSQ2FrulLGMdXSuHJsddhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278783; c=relaxed/simple;
	bh=H+euzww90eYlg4tjh6OlZYZYoFMku+vQdL5X1MCdhls=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ZkKseIlVPK955aJkz6aH//jyB2RVX9MXbokz5llPoWHQWdicHeuYu2eZ7qXmIsmBPahQ0QyZ0y7x2RaaGMuLzVZGVaj2IgvDYEGcj/ZWnS7vnNcID32YURtOhH9X+T2tWBIGqwT/O5YI6cBX6IDPkKD2aRRYVbxgn9op8/yLRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MX+YY1ql; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58INo6bU031341;
	Fri, 19 Sep 2025 10:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LvtQyq
	NFnkwIEdcrMc3wfQKNDwJrJrpPlUFGJSXUEho=; b=MX+YY1qlvGIJx1RyaLX41f
	/fIiHDuWiEoYuPWMILhJOmKokyUTdsEMF715H2XD+GcCuNYs7MSl/6s0TK1/JXkc
	/oKK/9L12OgrFaGdZK69e3JiMSB1pKL28ddGyQ1GG/s6EjufI9pMZwQzYGLCr0G4
	MRP8lG3bK5mlEC9CHvc8icVKRD8JADRm/oTppdnWa0YMcAxqvVCdc4+nRxuKw5Yj
	OrE2hRh7xiDAJa2z5f0XC0ejDloAnGLJQsFyKNjAdDB9Y5tyUOAJ6iIgtrdxcqVN
	eStSy/Ayim/6PKhJJ9ZugO2Oy30vbxIZRgveYkmICpWR3p+xGW3QRkT6ugnA2hJA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j01n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAeLh0004353;
	Fri, 19 Sep 2025 10:45:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j01n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9xnB5027308;
	Fri, 19 Sep 2025 10:45:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menkbfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjBEk13173498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 867BE58052;
	Fri, 19 Sep 2025 10:45:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677BD58056;
	Fri, 19 Sep 2025 10:45:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:10 +0000 (GMT)
Message-ID: <7d598ce0cd3f20be3748030af3c99f0dfb959efd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 02/34] lsm: split the init code out into lsm_init.c
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-38-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-38-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:10 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UT0m9SrmMrwwjNipR2xWnbq4ApRgDIyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2vHxRI3PrSAd
 uODfFlS6VxE5gQzFKKrXVqizyLXuJIWVWHhBpCrjVTMgUZUR5IWRBWc5GmE7StQqxPL8LWApNx3
 91SYtc+30gEsHSKIgqG0ZyHMWmYFUh9mH7wJ4D6ClhHEcktXy3bH0BCQ+VZCWVoOm7X6Pqg2CtQ
 nJ265F/LYy6NMo8JaIWziiJ05lTeTLznqY5C86jzhgf8QuC1mw5S2bs3O72nRwOym3AaFrJ7uh1
 JTK6a3+REi9dO0ZR6pJJCvKSsr1Edr7HX8sVO0eGKLrFiz/7DCZYsZFUgCzzQ1ou16Z7exxhSv3
 t7t2bkA/y2/PBczf7RgCxrn++H+z8zdJDra01ASXjTddA39e9OcX/KYR9MLva3xkDuoy51+f9BE
 QBm9+UQS
X-Proofpoint-GUID: 15WEJLBkm1TL_C6yKDHKweFIP03HbWez
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cd343a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=tGvTcIs_JqF9vkNbAUgA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AULIiLoY-XQsE5F6gcqX:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Continue to pull code out of security/security.c to help improve
> readability by pulling all of the LSM framework initialization
> code out into a new file.
>=20
> No code changes.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  include/linux/lsm_hooks.h |   3 +-
>  security/Makefile         |   2 +-
>  security/lsm.h            |  22 ++
>  security/lsm_init.c       | 543 ++++++++++++++++++++++++++++++++++
>  security/security.c       | 597 +++-----------------------------------
>  5 files changed, 601 insertions(+), 566 deletions(-)
>  create mode 100644 security/lsm.h
>  create mode 100644 security/lsm_init.c
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 79ec5a2bdcca..0112926ed923 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -170,11 +170,10 @@ struct lsm_info {
>  		__used __section(".early_lsm_info.init")		\
>  		__aligned(sizeof(unsigned long))
> =20
> +
>  /* DO NOT tamper with these variables outside of the LSM framework */
>  extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
> -extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> -extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> =20
>  /**
>   * lsm_get_xattr_slot - Return the next available slot and increment the=
 index
> diff --git a/security/Makefile b/security/Makefile
> index 14d87847bce8..4601230ba442 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+=3D lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+=3D min_addr.o
> =20
>  # Object file lists
> -obj-$(CONFIG_SECURITY)			+=3D security.o lsm_notifier.o
> +obj-$(CONFIG_SECURITY)			+=3D security.o lsm_notifier.o lsm_init.o
>  obj-$(CONFIG_SECURITYFS)		+=3D inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/
>  obj-$(CONFIG_SECURITY_SMACK)		+=3D smack/
> diff --git a/security/lsm.h b/security/lsm.h
> new file mode 100644
> index 000000000000..0e1731bad4a7
> --- /dev/null
> +++ b/security/lsm.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM functions
> + */
> +
> +#ifndef _LSM_H_
> +#define _LSM_H_
> +
> +#include <linux/lsm_hooks.h>
> +
> +/* LSM blob configuration */
> +extern struct lsm_blob_sizes blob_sizes;
> +
> +/* LSM blob caches */
> +extern struct kmem_cache *lsm_file_cache;
> +extern struct kmem_cache *lsm_inode_cache;
> +
> +/* LSM blob allocators */
> +int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +int lsm_task_alloc(struct task_struct *task);
> +
> +#endif /* _LSM_H_ */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> new file mode 100644
> index 000000000000..124213b906af
> --- /dev/null
> +++ b/security/lsm_init.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM initialization functions
> + */
> +
> +#define pr_fmt(fmt) "LSM: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/lsm_hooks.h>
> +
> +#include "lsm.h"
> +
> +char *lsm_names;
> +
> +/* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h=
 */
> +extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> +
> +/* Boot-time LSM user choice */
> +static __initconst const char *const builtin_lsm_order =3D CONFIG_LSM;
> +static __initdata const char *chosen_lsm_order;
> +static __initdata const char *chosen_major_lsm;
> +
> +/* Ordered list of LSMs to initialize. */
> +static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> +static __initdata struct lsm_info *exclusive;
> +
> +static __initdata bool debug;
> +#define init_debug(...)							\
> +	do {								\
> +		if (debug)						\
> +			pr_info(__VA_ARGS__);				\
> +	} while (0)
> +
> +static int lsm_append(const char *new, char **result);
> +
> +/* Save user chosen LSM */
> +static int __init choose_major_lsm(char *str)
> +{
> +	chosen_major_lsm =3D str;
> +	return 1;
> +}
> +__setup("security=3D", choose_major_lsm);
> +
> +/* Explicitly choose LSM initialization order. */
> +static int __init choose_lsm_order(char *str)
> +{
> +	chosen_lsm_order =3D str;
> +	return 1;
> +}
> +__setup("lsm=3D", choose_lsm_order);
> +
> +/* Enable LSM order debugging. */
> +static int __init enable_debug(char *str)
> +{
> +	debug =3D true;
> +	return 1;
> +}
> +__setup("lsm.debug", enable_debug);
> +
> +/* Mark an LSM's enabled flag. */
> +static int lsm_enabled_true __initdata =3D 1;
> +static int lsm_enabled_false __initdata =3D 0;
> +static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +{
> +	/*
> +	 * When an LSM hasn't configured an enable variable, we can use
> +	 * a hard-coded location for storing the default enabled state.
> +	 */
> +	if (!lsm->enabled) {
> +		if (enabled)
> +			lsm->enabled =3D &lsm_enabled_true;
> +		else
> +			lsm->enabled =3D &lsm_enabled_false;
> +	} else if (lsm->enabled =3D=3D &lsm_enabled_true) {
> +		if (!enabled)
> +			lsm->enabled =3D &lsm_enabled_false;
> +	} else if (lsm->enabled =3D=3D &lsm_enabled_false) {
> +		if (enabled)
> +			lsm->enabled =3D &lsm_enabled_true;
> +	} else {
> +		*lsm->enabled =3D enabled;
> +	}
> +}
> +
> +static inline bool is_enabled(struct lsm_info *lsm)
> +{
> +	if (!lsm->enabled)
> +		return false;
> +
> +	return *lsm->enabled;
> +}
> +
> +/* Is an LSM already listed in the ordered LSMs list? */
> +static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +{
> +	struct lsm_info **check;
> +
> +	for (check =3D ordered_lsms; *check; check++)
> +		if (*check =3D=3D lsm)
> +			return true;
> +
> +	return false;
> +}
> +
> +/* Append an LSM to the list of ordered LSMs to initialize. */
> +static int last_lsm __initdata;
> +static void __init append_ordered_lsm(struct lsm_info *lsm, const char *=
from)
> +{
> +	/* Ignore duplicate selections. */
> +	if (exists_ordered_lsm(lsm))
> +		return;
> +
> +	if (WARN(last_lsm =3D=3D MAX_LSM_COUNT, "%s: out of LSM static calls!?\=
n", from))
> +		return;
> +
> +	/* Enable this LSM, if it is not already set. */
> +	if (!lsm->enabled)
> +		lsm->enabled =3D &lsm_enabled_true;
> +	ordered_lsms[last_lsm++] =3D lsm;
> +
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +		   is_enabled(lsm) ? "enabled" : "disabled");
> +}
> +
> +/* Is an LSM allowed to be initialized? */
> +static bool __init lsm_allowed(struct lsm_info *lsm)
> +{
> +	/* Skip if the LSM is disabled. */
> +	if (!is_enabled(lsm))
> +		return false;
> +
> +	/* Not allowed if another exclusive LSM already initialized. */
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void __init lsm_set_blob_size(int *need, int *lbs)
> +{
> +	int offset;
> +
> +	if (*need <=3D 0)
> +		return;
> +
> +	offset =3D ALIGN(*lbs, sizeof(void *));
> +	*lbs =3D offset + *need;
> +	*need =3D offset;
> +}
> +
> +static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +{
> +	if (!needed)
> +		return;
> +
> +	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> +	/*
> +	 * The inode blob gets an rcu_head in addition to
> +	 * what the modules might need.
> +	 */
> +	if (needed->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> +		blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> +	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> +	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> +	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> +	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_set_blob_size(&needed->lbs_xattr_count,
> +			  &blob_sizes.lbs_xattr_count);
> +	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> +	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> +	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> +	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> +}
> +
> +/* Prepare LSM for initialization. */
> +static void __init prepare_lsm(struct lsm_info *lsm)
> +{
> +	int enabled =3D lsm_allowed(lsm);
> +
> +	/* Record enablement (to handle any following exclusive LSMs). */
> +	set_enabled(lsm, enabled);
> +
> +	/* If enabled, do pre-initialization work. */
> +	if (enabled) {
> +		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +			exclusive =3D lsm;
> +			init_debug("exclusive chosen:   %s\n", lsm->name);
> +		}
> +
> +		lsm_set_blob_sizes(lsm->blobs);
> +	}
> +}
> +
> +/* Initialize a given LSM, if it is enabled. */
> +static void __init initialize_lsm(struct lsm_info *lsm)
> +{
> +	if (is_enabled(lsm)) {
> +		int ret;
> +
> +		init_debug("initializing %s\n", lsm->name);
> +		ret =3D lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +	}
> +}
> +
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
> +/* Populate ordered LSMs list from comma-separated LSM name list. */
> +static void __init ordered_lsm_parse(const char *order, const char *orig=
in)
> +{
> +	struct lsm_info *lsm;
> +	char *sep, *name, *next;
> +
> +	/* LSM_ORDER_FIRST is always first. */
> +	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order =3D=3D LSM_ORDER_FIRST)
> +			append_ordered_lsm(lsm, "  first");
> +	}
> +
> +	/* Process "security=3D", if given. */
> +	if (chosen_major_lsm) {
> +		struct lsm_info *major;
> +
> +		/*
> +		 * To match the original "security=3D" behavior, this
> +		 * explicitly does NOT fallback to another Legacy Major
> +		 * if the selected one was separately disabled: disable
> +		 * all non-matching Legacy Major LSMs.
> +		 */
> +		for (major =3D __start_lsm_info; major < __end_lsm_info;
> +		     major++) {
> +			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			    strcmp(major->name, chosen_major_lsm) !=3D 0) {
> +				set_enabled(major, false);
> +				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
> +					   chosen_major_lsm, major->name);
> +			}
> +		}
> +	}
> +
> +	sep =3D kstrdup(order, GFP_KERNEL);
> +	next =3D sep;
> +	/* Walk the list, looking for matching LSMs. */
> +	while ((name =3D strsep(&next, ",")) !=3D NULL) {
> +		bool found =3D false;
> +
> +		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (strcmp(lsm->name, name) =3D=3D 0) {
> +				if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
> +					append_ordered_lsm(lsm, origin);
> +				found =3D true;
> +			}
> +		}
> +
> +		if (!found)
> +			init_debug("%s ignored: %s (not built into kernel)\n",
> +				   origin, name);
> +	}
> +
> +	/* Process "security=3D", if given. */
> +	if (chosen_major_lsm) {
> +		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (exists_ordered_lsm(lsm))
> +				continue;
> +			if (strcmp(lsm->name, chosen_major_lsm) =3D=3D 0)
> +				append_ordered_lsm(lsm, "security=3D");
> +		}
> +	}
> +
> +	/* LSM_ORDER_LAST is always last. */
> +	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order =3D=3D LSM_ORDER_LAST)
> +			append_ordered_lsm(lsm, "   last");
> +	}
> +
> +	/* Disable all LSMs not in the ordered list. */
> +	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (exists_ordered_lsm(lsm))
> +			continue;
> +		set_enabled(lsm, false);
> +		init_debug("%s skipped: %s (not in requested order)\n",
> +			   origin, lsm->name);
> +	}
> +
> +	kfree(sep);
> +}
> +
> +static void __init report_lsm_order(void)
> +{
> +	struct lsm_info **lsm, *early;
> +	int first =3D 0;
> +
> +	pr_info("initializing lsm=3D");
> +
> +	/* Report each enabled LSM name, comma separated. */
> +	for (early =3D __start_early_lsm_info;
> +	     early < __end_early_lsm_info; early++)
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> +	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> +
> +	pr_cont("\n");
> +}
> +
> +/**
> + * lsm_early_cred - during initialization allocate a composite cred blob
> + * @cred: the cred that needs a blob
> + *
> + * Allocate the cred blob for all the modules
> + */
> +static void __init lsm_early_cred(struct cred *cred)
> +{
> +	int rc =3D lsm_cred_alloc(cred, GFP_KERNEL);
> +
> +	if (rc)
> +		panic("%s: Early cred alloc failed.\n", __func__);
> +}
> +
> +/**
> + * lsm_early_task - during initialization allocate a composite task blob
> + * @task: the task that needs a blob
> + *
> + * Allocate the task blob for all the modules
> + */
> +static void __init lsm_early_task(struct task_struct *task)
> +{
> +	int rc =3D lsm_task_alloc(task);
> +
> +	if (rc)
> +		panic("%s: Early task alloc failed.\n", __func__);
> +}
> +
> +static void __init ordered_lsm_init(void)
> +{
> +	struct lsm_info **lsm;
> +
> +	if (chosen_lsm_order) {
> +		if (chosen_major_lsm) {
> +			pr_warn("security=3D%s is ignored because it is superseded by lsm=3D%=
s\n",
> +				chosen_major_lsm, chosen_lsm_order);
> +			chosen_major_lsm =3D NULL;
> +		}
> +		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> +	} else
> +		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +
> +	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +		prepare_lsm(*lsm);
> +
> +	report_lsm_order();
> +
> +	init_debug("cred blob size       =3D %d\n", blob_sizes.lbs_cred);
> +	init_debug("file blob size       =3D %d\n", blob_sizes.lbs_file);
> +	init_debug("ib blob size         =3D %d\n", blob_sizes.lbs_ib);
> +	init_debug("inode blob size      =3D %d\n", blob_sizes.lbs_inode);
> +	init_debug("ipc blob size        =3D %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        =3D %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */
> +	init_debug("msg_msg blob size    =3D %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("sock blob size       =3D %d\n", blob_sizes.lbs_sock);
> +	init_debug("superblock blob size =3D %d\n", blob_sizes.lbs_superblock);
> +	init_debug("perf event blob size =3D %d\n", blob_sizes.lbs_perf_event);
> +	init_debug("task blob size       =3D %d\n", blob_sizes.lbs_task);
> +	init_debug("tun device blob size =3D %d\n", blob_sizes.lbs_tun_dev);
> +	init_debug("xattr slots          =3D %d\n", blob_sizes.lbs_xattr_count)=
;
> +	init_debug("bdev blob size       =3D %d\n", blob_sizes.lbs_bdev);
> +	init_debug("bpf map blob size    =3D %d\n", blob_sizes.lbs_bpf_map);
> +	init_debug("bpf prog blob size   =3D %d\n", blob_sizes.lbs_bpf_prog);
> +	init_debug("bpf token blob size  =3D %d\n", blob_sizes.lbs_bpf_token);
> +
> +	/*
> +	 * Create any kmem_caches needed for blobs
> +	 */
> +	if (blob_sizes.lbs_file)
> +		lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
> +						   blob_sizes.lbs_file, 0,
> +						   SLAB_PANIC, NULL);
> +	if (blob_sizes.lbs_inode)
> +		lsm_inode_cache =3D kmem_cache_create("lsm_inode_cache",
> +						    blob_sizes.lbs_inode, 0,
> +						    SLAB_PANIC, NULL);
> +
> +	lsm_early_cred((struct cred *) current->cred);
> +	lsm_early_task(current);
> +	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +		initialize_lsm(*lsm);
> +}
> +
> +static bool match_last_lsm(const char *list, const char *lsm)
> +{
> +	const char *last;
> +
> +	if (WARN_ON(!list || !lsm))
> +		return false;
> +	last =3D strrchr(list, ',');
> +	if (last)
> +		/* Pass the comma, strcmp() will check for '\0' */
> +		last++;
> +	else
> +		last =3D list;
> +	return !strcmp(last, lsm);
> +}
> +
> +static int lsm_append(const char *new, char **result)
> +{
> +	char *cp;
> +
> +	if (*result =3D=3D NULL) {
> +		*result =3D kstrdup(new, GFP_KERNEL);
> +		if (*result =3D=3D NULL)
> +			return -ENOMEM;
> +	} else {
> +		/* Check if it is the last registered name */
> +		if (match_last_lsm(*result, new))
> +			return 0;
> +		cp =3D kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> +		if (cp =3D=3D NULL)
> +			return -ENOMEM;
> +		kfree(*result);
> +		*result =3D cp;
> +	}
> +	return 0;
> +}
> +
> +static void __init lsm_static_call_init(struct security_hook_list *hl)
> +{
> +	struct lsm_static_call *scall =3D hl->scalls;
> +	int i;
> +
> +	for (i =3D 0; i < MAX_LSM_COUNT; i++) {
> +		/* Update the first static call that is not used yet */
> +		if (!scall->hl) {
> +			__static_call_update(scall->key, scall->trampoline,
> +					     hl->hook.lsm_func_addr);
> +			scall->hl =3D hl;
> +			static_branch_enable(scall->active);
> +			return;
> +		}
> +		scall++;
> +	}
> +	panic("%s - Ran out of static slots.\n", __func__);
> +}
> +
> +/**
> + * security_add_hooks - Add a modules hooks to the hook lists.
> + * @hooks: the hooks to add
> + * @count: the number of hooks to add
> + * @lsmid: the identification information for the security module
> + *
> + * Each LSM has to register its hooks with the infrastructure.
> + */
> +void __init security_add_hooks(struct security_hook_list *hooks, int cou=
nt,
> +			       const struct lsm_id *lsmid)
> +{
> +	int i;
> +
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once during initialization, and LSM initialization
> +	 * is serialized. Landlock is one such case.
> +	 * Look at the previous entry, if there is one, for duplication.
> +	 */
> +	if (lsm_active_cnt =3D=3D 0 || lsm_idlist[lsm_active_cnt - 1] !=3D lsmi=
d) {
> +		if (lsm_active_cnt >=3D MAX_LSM_COUNT)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_idlist[lsm_active_cnt++] =3D lsmid;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		hooks[i].lsmid =3D lsmid;
> +		lsm_static_call_init(&hooks[i]);
> +	}
> +
> +	/*
> +	 * Don't try to append during early_security_init(), we'll come back
> +	 * and fix this up afterwards.
> +	 */
> +	if (slab_is_available()) {
> +		if (lsm_append(lsmid->name, &lsm_names) < 0)
> +			panic("%s - Cannot get early memory.\n", __func__);
> +	}
> +}
> +
> +int __init early_security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> +		if (!lsm->enabled)
> +			lsm->enabled =3D &lsm_enabled_true;
> +		prepare_lsm(lsm);
> +		initialize_lsm(lsm);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * security_init - initializes the security framework
> + *
> + * This should be called early in the kernel initialization sequence.
> + */
> +int __init security_init(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	init_debug("legacy security=3D%s\n", chosen_major_lsm ? : " *unspecifie=
d*");
> +	init_debug("  CONFIG_LSM=3D%s\n", builtin_lsm_order);
> +	init_debug("boot arg lsm=3D%s\n", chosen_lsm_order ? : " *unspecified*"=
);
> +
> +	/*
> +	 * Append the names of the early LSM modules now that kmalloc() is
> +	 * available
> +	 */
> +	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> +		init_debug("  early started: %s (%s)\n", lsm->name,
> +			   is_enabled(lsm) ? "enabled" : "disabled");
> +		if (lsm->enabled)
> +			lsm_append(lsm->name, &lsm_names);
> +	}
> +
> +	/* Load LSMs in specified order. */
> +	ordered_lsm_init();
> +
> +	return 0;
> +}
> diff --git a/security/security.c b/security/security.c
> index 8cb049bebc57..ff6da6735e2a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,24 +32,7 @@
>  #include <net/flow.h>
>  #include <net/sock.h>
> =20
> -#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK#=
#_##IDX
> -
> -/*
> - * Identifier for the LSM static calls.
> - * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> - * IDX is the index of the static call. 0 <=3D NUM < MAX_LSM_COUNT
> - */
> -#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> -
> -/*
> - * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> - */
> -#define LSM_LOOP_UNROLL(M, ...) 		\
> -do {						\
> -	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> -} while (0)
> -
> -#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
> +#include "lsm.h"
> =20
>  /*
>   * These are descriptions of the reasons that can be passed to the
> @@ -90,21 +73,29 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENT=
IALITY_MAX + 1] =3D {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>  };
> =20
> -static struct kmem_cache *lsm_file_cache;
> -static struct kmem_cache *lsm_inode_cache;
> +struct lsm_blob_sizes blob_sizes;
> =20
> -char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __ro_after_init;
> +struct kmem_cache *lsm_file_cache;
> +struct kmem_cache *lsm_inode_cache;
> =20
> -/* Boot-time LSM user choice */
> -static __initdata const char *chosen_lsm_order;
> -static __initdata const char *chosen_major_lsm;
> +#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK#=
#_##IDX
> =20
> -static __initconst const char *const builtin_lsm_order =3D CONFIG_LSM;
> +/*
> + * Identifier for the LSM static calls.
> + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> + * IDX is the index of the static call. 0 <=3D NUM < MAX_LSM_COUNT
> + */
> +#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> =20
> -/* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> -static __initdata struct lsm_info *exclusive;
> +/*
> + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> + */
> +#define LSM_LOOP_UNROLL(M, ...) 		\
> +do {						\
> +	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> +} while (0)
> +
> +#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
> =20
>  #ifdef CONFIG_HAVE_STATIC_CALL
>  #define LSM_HOOK_TRAMP(NAME, NUM) \
> @@ -155,496 +146,25 @@ struct lsm_static_calls_table
>  #undef INIT_LSM_STATIC_CALL
>  	};
> =20
> -static __initdata bool debug;
> -#define init_debug(...)						\
> -	do {							\
> -		if (debug)					\
> -			pr_info(__VA_ARGS__);			\
> -	} while (0)
> -
> -static bool __init is_enabled(struct lsm_info *lsm)
> -{
> -	if (!lsm->enabled)
> -		return false;
> -
> -	return *lsm->enabled;
> -}
> -
> -/* Mark an LSM's enabled flag. */
> -static int lsm_enabled_true __initdata =3D 1;
> -static int lsm_enabled_false __initdata =3D 0;
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> -{
> -	/*
> -	 * When an LSM hasn't configured an enable variable, we can use
> -	 * a hard-coded location for storing the default enabled state.
> -	 */
> -	if (!lsm->enabled) {
> -		if (enabled)
> -			lsm->enabled =3D &lsm_enabled_true;
> -		else
> -			lsm->enabled =3D &lsm_enabled_false;
> -	} else if (lsm->enabled =3D=3D &lsm_enabled_true) {
> -		if (!enabled)
> -			lsm->enabled =3D &lsm_enabled_false;
> -	} else if (lsm->enabled =3D=3D &lsm_enabled_false) {
> -		if (enabled)
> -			lsm->enabled =3D &lsm_enabled_true;
> -	} else {
> -		*lsm->enabled =3D enabled;
> -	}
> -}
> -
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> -{
> -	struct lsm_info **check;
> -
> -	for (check =3D ordered_lsms; *check; check++)
> -		if (*check =3D=3D lsm)
> -			return true;
> -
> -	return false;
> -}
> -
> -/* Append an LSM to the list of ordered LSMs to initialize. */
> -static int last_lsm __initdata;
> -static void __init append_ordered_lsm(struct lsm_info *lsm, const char *=
from)
> -{
> -	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> -		return;
> -
> -	if (WARN(last_lsm =3D=3D MAX_LSM_COUNT, "%s: out of LSM static calls!?\=
n", from))
> -		return;
> -
> -	/* Enable this LSM, if it is not already set. */
> -	if (!lsm->enabled)
> -		lsm->enabled =3D &lsm_enabled_true;
> -	ordered_lsms[last_lsm++] =3D lsm;
> -
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> -}
> -
> -/* Is an LSM allowed to be initialized? */
> -static bool __init lsm_allowed(struct lsm_info *lsm)
> -{
> -	/* Skip if the LSM is disabled. */
> -	if (!is_enabled(lsm))
> -		return false;
> -
> -	/* Not allowed if another exclusive LSM already initialized. */
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void __init lsm_set_blob_size(int *need, int *lbs)
> -{
> -	int offset;
> -
> -	if (*need <=3D 0)
> -		return;
> -
> -	offset =3D ALIGN(*lbs, sizeof(void *));
> -	*lbs =3D offset + *need;
> -	*need =3D offset;
> -}
> -
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> -{
> -	if (!needed)
> -		return;
> -
> -	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> -	/*
> -	 * The inode blob gets an rcu_head in addition to
> -	 * what the modules might need.
> -	 */
> -	if (needed->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> -		blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> -	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&needed->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> -	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> -	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> -	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> -}
> -
> -/* Prepare LSM for initialization. */
> -static void __init prepare_lsm(struct lsm_info *lsm)
> -{
> -	int enabled =3D lsm_allowed(lsm);
> -
> -	/* Record enablement (to handle any following exclusive LSMs). */
> -	set_enabled(lsm, enabled);
> -
> -	/* If enabled, do pre-initialization work. */
> -	if (enabled) {
> -		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -			exclusive =3D lsm;
> -			init_debug("exclusive chosen:   %s\n", lsm->name);
> -		}
> -
> -		lsm_set_blob_sizes(lsm->blobs);
> -	}
> -}
> -
> -/* Initialize a given LSM, if it is enabled. */
> -static void __init initialize_lsm(struct lsm_info *lsm)
> -{
> -	if (is_enabled(lsm)) {
> -		int ret;
> -
> -		init_debug("initializing %s\n", lsm->name);
> -		ret =3D lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> -	}
> -}
> -
> -/*
> - * Current index to use while initializing the lsm id list.
> - */
> -u32 lsm_active_cnt __ro_after_init;
> -const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> -
> -/* Populate ordered LSMs list from comma-separated LSM name list. */
> -static void __init ordered_lsm_parse(const char *order, const char *orig=
in)
> -{
> -	struct lsm_info *lsm;
> -	char *sep, *name, *next;
> -
> -	/* LSM_ORDER_FIRST is always first. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order =3D=3D LSM_ORDER_FIRST)
> -			append_ordered_lsm(lsm, "  first");
> -	}
> -
> -	/* Process "security=3D", if given. */
> -	if (chosen_major_lsm) {
> -		struct lsm_info *major;
> -
> -		/*
> -		 * To match the original "security=3D" behavior, this
> -		 * explicitly does NOT fallback to another Legacy Major
> -		 * if the selected one was separately disabled: disable
> -		 * all non-matching Legacy Major LSMs.
> -		 */
> -		for (major =3D __start_lsm_info; major < __end_lsm_info;
> -		     major++) {
> -			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->name, chosen_major_lsm) !=3D 0) {
> -				set_enabled(major, false);
> -				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
> -					   chosen_major_lsm, major->name);
> -			}
> -		}
> -	}
> -
> -	sep =3D kstrdup(order, GFP_KERNEL);
> -	next =3D sep;
> -	/* Walk the list, looking for matching LSMs. */
> -	while ((name =3D strsep(&next, ",")) !=3D NULL) {
> -		bool found =3D false;
> -
> -		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (strcmp(lsm->name, name) =3D=3D 0) {
> -				if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
> -					append_ordered_lsm(lsm, origin);
> -				found =3D true;
> -			}
> -		}
> -
> -		if (!found)
> -			init_debug("%s ignored: %s (not built into kernel)\n",
> -				   origin, name);
> -	}
> -
> -	/* Process "security=3D", if given. */
> -	if (chosen_major_lsm) {
> -		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (exists_ordered_lsm(lsm))
> -				continue;
> -			if (strcmp(lsm->name, chosen_major_lsm) =3D=3D 0)
> -				append_ordered_lsm(lsm, "security=3D");
> -		}
> -	}
> -
> -	/* LSM_ORDER_LAST is always last. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order =3D=3D LSM_ORDER_LAST)
> -			append_ordered_lsm(lsm, "   last");
> -	}
> -
> -	/* Disable all LSMs not in the ordered list. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (exists_ordered_lsm(lsm))
> -			continue;
> -		set_enabled(lsm, false);
> -		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->name);
> -	}
> -
> -	kfree(sep);
> -}
> -
> -static void __init lsm_static_call_init(struct security_hook_list *hl)
> -{
> -	struct lsm_static_call *scall =3D hl->scalls;
> -	int i;
> -
> -	for (i =3D 0; i < MAX_LSM_COUNT; i++) {
> -		/* Update the first static call that is not used yet */
> -		if (!scall->hl) {
> -			__static_call_update(scall->key, scall->trampoline,
> -					     hl->hook.lsm_func_addr);
> -			scall->hl =3D hl;
> -			static_branch_enable(scall->active);
> -			return;
> -		}
> -		scall++;
> -	}
> -	panic("%s - Ran out of static slots.\n", __func__);
> -}
> -
> -static void __init lsm_early_cred(struct cred *cred);
> -static void __init lsm_early_task(struct task_struct *task);
> -
> -static int lsm_append(const char *new, char **result);
> -
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first =3D 0;
> -
> -	pr_info("initializing lsm=3D");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	for (early =3D __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> -
> -	pr_cont("\n");
> -}
> -
> -static void __init ordered_lsm_init(void)
> -{
> -	struct lsm_info **lsm;
> -
> -	if (chosen_lsm_order) {
> -		if (chosen_major_lsm) {
> -			pr_warn("security=3D%s is ignored because it is superseded by lsm=3D%=
s\n",
> -				chosen_major_lsm, chosen_lsm_order);
> -			chosen_major_lsm =3D NULL;
> -		}
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -	} else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> -
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> -
> -	report_lsm_order();
> -
> -	init_debug("cred blob size       =3D %d\n", blob_sizes.lbs_cred);
> -	init_debug("file blob size       =3D %d\n", blob_sizes.lbs_file);
> -	init_debug("ib blob size         =3D %d\n", blob_sizes.lbs_ib);
> -	init_debug("inode blob size      =3D %d\n", blob_sizes.lbs_inode);
> -	init_debug("ipc blob size        =3D %d\n", blob_sizes.lbs_ipc);
> -#ifdef CONFIG_KEYS
> -	init_debug("key blob size        =3D %d\n", blob_sizes.lbs_key);
> -#endif /* CONFIG_KEYS */
> -	init_debug("msg_msg blob size    =3D %d\n", blob_sizes.lbs_msg_msg);
> -	init_debug("sock blob size       =3D %d\n", blob_sizes.lbs_sock);
> -	init_debug("superblock blob size =3D %d\n", blob_sizes.lbs_superblock);
> -	init_debug("perf event blob size =3D %d\n", blob_sizes.lbs_perf_event);
> -	init_debug("task blob size       =3D %d\n", blob_sizes.lbs_task);
> -	init_debug("tun device blob size =3D %d\n", blob_sizes.lbs_tun_dev);
> -	init_debug("xattr slots          =3D %d\n", blob_sizes.lbs_xattr_count)=
;
> -	init_debug("bdev blob size       =3D %d\n", blob_sizes.lbs_bdev);
> -	init_debug("bpf map blob size    =3D %d\n", blob_sizes.lbs_bpf_map);
> -	init_debug("bpf prog blob size   =3D %d\n", blob_sizes.lbs_bpf_prog);
> -	init_debug("bpf token blob size  =3D %d\n", blob_sizes.lbs_bpf_token);
> -
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
> -	if (blob_sizes.lbs_file)
> -		lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
> -						   blob_sizes.lbs_file, 0,
> -						   SLAB_PANIC, NULL);
> -	if (blob_sizes.lbs_inode)
> -		lsm_inode_cache =3D kmem_cache_create("lsm_inode_cache",
> -						    blob_sizes.lbs_inode, 0,
> -						    SLAB_PANIC, NULL);
> -
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> -		initialize_lsm(*lsm);
> -}
> -
> -int __init early_security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> -		if (!lsm->enabled)
> -			lsm->enabled =3D &lsm_enabled_true;
> -		prepare_lsm(lsm);
> -		initialize_lsm(lsm);
> -	}
> -
> -	return 0;
> -}
> -
>  /**
> - * security_init - initializes the security framework
> + * lsm_file_alloc - allocate a composite file blob
> + * @file: the file that needs a blob
>   *
> - * This should be called early in the kernel initialization sequence.
> - */
> -int __init security_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	init_debug("legacy security=3D%s\n", chosen_major_lsm ? : " *unspecifie=
d*");
> -	init_debug("  CONFIG_LSM=3D%s\n", builtin_lsm_order);
> -	init_debug("boot arg lsm=3D%s\n", chosen_lsm_order ? : " *unspecified*"=
);
> -
> -	/*
> -	 * Append the names of the early LSM modules now that kmalloc() is
> -	 * available
> -	 */
> -	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> -		init_debug("  early started: %s (%s)\n", lsm->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->name, &lsm_names);
> -	}
> -
> -	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> -
> -	return 0;
> -}
> -
> -/* Save user chosen LSM */
> -static int __init choose_major_lsm(char *str)
> -{
> -	chosen_major_lsm =3D str;
> -	return 1;
> -}
> -__setup("security=3D", choose_major_lsm);
> -
> -/* Explicitly choose LSM initialization order. */
> -static int __init choose_lsm_order(char *str)
> -{
> -	chosen_lsm_order =3D str;
> -	return 1;
> -}
> -__setup("lsm=3D", choose_lsm_order);
> -
> -/* Enable LSM order debugging. */
> -static int __init enable_debug(char *str)
> -{
> -	debug =3D true;
> -	return 1;
> -}
> -__setup("lsm.debug", enable_debug);
> -
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last =3D strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last =3D list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result =3D=3D NULL) {
> -		*result =3D kstrdup(new, GFP_KERNEL);
> -		if (*result =3D=3D NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp =3D kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp =3D=3D NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result =3D cp;
> -	}
> -	return 0;
> -}
> -
> -/**
> - * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsmid: the identification information for the security module
> + * Allocate the file blob for all the modules
>   *
> - * Each LSM has to register its hooks with the infrastructure.
> + * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int cou=
nt,
> -			       const struct lsm_id *lsmid)
> +static int lsm_file_alloc(struct file *file)
>  {
> -	int i;
> -
> -	/*
> -	 * A security module may call security_add_hooks() more
> -	 * than once during initialization, and LSM initialization
> -	 * is serialized. Landlock is one such case.
> -	 * Look at the previous entry, if there is one, for duplication.
> -	 */
> -	if (lsm_active_cnt =3D=3D 0 || lsm_idlist[lsm_active_cnt - 1] !=3D lsmi=
d) {
> -		if (lsm_active_cnt >=3D MAX_LSM_COUNT)
> -			panic("%s Too many LSMs registered.\n", __func__);
> -		lsm_idlist[lsm_active_cnt++] =3D lsmid;
> +	if (!lsm_file_cache) {
> +		file->f_security =3D NULL;
> +		return 0;
>  	}
> =20
> -	for (i =3D 0; i < count; i++) {
> -		hooks[i].lsmid =3D lsmid;
> -		lsm_static_call_init(&hooks[i]);
> -	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
> +	file->f_security =3D kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
> +	if (file->f_security =3D=3D NULL)
> +		return -ENOMEM;
> +	return 0;
>  }
> =20
>  /**
> @@ -679,46 +199,11 @@ static int lsm_blob_alloc(void **dest, size_t size,=
 gfp_t gfp)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>  {
>  	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
>  }
> =20
> -/**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> - */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc =3D lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_file_alloc - allocate a composite file blob
> - * @file: the file that needs a blob
> - *
> - * Allocate the file blob for all the modules
> - *
> - * Returns 0, or -ENOMEM if memory can't be allocated.
> - */
> -static int lsm_file_alloc(struct file *file)
> -{
> -	if (!lsm_file_cache) {
> -		file->f_security =3D NULL;
> -		return 0;
> -	}
> -
> -	file->f_security =3D kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
> -	if (file->f_security =3D=3D NULL)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
>  /**
>   * lsm_inode_alloc - allocate a composite inode blob
>   * @inode: the inode that needs a blob
> @@ -749,7 +234,7 @@ static int lsm_inode_alloc(struct inode *inode, gfp_t=
 gfp)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -static int lsm_task_alloc(struct task_struct *task)
> +int lsm_task_alloc(struct task_struct *task)
>  {
>  	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL)=
;
>  }
> @@ -851,20 +336,6 @@ static int lsm_bpf_token_alloc(struct bpf_token *tok=
en)
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
> =20
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc =3D lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
>  /**
>   * lsm_superblock_alloc - allocate a composite superblock blob
>   * @sb: the superblock that needs a blob


