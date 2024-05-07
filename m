Return-Path: <linux-integrity+bounces-2341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D498BDE60
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C21F2595E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2024 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398914E2E2;
	Tue,  7 May 2024 09:32:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0414D710;
	Tue,  7 May 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074354; cv=none; b=E/4Z7YDQg2LJBpRe6+ey9SgrAJCvkX1sUSxtDecNZ+o3OA3BaCC5Q4saDIyENp1fmMQg7K+6RebXussXiiYA0z6etrFymK89SqQ/addSBjWnN3dCl1ly3GnISKQxunnKwHDhiyutnoA/xtzOSxl43MBE/QLxcHRgC6r8Dj5Qayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074354; c=relaxed/simple;
	bh=db02E+eKNl5BqO07hsPeoCeQYWkq162mXseaLq+BHJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ag9vZnt0APsxf1JxMXntRJDerUGWYllqlXUbxifYnDTzF7J8lgEOuAA7W+4JC2WRxIMg7JLjHsHSIT0OnrZF4eU7dA53VaXzb0yOpxvo79bf0Tol5gl/HfxLXyjQGQSBaPNvUjd+8F5WBNTkY+eOR06pHMVxY/Yp+CLmbzyl8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VYXZ91DWTz9v7Y8;
	Tue,  7 May 2024 17:10:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 04C5E140390;
	Tue,  7 May 2024 17:32:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnXSEV9TlmiKitBw--.25415S2;
	Tue, 07 May 2024 10:32:17 +0100 (CET)
Message-ID: <e6e2b31983610bf566d8046edbac0e00c8453233.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: Use sequence number to wait for policy updates
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  john.johansen@canonical.com,
 stephen.smalley.work@gmail.com,  casey@schaufler-ca.com, eparis@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, guozihua@huawei.com, omosnace@redhat.com, 
	audit@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 07 May 2024 11:32:03 +0200
In-Reply-To: <20240507092831.3590793-1-roberto.sassu@huaweicloud.com>
References: <20240507092831.3590793-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAnXSEV9TlmiKitBw--.25415S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW8urWxXF47AF13KF4UArb_yoW7Ww4UpF
	Wvga4UCFyvvrWS9r4xC3yDZrWY9ry8Zr1UZ3s8W347AwnxXr10qF18Jry7Za4fGrW5CF1x
	XF4jgrs09w1jvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5kUAwAAsp

On Tue, 2024-05-07 at 11:28 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Maintain a global sequence number, and set it to individual policy rules,
> when they are created.

Just did an attempt, to see if this path is viable.

This patch would be an alternative to:

[PATCH v3] ima: Avoid blocking in RCU read-side critical section

Roberto

