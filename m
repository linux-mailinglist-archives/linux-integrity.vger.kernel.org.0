Return-Path: <linux-integrity+bounces-2360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F42128C28B2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0EF284F0B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2024 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D11A2C3A;
	Fri, 10 May 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XpFAszXG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5784161330
	for <linux-integrity@vger.kernel.org>; Fri, 10 May 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358237; cv=none; b=ZgO4V6W96ZmnJbcvUm6RPdll444h4LX0iLhCRbx/eHs8dQC6aY06UOStUw65/1AoualXETNOjs/XAUfKJl9i+fE6mYfmxWp4DBFIA8xnbc7LOGPZ2Vol2j78BLWkxDuF21xAmT0cbG+z0lhW+LQzy0bZJH4+sKJGDM+7C6yrcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358237; c=relaxed/simple;
	bh=lmSNSAVlJwC8QWoty9fKmUYXYzVZj7r5V6/K2NnIdno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE63vMQ7JNaOAKAnKLmbjeNMo3tynlKCtoRtIZO3OHq+Mw+EEhiowt8At+xSyohwDezuYWdW9sBppBEwuGzw7s811e+0wb/xiFZS7DMtmyirVZLSq+U0ZILTdhRDdAbvL+LEWTGU9FLAx0osCPZC0XFEQJQK6cPBLF16QKlivw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XpFAszXG; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715358234; bh=5XLR3EBIw7lnb+rS4VHbbSWXnZMKPca6mkXy6uJeRl0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XpFAszXGOVMDZqkGIse8WLrGdk/+oC2kmu5X9WXG9DflZ6ZEwlfm/sPdvctZCjjiTdWmPRnbDHyBT9y9S7fNEMK8HgnLCVgc/JYVJV5T7I1erDwWF9L+E7tgR1CSd0UVqsllMp3sFGEAfoBi5fdp3ov4VKolQjfO2VC8HtE3NTlsJB+u96XVKbbVOD/C6VJmiOILQw/VqUPCuLKM7u7sRGhy+92/0pt0WUYmKQ8ZEy86J45jdUDCQFlUEe/Htko0WZGCSCICRwu3fWXsGf21+CBHxrHtbwcYJUsnL5d0iy8MkeuB5iiMxkRAwiAzDzlkwNd6XWXoVTNC5eZfOpI1lA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715358234; bh=Oechh4YBd5vcmxng++MOWzHPH2rq+yi3zbR5UUCw6tF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SFM3ZtAVzPFHPnLLDAaPsImz6cAgDSLjUpHr/0rIMZnSJL9IHVD4F6jmuUm/po47p5KtNIXQlKE5DZ6RURGQE0g/pkFYgstjWPVuEmEPGHPNz3wo22QQqlhx4cgwQ25xsMQ953ClKhDozt+v6iR46JkQcJ/DszZJzEv3LMF6BfTCBmxG0DqmfrqTi2sxIehaTYkzRbqPlwmc7nedyUPZ3JMV0Izaf12yy/w4lRopZUlEWuHIW1r/tfIrPftzxje6VJynrLzPEP0XL+KguFX46b7PLn94LkdWHfFQRTqp3TnFX1gXpxLjWdnafwbTkxtb0WibG6p9xI/w/3yNAsfUBw==
