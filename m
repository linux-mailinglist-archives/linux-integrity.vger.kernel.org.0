Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0C25222E
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYUtr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 16:49:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38300 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgHYUtp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 16:49:45 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id ABC0820B4908;
        Tue, 25 Aug 2020 13:49:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABC0820B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598388585;
        bh=AXCrYoOoelxGw8+skONas2F/8wHLEi1Bp9lwaPCUfI8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U7uFJoIS8to4BZiCjL+j1546Q9llSoY5DX8f2ghawSh1oTxC+zfJOKRc9xKwq9C8g
         ZA1Is3YmQHcBvOQUsjCaryRSijOFUPPcglq2FqEDjH05GfJpa9i7JSgNrWxLD+FMHH
         fAe9Ube9843Kw9b6sqxw0b6pNyx7zBTZMvbSz6D8=
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <07854807-c495-b7e5-fc44-26d78ff14f1b@linux.microsoft.com>
Date:   Tue, 25 Aug 2020 13:49:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/24/20 3:18 PM, Paul Moore wrote:

Hi Paul,

>>>>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
>>>>
>>>> No, I think perhaps we should move the mutex to selinux_state instead
>>>> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
>>>> it can then use it indirectly.  Note that your patches are going to
>>>> conflict with other ongoing work in the selinux next branch that is
>>>> refactoring policy load and converting the policy rwlock to RCU.
>>>
>>> Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
>>> that would allow you to do this in a straightforward way without even
>>> messing with the fsi->mutex. My patch may or may not be eventually
>>> committed, but either way I'd recommend holding off on this for a
>>> while until the dust settles around the RCU conversion.
>>
>> I can make the SELinux\IMA changes in "selinux next branch" taking
>> dependencies on Stephen's patches + relevant IMA patches.
> 
> I know it can be frustrating to hear what I'm about to say, but the
> best option is probably just to wait a little to let things settle in
> the SELinux -next branch.  There is a lot of stuff going on right now
> with patches flooding in (at least "flooding" from a SELinux kernel
> development perspective) and we/I've haven't gotten through all of
> them yet.
> 

Could you please let me know when the current set of changes in SELinux 
next branch would be completed and be ready to take new changes?

I mean, roughly - would it be a month from now or you expect that to 
take longer?

thanks,
  -lakshmi

