Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36C32F3E2
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCET37 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 14:29:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51860 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCET3s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 14:29:48 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1457220B83EA;
        Fri,  5 Mar 2021 11:29:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1457220B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614972588;
        bh=C6yfakTHu6d1eI3TYLCRPkMg4Ti+vegwEX0NiykQuoU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hpln3CAQrwyY4794PdvobdjJXJrkT6Eaw6MshSYNHF8DUz7yfgY07jS7s3sQw2ZQt
         pPPyNSZFBliuZqe1SAFGEDkRlcS18BPnWTHN+dSjR9s5SV9clJYzievx8zSb7UM8Rc
         /iTnm8a2bMK+Rb4/Rie+s1UND0o8IMxncfyejL1E=
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Paul Moore <paul@paul-moore.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
 <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
 <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
 <CAHC9VhRBdJ9Vh1ESezim129OEf1UJ-Mxm1g9FpxEJmt-PUSLjg@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9170636f-1793-2272-e3fe-1551c18edeb9@linux.microsoft.com>
Date:   Fri, 5 Mar 2021 11:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRBdJ9Vh1ESezim129OEf1UJ-Mxm1g9FpxEJmt-PUSLjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 11:22 AM, Paul Moore wrote:

Hi Paul,

> On Fri, Mar 5, 2021 at 12:57 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>> On Fri, 2021-03-05 at 12:52 -0500, Paul Moore wrote:
>> [...]
>>> This draft seems fine to me, but there is a small logistical blocker
>>> at the moment which means I can't merge this until -rc2 is released,
>>> which likely means this coming Monday.  The problem is that this
>>> patch relies on code that went upstream via in the last merge window
>>> via the IMA tree, not the SELinux tree; normally that wouldn't be a
>>> problem as I typically rebase the selinux/next to Linus' -rc1 tag
>>> once the merge window is closed, but in this particular case the -rc1
>>> tag is dangerously broken for some system configurations (the tag has
>>> since been renamed) so I'm not rebasing onto -rc1 this time around.
>>>
>>> Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
>>> next week I'll rebase selinux/next to -rc2 and merge this patch.
>>> However, if the swapfile bug continues past -rc2 we can consider
>>> merging this via the IMA tree, but I'd assume not do that if possible
>>> due to merge conflict and testing reasons.
>>
>> If it helps, we rebased the SCSI tree on top of the merge for the
>> swapfile fix which is this one, without waiting for -rc2:
> 
> Considering that -rc2 is only two days away I'm not going to lose a
> lot of sleep over it.
> 

Thanks for reviewing the patch.

I can wait until the swapfile issue is resolved (in rc2 or later) and 
you are able to merge this patch. Please take your time.

thanks,
   -lakshmi
