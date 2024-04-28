Return-Path: <linux-integrity+bounces-2250-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D68B4CF2
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Apr 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A321F212D8
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Apr 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4236FE39;
	Sun, 28 Apr 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ds50SL2c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FA1C2D
	for <linux-integrity@vger.kernel.org>; Sun, 28 Apr 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323618; cv=none; b=WCx+vI6pSgGnVgo8KljL0k6P9GmTXhOOOdtV7aT1KfnPrHY53WQi21EeoWTlp9v3CxqA7gio4yNJ01JodMv4MtdfNlbNZN422JVBlqSy7Cp/qkLivnXgZNu//vO+zr+P+QtwUPQ32VVqOB9DDpQ+28eYPtDCBP8S/dAzgA/xCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323618; c=relaxed/simple;
	bh=xk0X2ITBRgqtBY1M/c8x83mB7LlqCKtIYGLpUQE1HQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRUcdFjGuUttwVbgo05X983wmPItVcKMuXhwW3QkBWqDSObC8FekwU8U/sOFaYZfy0HGXMUxVZoQhdfxCH11VdzxH9YanTsbA3MucqwIy0ZeIIq+6dvuVTeGdR4o+rYWmjmuabzemP9wCoe5C8V63pcmAlsCGLBzqGwvqohCOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ds50SL2c; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714323615; bh=R2Nu2YXwPdA9mlPNSzZZ/2DzKV5DgggcguVQGLUE1kU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ds50SL2cLcHyP1YU1F6FKT4AnfuJWkHs5rgQXSi7XYDQv78lbrJ/P8DHQdkmjQ5rXdUNpWmnAVZEk0i9Yr8YNPL+tWYh1s03G/sIE9n6Ur8rCrV2dT8aa7DFB75wJ8JcxhZGsysEAiUWLrmaT9WA9N3Bizt89p6yna22osgdvfSd83AXRTBT0Pc+nvQaBfb8uPsfjzXfAeqS9m+0sU7w/Ll9SlPOGNO7gxQf1TqHe99pGRy5wEhEdqOnhNmXnyepU2WJkbUHAk6Ya2zLE0c6vBJITYBUsD1OMtVA1AVAnSLLxjKLbnwQqMjC3HEEtby95YkCHLpJtyyO0fE/HmydTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714323615; bh=ViIr873++zDFTKGn3Ihegj1xLtZyq8ATKnmyoEOs8xA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qgzTjDspO5Mb5/wqScmTr1Dfgf+z3J38Js9tD0OfP6kJZEHiLiteTsSFD/iqEGgytiGUVsZaZ3wYhn2YIfHf8xL1Q6UPtH2U3eqFE2jnBFZHWtFR0e9J1qOIvxtOOyt/fQPEeze6T4qL0YHvDUnWnhZz6IKG96K8ng6yBeMiUpOaMBYiO2hx/q4OHD67DDJMCmQtBeg530RN62cjOiy0eSJ6XXvd1w8tznus/36B2FzJHnebLNLjYhQYcith2/+lF+OTR5Oi0Xe3l89r4vIa9QnMLBVMeL/eMnJ964bLylARPiGWEpSJdv/3uHwwdS/F6+vpMjKnuasakbE5xXn7Rw==
