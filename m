Return-Path: <linux-integrity+bounces-2814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843248FBDDA
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FDFB21451
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7B14B09E;
	Tue,  4 Jun 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="u90UA7Dn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDA140375;
	Tue,  4 Jun 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535527; cv=none; b=h25El7UACJC3h8TA3zZf0Dc0lGju/sPO1J+Vw1gHPsMKdp7FkeorzS7hZ5dBXmwbdzLGcvbh+D4bnxgdzE6/KI9InK6fcidb3bg9Of9DK0/H5vC8FL0wV3Zkp5FXJsm2mrAIbOAKRl2HtLPqn/U9nR5VFkyTFIQmGmdeM0WdWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535527; c=relaxed/simple;
	bh=+3+nZYGwjMBo1h7rn9OlnQr17nh3Jw/L2+pFHPDLCx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck+IrPh2kdr4kxIZ+e+5VFaViKR3I4cSfJp0CrwOxpH2nWqHrzTI+0VRqYfCW/nL9DbvAp69bwHAlpWLJpy5kgdY0zqPQ8TmPPgY0rYF4Y043AhJn+ausg2qtEt1yJD2puiMrYRbulD+3dX8KBzjpNJ5F9TgQOq1KimmYjrmv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=u90UA7Dn; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.83] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EB3063F328;
	Tue,  4 Jun 2024 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717535514;
	bh=z4Ze92yVXDr3n5usDAZ1blNDkW5aBW5P6snB2x0NBiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=u90UA7DnIbSRbze+wlk7E1HmoX9YcV8SFDxJ5BMBaWbTvZyN+1HhTKXIQ85j3fnRC
	 ZMo5lTpX1PmH0B4Fd4YZhLSWJG46t/fwmZjtDUjwq30ONjDp7simQFP2RLvju27LpS
	 mXQLYCgY5NY54AJivGNDgmjmbsNtixTXK3AoD5TANNWxQwuLCf4wUWFWRr+JW6F3/f
	 GP3zAgEcDznNNPPmLkhIBQGm6u4e8+1LUIBgjtvAqUvbB8s5H8K5ibRrOC3+HIxIYq
	 hpkh1N3qA10hWrVDIYF/a5+QdM9Axd+yUPfVNV/xElAz4NULrb2yoN4jc+w/fT05JH
	 gD5ZTbBK7UPlA==
Message-ID: <39e025dc-9298-49c1-906a-008073489201@canonical.com>
Date: Tue, 4 Jun 2024 14:11:48 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
To: GUO Zihua <guozihua@huawei.com>, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com, stephen.smalley.work@gmail.com,
 casey@schaufler-ca.com, eparis@redhat.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com, audit@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20240507012541.796421-1-guozihua@huawei.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240507012541.796421-1-guozihua@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 18:25, GUO Zihua wrote:
> A panic happens in ima_match_policy:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ima_get_action+0x22/0x30
>   process_measurement+0xb0/0x830
>   ? page_add_file_rmap+0x15/0x170
>   ? alloc_set_pte+0x269/0x4c0
>   ? prep_new_page+0x81/0x140
>   ? simple_xattr_get+0x75/0xa0
>   ? selinux_file_open+0x9d/0xf0
>   ima_file_check+0x64/0x90
>   path_openat+0x571/0x1720
>   do_filp_open+0x9b/0x110
>   ? page_counter_try_charge+0x57/0xc0
>   ? files_cgroup_alloc_fd+0x38/0x60
>   ? __alloc_fd+0xd4/0x250
>   ? do_sys_open+0x1bd/0x250
>   do_sys_open+0x1bd/0x250
>   do_syscall_64+0x5d/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
> 
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
> 
> The root cause of this issue could be described as follows:
> |	Thread A	|	Thread B	|
> |			|ima_match_policy	|
> |			|  rcu_read_lock	|
> |ima_lsm_update_rule	|			|
> |  synchronize_rcu	|			|
> |			|    kmalloc(GFP_KERNEL)|
> |			|      sleep		|
> ==> synchronize_rcu returns early
> |  kfree(entry)		|			|
> |			|    entry = entry->next|
> ==> UAF happens and entry now becomes NULL (or could be anything).
> |			|    entry->action	|
> ==> Accessing entry might cause panic.
> 
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

