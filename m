Return-Path: <linux-integrity+bounces-6713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAEEB10EE0
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BB7AC3C8
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93422EA164;
	Thu, 24 Jul 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QserEsDr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621E2E92BA
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371596; cv=none; b=FrFkZGYAniYRrCTG7vfJf4OXDarrkcFiFvKG+y1xm3pkNbC0XNIbq8B3YEF5NtjupewNXl4nUE9zVC2wWRFi+geu9rV2Yk0TjLOLSM2jdy1F8Ui1fPMN5QcKZXQ41Dc1BwnnM1wB+5oit8zGyTxQQfM/aDFc/Nw4XjspIzQihP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371596; c=relaxed/simple;
	bh=FsAMf18u2x6iJ5fO8hLillB7ewa20NZ2fOvoHzx62KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDukcsK1GuJgtSg4R8hFSUEDqOmfa5qS7ynDpP2LKYMJ1UVawtA+JjNIo603G7/Xxn3CrEaqt+BhoKesSRljd+TkYC7fTIUmDD6gHgyrNjQpsOD8ATdp/oF5hOgE1N8ntYSGkxCHgLCjPTDAC6BNBFNhX9AJ8EqSRSSr68ww3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QserEsDr; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371594; bh=5kP+FGll/Ei5bFHKc7uf+fQl/TTBT25ATnaaHOCTAnM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QserEsDrSIi/cnniHEOG1YDY8yJBUM8Q9APmgd5YytHmlqStPqE3GarqxTy8kVZL/tbh4u9wnJOORM3ZYL4AgGh5RkiJ58ekcOsgs7QqfXRuTvZTkfrjjQUAyGUoKCmW5j92JgmHu4AjTTA3TMC+ID/T5P7cmMNiypR18V496m8GfdyB7kWLIIi805+xvEkpAxvURD1FtQa9YlNoeIn6GsS6ju3MDcXNArIyeZuOiM6pnCg5oq0MPMZqeVmCqRnG6qCzTznf6uPatpFZM9VyhtIbQPc9AS+BbZ0JNLJCUHG+4+D9WC61Hf1Q4ALXjaRB5Xk/uvmwC57+eYbzEdsLtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753371594; bh=GrxW9XsLeSQXLHxP1TOvIROINVTUF17DYiAffDa07xn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MHF8ep0LpxJx30cVp73I4LuAGgn3p/T3Sq7qaKce1ciDlvA7cDQAuheTrCOl/92qmv1D5kLXNEZjtpiRXa8k4fEm+7DG7jd3EcCEr4Om1aXY1M0oQjn6toFOaucoug0vTTn8rwx/pGnyMnl8dqj5CeU0ihmf8XEY+FWV4Rez0ilVBwgFdOXQvQwwnsJVJ6e4t16UiA7CKLCOxq1EggmoNJT5yf3Mvgahl8o84EuW7DGt+z5lrVy5KGXU0gPN+kCyTU3bAYH84hssbxcXdWETLgpq7lDG+w8axl8OHa8dQG1i07VHwHwaKh/wwy5aQuaWehybGdEC9p4M8Yfu2Rj94Q==