X-YMail-OSG: WuBuhocVM1nJnyLuH3eyEV7YKubzkw9B5EYf8k86R12pBlo60Y0R91FFWupYmiq
 E0iTYmKzimXPwXO5PIgUhy5taV222AkBXnjTj_4N7NLsVqIMY2eBGGBnXtLA_X.Gz.X9WIBTreQA
 TNZsA9BxKtMbSqBpXtPsX8WyJwYELuLuWC64t5PdFTDx_2sUSune9.d9vjVQxWkHK92drAxyWDZt
 xV7m9VjH7E9I3vo41NgJTqjI7AiyS4zbWJOOrbvXosjI.N2Ygd5xv0Zbn7Sut2xcLpZ1vWJhz8jK
 NSPDeBg.rDtxh11nKtmyIja0d6ku.ZZ_awvZ19zn52JhM5b1qErJb.zw4wWyr.n7SleBB4n5UfzX
 n4KPU4lqoTZSreWb8OGZS60RVLub3fW8H.5GOqPRQcPFoNPZ4fk1qE3t0Dixxht7lq8eW.gxQrgx
 _qBbzIDWTq9Dloy2YjvJvbOd7HiRA4Z4242yh5.GC2.v9pdwfnFDZVb6lsaNxWsmHmklPSxAWJHm
 0Xum7pPeyN9WPaKlYIKzXjbEik0dtrnLriA3I.l.JysFPxKPN.kogg7wI8I88wFnZWJhr9138Y2c
 NjlEKqkYP2IDiRBAlSeJKIzV9g9vmYKURe3SdbMe_aumG53PjsTRpJA0RBD6DGLB.uC3lXwvkeyV
 ghsgL9pSypsf5kGuFQoOzdNKgyioXVGHGsQsqe7AEbU1ZX9MiseHPkQsUbCxMPV1B1pPLK5AOGmK
 RGJtSn_9v3ZF8eSfhUxAZBTE9nSKaF9QHRSR25WSotyFwfKJxzTPRXTTwgdikQBwDwutVIFZDmfI
 xFHp7HwihP7NwVh4oVY9vY4uB.aqWhayuUPy9WNQcbDvamfWdYeeXwZlvWnYGea9fnBtHLxMTYoL
 rod2k8vN1xpsRf_CU8CH4RF9h74lYcVvT14OALcHqVQsq4dV..gWzVkuZq0yBTams90YictAaBRp
 Y56CBTht8Jr9QMEtXW9T_u3unptjAWHkyGxG4bkN3YHy0ax09nCgDRSRa.zFoWiiZl70Rka8x.vu
 diVMRsaLSTX8wxqpqyfGrM1xMWJFx8AwNSUb8Icl4rSKW2dFC5g.X_vu4wAfjzVXnzqVa54wPNm1
 .TYfC8jxp9Cm6E_fAR.E0RqIjNOca3yXJX1cwcKs6DkhyZQV5PDqoZ.JkYJHGgNqEjo.k3KPUkcj
 vwhVkos_I27bPHJ3gl.MZTokLO8h0ALhnYfLATI3C0WXpVC95KjHgKZ_XeYarQCxe0ejASjuijIn
 hQ3XV4ygTuHJRGIffXZ2TtCY2nzoefoRY94rhEatexd8lwEsUTWfZoQX7oIIDZYPJBvj2DULvVA6
 Hg3NgINqtoi_5Zr_lIW_N1STq_EILtCmsB1BXz2dX0mgaohjtuViQg0E7CUQKzCnyHAcGTdRGH9s
 G1Qy_ouETDiQuTxszSiSCK3BKrpDztHajcg_zKWA9zcAoniYmfModNp92hqBUygL2ihC4NbYV4qY
 ZlfQqmvWW17krzMsuGXH4r9HBSypnEL.a5OJLVBXoEv6VBTYHvE3KeFHdEhHFrRV.gTpZuROX22M
 Hbn1etz_ORxw00L9m8P77gRYR4kaADdce5w6wqi4EaKNYL_4DLlpLpUrntcx3APM8xSVXXyeaN5r
 bcCgYZrMcqJF48JrHHg__NfykgqXqrybfHGPSmndvTJcG6ui24t98yYidqOAicy2izgDlJe05mMg
 k1f4gxP3Xalp5vBgE3V7er.N9cuUYzk2M0HVEuU8gIcznMabaHfEIEBr91Ra0bdrJNhmLQeEQqgt
 Mst2gf6hujs0CRFKO8wRduve4e5cER1DwRCN3z0.AvffLTY7X5hEZx23bnzSGUKCFbraKnF7KXTo
 rG3FUuYlgb1I9isFW_l8iXpVZ3KAWo7e7YJI3rnetQoLdWoKLyyynHaPP6SrxIgse3EZs6V0Mp2J
 YzkBemFiYvwfIpnfKQFUjTy78asLEIaZfzCbD.9d4c4H2_UmfsKKmMGMwnXHbXQfHjBZVIDr5FXq
 .fIKGlI82mcLseXxrLlPe5AbYotx1ngd3YrTG4ErvRWYI4yN8feh.QyJF4gW4VT0De7AS4ZfGAjK
 Z1KLTO98RuP_pVspHNtP4E2B8CJCisj1R5IlWeaiyFi3YvbaSQlh4G9TvYQKx81ForZHaBR_oQK.
 Y5AIKLkU3cuZsUSzM4kU8eSWcOZcDCjn8T3rczeLgj7HobPh.9qh.2o4nyfYCCvZwljNwj3gd5m2
 jm.9dDXcOSd5ctD3WHZpRRTVCWwILZGrqeijYdkYebZSGHAb81aJiqrSgQozwjwbwMVL1Y0yYTse
 ztN9FQw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6700f865-cc25-48e2-a20b-2d0b1ce55013
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sun, 28 Apr 2024 17:00:15 +0000
Received: by hermes--production-gq1-59c575df44-ftslf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d52c73b08ca2e7f397be816e324af8bc;
          Sun, 28 Apr 2024 16:39:56 +0000 (UTC)
