Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE723AFF5
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgHCWIK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 18:08:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60894 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgHCWIK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 18:08:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F70520B4908;
        Mon,  3 Aug 2020 15:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F70520B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596492489;
        bh=lOuSme48DtaAahlNbilkFH/6Rv176zUXrsFgRlysqqs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WYjnd6dI4uoxBT0ptGFkjCRUWPUHavtt0YrQ+lPKDy6IEvcbD5UPs8HJ3W6vikKvE
         TiEHmYJcr9dIdemFW9y/E4Z45wzY7Fcf1YQc1I/0SA/teBekYShIVQOvFhhLfizxUE
         bX0N0toB9j6tQQ4f1YHNrFtNkSQ/72Ghl9PWNFJw=
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3e766eed-7a0b-afca-6139-ac43dea053d7@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 15:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c843a3d-713c-e71f-8d4f-c6e5f51422f1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/3/20 2:07 PM, Stephen Smalley wrote:

>>>> [   68.870715] irq event stamp: 23486085
>>>> [   68.870715] hardirqs last  enabled at (23486085):
>>>> [<ffffffffaa419406>] _raw_spin_unlock_irqrestore+0x46/0x60
>>>> [   68.870715] hardirqs last disabled at (23486084):
>>>> [<ffffffffaa419443>] _raw_spin_lock_irqsave+0x23/0x90
>>>> [   68.870715] softirqs last  enabled at (23486074):
>>>> [<ffffffffaa8004f3>] __do_softirq+0x4f3/0x662
>>>> [   68.870715] softirqs last disabled at (23486067):
>>>> [<ffffffffaa601072>] asm_call_on_stack+0x12/0x20
>>>> [   68.870715] ---[ end trace fb02740ff6f4d0cd ]---
>>>
>>> I think one issue here is that systemd loads SELinux policy first, 
>>> then IMA policy, so it doesn't know whether it needs to measure 
>>> SELinux policy on first policy load, and another issue is that the 
>>> policy is too large to just queue the policy data itself this way (or 
>>> you need to use an allocator that can handle larger sizes).
>>>
>>
>> The problem seems to be that a lock is held when the IMA hook to 
>> measure the LSM state is called. So memory allocation is not allowed, 
>> but the hook is doing an allocation. I'll address this - thanks for 
>> catching it.
>>
>> I have the following CONFIGs enabled, but I still don't see the above 
>> issue on my machine.
>>
> The warning has to do with the memory allocation order being above the 
> max order supported for kmalloc.  I think the problem is that 
> ima_alloc_data_entry() is using kmemdup() to duplicate a payload of 
> arbitrary size.  Policies on e.g. Fedora can be quite large, so you 
> can't assume they can be allocated with kmalloc and friends.
> 

Thanks for clarifying. Yes ima_alloc_entry() does use kmemdup to save 
the given buffer (to be measured) until IMA loads custom policy.

On my machine the SELinux policy size is about 2MB.

Perhaps vmalloc would be better than using kmalloc? If there are better 
options for such large buffer allocation, please let me know.

  -lakshmi
