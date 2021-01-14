Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D42F6AD6
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 20:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbhANTWc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 14:22:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55824 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhANTWb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 14:22:31 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 662FE20B6C40;
        Thu, 14 Jan 2021 11:21:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 662FE20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610652110;
        bh=I4cAP2yTfzfJ6bR1hO7JL9ZSqeT+XfkyJmkXNFA+Ri8=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=QTUPALLIP+CeQ8+1BOPVQ92E6WwlvlOttIjBn6qLzJKYlREA/eVVZSv2tNFgveO89
         5vcDmYzq/27jUvRw7Hh5bEoFqsPPDi4fVhfui8t7/v1pMWtJ/PJsnCdj4bEGHCKnSP
         m/816JO+CtnH58UGFzByFXInU6P3NcpJN8LDnrTM=
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com>
 <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
 <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
 <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
 <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
 <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com>
 <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
 <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
 <3746bc7673df25354411151442a7772b867be396.camel@linux.ibm.com>
 <fc80b1a1-ff4d-3bf2-59bd-2cb56135bf0f@linux.microsoft.com>
 <99be76345f375bb2f485f08a53dcb8ed806dc538.camel@linux.ibm.com>
 <f42d49d2e876379c0ef6e31a34027be95ffb1375.camel@linux.ibm.com>
 <e883298b-1027-2a58-dcf8-fc940ebc27ff@linux.microsoft.com>
Message-ID: <507ebab8-828b-8b44-45be-2dbff3406b72@linux.microsoft.com>
Date:   Thu, 14 Jan 2021 11:21:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e883298b-1027-2a58-dcf8-fc940ebc27ff@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/14/21 9:48 AM, Lakshmi Ramasubramanian wrote:
> On 1/14/21 8:50 AM, Mimi Zohar wrote:
>> On Thu, 2021-01-14 at 11:44 -0500, Mimi Zohar wrote:
>>> [Cc'ing Sasha]
>>>
>>> Hi Lakshmi,
>>>
>>> On Thu, 2021-01-14 at 08:22 -0800, Lakshmi Ramasubramanian wrote:
>>>> On 1/13/21 6:49 PM, Mimi Zohar wrote:
>>>
>>>>>>> Lakshmi is trying to address the situation where an event changes a
>>>>>>> value, but then is restored to the original value.  The original and
>>>>>>> subsequent events are measured, but restoring to the original value
>>>>>>> isn't re-measured.  This isn't any different than when a file is
>>>>>>> modified and then reverted.
>>>>>>>
>>>>>>> Instead of changing the name like this, which doesn't work for 
>>>>>>> files,
>>>>>>> allowing duplicate measurements should be generic, based on policy.
>>>>>>
>>>>>> Perhaps it is just the end of the day and I'm a bit tired, but I just
>>>>>> read all of the above and I have no idea what your current thoughts
>>>>>> are regarding this patch.
>>>>>
>>>>> Other than appending the timestamp, which is a hack, the patch is 
>>>>> fine.
>>>>> Support for re-measuring an event can be upstreamed independently.
>>>>>
>>>>
>>>> Thanks for clarifying the details related to duplicate measurement
>>>> detection and re-measuring.
>>>>
>>>> I will keep the timestamp for the time being, even though its a 
>>>> hack, as
>>>> it helps with re-measuring state changes in SELinux. We will add 
>>>> support
>>>> for "policy driven" re-measurement as a subsequent patch series.
>>>
>>> Once including the timestamp is upstreamed, removing it will be
>>> difficult, especially if different userspace applications are dependent
>>> on it.  Unless everyone is on board that removing the timestamp
>>> wouldn't be considered a regression, it cannot be upstreamed.
>>
>> Feel free to just re-post just this one patch.  Otherwise the patch set
>> looks good.
>>
>> thanks,
>>
> 
> Sounds good Mimi - I will remove the timestamp and re-post the selinux 
> patch.
> 

I have removed the timestamp in the event name and have posted the 
selinux patch alone.

Thanks a lot for reviewing the changes.

  -lakshmi


