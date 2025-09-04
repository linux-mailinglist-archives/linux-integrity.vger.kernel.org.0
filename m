Return-Path: <linux-integrity+bounces-7015-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25926B4363E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5989816A856
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D62C11EC;
	Thu,  4 Sep 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uBNBYSEQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE2C2343
	for <linux-integrity@vger.kernel.org>; Thu,  4 Sep 2025 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975730; cv=none; b=scs4KcWi+QsJzl6b4ugNGmOss5v34eZL+R/178eDV2PnV9RoDhqJ4zjm9QkmFtsYJTI4dEfWM5gxr4uJFrBv80afPc7+0Wh7T4t5AiXa0+EjGFGLhsV/4NlwXMKQQvM71jKPV2Y0JWnbn9hssd7ZXbycgadpJCLlwADldfcVSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975730; c=relaxed/simple;
	bh=EwazvWPzR8vepUOFTeCFvhzjfclqshZz/AXS2i/bgN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr1r8OJqUlITSjCQaVsVEQ51oJEE7QeWqCe51TXczAmtz5AUqfgaMcNjMBED+vtLFvxxGkIHvD/k6a8nE29LySE9yr2/EX5HDspvYb174DN0N9kmxDxTu2UJ0hBBN4H4yjE1uuRnmx4qlthaWIwDiUPgivjCBS8RFWoiDkpcoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uBNBYSEQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C98B3F7BE
	for <linux-integrity@vger.kernel.org>; Thu,  4 Sep 2025 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756975724;
	bh=SCbjyqx/Z9dzfw7O6LkSMU8fRG1enXlLIV6BCNnclyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uBNBYSEQ7ZXILqkyJgqsM2uy1rfzqJdPMoDFhxxXNToh7Az94AwYX18X6dFXqNSnu
	 CyOaFhxbGaR4RYQ03HhhPwbISgr5KSfFiJ9n1NNNDxYwCRFXWXJuXEVMdarEe669hE
	 laH3le5vvG19gxR8kXdaH0baS/guzRXvEEh+4uZqD7MrgZ4OxSM0Fcll8RH8OoaWDM
	 0oM8lcHS+yDuF018fe18gI5zmbJd/PiqJe8VmQL1LCo6tdV/FRgOKQseVLU6njVtba
	 6qk/bAeOu+EcXEtpj34vm4e2dMivvw5Q3V8p9Jb7cW3sOnL7Sld/hGA2GOgYbEz6dJ
	 CA1sOMCjOIcrw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b18ad403eso15397205ad.1
        for <linux-integrity@vger.kernel.org>; Thu, 04 Sep 2025 01:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975721; x=1757580521;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCbjyqx/Z9dzfw7O6LkSMU8fRG1enXlLIV6BCNnclyg=;
        b=rVRz7evxk665GAw0eVO0FKMoxG1LwwsW2uYsNttg8JFu/p0/j+Hn8P/uCveYDABiM0
         58+Chsp5lDPmbziRU5QqvBohpLvMweId/VQ9UkEutFrj3BOM1I5+v+/ur13r61+Yiiin
         AANHLu5EiEfSyUgO/B3JkWpx0Rk51zbI+gjXxyzLycGwTXv73WgzdAWEfK3woU12CZi5
         1qjKPIEo7SWH9S/qByc0Ppe1lX+cvNYxkaPHCkdMwkgMJLIoJNYbrMXT7MwtrRhS7qce
         /JizqWn4jb/dRelSyyf8qDwvby+pabnGcdl6vAoEFM0iCI7a7Iq5e6rd4g6Rd1NkCeho
         suZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+/qLsgNzuVk7lYotpzUKiNac0R9EHhidr3wuX82AGwqzsr28E7LYP2V8AeTh/vxClt/5gyy/5TGcChhTzwPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M6mk6NUv3/sw+SecMW5tk2UisYkPLGC7u2F/jvAI08x3zsLV
	guak+MMRh/2+vhpZfovcPoCfO65zjNCehoQKi2zZieOac0I72ibtYpFVzIRmMlUOVAoY3qnOqNC
	iwJk9whlx4ED7Eigj4AUyXudFxeT78cyau9RHwJfMNH3qLXABCqpbvtaHfYj6ZzwZHAU1GaNgU3
	kgtZCFI0t9qg==
