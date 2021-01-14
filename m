Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAE2F65CA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbhANQXc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 11:23:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33376 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANQXb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:31 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E852C20B6C40;
        Thu, 14 Jan 2021 08:22:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E852C20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610641370;
        bh=8KBsWFA0uQdPJalWO9bcjGILs5uqsg5GOYsPyXUXKMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mTtI4JG+13FKeFJaS+lUZgtByd4Xfm/FOqBumNKjFfHRu+xm/LtQDQ/NM3rSc1xMG
         IzpVB4HFbMfxv4HO1I61xiAJ70t9o2xTpczjlXT52C8R3cEw0o8bLbsJsQEkRJxNOp
         8bWdTMDbEOSZXv1FxLuSKLURovAmUj7+izH48Dpw=
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fc80b1a1-ff4d-3bf2-59bd-2cb56135bf0f@linux.microsoft.com>
Date:   Thu, 14 Jan 2021 08:22:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3746bc7673df25354411151442a7772b867be396.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/13/21 6:49 PM, Mimi Zohar wrote:

Hi Mimi,

>>>>>>>> I remain concerned about the possibility of bypassing a measurement by
>>>>>>>> tampering with the time, but I appear to be the only one who is
>>>>>>>> worried about this so I'm not going to block this patch on those
>>>>>>>> grounds.
>>>>>>>>
>>>>>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>>>>>
>>>>>>> Thanks, Paul.
>>>>>>>
>>>>>>> Including any unique string would cause the buffer hash to change,
>>>>>>> forcing a new measurement.  Perhaps they were concerned with
>>>>>>> overflowing a counter.
>>>>>>
>>>>>> My understanding is that Lakshmi wanted to force a new measurement
>>>>>> each time and felt using a timestamp would be the best way to do that.
>>>>>> A counter, even if it wraps, would have a different value each time
>>>>>> whereas a timestamp is vulnerable to time adjustments.  While a
>>>>>> properly controlled and audited system could be configured and
>>>>>> monitored to detect such an event (I *think*), why rely on that if it
>>>>>> isn't necessary?
>>>>>
>>>>> Why are you saying that even if the counter wraps a new measurement is
>>>>> guaranteed.   I agree with the rest of what you said.
>>>>
>>>> I was assuming that the IMA code simply compares the passed
>>>> "policy_event_name" value to the previous value, if they are different
>>>> a new measurement is taken, if they are the same the measurement
>>>> request is ignored.  If this is the case the counter value is only
>>>> important in as much as that it is different from the previous value,
>>>> even simply toggling a single bit back and forth would suffice in this
>>>> case.  IMA doesn't keep a record of every previous "policy_event_name"
>>>> value does it?  Am I misunderstanding how
>>>> ima_measure_critical_data(...) works?
>>>
>>> Originally, there was quite a bit of discussion as to how much or how
>>> little should be measured for a number of reasons.  One reason is that
>>> the TPM is relatively slow.  Another reason is to limit the size of the
>>> measurement list.  For this reason, duplicate hashes aren't added to
>>> the measurement list or extended into the TPM.
>>>
>>> When a dentry is removed from cache, its also removed from IMA's iint
>>> cache.  A subsequent file read would result in adding the measurement
>>> and extending the TPM again.  ima_lookup_digest_entry() is called to
>>> prevent adding the duplicate entry.
>>>
>>> Lakshmi is trying to address the situation where an event changes a
>>> value, but then is restored to the original value.  The original and
>>> subsequent events are measured, but restoring to the original value
>>> isn't re-measured.  This isn't any different than when a file is
>>> modified and then reverted.
>>>
>>> Instead of changing the name like this, which doesn't work for files,
>>> allowing duplicate measurements should be generic, based on policy.
>>
>> Perhaps it is just the end of the day and I'm a bit tired, but I just
>> read all of the above and I have no idea what your current thoughts
>> are regarding this patch.
> 
> Other than appending the timestamp, which is a hack, the patch is fine.
> Support for re-measuring an event can be upstreamed independently.
> 

Thanks for clarifying the details related to duplicate measurement 
detection and re-measuring.

I will keep the timestamp for the time being, even though its a hack, as 
it helps with re-measuring state changes in SELinux. We will add support 
for "policy driven" re-measurement as a subsequent patch series.

thanks,
  -lakshmi
