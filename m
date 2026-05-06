Return-Path: <linux-integrity+bounces-9458-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAz2Lmmj+mlWQwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9458-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 04:11:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB104D5945
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12945304299D
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E62798F3;
	Wed,  6 May 2026 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G4xQIEJR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160278C9C
	for <linux-integrity@vger.kernel.org>; Wed,  6 May 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033509; cv=none; b=Y3mR+H0uzHgCoRnu2VuxwlWI2/7qeHhY0WVRbxbpzt/LTYLKVKyTIS2gjWHFw2KifYRl3nHWoIs5mERyDD+YJOCa6rCVPop1y9ZpxBWjNGyPtm0rjxDGKF2yE6n3jfkuiAhpW/QpvfhUaewbt8LnjK9Oo6aBJ3abIQ5O5S7jKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033509; c=relaxed/simple;
	bh=jr0C3ws9gN/dCpRosmQxsI5jdCjT1h5T1Ng7TbjVcBY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZaAAzTl9/aHZvQ0yiHLQxhySAZvt4KRvxXi4bBDeaqzqcAqKKkb5ygw7H5XYO6mDeElZVYl2BdrOimez/mDCoQKUXErS2V+i3c/3Yu2DAkGLtR3KVBg1jeVHtg7y0EfWSsqtbm9IxVXiqAnoS/4icX+m/1QiIA+s6ahv6RyRDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G4xQIEJR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ee7ffd738dso52103685a.1
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2026 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778033506; x=1778638306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrGezS/XNq9+psZQ70L22Z8q+JOJb1NZlusetExcJPM=;
        b=G4xQIEJR/ebOjowjSSdMTbqoNKWOl5jU7BKss3pM77W3gCg2St8Ue0lw15TNrBF5yG
         BG/LmFlgWOon/npVbLJdOHPM1xkdNAKTcJRXA1dAofk8PogkSBUC+PC8I6XLgI7tfGy0
         fp34/9U70domkU8qO+OUpBES5fw3pgPYbql01bA4+bwLfATPOlTZAJICFqJU6Xsdf4OJ
         g/sFb3CdEp3DcJvshSgvHwqQUXJohiA3dfmwE1tjLT4TFo+lIAfXx0LMbgT11QyhTJo6
         5yJRgMXJ4N18Rjf51FB8PVJ5iSKjoJtIi+M/p341WnJP1VAmnbAyNSpjPx/qhyhcMBvz
         k/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033506; x=1778638306;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrGezS/XNq9+psZQ70L22Z8q+JOJb1NZlusetExcJPM=;
        b=FvSJzmt+DVc14JT2dhZZ1Zg03GH0tHhnk3Z86n+klrQ+kDSsTVDDaL/obmaK2HB/dB
         gDzRvLGyXxutu7fCXgWGZq2e8L5XYn3nvtsTGUbm3z+vz8ui4g6ygtcC5lGLxKV5vfpH
         I/2fJkfpNywb80CtrilqxJp23kWsV8WNpDvJjf9yxdZTBht7CzXrDpgG8Y5Kr/GsxcZR
         4aLRNxfFncgoGHyUo+ISmatnz2nH4rk7f/oRpMRHyUrI8rvhewxzy1uus92xxTNTkgts
         Jn59rSZzF4BxamTc0eRhNFt0Jd3ZR3Wjt7PI2aJJ/PnhLTgCE/EtpzeULIeCBYDHW1E9
         dBrw==
X-Forwarded-Encrypted: i=1; AFNElJ9aR3NaCzK3VM8Gvusmq0EVN18lFVNZPixp+iZXabxlnfXCQrqvriA5ca8lI5HP55aw3L/MwVxXOV6a+Aqt8ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4s8kBJspryJfgl+z9omtMKNyQKBByNY3lBW5ZSL3sCo78HoC
	Q8WysFL8RtoC2s0e1FaGsDzc6EQdpAOHMGwZ8VVflf489UMKYyOG5Yau1+ZgxRnrjw==
