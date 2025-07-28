Return-Path: <linux-integrity+bounces-6738-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F70B13859
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 11:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C843A04D0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C833253F2C;
	Mon, 28 Jul 2025 09:46:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DB22C35D;
	Mon, 28 Jul 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695987; cv=none; b=qAocOyMiItMAJeGCLEtKmloDbZdnXOMgN+GROyAAbHmSF+Ei6TMURZaepOHZbWYnrOcmRPqnz/JKigctXgZ2YJbdqsZQsONSujBUCjtCZw8zHNbF//qigXOP1i0kqDnc+G9zwgwR0ApCJLxh3gnTy7SslRk0iDOQOut1uIDLFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695987; c=relaxed/simple;
	bh=P62eZg/nm410fwbt5YFv3Mb7ON32QFktxryCVgTdFF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OY65dEYN8Gf0Cc4cirOY6Mr+yBV3bfLVySUsdwGkixt30PceElE6ifLHOd+T+AfmXZ9Q94n0twCVUIB5ZdVFxA80Mo3KKtgBpKubO5hSbLRXIfIg2upzmRh2/4cEanqpRjjnkoH4gzaGfG6X0IrWBHHESLioludiI+GkX6hMTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brD9P1qtYz1HCbV;
	Mon, 28 Jul 2025 17:45:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 48EA614037D;
	Mon, 28 Jul 2025 17:46:16 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD301bdRodoTzb3AA--.22192S2;
	Mon, 28 Jul 2025 10:46:15 +0100 (CET)
Message-ID: <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
  linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu
 <wufan@kernel.org>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, 
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>, Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Mon, 28 Jul 2025 11:46:02 +0200
In-Reply-To: <20250721232142.77224-62-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
	 <20250721232142.77224-62-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD301bdRodoTzb3AA--.22192S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr47AF4xZw4rKFWUuw1UGFg_yoW5KFWDpr
	WDtFnxKF1xtFZ7AF17u347KFyag395GryUCrs8uw15ZFnxWry8Grn3Zry7AF1fGF4DZF4r
	KF47Xr13W3WqkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGiHHzsCbQAAsi

On Mon, 2025-07-21 at 19:21 -0400, Paul Moore wrote:
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
>=20
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/smack/smack.h           | 7 +++++++
>  security/smack/smack_lsm.c       | 9 +++++++++
>  security/smack/smack_netfilter.c | 4 +---
>  security/smack/smackfs.c         | 4 +---
>  4 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..885a2f2929fd 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,13 @@ struct smk_audit_info {
>  #endif
>  };
> =20
> +/*
> + * Initialization
> + */
> +int init_smk_fs(void);
> +int smack_nf_ip_init(void);

I made the following changes (due to not having
CONFIG_SECURITY_SMACK_NETFILTER):

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 885a2f2929fd..4401cee2bbb7 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -279,9 +279,17 @@ struct smk_audit_info {
  * Initialization
  */
 int init_smk_fs(void);
-int smack_nf_ip_init(void);
 int smack_initcall(void);
=20
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+int smack_nf_ip_init(void);
+#else
+static inline int smack_nf_ip_init(void)
+{
+       return 0;
+}
+#endif
+

Roberto

> +int smack_initcall(void);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09490c75f59..f14d536c516b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5270,6 +5270,14 @@ static __init int smack_init(void)
>  	return 0;
>  }
> =20
> +int __init smack_initcall(void)
> +{
> +	int rc_fs =3D init_smk_fs();
> +	int rc_nf =3D smack_nf_ip_init();
> +
> +	return rc_fs ? rc_fs : rc_nf;
> +}
> +
>  /*
>   * Smack requires early initialization in order to label
>   * all processes and objects when they are created.
> @@ -5279,4 +5287,5 @@ DEFINE_LSM(smack) =3D {
>  	.flags =3D LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.blobs =3D &smack_blob_sizes,
>  	.init =3D smack_init,
> +	.initcall_device =3D smack_initcall,
>  };
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netf=
ilter.c
> index 8fd747b3653a..17ba578b1308 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops =3D {
>  	.exit =3D smack_nf_unregister,
>  };
> =20
> -static int __init smack_nf_ip_init(void)
> +int __init smack_nf_ip_init(void)
>  {
>  	if (smack_enabled =3D=3D 0)
>  		return 0;
> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>  	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>  	return register_pernet_subsys(&smack_net_ops);
>  }
> -
> -__initcall(smack_nf_ip_init);
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index b1e5e62f5cbd..405ace6db109 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2978,7 +2978,7 @@ static struct vfsmount *smackfs_mount;
>   * Returns true if we were not chosen on boot or if
>   * we were chosen and filesystem registration succeeded.
>   */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>  {
>  	int err;
>  	int rc;
> @@ -3021,5 +3021,3 @@ static int __init init_smk_fs(void)
> =20
>  	return err;
>  }
> -
> -__initcall(init_smk_fs);


