Return-Path: <linux-integrity+bounces-7014-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A240B43539
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C0C168587
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012872BFC85;
	Thu,  4 Sep 2025 08:13:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF6275B0D;
	Thu,  4 Sep 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973596; cv=none; b=KpsuSvOKRGfFbZoo4ND3Kbmf9h6apRb4m8UH5LoHvQxZvsj8O1ReN4stNHRsQbd4FWF7ob+aVvyVp7nd8+PW7ztPE1qsYugx4h/PKRlArrP1u+V+Fu9+6H8cdn/S7MyNODUh5/ISXhb70aC7iNOrZO/2YD5rXbHoCd7ynUNJ6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973596; c=relaxed/simple;
	bh=srK6FvFoKXEd9IdJ/rb3J0sDqetIDXmnxyjjhdEdNOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbUanKMAK2Z4B45dWvIK1pGt2xxIETwbn1sOukRoHZuq1fP66XFFN69bCZyUUro/QAM51kSOvT7mkhzEme4Uh9sRLkFkHk+k9hsXF3B0zD6nfd155eTqbLqwWaXPnfzztA8bdkuh+Akfxh2DXPk2dncE6kUnGeSwFZ3ukrvfNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cHXHc2qZNzsXB2;
	Thu,  4 Sep 2025 16:11:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A34F61402C4;
	Thu,  4 Sep 2025 16:13:04 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXeT8GSrlofHW5AA--.9858S2;
	Thu, 04 Sep 2025 09:13:04 +0100 (CET)
Message-ID: <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: John Johansen <john.johansen@canonical.com>, Paul Moore
	 <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Fan Wu <wufan@kernel.org>,
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, 
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>, Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Thu, 04 Sep 2025 10:12:51 +0200
In-Reply-To: <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
	 <20250814225159.275901-47-paul@paul-moore.com>
	 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXeT8GSrlofHW5AA--.9858S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW8Cr43tFyrXw1UXw48tFb_yoW7ur4xpF
	Z0qFy3KFWrAFy7ur42qFnrKa4Sq393Cr47Gr47G3WxAw1vyrnaqr17GFya9ryDArZrGw4F
	vF42vrnxCF45taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGi5OGkBIwAAsl

