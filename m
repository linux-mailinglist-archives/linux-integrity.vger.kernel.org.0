Return-Path: <linux-integrity+bounces-7593-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97246C3D5CE
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 21:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71FDA4E1E36
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2982F7AB1;
	Thu,  6 Nov 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oydei4R7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607E2DBF7C;
	Thu,  6 Nov 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461169; cv=none; b=G6eE17H+1y1/6m7YKgMoXwrLNfE4ySa0OzLrvshpnXp9/XVg1F9IZMVT2bFxurUSV0UOJtGtILgCRwHy1Yd4y3Q+13SXZ8aG+qD1E83H7DuBqrUV9LFm6daxFz41hvwHYrVgHIPDeDrQ2668uTIADGFayQfk3lTazsjsisUIxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461169; c=relaxed/simple;
	bh=wK2Q+sR/Kh9KiE0VD5GsDys1VbhdjkcEV3Grw9XO0Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HSHCG3dBR3An5QldqVCcA04Ojxa7lMh683beuluSQ/Ue8A/QiXST7zmpN/PxXQ3mEdSypK5CoDntKiOb2Hnu+0i4vIi6mTYCfbKKAk95tjMTeT1xkKlF/vy9MjfIZtbJMTKEXd6WKQVR0alzzpjA7lskGW/jCT4HFnfjV1W5a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oydei4R7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.49] (c-73-240-88-29.hsd1.or.comcast.net [73.240.88.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB768212038E;
	Thu,  6 Nov 2025 12:32:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB768212038E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762461167;
	bh=NmhZbzQTHyHrl2v/TsawGmh/o53psO9Ly+TGU8r+aTY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oydei4R73PtKCuWhTk7ipjOJ1PXn0eNIhbrFaAHXQewHERTQcP56lfUU6qWP/eLWL
	 GsT66nECxsyatjw2FRhvgU9df3pB6gnyF8pqY6PAgm990i2A1LBoLAR4M4XwSIzPx4
	 5Cl7mtHcawkqM6BEkk9eQheDVb85zqY7RfAhXnPA=
Message-ID: <b36a6508-1b2a-4c87-b3b5-9af0b402dc0b@linux.microsoft.com>
Date: Thu, 6 Nov 2025 12:32:45 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 code@tyhicks.com
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
Content-Language: en-US
From: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
In-Reply-To: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/2025 10:14 AM, Tahera Fahimi wrote:
> Prevent redundant IMA policy rules by checking for duplicates before insertion. This ensures that
> rules are not re-added when userspace is restarted (using systemd-soft-reboot) without a full system
> reboot. ima_rule_exists() detects duplicates in both temporary and active rule lists.

I have run into this too. Thanks for proposing a patch!

FWIW - I am fairly new to the IMA subsystem, so feedback below is mostly 
structural, with some IMA specific comments.

> 
> Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_policy.c | 157 +++++++++++++++++++++++++++-
>   1 file changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 164d62832f8ec..3dd902101dbda 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1953,6 +1953,153 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   	return result;
>   }
>   
> +static bool template_has_field(const char *field_id, const struct ima_template_desc *template2)
> +{
> +	int j;

j is declared in the loop header below too, which is more correct 
because it keeps the scope of j to be within the loop. So I'd say get 
rid of the above declaration.

> +
> +	for (int j = 0; j < template2->num_fields; j++)
> +		if (strcmp(field_id, template2->fields[j]->field_id) == 0)
> +			return true;
I believe the preferred kernel style is to use if (!strcmp(...)).

> +
> +	return false;
> +}
> +
> +static bool keyring_has_item(const char *item, const struct ima_rule_opt_list *keyrings)
> +{
> +	int j;
> +
> +	for (j = 0; j < keyrings->count; j++) {
> +		if (strcmp(item, keyrings->items[j]) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool labels_has_item(const char *item, const struct ima_rule_opt_list *labels)
> +{
> +	int j;
> +
> +	for (j = 0; j < labels->count; j++) {
> +		if (strcmp(item, labels->items[j]) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool ima_rules_equal(const struct ima_rule_entry *rule1, const struct ima_rule_entry *rule2)
> +{
> +	int i;

i is used further down in this function, and even in all those cases, 
the scope of i can be limited to the loop body where it's used.

If you didn't know this already - you can use cppcheck to identify and 
reduce the scope of variables.

> +
> +	if (rule1->flags != rule2->flags)
> +		return false;
> +
> +	if (rule1->action != rule2->action)
> +		return false;
> +
> +	if (((rule1->flags & IMA_FUNC) && rule1->func != rule2->func) ||
> +	    ((rule1->flags & (IMA_MASK | IMA_INMASK)) && rule1->mask != rule2->mask) ||
> +	    ((rule1->flags & IMA_FSMAGIC) && rule1->fsmagic != rule2->fsmagic) ||
> +	    ((rule1->flags & IMA_FSUUID) && !uuid_equal(&rule1->fsuuid, &rule2->fsuuid)) ||
> +	    ((rule1->flags & IMA_UID) && !uid_eq(rule1->uid, rule2->uid)) ||
> +	    ((rule1->flags & IMA_GID) && !gid_eq(rule1->gid, rule2->gid)) ||
> +	    ((rule1->flags & IMA_FOWNER) && !uid_eq(rule1->fowner, rule2->fowner)) ||
> +	    ((rule1->flags & IMA_FGROUP) && !gid_eq(rule1->fgroup, rule2->fgroup)) ||
> +	    ((rule1->flags & IMA_FSNAME) && (strcmp(rule1->fsname, rule2->fsname) != 0)) ||
> +	    ((rule1->flags & IMA_PCR) && rule1->pcr != rule2->pcr) ||
> +	    ((rule1->flags & IMA_VALIDATE_ALGOS) &&
> +	      rule1->allowed_algos != rule2->allowed_algos) ||
> +	    ((rule1->flags & IMA_EUID) && !uid_eq(rule1->uid, rule2->uid)) ||
> +	    ((rule1->flags & IMA_EGID) && !gid_eq(rule1->gid, rule2->gid)))
> +		return false;

So the goal is to prevent the exact same policy rule from being added, 
not to update an existing rule, correct? IOW, you could end up with two 
very similar rules, because the new rule has one thing that's different 
compared to the existing rule?

I feel that a little bit of commentary around what makes two rules the 
same would be useful.

> +
> +	if (!rule1->template && !rule2->template) {
> +		;
You're trying to do nothing and continue on. A goto statement would 
communicate intent better. There are other places below with the same 
noop structure.

To be fair, I also don't completely understand what you're trying to 
achieve here, Regardless, this "do nothing inside a conditional" looks 
weird and I feel like there should be a way to structure your logic 
without resorting to this.

> +	} else if (!rule1->template || !rule2->template) {
> +		return false;
> +	} else if (rule1->template->num_fields != rule2->template->num_fields) {
> +		return false;
> +	} else if (rule1->template->num_fields != 0) {
> +		for (i = 0; i < rule1->template->num_fields; i++) {
> +			if (!template_has_field(rule1->template->fields[i]->field_id,
> +						rule2->template))
> +				return false;
> +		}
> +	}

if + return will achieve the same end goals as else if + return, with 
lesser clutter. I have seen some static analyzers flag this pattern, but 
I can't remember which one at the moment.

So something like this:

if (!rule1->template && !rule2->template)
     goto some_target;

if (!rule1->template || !rule2->template)
     return false;

if (rule1->template->num_fields != rule2->template->num_fields)
     return false;

if (rule1->template->num_fields != 0) {
     for (i = 0; i < rule1->template->num_fields; i++) {
         if (!template_has_field(rule1->template->fields[i]->field_id,
                                 rule2->template))
               return false;
         }
}

some_target:
...
...

> +
> +	if (rule1->flags & IMA_KEYRINGS) {
> +		if (!rule1->keyrings && !rule2->keyrings) {
> +			;

Another if block no-op

> +		} else if (!rule1->keyrings || !rule2->keyrings) {
> +			return false;
> +		} else if (rule1->keyrings->count != rule2->keyrings->count) {
> +			return false;
> +		} else if (rule1->keyrings->count != 0) {

if (rule1->keyrings->count)

> +			for (i = 0; i < rule1->keyrings->count; i++) {

for (int i,

> +				if (!keyring_has_item(rule1->keyrings->items[i], rule2->keyrings))
> +					return false;
> +			}
> +		}
> +	}
> +
> +	if (rule1->flags & IMA_LABEL) {
> +		if (!rule1->label && !rule2->label) {
> +			;

Another if block no-op

> +		} else if (!rule1->label || !rule2->label) {
> +			return false;
> +		} else if (rule1->label->count != rule2->label->count) {
> +			return false;
> +		} else if (rule1->label->count != 0) {
> +			for (i = 0; i < rule1->label->count; i++) {
> +				if (!labels_has_item(rule1->label->items[i], rule2->label))
> +					return false;
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < MAX_LSM_RULES; i++) {

for (int i,

> +		if (!rule1->lsm[i].rule && !rule2->lsm[i].rule)
> +			continue;
> +
> +		if (!rule1->lsm[i].rule || !rule2->lsm[i].rule)
> +			return false;
> +
> +		if (strcmp(rule1->lsm[i].args_p, rule2->lsm[i].args_p) != 0)
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
> +	ima_rules_tmp = rcu_dereference(ima_rules);
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
>   /**
>    * ima_parse_add_rule - add a rule to ima_policy_rules
>    * @rule: ima measurement policy rule
> @@ -1993,7 +2140,15 @@ ssize_t ima_parse_add_rule(char *rule)
>   		return result;
>   	}
>   
> -	list_add_tail(&entry->list, &ima_temp_rules);
> +	if (!ima_rule_exists(entry)) {
> +		list_add_tail(&entry->list, &ima_temp_rules);
> +	} else {
> +		result = -EEXIST;
Is it necessary to set result? Or can you just pass -EEXIST to the audit 
call below?

> +		ima_free_rule(entry);
> +		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
> +				    NULL, op, "duplicate-policy", result,
> +				    audit_info);
> +	}
>   
>   	return len;
>   }


