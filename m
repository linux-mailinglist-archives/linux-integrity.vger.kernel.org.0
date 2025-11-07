Return-Path: <linux-integrity+bounces-7603-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D2C3F49A
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B16C74E6DD0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087801FF1B4;
	Fri,  7 Nov 2025 10:00:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86793F9FB;
	Fri,  7 Nov 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509645; cv=none; b=EyWkjEQB7AFu6tscxWkIGkpF1nV21fUY3bRg0gYMt+v8eNv5XqHWDx1nLQ9EBH21r0Y53gYdBXqanS06kSfrcdzA5fBHLewfVbVlhe0R376/nnEIW/PLoxj654ShHjPlV9F7YJmgWirU0cJLueM95X/ABBhDGBxzVHBDS9n5K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509645; c=relaxed/simple;
	bh=DoOEZ//JAKl69/9mRcBMtVOZdn+ipyFZM4RcriXgrWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTjuvbJhIRo5Vie3aS+u6XjQdIOC0G6+R3IYtWwRBZYEI8NM/dHyAqwgflK90On0MuG52gahU4/zjVcaW2dwHTK3j312LiiVnueMchtqzSaa3n+psPNltGPjYD1Bjici++BaYYprVFs+WnR8L/DQQn93XZhBhrn4Bhh8dWCNGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4d2vJG465nzpSvg;
	Fri,  7 Nov 2025 17:43:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 54C51140276;
	Fri,  7 Nov 2025 17:44:25 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnmHVvvw1pxl2qAQ--.20817S2;
	Fri, 07 Nov 2025 10:44:24 +0100 (CET)
Message-ID: <1cc67c25a141aef8982840898a6e7397cbdf10d9.camel@huaweicloud.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, zohar@linux.ibm.com, 
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 code@tyhicks.com
Cc: Lennart Poettering <mzxreary@0pointer.de>
Date: Fri, 07 Nov 2025 10:44:12 +0100
In-Reply-To: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnmHVvvw1pxl2qAQ--.20817S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWDGr4kGF18urW7Kr17Wrg_yoWxJr1xpa
	98KFy3CFyFvrZ7JFsrX3WrWws0yrnxt3W8JFW7C34vywn8Zr1UGw45Grya9F4rtr13Wrn2
	qF15Krs09w1jgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGkNTvkDcAAAsg

On Thu, 2025-11-06 at 18:14 +0000, Tahera Fahimi wrote:
> Prevent redundant IMA policy rules by checking for duplicates before inse=
rtion. This ensures that
> rules are not re-added when userspace is restarted (using systemd-soft-re=
boot) without a full system
> reboot. ima_rule_exists() detects duplicates in both temporary and active=
 rule lists.

+ Lennart

Hi Tahera

thanks for the patch!


Wouldn't be better to enhance systemd-soft-reboot to not send the same
IMA policy again?

Thanks

Roberto

> Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_policy.c | 157 +++++++++++++++++++++++++++-
>  1 file changed, 156 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 164d62832f8ec..3dd902101dbda 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1953,6 +1953,153 @@ static int ima_parse_rule(char *rule, struct ima_=
rule_entry *entry)
>  	return result;
>  }
> =20
> +static bool template_has_field(const char *field_id, const struct ima_te=
mplate_desc *template2)
> +{
> +	int j;
> +
> +	for (int j =3D 0; j < template2->num_fields; j++)
> +		if (strcmp(field_id, template2->fields[j]->field_id) =3D=3D 0)
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool keyring_has_item(const char *item, const struct ima_rule_opt=
_list *keyrings)
> +{
> +	int j;
> +
> +	for (j =3D 0; j < keyrings->count; j++) {
> +		if (strcmp(item, keyrings->items[j]) =3D=3D 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool labels_has_item(const char *item, const struct ima_rule_opt_=
list *labels)
> +{
> +	int j;
> +
> +	for (j =3D 0; j < labels->count; j++) {
> +		if (strcmp(item, labels->items[j]) =3D=3D 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool ima_rules_equal(const struct ima_rule_entry *rule1, const st=
ruct ima_rule_entry *rule2)
> +{
> +	int i;
> +
> +	if (rule1->flags !=3D rule2->flags)
> +		return false;
> +
> +	if (rule1->action !=3D rule2->action)
> +		return false;
> +
> +	if (((rule1->flags & IMA_FUNC) && rule1->func !=3D rule2->func) ||
> +	    ((rule1->flags & (IMA_MASK | IMA_INMASK)) && rule1->mask !=3D rule2=
->mask) ||
> +	    ((rule1->flags & IMA_FSMAGIC) && rule1->fsmagic !=3D rule2->fsmagic=
) ||
> +	    ((rule1->flags & IMA_FSUUID) && !uuid_equal(&rule1->fsuuid, &rule2-=
>fsuuid)) ||
> +	    ((rule1->flags & IMA_UID) && !uid_eq(rule1->uid, rule2->uid)) ||
> +	    ((rule1->flags & IMA_GID) && !gid_eq(rule1->gid, rule2->gid)) ||
> +	    ((rule1->flags & IMA_FOWNER) && !uid_eq(rule1->fowner, rule2->fowne=
r)) ||
> +	    ((rule1->flags & IMA_FGROUP) && !gid_eq(rule1->fgroup, rule2->fgrou=
p)) ||
> +	    ((rule1->flags & IMA_FSNAME) && (strcmp(rule1->fsname, rule2->fsnam=
e) !=3D 0)) ||
> +	    ((rule1->flags & IMA_PCR) && rule1->pcr !=3D rule2->pcr) ||
> +	    ((rule1->flags & IMA_VALIDATE_ALGOS) &&
> +	      rule1->allowed_algos !=3D rule2->allowed_algos) ||
> +	    ((rule1->flags & IMA_EUID) && !uid_eq(rule1->uid, rule2->uid)) ||
> +	    ((rule1->flags & IMA_EGID) && !gid_eq(rule1->gid, rule2->gid)))
> +		return false;
> +
> +	if (!rule1->template && !rule2->template) {
> +		;
> +	} else if (!rule1->template || !rule2->template) {
> +		return false;
> +	} else if (rule1->template->num_fields !=3D rule2->template->num_fields=
) {
> +		return false;
> +	} else if (rule1->template->num_fields !=3D 0) {
> +		for (i =3D 0; i < rule1->template->num_fields; i++) {
> +			if (!template_has_field(rule1->template->fields[i]->field_id,
> +						rule2->template))
> +				return false;
> +		}
> +	}
> +
> +	if (rule1->flags & IMA_KEYRINGS) {
> +		if (!rule1->keyrings && !rule2->keyrings) {
> +			;
> +		} else if (!rule1->keyrings || !rule2->keyrings) {
> +			return false;
> +		} else if (rule1->keyrings->count !=3D rule2->keyrings->count) {
> +			return false;
> +		} else if (rule1->keyrings->count !=3D 0) {
> +			for (i =3D 0; i < rule1->keyrings->count; i++) {
> +				if (!keyring_has_item(rule1->keyrings->items[i], rule2->keyrings))
> +					return false;
> +			}
> +		}
> +	}
> +
> +	if (rule1->flags & IMA_LABEL) {
> +		if (!rule1->label && !rule2->label) {
> +			;
> +		} else if (!rule1->label || !rule2->label) {
> +			return false;
> +		} else if (rule1->label->count !=3D rule2->label->count) {
> +			return false;
> +		} else if (rule1->label->count !=3D 0) {
> +			for (i =3D 0; i < rule1->label->count; i++) {
> +				if (!labels_has_item(rule1->label->items[i], rule2->label))
> +					return false;
> +			}
> +		}
> +	}
> +
> +	for (i =3D 0; i < MAX_LSM_RULES; i++) {
> +		if (!rule1->lsm[i].rule && !rule2->lsm[i].rule)
> +			continue;
> +
> +		if (!rule1->lsm[i].rule || !rule2->lsm[i].rule)
> +			return false;
> +
> +		if (strcmp(rule1->lsm[i].args_p, rule2->lsm[i].args_p) !=3D 0)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * ima_rule_exists - check if a rule already exists in the policy
> + *
> + * Checking both the active policy and the temporary rules list.
> + */
> +static bool ima_rule_exists(struct ima_rule_entry *new_rule)
> +{
> +	struct ima_rule_entry *entry;
> +	struct list_head *ima_rules_tmp;
> +
> +	if (!list_empty(&ima_temp_rules)) {
> +		list_for_each_entry(entry, &ima_temp_rules, list) {
> +			if (ima_rules_equal(entry, new_rule))
> +				return true;
> +		}
> +	}
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
> +		if (ima_rules_equal(entry, new_rule)) {
> +			rcu_read_unlock();
> +			return true;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return false;
> +}
> +
>  /**
>   * ima_parse_add_rule - add a rule to ima_policy_rules
>   * @rule: ima measurement policy rule
> @@ -1993,7 +2140,15 @@ ssize_t ima_parse_add_rule(char *rule)
>  		return result;
>  	}
> =20
> -	list_add_tail(&entry->list, &ima_temp_rules);
> +	if (!ima_rule_exists(entry)) {
> +		list_add_tail(&entry->list, &ima_temp_rules);
> +	} else {
> +		result =3D -EEXIST;
> +		ima_free_rule(entry);
> +		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
> +				    NULL, op, "duplicate-policy", result,
> +				    audit_info);
> +	}
> =20
>  	return len;
>  }