X-YMail-OSG: SfBwWFcVM1mWkq9WoVO4QVppLbR60mOX4hc7_l0O5BNUS2MOVumzDgeOrxAgnDI
 IVUjCJJxrbGmnGrlIrYppJEx5fczNkEyQnBiUICfJtZvLb.253e_maav14kAkli6Qly2Ez7nZESA
 tRelTvBWsjUxjTBdWYXmWNAHlN01Xgx_i3d91IdFCxxpZ0PcgV3QJD3xD43EmLzHfIQOUykfSswH
 FGKd6UJTVVz6LAVrJsqcRmeGGnad7T87mkJBH60FVddSISnWuBhirUlO_WbZ98regu0aZNP7CV8W
 ID92DkIBBXDgEV.Uusa6h7.gtm3DR1swcYLxvi4IGd19WUmtT85EoytErToEAE1Xi1nul6EJDIoZ
 79Kx9ArcWX3ScMDm4L8hLmgMQpZa9zjTWSJWS8CApPZNilfegCg8iEYWSHLw7oKZbPNqurH.oWue
 9EOjsKjzRuLZU2GlgXwzQcxaSC82EyHJOGXVVSW3mwD1AEzFxdWA_elB.2z.lj4JW91Y3ZnKGrDw
 StKo3IAbYaU0WYe47xoCBsV4gqN7GFYwgbHDbhjnTV1lJtypFMTtzJ87XOEB5MvzWP4a1RXBKvCV
 Zn40hHQnWRct41_93Q_I9_CIahQ0oKSLATDxmWbAxMUTWzvTf0qb9tWFcxFSEyQN0f5qusCDmowh
 pve3W3YsVOmAinn4S7XDyR4S1RVyFbhYW6CpNO9P3QsSuPBEaae18voyGEFk1emp6vZv0PYhykYB
 Qz7bhjytn3WBeNH0GE9aL2vl29vbDZpZksat_mtVE3zTh7nWNiG2UgQorIxU5gsJnfRb73PJeoZC
 eo5H1QhT9o3Ip2lzCVxiKoR1.Nn8_4AzclmoBBPb25BRxe33zkT.An7fvcrDPFs9_ZlZ5eIk89IF
 vtGBdf._1NaX2wRfRXXXLRMWRQJbnAl_VAyfg6N7XCePDXtf5PrmSu4iS8A373zNg7tfZdGZgWUa
 ZnJeQ94yWda5crZux40FzJumXNjWh3dcZL6_qEQpUUaWMK.udz.TVPQOvMmbm6bVw6UmUjzW6bgw
 W3Xxv0czWT6XcvKKNQ5.tSbhSRZDIQ7ehxrVb65J34wg2rCnWooZiHXIZOAC5GU5EfAmYDQzupFa
 84HVNd2reJDMaFD8qoM3jZ0Ru52SL52ZyyiD8auSNlwxluWm1CFjGnqgJZWSxyi9LJWNHHN1wPMW
 65Q0sXORo88ooQpCmiUc1BbzjDJfptQIW_uDqZu.p68cTFmpmKZoQLmDsEjinp97lOLIGaefqHIx
 6uYnNWvo2uJ5MHevodK8UO8kUmtOVkJa2DKl0870Z3yCxaDK69z8t5vxcMQj6xEyNlnmBAGrQHzW
 dQdYzP8NFgnMiFWoD7QF1r0crurwNU0WwhPQlYVVg4nQnrypsPjda.aUAVgOkZKhyKbiHYtL9Ef0
 tM6AyPwj9ndKFCJwLlckxCkvONcThV2IEYTxnBYHcEQwP5G_8Hky3CYbFNhs.ft.7tmBXfzrd6Rh
 PCWzAC5aKQGFzRUxFAyGe_GUKe3YbI84gpRj3mTB4QyyAnw_LoVO_n3DtKQpqTWvqM6Db.EMO6bn
 y29eewei7OnUAJ5OmtiQBEWakQTLGGci0heDxQ9n9EUBotlbU3nGf_9ugIUZ0XLXrhCqcgECzOhH
 QbbQ7xfc6vwf0ZAZksu_PkAsXmjWc7zRAogEhVRkXeSmYkaRcb1JPzeJbP7FioO4I61d8hraXYJo
 JY1wIvC3F5BLgRlYfwfZi5Thx1.mcSYtpCBgLpR0H_04l44wyT3gol2vZz4nLA8hrgux63TjitF0
 5CdfRYPxdGbft03qB8MKCk3Q9Qnsca3Le6cd9Y8hpSmBqSjixPzil5.QuA9TWCYEHv_vygCBAz2w
 .6ZsWsOzyM4KVkVhZbWa5jP8x1uKK4yTn1nMTz2PPTU818JEDDg1gpMTBEal0ECDCpMkv8_XJ5Kp
 fbuz49zBZGfiXxEw9Jqme6cUO6yxDQl5_N9AZGi.Xf.nLmHKqmOh3MOpF.ULGRBerVRim452P3Fn
 iX9fudvoFA4OZ1j75yIbqlz5XNjo_761W7gA0sJnwKUok53awCF_rtGnCsUQifNFZqa0.7rt_cgb
 s6VZZIFcGMeyubF2qzAiGlJbVzfMgt7i0mG9JAIMWhde6Le_sCb9rJMoWSv4YIvS8CxEIt7LFlZO
 w8Z_r5K6yr7RkFcp2qN7DCKU6LcCP86P25stimdrwP56ml1X48Dsq5NMeZNtsY_nq7mJBJxl3D.l
 i0R6RYYn5gm.3142LVSPymawagfIXGywJa8lz.B0RdXdWwpH.MiXaLuHJVATZaSsrXLSmE5I9kNN
 gox0Q.EcFWKXu1aRfGtmKX..nFFSdN0DaE5Mcwfn_6lp3
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 34e39634-6797-4eba-a93d-1b7ff762b2ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:39:54 +0000
Received: by hermes--production-gq1-74d64bb7d7-lwch7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 186430967151c9686b4398240d957f28;
          Thu, 24 Jul 2025 15:39:49 +0000 (UTC)