On Tue, 2025-09-02 at 10:20 -0700, John Johansen wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >=20
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   include/linux/lsm_hooks.h |  1 -
> >   security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++-=
-
> >   security/lsm_init.c       | 49 --------------------------------
> >   3 files changed, 57 insertions(+), 52 deletions(-)
> >=20
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 7343dd60b1d5..65a8227bece7 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -172,7 +172,6 @@ struct lsm_info {
> >  =20
> >  =20
> >   /* DO NOT tamper with these variables outside of the LSM framework */
> > -extern char *lsm_names;
> >   extern struct lsm_static_calls_table static_calls_table __ro_after_in=
it;
> >  =20
> >   /**
> > diff --git a/security/inode.c b/security/inode.c
> > index 43382ef8896e..a5e7a073e672 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -22,6 +22,8 @@
> >   #include <linux/lsm_hooks.h>
> >   #include <linux/magic.h>
> >  =20
> > +#include "lsm.h"
> > +
> >   static struct vfsmount *mount;
> >   static int mount_count;
> >  =20
> > @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
> >   EXPORT_SYMBOL_GPL(securityfs_remove);
> >  =20
> >   #ifdef CONFIG_SECURITY
> > +#include <linux/spinlock.h>
> > +
> >   static struct dentry *lsm_dentry;
> > +
> > +/* NOTE: we never free the string below once it is set. */
> > +static DEFINE_SPINLOCK(lsm_read_lock);
>=20
> nit, this is only used on the write side, so not the best name
>=20
> > +static char *lsm_read_str =3D NULL;
> > +static ssize_t lsm_read_len =3D 0;
> > +
> >   static ssize_t lsm_read(struct file *filp, char __user *buf, size_t c=
ount,
> >   			loff_t *ppos)
> >   {
> > -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -		strlen(lsm_names));
> > +	int i;
> > +	char *str;
> > +	ssize_t len;
> > +
> > +restart:
> > +
> > +	rcu_read_lock();

Uhm, it seems we cannot use plain RCU here, simple_read_from_buffer()
can sleep.

Roberto

> > +	if (!lsm_read_str) {
> should probably be
> if (!rcu_access_pointer(lsm_read_str)) {
>=20
> > +		/* we need to generate the string and try again */
> > +		rcu_read_unlock();
> > +		goto generate_string;
> > +	}
> > +	len =3D simple_read_from_buffer(buf, count, ppos,
> > +				      rcu_dereference(lsm_read_str),
> > +				      lsm_read_len);
> > +	rcu_read_unlock();
> > +	return len;
> > +
> > +generate_string:
> > +
> > +	for (i =3D 0; i < lsm_active_cnt; i++)
> > +		/* the '+ 1' accounts for either a comma or a NUL */
> > +		len +=3D strlen(lsm_idlist[i]->name) + 1;
> > +
> > +	str =3D kmalloc(len, GFP_KERNEL);
> > +	if (!str)
> > +		return -ENOMEM;
> > +	str[0] =3D '\0';
> > +
> > +	for (i =3D 0; i < lsm_active_cnt; i++) {
> > +		if (i > 0)
> > +			strcat(str, ",");
> > +		strcat(str, lsm_idlist[i]->name);
> > +	}
> > +
> > +	spin_lock(&lsm_read_lock);
> > +	if (lsm_read_str) {
> > +		/* we raced and lost */
> > +		spin_unlock(&lsm_read_lock);
> > +		kfree(str);
> > +		goto restart;
> > +	}
> > +	lsm_read_str =3D str;
> > +	lsm_read_len =3D len - 1;
> > +	spin_unlock(&lsm_read_lock);
> > +
> > +	goto restart;
> >   }
> >  =20
> >   static const struct file_operations lsm_ops =3D {
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 9e495a36a332..87e2147016b3 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -10,8 +10,6 @@
> >  =20
> >   #include "lsm.h"
> >  =20
> > -char *lsm_names;
> > -
> >   /* Pointers to LSM sections defined in include/asm-generic/vmlinux.ld=
s.h */
> >   extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> >   extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info=
[];
> > @@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
> >   	}
> >   }
> >  =20
> > -static bool match_last_lsm(const char *list, const char *lsm)
> > -{
> > -	const char *last;
> > -
> > -	if (WARN_ON(!list || !lsm))
> > -		return false;
> > -	last =3D strrchr(list, ',');
> > -	if (last)
> > -		/* Pass the comma, strcmp() will check for '\0' */
> > -		last++;
> > -	else
> > -		last =3D list;
> > -	return !strcmp(last, lsm);
> > -}
> > -
> > -static int lsm_append(const char *new, char **result)
> > -{
> > -	char *cp;
> > -
> > -	if (*result =3D=3D NULL) {
> > -		*result =3D kstrdup(new, GFP_KERNEL);
> > -		if (*result =3D=3D NULL)
> > -			return -ENOMEM;
> > -	} else {
> > -		/* Check if it is the last registered name */
> > -		if (match_last_lsm(*result, new))
> > -			return 0;
> > -		cp =3D kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> > -		if (cp =3D=3D NULL)
> > -			return -ENOMEM;
> > -		kfree(*result);
> > -		*result =3D cp;
> > -	}
> > -	return 0;
> > -}
> > -
> >   static void __init lsm_static_call_init(struct security_hook_list *hl=
)
> >   {
> >   	struct lsm_static_call *scall =3D hl->scalls;
> > @@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hoo=
k_list *hooks, int count,
> >   		hooks[i].lsmid =3D lsmid;
> >   		lsm_static_call_init(&hooks[i]);
> >   	}
> > -
> > -	/*
> > -	 * Don't try to append during early_security_init(), we'll come back
> > -	 * and fix this up afterwards.
> > -	 */
> > -	if (slab_is_available()) {
> > -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> > -			panic("%s - Cannot get early memory.\n", __func__);
> > -	}
> >   }
> >  =20
> >   int __init early_security_init(void)
> > @@ -488,8 +441,6 @@ int __init security_init(void)
> >   	lsm_early_for_each_raw(lsm) {
> >   		init_debug("  early started: %s (%s)\n", lsm->id->name,
> >   			   is_enabled(lsm) ? "enabled" : "disabled");
> > -		if (lsm->enabled)
> > -			lsm_append(lsm->id->name, &lsm_names);
> >   	}
> >  =20
> >   	/* Load LSMs in specified order. */
>=20