this looks fine
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
> 
> v3:
>    ima_lsm_copy_rule takes a GFP flag as input as well.
> v2:
>    Changed the audit_rule_init security hook to accept a new GFP flag, as
> per Stephen's suggestion.
> 
> ---
>   include/linux/lsm_hook_defs.h       |  2 +-
>   include/linux/security.h            |  5 +++--
>   kernel/auditfilter.c                |  5 +++--
>   security/apparmor/audit.c           |  6 +++---
>   security/apparmor/include/audit.h   |  2 +-
>   security/integrity/ima/ima_policy.c | 15 +++++++++------
>   security/security.c                 |  6 ++++--
>   security/selinux/include/audit.h    |  4 +++-
>   security/selinux/ss/services.c      |  5 +++--
>   security/smack/smack_lsm.c          |  3 ++-
>   10 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 334e00efbde4..7e539f6f8c67 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -412,7 +412,7 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
>   
>   #ifdef CONFIG_AUDIT
>   LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
> -	 void **lsmrule)
> +	 void **lsmrule, gfp_t gfp)
>   LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
>   LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
>   LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41a8f667bdfa..5122e3ad83b1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2048,7 +2048,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
>   
>   #ifdef CONFIG_AUDIT
>   #ifdef CONFIG_SECURITY
> -int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> +int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			     gfp_t gfp);
>   int security_audit_rule_known(struct audit_krule *krule);
>   int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>   void security_audit_rule_free(void *lsmrule);
> @@ -2056,7 +2057,7 @@ void security_audit_rule_free(void *lsmrule);
>   #else
>   
>   static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
> -					   void **lsmrule)
> +					   void **lsmrule, gfp_t gfp)
>   {
>   	return 0;
>   }
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index be8c680121e4..d6ef4f4f9cba 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -529,7 +529,8 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>   			entry->rule.buflen += f_val;
>   			f->lsm_str = str;
>   			err = security_audit_rule_init(f->type, f->op, str,
> -						       (void **)&f->lsm_rule);
> +						       (void **)&f->lsm_rule,
> +						       GFP_KERNEL);
>   			/* Keep currently invalid fields around in case they
>   			 * become valid after a policy reload. */
>   			if (err == -EINVAL) {
> @@ -799,7 +800,7 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
>   
>   	/* our own (refreshed) copy of lsm_rule */
>   	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
> -				       (void **)&df->lsm_rule);
> +				       (void **)&df->lsm_rule, GFP_KERNEL);
>   	/* Keep currently invalid fields around in case they
>   	 * become valid after a policy reload. */
>   	if (ret == -EINVAL) {
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 45beb1c5f747..6b5181c668b5 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -217,7 +217,7 @@ void aa_audit_rule_free(void *vrule)
>   	}
>   }
>   
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp)
>   {
>   	struct aa_audit_rule *rule;
>   
> @@ -230,14 +230,14 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>   		return -EINVAL;
>   	}
>   
> -	rule = kzalloc(sizeof(struct aa_audit_rule), GFP_KERNEL);
> +	rule = kzalloc(sizeof(struct aa_audit_rule), gfp);
>   
>   	if (!rule)
>   		return -ENOMEM;
>   
>   	/* Currently rules are treated as coming from the root ns */
>   	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
> -				     GFP_KERNEL, true, false);
> +				     gfp, true, false);
>   	if (IS_ERR(rule->label)) {
>   		int err = PTR_ERR(rule->label);
>   		aa_audit_rule_free(rule);
> diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
> index acbb03b9bd25..0c8cc86b417b 100644
> --- a/security/apparmor/include/audit.h
> +++ b/security/apparmor/include/audit.h
> @@ -200,7 +200,7 @@ static inline int complain_error(int error)
>   }
>   
>   void aa_audit_rule_free(void *vrule);
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
>   int aa_audit_rule_known(struct audit_krule *rule);
>   int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
>   
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c0556907c2e6..09da8e639239 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -401,7 +401,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
>   	kfree(entry);
>   }
>   
> -static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> +static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry,
> +						gfp_t gfp)
>   {
>   	struct ima_rule_entry *nentry;
>   	int i;
> @@ -410,7 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>   	 * Immutable elements are copied over as pointers and data; only
>   	 * lsm rules can change
>   	 */
> -	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> +	nentry = kmemdup(entry, sizeof(*nentry), gfp);
>   	if (!nentry)
>   		return NULL;
>   
> @@ -425,7 +426,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>   
>   		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>   				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     gfp);
>   		if (!nentry->lsm[i].rule)
>   			pr_warn("rule for LSM \'%s\' is undefined\n",
>   				nentry->lsm[i].args_p);
> @@ -438,7 +440,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>   	int i;
>   	struct ima_rule_entry *nentry;
>   
> -	nentry = ima_lsm_copy_rule(entry);
> +	nentry = ima_lsm_copy_rule(entry, GFP_KERNEL);
>   	if (!nentry)
>   		return -ENOMEM;
>   
> @@ -664,7 +666,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>   		}
>   
>   		if (rc == -ESTALE && !rule_reinitialized) {
> -			lsm_rule = ima_lsm_copy_rule(rule);
> +			lsm_rule = ima_lsm_copy_rule(rule, GFP_ATOMIC);
>   			if (lsm_rule) {
>   				rule_reinitialized = true;
>   				goto retry;
> @@ -1140,7 +1142,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>   	entry->lsm[lsm_rule].type = audit_type;
>   	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>   				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      GFP_KERNEL);
>   	if (!entry->lsm[lsm_rule].rule) {
>   		pr_warn("rule for LSM \'%s\' is undefined\n",
>   			entry->lsm[lsm_rule].args_p);
> diff --git a/security/security.c b/security/security.c
> index 0a9a0ac3f266..4fd3c839353e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5331,15 +5331,17 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>    * @op: rule operator
>    * @rulestr: rule context
>    * @lsmrule: receive buffer for audit rule struct
> + * @gfp: GFP flag used for kmalloc
>    *
>    * Allocate and initialize an LSM audit rule structure.
>    *
>    * Return: Return 0 if @lsmrule has been successfully set, -EINVAL in case of
>    *         an invalid rule.
>    */
> -int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			     gfp_t gfp)
>   {
> -	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule);
> +	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
>   }
>   
>   /**
> diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
> index 52aca71210b4..29c7d4c86f6d 100644
> --- a/security/selinux/include/audit.h
> +++ b/security/selinux/include/audit.h
> @@ -21,12 +21,14 @@
>    *	@op: the operator the rule uses
>    *	@rulestr: the text "target" of the rule
>    *	@rule: pointer to the new rule structure returned via this
> + *	@gfp: GFP flag used for kmalloc
>    *
>    *	Returns 0 if successful, -errno if not.  On success, the rule structure
>    *	will be allocated internally.  The caller must free this structure with
>    *	selinux_audit_rule_free() after use.
>    */
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule);
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
> +			    gfp_t gfp);
>   
>   /**
>    *	selinux_audit_rule_free - free an selinux audit rule structure.
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e88b1b6c4adb..ded250e525e9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3508,7 +3508,8 @@ void selinux_audit_rule_free(void *vrule)
>   	}
>   }
>   
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +			    gfp_t gfp)
>   {
>   	struct selinux_state *state = &selinux_state;
>   	struct selinux_policy *policy;
> @@ -3549,7 +3550,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>   		return -EINVAL;
>   	}
>   
> -	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
> +	tmprule = kzalloc(sizeof(struct selinux_audit_rule), gfp);
>   	if (!tmprule)
>   		return -ENOMEM;
>   	context_init(&tmprule->au_ctxt);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..a4943628d75a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4696,7 +4696,8 @@ static int smack_post_notification(const struct cred *w_cred,
>    * Prepare to audit cases where (@field @op @rulestr) is true.
>    * The label to be audited is created if necessay.
>    */
> -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +				 gfp_t gfp)
>   {
>   	struct smack_known *skp;
>   	char **rule = (char **)vrule;