X-Gm-Gg: ASbGncs5mamgZU12kKgiUrZOpvFetP+4sR1SrMnzzDeMTbkiur6QmWD0xMFkwzZXl88
	ZNMhHrmgScj9x/m7bKU0OunKFaWBS9su+9Uxt54IQWyhUtTSBZIRfgEe3Bwe6vshOpZ7y8qcPOr
	wMnIFdKC4dFa0Gwsi6OLGDaUHqwaLRH0tcYWKuNDUDQGir4Fr467jlke68y3yx2BkFeSxi/lvAl
	g09rW3BV4x6SMR6ZAiErt145Qx6eUSEXz/FCILqWb5bwPv7u3DqCh0cif7gHlZbYSxpxZ26Vl3G
	2e3pMMJ1WPsvssFOGOAlSkEE3w3bGmuiVatnJ6Vv7s4hd/DcDWfSLA==
X-Received: by 2002:a17:902:d489:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2493ef50b32mr246034055ad.16.1756975721469;
        Thu, 04 Sep 2025 01:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrAhLGvPBPAnqJegQYigIuZ/3LIk1Dzf8Cb4phjxceeJQe67hg5Gp6a9T/d3zw6XHlZmjzaA==
X-Received: by 2002:a17:902:d489:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2493ef50b32mr246033705ad.16.1756975720711;
        Thu, 04 Sep 2025 01:48:40 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24a956d9b7esm138336425ad.11.2025.09.04.01.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:48:40 -0700 (PDT)
Message-ID: <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
Date: Thu, 4 Sep 2025 01:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
 <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 01:12, Roberto Sassu wrote:
> On Tue, 2025-09-02 at 10:20 -0700, John Johansen wrote:
>> On 8/14/25 15:50, Paul Moore wrote:
>>> The LSM currently has a lot of code to maintain a list of the currently
>>> active LSMs in a human readable string, with the only user being the
>>> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
>>> generate the string on first use and then cache it for subsequent use.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>    include/linux/lsm_hooks.h |  1 -
>>>    security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
>>>    security/lsm_init.c       | 49 --------------------------------
>>>    3 files changed, 57 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 7343dd60b1d5..65a8227bece7 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -172,7 +172,6 @@ struct lsm_info {
>>>    
>>>    
>>>    /* DO NOT tamper with these variables outside of the LSM framework */
>>> -extern char *lsm_names;
>>>    extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>>>    
>>>    /**
>>> diff --git a/security/inode.c b/security/inode.c
>>> index 43382ef8896e..a5e7a073e672 100644
>>> --- a/security/inode.c
>>> +++ b/security/inode.c
>>> @@ -22,6 +22,8 @@
>>>    #include <linux/lsm_hooks.h>
>>>    #include <linux/magic.h>
>>>    
>>> +#include "lsm.h"
>>> +
>>>    static struct vfsmount *mount;
>>>    static int mount_count;
>>>    
>>> @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
>>>    EXPORT_SYMBOL_GPL(securityfs_remove);
>>>    
>>>    #ifdef CONFIG_SECURITY
>>> +#include <linux/spinlock.h>
>>> +
>>>    static struct dentry *lsm_dentry;
>>> +
>>> +/* NOTE: we never free the string below once it is set. */
>>> +static DEFINE_SPINLOCK(lsm_read_lock);
>>
>> nit, this is only used on the write side, so not the best name
>>
>>> +static char *lsm_read_str = NULL;
>>> +static ssize_t lsm_read_len = 0;
>>> +
>>>    static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>>>    			loff_t *ppos)
>>>    {
>>> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
>>> -		strlen(lsm_names));
>>> +	int i;
>>> +	char *str;
>>> +	ssize_t len;
>>> +
>>> +restart:
>>> +
>>> +	rcu_read_lock();
> 
> Uhm, it seems we cannot use plain RCU here, simple_read_from_buffer()
> can sleep.
> 

doh, yes.

But we shouldn't need RCU here either. This is a write once, never update
again situation. Instead we can get away with just a lock on the write
side to ensure exclusion on setting the value.

We don't even need the read side memory barrier, if the assumption that
the pointer is read as a single value holds, and the the null read will
go to the lock, and end up rereading.

> Roberto
> 
>>> +	if (!lsm_read_str) {
>> should probably be
>> if (!rcu_access_pointer(lsm_read_str)) {
>>
>>> +		/* we need to generate the string and try again */
>>> +		rcu_read_unlock();
>>> +		goto generate_string;
>>> +	}
>>> +	len = simple_read_from_buffer(buf, count, ppos,
>>> +				      rcu_dereference(lsm_read_str),
>>> +				      lsm_read_len);
>>> +	rcu_read_unlock();
>>> +	return len;
>>> +
>>> +generate_string:
>>> +
>>> +	for (i = 0; i < lsm_active_cnt; i++)
>>> +		/* the '+ 1' accounts for either a comma or a NUL */
>>> +		len += strlen(lsm_idlist[i]->name) + 1;
>>> +
>>> +	str = kmalloc(len, GFP_KERNEL);
>>> +	if (!str)
>>> +		return -ENOMEM;
>>> +	str[0] = '\0';
>>> +
>>> +	for (i = 0; i < lsm_active_cnt; i++) {
>>> +		if (i > 0)
>>> +			strcat(str, ",");
>>> +		strcat(str, lsm_idlist[i]->name);
>>> +	}
>>> +
>>> +	spin_lock(&lsm_read_lock);
>>> +	if (lsm_read_str) {
>>> +		/* we raced and lost */
>>> +		spin_unlock(&lsm_read_lock);
>>> +		kfree(str);
>>> +		goto restart;
>>> +	}
>>> +	lsm_read_str = str;
>>> +	lsm_read_len = len - 1;
>>> +	spin_unlock(&lsm_read_lock);
>>> +
>>> +	goto restart;
>>>    }
>>>    
>>>    static const struct file_operations lsm_ops = {
>>> diff --git a/security/lsm_init.c b/security/lsm_init.c
>>> index 9e495a36a332..87e2147016b3 100644
>>> --- a/security/lsm_init.c
>>> +++ b/security/lsm_init.c
>>> @@ -10,8 +10,6 @@
>>>    
>>>    #include "lsm.h"
>>>    
>>> -char *lsm_names;
>>> -
>>>    /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>>>    extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>>>    extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>>> @@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
>>>    	}
>>>    }
>>>    
>>> -static bool match_last_lsm(const char *list, const char *lsm)
>>> -{
>>> -	const char *last;
>>> -
>>> -	if (WARN_ON(!list || !lsm))
>>> -		return false;
>>> -	last = strrchr(list, ',');
>>> -	if (last)
>>> -		/* Pass the comma, strcmp() will check for '\0' */
>>> -		last++;
>>> -	else
>>> -		last = list;
>>> -	return !strcmp(last, lsm);
>>> -}
>>> -
>>> -static int lsm_append(const char *new, char **result)
>>> -{
>>> -	char *cp;
>>> -
>>> -	if (*result == NULL) {
>>> -		*result = kstrdup(new, GFP_KERNEL);
>>> -		if (*result == NULL)
>>> -			return -ENOMEM;
>>> -	} else {
>>> -		/* Check if it is the last registered name */
>>> -		if (match_last_lsm(*result, new))
>>> -			return 0;
>>> -		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
>>> -		if (cp == NULL)
>>> -			return -ENOMEM;
>>> -		kfree(*result);
>>> -		*result = cp;
>>> -	}
>>> -	return 0;
>>> -}
>>> -
>>>    static void __init lsm_static_call_init(struct security_hook_list *hl)
>>>    {
>>>    	struct lsm_static_call *scall = hl->scalls;
>>> @@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>>    		hooks[i].lsmid = lsmid;
>>>    		lsm_static_call_init(&hooks[i]);
>>>    	}
>>> -
>>> -	/*
>>> -	 * Don't try to append during early_security_init(), we'll come back
>>> -	 * and fix this up afterwards.
>>> -	 */
>>> -	if (slab_is_available()) {
>>> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
>>> -			panic("%s - Cannot get early memory.\n", __func__);
>>> -	}
>>>    }
>>>    
>>>    int __init early_security_init(void)
>>> @@ -488,8 +441,6 @@ int __init security_init(void)
>>>    	lsm_early_for_each_raw(lsm) {
>>>    		init_debug("  early started: %s (%s)\n", lsm->id->name,
>>>    			   is_enabled(lsm) ? "enabled" : "disabled");
>>> -		if (lsm->enabled)
>>> -			lsm_append(lsm->id->name, &lsm_names);
>>>    	}
>>>    
>>>    	/* Load LSMs in specified order. */
>>
> 


