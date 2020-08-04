Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8453523BD30
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgHDP3o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgHDP3l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 11:29:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A383C06174A;
        Tue,  4 Aug 2020 08:29:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b25so31200713qto.2;
        Tue, 04 Aug 2020 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A3dFPndoyZvaWEl6YVaSywxK6lVziWTAEQzlumQD6Fs=;
        b=jZ2Jas15OLgmyhb72/ztVsVnNfEV5LeMoUoRQzqhZg2uMUEZuzDlWCZvZ9o/Z6c4Ga
         ZN08Z/F0NNr6/0b35XQHiji2W1nAdzt/d9R44eIknuUgLEyE6hIxSWYAPPLUe0lywx66
         nDp06wt43XmZ/CFOGnj4mDCHMvl9l8xo4y7rUQzWXKeZi+B9hBpxv5my4khl24R+Rk2j
         4ZlBvJc+igtHi8Pj8upBiENNO5Ev3loMwmgo8OsneFP0Vgp1m1zOSnLQoN3Gd4JyN6Kq
         jEje80e5k8uSgMvEPl4hpjbMlMIWhSufxgqKBThDb7xRsqZh3Ze+jgParxQqDB/Eu7Ok
         GoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A3dFPndoyZvaWEl6YVaSywxK6lVziWTAEQzlumQD6Fs=;
        b=Y/uosQC0XCIujQeVG8WXu3eajODjiL7IqbmGgYzkM8eMxGii4bbLe4W24wjYoQek6g
         8tcsgxSE3/zmNtlJxxKH8ygd4ZSBU1LJiq6I5d/nZopiCKwwvD9qSVhzQ3R5n+QJqOcL
         FB8EqRm6Ydojau3d+yuH9HwvpuE2BtV9qdC+WdrZ7kKVhN0kJkxi7Ms+90o8FWNqEIOl
         LtLcGZLtk+Ph9Q+JOd9kSgcaMzIxx2HTCzESnHevuvQJ1R59bVUDavBqnqpdvyJqd0Ov
         6ZueRJv1eLO2WKUiGe8gobIuFOC918npztge/5Bs0jIUbz+aojsVKAyNn/bARRkbs9wk
         P+zg==
X-Gm-Message-State: AOAM532E54lByEQifpSOsd7ZX7MtKsO9MIQT0zfVv+pPz2ZgRHJbH1Ax
        IEvfjYaznFT42854DU6tyX0GeI0bHjc=
X-Google-Smtp-Source: ABdhPJwQAAeoyAn31/xwdwHap5tFvMTs6BZKat8bFoDFP6/onB9Itr1XbdKiZVYUWS9WJMpJ5W8E6g==
X-Received: by 2002:ac8:4b4d:: with SMTP id e13mr21821962qts.256.1596554980407;
        Tue, 04 Aug 2020 08:29:40 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id d26sm17370443qtc.51.2020.08.04.08.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:29:39 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
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
 <0fa0b1f3-6226-c307-0f11-8b3a881a070e@gmail.com>
Message-ID: <32da0a4a-252a-67d8-5dc8-173959f6ddb4@gmail.com>
Date:   Tue, 4 Aug 2020 11:29:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fa0b1f3-6226-c307-0f11-8b3a881a070e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/20 11:20 AM, Stephen Smalley wrote:

> On 8/3/20 6:08 PM, Lakshmi Ramasubramanian wrote:
>
>> On 8/3/20 2:07 PM, Stephen Smalley wrote:
>>
>>>>>> [   68.870715] irq event stamp: 23486085
>>>>>> [   68.870715] hardirqs last  enabled at (23486085):
>>>>>> [<ffffffffaa419406>] _raw_spin_unlock_irqrestore+0x46/0x60
>>>>>> [   68.870715] hardirqs last disabled at (23486084):
>>>>>> [<ffffffffaa419443>] _raw_spin_lock_irqsave+0x23/0x90
>>>>>> [   68.870715] softirqs last  enabled at (23486074):
>>>>>> [<ffffffffaa8004f3>] __do_softirq+0x4f3/0x662
>>>>>> [   68.870715] softirqs last disabled at (23486067):
>>>>>> [<ffffffffaa601072>] asm_call_on_stack+0x12/0x20
>>>>>> [   68.870715] ---[ end trace fb02740ff6f4d0cd ]---
>>>>>
>>>>> I think one issue here is that systemd loads SELinux policy first, 
>>>>> then IMA policy, so it doesn't know whether it needs to measure 
>>>>> SELinux policy on first policy load, and another issue is that the 
>>>>> policy is too large to just queue the policy data itself this way 
>>>>> (or you need to use an allocator that can handle larger sizes).
>>>>>
>>>>
>>>> The problem seems to be that a lock is held when the IMA hook to 
>>>> measure the LSM state is called. So memory allocation is not 
>>>> allowed, but the hook is doing an allocation. I'll address this - 
>>>> thanks for catching it.
>>>>
>>>> I have the following CONFIGs enabled, but I still don't see the 
>>>> above issue on my machine.
>>>>
>>> The warning has to do with the memory allocation order being above 
>>> the max order supported for kmalloc.  I think the problem is that 
>>> ima_alloc_data_entry() is using kmemdup() to duplicate a payload of 
>>> arbitrary size.  Policies on e.g. Fedora can be quite large, so you 
>>> can't assume they can be allocated with kmalloc and friends.
>>>
>>
>> Thanks for clarifying. Yes ima_alloc_entry() does use kmemdup to save 
>> the given buffer (to be measured) until IMA loads custom policy.
>>
>> On my machine the SELinux policy size is about 2MB.
>>
>> Perhaps vmalloc would be better than using kmalloc? If there are 
>> better options for such large buffer allocation, please let me know.
>
> kvmalloc() can be used to select whichever one is most appropriate.

Other option would be for ima to compute and save the hash(es) of the 
payload and not the payload itself for later use.  I guess you won't 
know at that point which hash algorithm is desired?