> When a rule is stale, wait for the global sequence number to increase,
> which happens when the LSM policy has been fully updated.
>=20
> Finally, restart the ima_match_policy() loop, which should not encounter
> the stale rule anymore.
>=20
> On policy update, already increase the rule sequence number, so that a wa=
it
> can be implemented for the next policy update.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 65 +++++++++++++++--------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index c0556907c2e6..4f8275e216fe 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -51,9 +51,12 @@
>  #define INVALID_PCR(a) (((a) < 0) || \
>  	(a) >=3D (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
> =20
> +DECLARE_WAIT_QUEUE_HEAD(wait_queue_t);
> +
>  int ima_policy_flag;
>  static int temp_ima_appraise;
>  static int build_ima_appraise __ro_after_init;
> +static int global_seqno;
> =20
>  atomic_t ima_setxattr_allowed_hash_algorithms;
> =20
> @@ -122,6 +125,7 @@ struct ima_rule_entry {
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyr=
ings */
>  	struct ima_rule_opt_list *label; /* Measure data grouped under this lab=
el */
>  	struct ima_template_desc *template;
> +	int seqno;
>  };
> =20
>  /*
> @@ -442,6 +446,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry =
*entry)
>  	if (!nentry)
>  		return -ENOMEM;
> =20
> +	nentry->seqno++;
> +
>  	list_replace_rcu(&entry->list, &nentry->list);
>  	synchronize_rcu();
>  	/*
> @@ -497,6 +503,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, =
unsigned long event,
>  		return NOTIFY_DONE;
> =20
>  	ima_lsm_update_rules();
> +	global_seqno++;
> +	wake_up(&wait_queue_t);
>  	return NOTIFY_OK;
>  }
> =20
> @@ -560,18 +568,16 @@ static bool ima_match_rule_data(struct ima_rule_ent=
ry *rule,
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC=
)
>   * @func_data: func specific data, may be NULL
>   *
> - * Returns true on rule match, false on failure.
> + * Returns 1 on rule match, 0 on mismatch, -ESTALE on stale policy.
>   */
> -static bool ima_match_rules(struct ima_rule_entry *rule,
> -			    struct mnt_idmap *idmap,
> -			    struct inode *inode, const struct cred *cred,
> -			    u32 secid, enum ima_hooks func, int mask,
> -			    const char *func_data)
> +static int ima_match_rules(struct ima_rule_entry *rule,
> +			   struct mnt_idmap *idmap,
> +			   struct inode *inode, const struct cred *cred,
> +			   u32 secid, enum ima_hooks func, int mask,
> +			   const char *func_data)
>  {
>  	int i;
> -	bool result =3D false;
>  	struct ima_rule_entry *lsm_rule =3D rule;
> -	bool rule_reinitialized =3D false;
> =20
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func !=3D func && func !=3D POST_SETATTR))
> @@ -642,7 +648,6 @@ static bool ima_match_rules(struct ima_rule_entry *ru=
le,
>  				return false;
>  		}
> =20
> -retry:
>  		switch (i) {
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
> @@ -663,27 +668,13 @@ static bool ima_match_rules(struct ima_rule_entry *=
rule,
>  			break;
>  		}
> =20
> -		if (rc =3D=3D -ESTALE && !rule_reinitialized) {
> -			lsm_rule =3D ima_lsm_copy_rule(rule);
> -			if (lsm_rule) {
> -				rule_reinitialized =3D true;
> -				goto retry;
> -			}
> -		}
> -		if (!rc) {
> -			result =3D false;
> -			goto out;
> -		}
> +		if (!rc)
> +			return false;
> +		else if (rc =3D=3D -ESTALE)
> +			return rc;
>  	}
> -	result =3D true;
> =20
> -out:
> -	if (rule_reinitialized) {
> -		for (i =3D 0; i < MAX_LSM_RULES; i++)
> -			ima_filter_rule_free(lsm_rule->lsm[i].rule);
> -		kfree(lsm_rule);
> -	}
> -	return result;
> +	return true;
>  }
> =20
>  /*
> @@ -741,12 +732,12 @@ int ima_match_policy(struct mnt_idmap *idmap, struc=
t inode *inode,
>  		     const char *func_data, unsigned int *allowed_algos)
>  {
>  	struct ima_rule_entry *entry;
> -	int action =3D 0, actmask =3D flags | (flags << 1);
> +	int action =3D 0, rc, actmask =3D flags | (flags << 1);
>  	struct list_head *ima_rules_tmp;
> =20
>  	if (template_desc && !*template_desc)
>  		*template_desc =3D ima_template_desc_current();
> -
> +retry:
>  	rcu_read_lock();
>  	ima_rules_tmp =3D rcu_dereference(ima_rules);
>  	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
> @@ -754,9 +745,18 @@ int ima_match_policy(struct mnt_idmap *idmap, struct=
 inode *inode,
>  		if (!(entry->action & actmask))
>  			continue;
> =20
> -		if (!ima_match_rules(entry, idmap, inode, cred, secid,
> -				     func, mask, func_data))
> +		rc =3D ima_match_rules(entry, idmap, inode, cred, secid,
> +				     func, mask, func_data);
> +		if (!rc)
>  			continue;
> +		else if (rc =3D=3D -ESTALE) {
> +			rcu_read_unlock();
> +
> +			wait_event_interruptible(wait_queue_t,
> +				(global_seqno =3D=3D entry->seqno + 1));
> +
> +			goto retry;
> +		}
> =20
>  		action |=3D entry->flags & IMA_NONACTION_FLAGS;
> =20
> @@ -1153,6 +1153,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry =
*entry,
>  			result =3D 0;
>  	}
> =20
> +	entry->seqno =3D global_seqno;
>  	return result;
>  }
> =20