X-Gm-Gg: AeBDiesbnMvBUT3F+atO+qVn9kt6/vKn3YRjD4mowupTJHHdLgKR+RR6Yh7hXXaDCUd
	Kk97CVYmKlpLXlY0797oabU5R67gzf/4TGah+WKr3/9JSvqemhozLBYyi56DG8QG6tD5h+jPf2P
	PxbtK3knEM8olNrAAS4OeK2PUfdyVHJoPYAG4eXMpAy87NeRtzdD9Odp5g5jW/GsXpOLebUQnYk
	hYTMtu56TGvd4jJyP/9501c2eh667vD8ZlLcv8TYrGhL55qUUxMcWfxKN1duPa3+kYDN1N8J12J
	OFl6uR8bppeJ3zzwqEEdWvD+fEvjOx/o0JQZBbZtS4r73CN8O3Ufe47AHAKe6SFi+PzvIk6Hy8+
	8+FT3wAY9NzVvgWXg5PUZyrKxduua7YzJc185BixbmehZiK4vSAzNY140F3fsAPDUP/8NZw8W4z
	R7XetqcNikDU56KRG3+hkLErptZd/Wbl122nrl50VDFf08QmYcolN7K3Oaez6wLZCm8oHxSMV9Y
	SwsoBWVR1bIOvX3CDU0tg==
X-Received: by 2002:a05:620a:318e:b0:8ee:fc5e:e2e9 with SMTP id af79cd13be357-902e298aa9cmr923174085a.13.1778033506563;
        Tue, 05 May 2026 19:11:46 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91e11fsm1471690385a.40.2026.05.05.19.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 19:11:45 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>, <jmorris@namei.org>, <serge@hallyn.com>, <roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>, <sudeep.holla@kernel.org>, <maz@kernel.org>, <oupton@kernel.org>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>, <catalin.marinas@arm.com>, <will@kernel.org>, <noodles@meta.com>, <sebastianene@google.com>
Date: Tue, 05 May 2026 22:11:42 -0400
Message-ID: <19dfb0e2730.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <5debff82dc758d9c91223e4f1f5b9e39a3fcd4f5.camel@linux.ibm.com>
References: <cover.1777036497.git.noodles@meta.com>
 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com>
 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
 <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
 <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com>
 <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
 <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
 <5debff82dc758d9c91223e4f1f5b9e39a3fcd4f5.camel@linux.ibm.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DB104D5945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9458-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On May 5, 2026 9:57:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Tue, 2026-05-05 at 18:55 -0400, Paul Moore wrote:
>> On Tue, May 5, 2026 at 5:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
>>>> On Mon, May 4, 2026 at 8:03 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>> On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
>>>>>> Regardless, assuming you always want IMA to leverage a TPMs when they
>>>>>> exist, your reply suggests that using an initcall based IMA init
>>>>>> scheme, even a late-sync initcall, may not be sufficient because
>>>>>> deferred TPM initialization could happen later, yes?
>>>>>
>>>>> Well yeah.  The TPM could be configured as a module, but that scenario is 
>>>>> not of
>>>>> interest.  That's way too late.  The case being addressed in this patch set is
>>>>> when the TPM driver tries to initialize at device_initcall, returns
>>>>> EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcall).  Since
>>>>> ordering within an initcall is not supported, this patch attempts to initialize
>>>>> IMA at late_initcall and similarly retries, in this case, at 
>>>>> late_initcall_sync.
>>>>
>>>> Okay, so from a TPM initialization perspective you are satisfied with
>>>> a late-sync IMA initialization, yes?
>>>
>>> No. On some architectures moving IMA initialization from the late_initcall to
>>> late_initcall_sync does not miss any measurement records. However, as 
>>> previously
>>> mentioned, Linux running in a PowerVM LPAR the move would drop ~30 measurement
>>> records[1].  So no, only if the TPM is not initialized by late_initcall, should
>>> IMA retry at late_initcall_sync.
>>
>> What do you do in the PowerVM LPAR when the TPM is not avaiable at
>> late initcall and you have to defer IMA initialization until
>> late-sync?
>
> Your question is hypothetical ...

<heavy eye roll>

> ... as the TPM isn't deferred, so IMA doesn't go into
> TPM-bypass mode.  Testing on a PowerVM LPAR demonstrated that it skips ~30
> measurement list records.  So moving the initcall to late_initcall_sync would
> cause a regression.

Let me rephrase to make the question clear - how do you plan to handle a 
system where you lose measurements by waiting until late-sync, but the TPM 
is not available at the late initcall.

--
paul-moore.com




