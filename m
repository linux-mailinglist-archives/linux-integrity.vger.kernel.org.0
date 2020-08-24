Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB0250ADE
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 23:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHXV3P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 17:29:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXV3P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 17:29:15 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E9BE20B4908;
        Mon, 24 Aug 2020 14:29:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E9BE20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598304554;
        bh=ip2NfJop1Mn4C2YXcC4jWvJF3zXEyShjXfQMZzz1iVg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tML63gh5vIHnEShue4Gs5/MFXFSbnNSfC0Xg3Rz86qEQjJCkZx1OZ2bBrGon+vqIx
         H9xTuCTTInq88f5FoCa+yhFtEr7FoHyiZvpo8Tvko6HInpTGRwnUza+RObtZRLSMp8
         D6BEQBhQ11OIbCxNAXvLWcv85l6kBhrSLIQmJ/zc=
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
Date:   Mon, 24 Aug 2020 14:29:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/24/20 1:01 PM, Ondrej Mosnacek wrote:
> On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
>> <nramas@linux.microsoft.com> wrote:
>>>
>>> On 8/24/20 7:00 AM, Stephen Smalley wrote:
>>>
>>>>> +int security_read_policy_kernel(struct selinux_state *state,
>>>>> +                               void **data, size_t *len)
>>>>> +{
>>>>> +       int rc;
>>>>> +
>>>>> +       rc = security_read_policy_len(state, len);
>>>>> +       if (rc)
>>>>> +               return rc;
>>>>> +
>>>>> +       *data = vmalloc(*len);
>>>>> +       if (!*data)
>>>>> +               return -ENOMEM;
>>>>>
>>>>> +       return security_read_selinux_policy(state, data, len);
>>>>>    }
>>>>
>>>> See the discussion here:
>>>> https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
>>>>
>>>> In order for this to be safe, you need to ensure that all callers of
>>>> security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
>>>> any use of security_read_policy_len() occurs while holding the mutex.
>>>> Otherwise, the length can change between security_read_policy_len()
>>>> and security_read_selinux_policy() if policy is reloaded.
>>>>
>>>
>>> "struct selinux_fs_info" is available when calling
>>> security_read_policy_kernel() - currently in measure.c.
>>> Only "struct selinux_state" is.
>>>
>>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
>>
>> No, I think perhaps we should move the mutex to selinux_state instead
>> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
>> it can then use it indirectly.  Note that your patches are going to
>> conflict with other ongoing work in the selinux next branch that is
>> refactoring policy load and converting the policy rwlock to RCU.
> 
> Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
> that would allow you to do this in a straightforward way without even
> messing with the fsi->mutex. My patch may or may not be eventually
> committed, but either way I'd recommend holding off on this for a
> while until the dust settles around the RCU conversion.
> 

I can make the SELinux\IMA changes in "selinux next branch" taking 
dependencies on Stephen's patches + relevant IMA patches.

Could you please let me know the URL to the "selinux next branch"?

thanks,
  -lakshmi