Message-ID: <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:39:46 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-47-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-47-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the currently
> active LSMs in a human readable string, with the only user being the
> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> generate the string on first use and then cache it for subsequent use.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
>  security/lsm_init.c       | 49 --------------------------------
>  3 files changed, 57 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4cd17c9a229f..bc477fb20d02 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -169,7 +169,6 @@ struct lsm_info {
>  
>  
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index 3913501621fa..68ee6c9de833 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
>  
> +#include "lsm.h"
> +
>  static struct vfsmount *mount;
>  static int mount_count;
>  
> @@ -339,12 +341,65 @@ void securityfs_recursive_remove(struct dentry *dentry)
>  EXPORT_SYMBOL_GPL(securityfs_recursive_remove);
>  
>  #ifdef CONFIG_SECURITY
> +#include <linux/spinlock.h>
> +
>  static struct dentry *lsm_dentry;
> +
> +/* NOTE: we never free the string below once it is set. */
> +static DEFINE_SPINLOCK(lsm_read_lock);
> +static char *lsm_read_str = NULL;
> +static ssize_t lsm_read_len = 0;
> +
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	char *str;
> +	ssize_t len;
> +
> +restart:
> +
> +	rcu_read_lock();
> +	if (!lsm_read_str) {
> +		/* we need to generate the string and try again */
> +		rcu_read_unlock();
> +		goto generate_string;
> +	}
> +	len = simple_read_from_buffer(buf, count, ppos,
> +				      rcu_dereference(lsm_read_str),
> +				      lsm_read_len);
> +	rcu_read_unlock();
> +	return len;
> +
> +generate_string:
> +
> +	for (i = 0; i < lsm_active_cnt; i++)
> +		/* the '+ 1' accounts for either a comma or a NUL */
> +		len += strlen(lsm_idlist[i]->name) + 1;
> +
> +	str = kmalloc(len, GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	str[0] = '\0';
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (i > 0)
> +			strcat(str, ",");
> +		strcat(str, lsm_idlist[i]->name);
> +	}
> +
> +	spin_lock(&lsm_read_lock);
> +	if (lsm_read_str) {
> +		/* we raced and lost */
> +		spin_unlock(&lsm_read_lock);
> +		kfree(str);
> +		goto restart;
> +	}
> +	lsm_read_str = str; 
> +	lsm_read_len = len;

You're going to get a nul byte at the end of the string because
you accounted for the ',' above, but there isn't one at the end
of the string.

> +	spin_unlock(&lsm_read_lock);
> +
> +	goto restart;
>  }
>  
>  static const struct file_operations lsm_ops = {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 03d3e140e0b1..80b57aef38a0 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,8 +10,6 @@
>  
>  #include "lsm.h"
>  
> -char *lsm_names;
> -
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -365,42 +363,6 @@ static void __init lsm_init_ordered(void)
>  	}
>  }
>  
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last = strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last = list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result == NULL) {
> -		*result = kstrdup(new, GFP_KERNEL);
> -		if (*result == NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp == NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result = cp;
> -	}
> -	return 0;
> -}
> -
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -437,15 +399,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsmid = lsmid;
>  		lsm_static_call_init(&hooks[i]);
>  	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
>  }
>  
>  int __init early_security_init(void)
> @@ -482,8 +435,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */

