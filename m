Return-Path: <linux-integrity+bounces-5898-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD50A8AB49
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DB93AE558
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C22741A9;
	Tue, 15 Apr 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AA2M7U8E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11501161310;
	Tue, 15 Apr 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756227; cv=none; b=Jv+b/f40NhpR04UBRr+odSdwGZqRgqDPH08bmZfbccg7bIcrHWEYe5slGM9Ptdp/rJwVc5qtzXXj25LGbLR8CakX26gGVQ9AV58R0WDr8Wevolebs8/3D+muiln2g22d2Lc5cfDHutAOWYdfKMVmr4ecrmgyYjNQxp0qrucx0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756227; c=relaxed/simple;
	bh=sm4m4Ic1r6NGTXiHiFp3iMuC4VALm6Hln+XUk/0O7dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBUBPjU3ECVs8ngc7EmcSWv+alOXqrv6hw0qkisV7LrRt+kJQjxUbvXFLssxq0OYvAT6prPsaHkLqthqe5PQTHH/OLfvjSDGadUSUz+knliWQcBWEjIp2gJdP0+lDtsjvdyRBjXmYFa1sbTkElOGjZPfBN6roG35RVNuS3vfBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AA2M7U8E; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 275363FFBD;
	Tue, 15 Apr 2025 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744756214;
	bh=7xg0mN2qYJiYxvFo4La6OGn/H9iXblVBNB/eOGi69YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=AA2M7U8E61gLuAtcR1MmlnIHrroDzdhpethO12wDheKLYEsDn0BFZSvvz2hUv3JU1
	 dNTLPQ45deS9jLcH/7ILfj3kFgsZiwUByT99Fqn3XIT/3jn+BOQxBo9bH2AS1cP8f9
	 E4N70yHqlo1RTGSkzl0JzaM7IheoVcsxIktE0/Fsy4/dHlVF5xuUZYAvIxrwQI6oee
	 GOfcMioubIue8gJ38yfqGGN3ahvz71Sxk1LFHTmrdtVXW+EjXwdMpJ+LvxEK/IL5V6
	 2QimebIE0KeFYdqEUKNvKqUSAjhbmFxzse9PNoe5F256NSZQSOu4Hdg2t5AY+msBXJ
	 ju7raYw6ODygA==
Message-ID: <03eeafb2-12e7-44a2-b0fc-cf26fa256f1b@canonical.com>
Date: Tue, 15 Apr 2025 15:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some
 cleanup
To: Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-39-paul@paul-moore.com>
 <202504091607.0A394D5EF@keescook>
 <CAHC9VhS4nB2xV-zw+=eN2MYaetvCkParammXn1fPGsm-wuHtTw@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhS4nB2xV-zw+=eN2MYaetvCkParammXn1fPGsm-wuHtTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 15:47, Paul Moore wrote:
> On Wed, Apr 9, 2025 at 7:13 PM Kees Cook <kees@kernel.org> wrote:
>>
>> On Wed, Apr 09, 2025 at 02:49:53PM -0400, Paul Moore wrote:
>>> The LSM currently has a lot of code to maintain a list of the
>>> currently active LSMs in a human readable string, with the only
>>> user being the "/sys/kernel/security/lsm" code.  Let's drop all
>>> of that code and generate the string on an as-needed basis when
>>> userspace reads "/sys/kernel/security/lsm".
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>   include/linux/lsm_hooks.h |  1 -
>>>   security/inode.c          | 27 +++++++++++++++++++--
>>>   security/lsm_init.c       | 49 ---------------------------------------
>>>   3 files changed, 25 insertions(+), 52 deletions(-)
> 
> ...
> 
>>> @@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
>>>   static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>>>                        loff_t *ppos)
>>>   {
>>> -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
>>> -             strlen(lsm_names));
>>> +     int i;
>>> +     char *str;
>>> +     ssize_t rc, len = 0;
>>> +
>>> +     for (i = 0; i < lsm_count; i++)
>>> +             /* the '+ 1' accounts for either a comma or a NUL terminator */
>>> +             len += strlen(lsm_order[i]->id->name) + 1;
>>> +
>>> +     str = kmalloc(len, GFP_KERNEL);
>>> +     if (!str)
>>> +             return -ENOMEM;
>>> +     str[0] = '\0';
>>> +
>>> +     i = 0;
>>> +     while (i < lsm_count) {
>>> +             strcat(str, lsm_order[i]->id->name);
>>> +             if (++i < lsm_count)
>>> +                     strcat(str, ",");
>>> +     }
>>> +
>>> +     rc = simple_read_from_buffer(buf, count, ppos, str, len);
>>> +     kfree(str);
>>> +     return rc;
>>
>> Hrm, at least cache it?
> 
> Are you aware of a performance critical use of this?
> 
no I can't see anything performance critical, I think it just is cleaner
to only generate once if after init the list doesn't change.

>> Better yet, do this whole thing in a initcall after LSMs are loaded, and
>> both can gain __ro_after_init...
> 
> I *really* disliked all the stuff we were having to do during boot,
> and all the redundant global state we were keeping around.  I'll go
> ahead and cache the lsm_read() result local to the function but that's
> probably all I'm going to accept at this point in time.
> 
fair, I don't even think this needs to be changed, I think kees's suggestion
is more of a nice to have


