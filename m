Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFB23BD1A
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgHDPUg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgHDPU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 11:20:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C16C06174A;
        Tue,  4 Aug 2020 08:20:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id o2so19157977qvk.6;
        Tue, 04 Aug 2020 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dCP9Xm0N68g5DjjnQqpQuC5mXfr9g2liSIh6GF/hCR8=;
        b=LDvAYGN/SPiB6yt24Sm/wAzcsbexiUBVS8poqrZti9WWPLJZ1833ATXhKYVJJLXrrh
         isJy+Yt/IIUdspiRR72LpclBIzO8JqxfKLn/Bqu2txUR2BzxkusKf4Gxur5WZpAvvrKo
         kempoiCdTONDym6kuT9uR8Eb+qDC01jEzy97LXKyxKsRErEwnhiS3xjuQTNjCZjMGv3p
         LyHLGCWZD7OyMn29niN/QJ4N5IFNwebVMCkQgttzfYlcE9hNpE2H+A8nhANN5IJmWSNk
         bxbXiMUVhRFuBi9OCaHxMEU1BhApxzVK2tIMpvf+PNrkkp/y6uKzM21UgPPDdOikoKnX
         NNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dCP9Xm0N68g5DjjnQqpQuC5mXfr9g2liSIh6GF/hCR8=;
        b=B62BR9pXgweyOHtV/NA+sJ7aYeJWOzAwoghMn0mCtgH9sdvvaVI5UF1PvitMd4yKtw
         57pxU5EQb5qCc1FGEQ/pKJby66JvFwWiDiuSLCAaTehkv4qszBVlRVGyRa/XhR3OJcEh
         /utnfzXC9WaBW0SPqCNuJ/3IkiH+L2nMph+k29kHX6ArRv47yo86nVL9ProXV3X9xgql
         hjWLzZdIYtTO1hQy9eTRWGVttjzVTPlXylhgxdud1vBbcAf/ZYkf9/U6aA0YpNU1nQhM
         kDi6qBx0Q97Ip13LI1Exrvv6sHLtdmI0t9hQWBbKHE9kwoiVzyHG+EPHUcmjcKNwmoBn
         HUng==
X-Gm-Message-State: AOAM533c22RAY53cYRmoTQWuTq0e/nG+dgizxnRkkPhHjYWtfmkpU8lK
        fpSeOXF/VL2js8054ZI7zY5nfJNlFy0=
X-Google-Smtp-Source: ABdhPJxpXtGFCuYSn/U3asw4U0FrcgnKXGxQRue5ASTPwWIKYT1FOek8bQEkACQBkEpb3VmrpaYDZg==
X-Received: by 2002:ad4:414b:: with SMTP id z11mr21407735qvp.116.1596554426924;
        Tue, 04 Aug 2020 08:20:26 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id w44sm26278746qtj.86.2020.08.04.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:20:25 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-4-nramas@linux.microsoft.com>
 <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
 <6371efa9-5ae6-05ac-c357-3fbe1a5a93d5@linux.microsoft.com>
 <CAEjxPJ789kmdDwy-6RaL7HuMFxKpQ9Hwxj9J-_-f62XDCNJUiA@mail.gmail.com>
 <f992901f-6dca-7d31-3426-5a74d36c2c8c@gmail.com>
 <d988a6d0-04e0-62f0-2705-4352b268ca55@linux.microsoft.com>
 <5c843a3d-713c-e71f-8d4f-c6e5f51422f1@gmail.com>
 <3e766eed-7a0b-afca-6139-ac43dea053d7@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <0fa0b1f3-6226-c307-0f11-8b3a881a070e@gmail.com>
Date:   Tue, 4 Aug 2020 11:20:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3e766eed-7a0b-afca-6139-ac43dea053d7@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/3/20 6:08 PM, Lakshmi Ramasubramanian wrote:

> On 8/3/20 2:07 PM, Stephen Smalley wrote:
>
>>>>> [   68.870715] irq event stamp: 23486085
>>>>> [   68.870715] hardirqs last  enabled at (23486085):
>>>>> [<ffffffffaa419406>] _raw_spin_unlock_irqrestore+0x46/0x60
>>>>> [   68.870715] hardirqs last disabled at (23486084):
>>>>> [<ffffffffaa419443>] _raw_spin_lock_irqsave+0x23/0x90
>>>>> [   68.870715] softirqs last  enabled at (23486074):
>>>>> [<ffffffffaa8004f3>] __do_softirq+0x4f3/0x662
>>>>> [   68.870715] softirqs last disabled at (23486067):
>>>>> [<ffffffffaa601072>] asm_call_on_stack+0x12/0x20
>>>>> [   68.870715] ---[ end trace fb02740ff6f4d0cd ]---
>>>>
>>>> I think one issue here is that systemd loads SELinux policy first, 
>>>> then IMA policy, so it doesn't know whether it needs to measure 
>>>> SELinux policy on first policy load, and another issue is that the 
>>>> policy is too large to just queue the policy data itself this way 
>>>> (or you need to use an allocator that can handle larger sizes).
>>>>
>>>
>>> The problem seems to be that a lock is held when the IMA hook to 
>>> measure the LSM state is called. So memory allocation is not 
>>> allowed, but the hook is doing an allocation. I'll address this - 
>>> thanks for catching it.
>>>
>>> I have the following CONFIGs enabled, but I still don't see the 
>>> above issue on my machine.
>>>
>> The warning has to do with the memory allocation order being above 
>> the max order supported for kmalloc.  I think the problem is that 
>> ima_alloc_data_entry() is using kmemdup() to duplicate a payload of 
>> arbitrary size.  Policies on e.g. Fedora can be quite large, so you 
>> can't assume they can be allocated with kmalloc and friends.
>>
>
> Thanks for clarifying. Yes ima_alloc_entry() does use kmemdup to save 
> the given buffer (to be measured) until IMA loads custom policy.
>
> On my machine the SELinux policy size is about 2MB.
>
> Perhaps vmalloc would be better than using kmalloc? If there are 
> better options for such large buffer allocation, please let me know.

kvmalloc() can be used to select whichever one is most appropriate.