Message-ID: <314b8900-a539-41cd-af60-48bf7bd05b87@schaufler-ca.com>
Date: Sun, 28 Apr 2024 09:39:53 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ima: Avoid blocking in RCU read-side critical section
To: GUO Zihua <guozihua@huawei.com>, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 LSM List <linux-security-module@vger.kernel.org>
References: <20240428091045.85513-1-guozihua@huawei.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240428091045.85513-1-guozihua@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/28/2024 2:10 AM, GUO Zihua wrote:
> A panic happens in ima_match_policy:

You need to add linux-security-module@vger.kernel.org to your CC list.

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
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
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
> ---
>
> v2:
>   Changed the audit_rule_init security hook to accept a new GFP flag, as
> per Stephen's suggestion.
>
> ---
>  include/linux/lsm_hook_defs.h       | 2 +-
>  include/linux/security.h            | 5 +++--
>  kernel/auditfilter.c                | 5 +++--
>  security/apparmor/audit.c           | 6 +++---
>  security/apparmor/include/audit.h   | 2 +-
>  security/integrity/ima/ima_policy.c | 8 +++++---
>  security/security.c                 | 6 ++++--
>  security/selinux/include/audit.h    | 4 +++-
>  security/selinux/ss/services.c      | 5 +++--
>  security/smack/smack_lsm.c          | 3 ++-
>  10 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 334e00efbde4..7e539f6f8c67 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -412,7 +412,7 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
>  
>  #ifdef CONFIG_AUDIT
>  LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
> -	 void **lsmrule)
> +	 void **lsmrule, gfp_t gfp)
>  LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
>  LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
>  LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41a8f667bdfa..5122e3ad83b1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2048,7 +2048,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
>  
>  #ifdef CONFIG_AUDIT
>  #ifdef CONFIG_SECURITY
> -int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> +int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			     gfp_t gfp);
>  int security_audit_rule_known(struct audit_krule *krule);
>  int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>  void security_audit_rule_free(void *lsmrule);
> @@ -2056,7 +2057,7 @@ void security_audit_rule_free(void *lsmrule);
>  #else
>  
>  static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
> -					   void **lsmrule)
> +					   void **lsmrule, gfp_t gfp)
>  {
>  	return 0;
>  }
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index be8c680121e4..d6ef4f4f9cba 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -529,7 +529,8 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>  			entry->rule.buflen += f_val;
>  			f->lsm_str = str;
>  			err = security_audit_rule_init(f->type, f->op, str,
> -						       (void **)&f->lsm_rule);
> +						       (void **)&f->lsm_rule,
> +						       GFP_KERNEL);
>  			/* Keep currently invalid fields around in case they
>  			 * become valid after a policy reload. */
>  			if (err == -EINVAL) {
> @@ -799,7 +800,7 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
>  
>  	/* our own (refreshed) copy of lsm_rule */
>  	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
> -				       (void **)&df->lsm_rule);
> +				       (void **)&df->lsm_rule, GFP_KERNEL);
>  	/* Keep currently invalid fields around in case they
>  	 * become valid after a policy reload. */
>  	if (ret == -EINVAL) {
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 45beb1c5f747..6b5181c668b5 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -217,7 +217,7 @@ void aa_audit_rule_free(void *vrule)
>  	}
>  }
>  
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp)
>  {
>  	struct aa_audit_rule *rule;
>  
> @@ -230,14 +230,14 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  		return -EINVAL;
>  	}
>  
> -	rule = kzalloc(sizeof(struct aa_audit_rule), GFP_KERNEL);
> +	rule = kzalloc(sizeof(struct aa_audit_rule), gfp);
>  
>  	if (!rule)
>  		return -ENOMEM;
>  
>  	/* Currently rules are treated as coming from the root ns */
>  	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
> -				     GFP_KERNEL, true, false);
> +				     gfp, true, false);
>  	if (IS_ERR(rule->label)) {
>  		int err = PTR_ERR(rule->label);
>  		aa_audit_rule_free(rule);
> diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
> index acbb03b9bd25..0c8cc86b417b 100644
> --- a/security/apparmor/include/audit.h
> +++ b/security/apparmor/include/audit.h
> @@ -200,7 +200,7 @@ static inline int complain_error(int error)
>  }
>  
>  void aa_audit_rule_free(void *vrule);
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
>  int aa_audit_rule_known(struct audit_krule *rule);
>  int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c0556907c2e6..216ffe388ce5 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  	 * Immutable elements are copied over as pointers and data; only
>  	 * lsm rules can change
>  	 */
> -	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> +	nentry = kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
>  	if (!nentry)
>  		return NULL;
>  
> @@ -425,7 +425,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     GFP_ATOMIC);
>  		if (!nentry->lsm[i].rule)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				nentry->lsm[i].args_p);
> @@ -1140,7 +1141,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  	entry->lsm[lsm_rule].type = audit_type;
>  	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>  				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      GFP_KERNEL);
>  	if (!entry->lsm[lsm_rule].rule) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			entry->lsm[lsm_rule].args_p);
> diff --git a/security/security.c b/security/security.c
> index 0a9a0ac3f266..4fd3c839353e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5331,15 +5331,17 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>   * @op: rule operator
>   * @rulestr: rule context
>   * @lsmrule: receive buffer for audit rule struct
> + * @gfp: GFP flag used for kmalloc
>   *
>   * Allocate and initialize an LSM audit rule structure.
>   *
>   * Return: Return 0 if @lsmrule has been successfully set, -EINVAL in case of
>   *         an invalid rule.
>   */
> -int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> +int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
> +			     gfp_t gfp)
>  {
> -	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule);
> +	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
>  }
>  
>  /**
> diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
> index 52aca71210b4..29c7d4c86f6d 100644
> --- a/security/selinux/include/audit.h
> +++ b/security/selinux/include/audit.h
> @@ -21,12 +21,14 @@
>   *	@op: the operator the rule uses
>   *	@rulestr: the text "target" of the rule
>   *	@rule: pointer to the new rule structure returned via this
> + *	@gfp: GFP flag used for kmalloc
>   *
>   *	Returns 0 if successful, -errno if not.  On success, the rule structure
>   *	will be allocated internally.  The caller must free this structure with
>   *	selinux_audit_rule_free() after use.
>   */
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule);
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
> +			    gfp_t gfp);
>  
>  /**
>   *	selinux_audit_rule_free - free an selinux audit rule structure.
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e88b1b6c4adb..ded250e525e9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3508,7 +3508,8 @@ void selinux_audit_rule_free(void *vrule)
>  	}
>  }
>  
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +			    gfp_t gfp)
>  {
>  	struct selinux_state *state = &selinux_state;
>  	struct selinux_policy *policy;
> @@ -3549,7 +3550,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  		return -EINVAL;
>  	}
>  
> -	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
> +	tmprule = kzalloc(sizeof(struct selinux_audit_rule), gfp);
>  	if (!tmprule)
>  		return -ENOMEM;
>  	context_init(&tmprule->au_ctxt);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..a4943628d75a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4696,7 +4696,8 @@ static int smack_post_notification(const struct cred *w_cred,
>   * Prepare to audit cases where (@field @op @rulestr) is true.
>   * The label to be audited is created if necessay.
>   */
> -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +				 gfp_t gfp)
>  {
>  	struct smack_known *skp;
>  	char **rule = (char **)vrule;