X-YMail-OSG: Ep84enYVM1m97efRhU0mCN47dvxkYOn7JUfDjtvVVjAdiTsxOBNf88JJF9AmFcc
 hI6vNrBiJiaOalDLLw__7crwoAaiZ0NH8yjgwZ00KzYIX4rLLbMFuyxhb74OR1DMDuvpaNZhilNC
 gaiRsgeHft0_8svpEXgPw1WS33GIjxWXfOelsF1rkPrlK3M1zVS1gH_g9Ac2VhTm_RUDQi.NLQEx
 EKWHoA3ADUyLmasKVchAbzLJQc_WV7Wp5lj9Wl65GBruxQrax3wLgi5Wk29.iUHeTM0b.BR.x59i
 LioXbQF6dlph4GE4YjWwEglYPFPQfZwJxAEuEQewiStfkfB0tLPwnYSsxwEXEmQ49rdB8U4pMNCy
 bke1RDANnleAf1yIclyBBUzVkPQsTYFMCxwvrZOCb3cy6ujEb4_meMV9wf83UB6ja6mCjvkiWXCm
 UL3oeyyRTIk8oqUJJ1Tsjo6TU9Y7c5DYrY8Hnu28Sg9hJE4z6v26xAeKJnnQD2AMJU8f_1xMSF_.
 cF77rh6eeeDShKNkk43g5tiNrokyTftRo2.M8V0c034JFy6IN4U7uy0i.ODUH5X8kH_tOxRwZUnq
 9UTrnllFtpNBWyANOYlea1tkovHV3pMivn0zyR9Io4UdusOQxZQU6UEZQF3gHlS3kwlwfkOcBN7H
 tynq9PIG9MBJxBUwIReTzyO_vMJuYWVrFNJU4vx_9ouCVwwnxKrnxv66BwFZ7velqqrAbDPR.3yo
 WIMYPl6.MVazyTPZyMMzoCGZA0JJlIqVIu73sSAMe70jlY3eQ13fAIrKRYSNfT_w8sKq_mMgD2ER
 WsEPBRZNcKTIuGWPyVUCTqnCptNJKwLaOuJ6B836UdgAwo8AowD0LACQfTDABVZTuinaU.4d.a_9
 02YFeF8Cr7nOmOILFzzU7S8RRJ1KIJo46COqn7JW04KvS3MjHne4C0Qko5_Wljcy6wDi8vDpzQWY
 ELtbgDO3_aY2Y.mBTk9pOk65l.we.gXHEKAZi.UV.5jzpJO3.3SxNaXmp82ABCGNbeNsO_iQOtJM
 Y6DJ4itb5PGNLNrOACfPZ2IVh9fI96CcIgUpNhtHHsDrkaelmOKXosiTUM_HctqVu1DL0VEotWnA
 8MASgmwxycLpHMz0kmRqRP6lEAbtckKN5Vddlq2zg5EF1EEHwML9rrsxTOHo3M5BdhbBrxZkHRtI
 xZoMu2C9oHUu7R0WFGpIJnq5v8ANMQkoMXUWN3a5zH2SywHlK3xaG2dbLw.tgrLDHmhLX0eaRe5r
 OipvNiFu_g7scytsomdtp6.ryy2ximrUHSjLVXCpvspwXo7JaRSTpmtcipZjhqa4UEgNUjqxSTHj
 I.4_lhEjjHVKTs.BtPSi3zzDf1vaGHnevwoAdB409CjkCyldRzC4V9w7LhDqVe83VaFKW6ROUoyw
 yDUb3WruGcY1wox9_KANqK9MAwegzEcssVstIxgSq01y2i8ld_281.5w0Xb4rDJTMB1VeN5nE1Lw
 haFrR1QrOwAtni0KlCercX6BOXYTbdDC8.RsEadv..Rdjn_UWK7S_i5zwM3YYW2hFVyxA4Jf..0I
 YvDjTesQF8lOg9mRojPdQxYE4QEjh28rdOCJldLp6nBxxKCRHoms9ZtrJ7e3POvo3EmQ6ZerAqwb
 _8aZZDCivVBnqsI_tT5kzmZ2_83g8Hut.mlaSPaJwF7tRGaay2R.WR_VJYZe7rPRS2nR305kvR87
 6CqEsuuMkEM9JHTujOL3iCs4R2tj1xzJVAcnkfhKGk.5uEw0A8muEFZji2aOc4sX3Era2Tqmr3zG
 V9aVLFyo8_FPHxGzsTwLUEmMeCQyhDdUGKdZvl7lbmVPWGVFmqDwVGBW6nICZjrBI8oDNtnjB8pL
 ka1GN9QBSHRFiEAMrqvY6EX.mlIWrF5BtJpqrR_6GojBpqgdFqgbFF2kT5ke4oXon.saY26savU3
 aI.KvL_tttASa3ztDWLlmA53SUGpMxidiO442yZLDtiP_zdEoLWwoFOdF_RlJDRJuZuWPvkFuBVZ
 b1UDVaHksEaa9A5Jl9tXI2lQTDdjXoFK0ZSVdzS7RiuxX0rhundqe3ZHZDbFL6WrOmQGEpZokoTi
 iWH2dICoAd_d9iLgM3ScyNGwcmtgRbZfSaUINufauyTwZMHHblJt5fnccsftqYHilCEflzkjWFeT
 XyxHb_FhICO.muHjvk7QYI2T.j7Xy85cvuAk3GkENQxVlZlsoM_OKU7sO96gmVFWH68z_lOUmzPP
 ftscVCDcW47zroXiW22SBBYFSKnggTjOeHEyyFxDRO_j4Y88Uq9iFl7dJhkw1vHlPRaUhBqD5wls
 ymwQtzIqnAnrnRVw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4da128df-6383-41b0-9cfe-6ee715233a39
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 May 2024 16:23:54 +0000
Received: by hermes--production-gq1-59c575df44-94tst (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38847c749197c2be6fcf3efbf6fd4091;
          Fri, 10 May 2024 16:03:38 +0000 (UTC)
Message-ID: <a46c9c3f-9fec-43b0-8d21-e6ed1e42ee67@schaufler-ca.com>
Date: Fri, 10 May 2024 09:03:35 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
To: GUO Zihua <guozihua@huawei.com>, paul@paul-moore.com,
 john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 stephen.smalley.work@gmail.com, eparis@redhat.com
Cc: eric.snowberg@oracle.com, omosnace@redhat.com, audit@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240507012541.796421-1-guozihua@huawei.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240507012541.796421-1-guozihua@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/6/2024 6:25 PM, GUO Zihua wrote:
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

Looks fine from the Smack perspective.
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
> v3:
>   ima_lsm_copy_rule takes a GFP flag as input as well.
> v2:
>   Changed the audit_rule_init security hook to accept a new GFP flag, as
> per Stephen's suggestion.
>
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/security.h            |  5 +++--
>  kernel/auditfilter.c                |  5 +++--
>  security/apparmor/audit.c           |  6 +++---
>  security/apparmor/include/audit.h   |  2 +-
>  security/integrity/ima/ima_policy.c | 15 +++++++++------
>  security/security.c                 |  6 ++++--
>  security/selinux/include/audit.h    |  4 +++-
>  security/selinux/ss/services.c      |  5 +++--
>  security/smack/smack_lsm.c          |  3 ++-
>  10 files changed, 32 insertions(+), 21 deletions(-)
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
> index c0556907c2e6..09da8e639239 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -401,7 +401,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
>  	kfree(entry);
>  }
>  
> -static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> +static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry,
> +						gfp_t gfp)
>  {
>  	struct ima_rule_entry *nentry;
>  	int i;
> @@ -410,7 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  	 * Immutable elements are copied over as pointers and data; only
>  	 * lsm rules can change
>  	 */
> -	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> +	nentry = kmemdup(entry, sizeof(*nentry), gfp);
>  	if (!nentry)
>  		return NULL;
>  
> @@ -425,7 +426,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     gfp);
>  		if (!nentry->lsm[i].rule)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				nentry->lsm[i].args_p);
> @@ -438,7 +440,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>  	int i;
>  	struct ima_rule_entry *nentry;
>  
> -	nentry = ima_lsm_copy_rule(entry);
> +	nentry = ima_lsm_copy_rule(entry, GFP_KERNEL);
>  	if (!nentry)
>  		return -ENOMEM;
>  
> @@ -664,7 +666,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		}
>  
>  		if (rc == -ESTALE && !rule_reinitialized) {
> -			lsm_rule = ima_lsm_copy_rule(rule);
> +			lsm_rule = ima_lsm_copy_rule(rule, GFP_ATOMIC);
>  			if (lsm_rule) {
>  				rule_reinitialized = true;
>  				goto retry;
> @@ -1140,7 +1142,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
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

