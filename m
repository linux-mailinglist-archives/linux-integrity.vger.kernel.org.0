Return-Path: <linux-integrity+bounces-2913-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04145912E9D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832701F226B6
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ADE16D4F9;
	Fri, 21 Jun 2024 20:34:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45794374DD;
	Fri, 21 Jun 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002089; cv=none; b=Ro4uFzeBx9UcC1yAGNVXc5XG6Az8lh6goBZSAY1qcDsCqkIvU02dX4DtNfx5C5BoeKoso+be5jHTV59WNXXLkVPT2/+aIfiiSGstHwUbSIWJgxZB35SGAd+lS6lRuXz3lFV86zLLyA9rmN456jdt6sDoEHZjdc2OeXWiaZ5VICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002089; c=relaxed/simple;
	bh=RT/+yhfG1qX8sq8+FisAQwWHObfiENnmk06EzW4HVak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLcxkTzy0iBnLofC4ApkpLXLxMZ+t3KB8EQ67/wTOvJ55wOg9ROq+KQZOEFeaOpDJhyQQYlHo+VJem1S6fQKy5XJiUPxQIRgmYRuCqNGLo+Muf8IIaUZtcIv0VE/Zdv5zvEMoGuYtxchs48EdEm/MEb/J1ZmIFOROTaHd17Sc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5TCn12j8z9v7Hk;
	Sat, 22 Jun 2024 04:16:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 439F31407FA;
	Sat, 22 Jun 2024 04:34:32 +0800 (CST)
Received: from [10.45.150.173] (unknown [10.45.150.173])
	by APP2 (Coremail) with SMTP id GxC2BwCXHzrM43VmwarhAA--.16019S2;
	Fri, 21 Jun 2024 21:34:31 +0100 (CET)
Message-ID: <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
Date: Fri, 21 Jun 2024 22:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
To: Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, mic@digikod.net,
 linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com>
 <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXHzrM43VmwarhAA--.16019S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryDCF48CrWkAF17Kry5twb_yoW7ZFW8pF
	WUKF4UCF48XFy7G3sa9wnrW3ZaqrWrGr1DZrsxG34DtFn0yrnrGr13Ar4rur9Ygr48Cr1I
	vF17WrW3uw4Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj5+PkAAAs1

On 6/21/2024 10:23 PM, Mimi Zohar wrote:
> On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
>> On Fri, Jun 21, 2024 at 12:50 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Fri, Dec 15, 2023 at 5:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Create real functions for the ima_filter_rule interfaces.
>>>> These replace #defines that obscure the reuse of audit
>>>> interfaces. The new functions are put in security.c because
>>>> they use security module registered hooks that we don't
>>>> want exported.
>>>>
>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> To: Mimi Zohar <zohar@linux.ibm.com>
>>>> Cc: linux-integrity@vger.kernel.org
>>>> ---
>>>>   include/linux/security.h     | 24 ++++++++++++++++++++++++
>>>>   security/integrity/ima/ima.h | 26 --------------------------
>>>>   security/security.c          | 21 +++++++++++++++++++++
>>>>   3 files changed, 45 insertions(+), 26 deletions(-)
>>>
>>> Mimi, Roberto, are you both okay if I merge this into the lsm/dev
>>> branch?  The #define approach taken with the ima_filter_rule_XXX
>>> macros likely contributed to the recent problem where the build
>>> problem caused by the new gfp_t parameter was missed during review;
>>> I'd like to get this into an upstream tree independent of the larger
>>> stacking effort as I believe it has standalone value.
>>
>> ... and I just realized neither Mimi or Roberto were directly CC'd on
>> that last email, oops.  Fixed.
> 
> Paul, I do see things posted on the linux-integrity mailing list pretty quickly.
> Unfortunately, something came up midday and I'm just seeing this now.  As for
> Roberto, it's probably a time zone issue.

Will review/check it first thing Monday morning.

Roberto

> The patch looks ok, but I haven't had a chance to apply or test it.  I'll look
> at it over the weekend and get back to you.
> 
> Mimi
> 
>>
>>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>>> index 750130a7b9dd..4790508818ee 100644
>>>> --- a/include/linux/security.h
>>>> +++ b/include/linux/security.h
>>>> @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *lsmrule)
>>>>   #endif /* CONFIG_SECURITY */
>>>>   #endif /* CONFIG_AUDIT */
>>>>
>>>> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
>>>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>>>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>>>> +void ima_filter_rule_free(void *lsmrule);
>>>> +
>>>> +#else
>>>> +
>>>> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
>>>> +                                          void **lsmrule)
>>>> +{
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>>>> +                                           void *lsmrule)
>>>> +{
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static inline void ima_filter_rule_free(void *lsmrule)
>>>> +{ }
>>>> +
>>>> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
>>>> +
>>>>   #ifdef CONFIG_SECURITYFS
>>>>
>>>>   extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
>>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>>> index c29db699c996..560d6104de72 100644
>>>> --- a/security/integrity/ima/ima.h
>>>> +++ b/security/integrity/ima/ima.h
>>>> @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
>>>>   }
>>>>   #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>>>>
>>>> -/* LSM based policy rules require audit */
>>>> -#ifdef CONFIG_IMA_LSM_RULES
>>>> -
>>>> -#define ima_filter_rule_init security_audit_rule_init
>>>> -#define ima_filter_rule_free security_audit_rule_free
>>>> -#define ima_filter_rule_match security_audit_rule_match
>>>> -
>>>> -#else
>>>> -
>>>> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
>>>> -                                      void **lsmrule)
>>>> -{
>>>> -       return -EINVAL;
>>>> -}
>>>> -
>>>> -static inline void ima_filter_rule_free(void *lsmrule)
>>>> -{
>>>> -}
>>>> -
>>>> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>>>> -                                       void *lsmrule)
>>>> -{
>>>> -       return -EINVAL;
>>>> -}
>>>> -#endif /* CONFIG_IMA_LSM_RULES */
>>>> -
>>>>   #ifdef CONFIG_IMA_READ_POLICY
>>>>   #define        POLICY_FILE_FLAGS       (S_IWUSR | S_IRUSR)
>>>>   #else
>>>> diff --git a/security/security.c b/security/security.c
>>>> index d7b15ea67c3f..8e5379a76369 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>>>   }
>>>>   #endif /* CONFIG_AUDIT */
>>>>
>>>> +#ifdef CONFIG_IMA_LSM_RULES
>>>> +/*
>>>> + * The integrity subsystem uses the same hooks as
>>>> + * the audit subsystem.
>>>> + */
>>>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>>>> +{
>>>> +       return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
>>>> +}
>>>> +
>>>> +void ima_filter_rule_free(void *lsmrule)
>>>> +{
>>>> +       call_void_hook(audit_rule_free, lsmrule);
>>>> +}
>>>> +
>>>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>>> +{
>>>> +       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>>>> +}
>>>> +#endif /* CONFIG_IMA_LSM_RULES */
>>>> +
>>>>   #ifdef CONFIG_BPF_SYSCALL
>>>>   /**
>>>>    * security_bpf() - Check if the bpf syscall operation is allowed
>>>> --
>>>> 2.41.0
> 


