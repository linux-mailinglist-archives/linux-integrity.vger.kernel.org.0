Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF0257EEB
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 18:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHaQjL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 12:39:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33892 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaQjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 12:39:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 671FC20B7178;
        Mon, 31 Aug 2020 09:39:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 671FC20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598891949;
        bh=GgBq+5VlMaXRLhKt8NiZM6TEsQUV1hrj4rr8ds/qjsk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r/gWRXXenYRrhPaikEQ9yCrJ/nfN5QdjLAq4e7Vlr6bLrSySkj/Lm9YqXHNBpyDgp
         MNimwrHUQ0d2NJGiLDhTkI0ejcmFlzzB8ZVlugXuXHg3v0klBGWf7COBfDNrdcNo/2
         p6Z2C20qjxsha2QQuhDfDh+V4zZ5cTP3gzbU7DPU=
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
 <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
 <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
 <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
 <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com>
 <07854807-c495-b7e5-fc44-26d78ff14f1b@linux.microsoft.com>
 <CAEjxPJ4TkEEKG+pXwUjyysov1s1mFk4jbGGVyC7ghmpfd3TJ4w@mail.gmail.com>
 <CAEjxPJ6GkUot29g5qq2GVYzmY2xwfTvVJkNP2kK54OcW7tkz1Q@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <612ec12d-0048-2a5f-83a5-518a11eb546d@linux.microsoft.com>
Date:   Mon, 31 Aug 2020 09:39:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6GkUot29g5qq2GVYzmY2xwfTvVJkNP2kK54OcW7tkz1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/31/20 7:47 AM, Stephen Smalley wrote:

>>>>
>>>
>>> Could you please let me know when the current set of changes in SELinux
>>> next branch would be completed and be ready to take new changes?
>>>
>>> I mean, roughly - would it be a month from now or you expect that to
>>> take longer?
>>
>> I can't speak for Paul but I would expect it to be sooner rather than
>> later. Ondrej has some follow ups on top of my policy rcu conversion
>> but then it should be good to go.
> 
> I think the major changes are now merged although there are still a
> couple of changes coming from Ondrej that could affect your code.  For
> your purposes, the important things to note are:
> 
> 1) The mutex has moved from selinux_fs_info to selinux_state and is
> now named policy_mutex.  You will need to take it around your call to
> security_read_policy_kernel().
> 
> 2) security_policydb_len() was removed and security_read_policy() just
> directly reads the policydb len.  You can do the same from your
> security_read_policy_kernel() variant.
> 
> 3) Ondrej has a pending change to move the policycap[] array from
> selinux_state to selinux_policy so that it can be atomically updated
> with the policy.
> 
> 4) Ondrej has a pending change to eliminate the separate initialized
> boolean from selinux_state and just test whether selinux_state.policy
> is non-NULL but as long as you are using selinux_initialized() to
> test, your code should be unaffected.
> 

Thanks a lot for the update Stephen.

I will start updating the IMA measurement changes in selinux next 
branch. Will post the patches this week.

  -lakshmi
