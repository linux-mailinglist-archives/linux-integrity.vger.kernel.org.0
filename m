Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A550B2A3544
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Nov 2020 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBUi7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 15:38:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47780 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKBUiO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 15:38:14 -0500
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1337E20B4905;
        Mon,  2 Nov 2020 12:38:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1337E20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604349493;
        bh=A9puWUBw2GZStdPfUDTSMK8RC4dl3Ke5HWaaHfg3h+0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oyRIDQr2OzuPOugckBG7GYNCRXLddmjvNPH+24jtF64hgJV8+G3SDUIszswyftiiQ
         2m9l44GztdRqgIE8mQJN+DNef0rQCxRANSNyotZl73gNK7xt78sPeRsZ1Tato4o7Rn
         NFcwZUeuryt1kfBUZa0QH98UJC0kx4EvoHhsLH3A=
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
 <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
 <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
 <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
 <66678394f824be5367cc0e1745f1bda98b436550.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c8787d87-e098-26af-f522-b252592c8fb1@linux.microsoft.com>
Date:   Mon, 2 Nov 2020 12:38:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <66678394f824be5367cc0e1745f1bda98b436550.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-02 8:35 a.m., Mimi Zohar wrote:
> On Sat, 2020-10-31 at 20:08 -0700, Tushar Sugandhi wrote:
>> Hi Paul,
>>
>> On 2020-10-30 1:37 p.m., Paul Moore wrote:
>>> On Fri, Oct 30, 2020 at 12:43 PM Tushar Sugandhi
>>> <tusharsu@linux.microsoft.com> wrote:
>>>>> Unless this patch set is specifically dependent on the two patches in
>>>>> the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
>>>>
>>>> Thanks Mimi. We don't have dependencies on those two patches in SELinux
>>>> tree.
>>>>
>>>> We'll base our changes on v5.10.0-rc1 in SELinux tree.
>>>>
>>>> Thanks for the quick response.
>>>
>>> I'm not as fast as Mimi, but I thought it might be worthwhile to
>>> provide a bit more detail as to what I expect from SELinux kernel
>>> submissions.  I believe most other maintainers operate in a similar
>>> manner, but I obviously can't speak for them.
>> Thanks a lot for the detailed information Paul.
>> Its very helpful, and we appreciate it.
>>>
>>> Unless there is an exception due to a previous discussion, I ask that
>>> all SELinux kernel patches be based on either the selinux/next branch
>>> or Linus' current tree.  If your patch(set) applies cleanly to either
>>> of those branches, and passes review, I'll merge it into the
>>> selinux/next branch taking care of any merge conflicts that may arise.
>> We will base on SeLinux -> next branch, as you/Mimi suggested.
> 
> Unless there was a compelling reason for basing it on the SELinux
> branch, I asked that you base the changes on v5.10.0-rc1 (or later),
> which has nothing to do with the SELinux branch.  Once this patch set
> is reviewed and ready to be upstreamed, a topic branch will be created
> containing at least the IMA patches.   The decision as to how the the
> SELinux patch will be upstreamed will be made at that point.  That
> discussion will be between Paul and me.
> 
Sincere apologies Mimi.
We misunderstood your feedback when you mentioned -
"Unless this patch set is specifically dependent on the two patches in
the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1."

We believed you were recommending selinux repo as there were exactly
two patches present in the selinux/next branch after the tag v5.10-rc1.

Anyways - we tried applying the patches to -
repo: https://github.com/torvalds/linux
branch: master
tag: v5.10-rc1

and they get applied cleanly and are working fine.

We will wait for feedback on the v5 patch from you/Paul/Stephen, address
those, and then base v6 of the series to tarvolds/master branch on
v5.10-rc1 (or later).

Does it sound ok?

Here is the v5 of the series we published yesterday.
https://patchwork.kernel.org/project/linux-integrity/list/?series=375103

Thanks,
Tushar


> thanks,
> 
> Mimi
> 
