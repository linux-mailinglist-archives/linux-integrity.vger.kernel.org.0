Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6A2332C1
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3NM2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 09:12:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40630 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NM2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 09:12:28 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C0AC320B4908;
        Thu, 30 Jul 2020 06:12:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0AC320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596114747;
        bh=s8mJv9YAJzJCZHgQrTYRSwjw1T2jhFhMQuqnKP9TJMA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lSya2PEk3bmUQMaWypDCGUZIZIcSyhTcN/lyjbU+HEIQHAmO03LnturBXZkot9wRr
         nV1CiZi7Lcg1+YLny9Nv6sZpzDY120ixfsNJKTmx/Uj5w/IDEgYcKQH/iBnIDHUVxp
         ++pKhH9Vpr9aMoNHj47LLi24XxKnT3J2bspn+jxM=
Subject: Re: Measure data again even when it has not changed
To:     Mimi Zohar <zohar@kernel.org>, linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>
References: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
 <59f23e8953c0735695e5679fc7b7021252837874.camel@linux.ibm.com>
 <a83fdf87-d98e-b5cd-2557-2fae88b09a13@linux.microsoft.com>
 <1596110753.25003.3.camel@kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <31db3e6f-c877-b359-19fd-cd09a58dbc13@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 06:12:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596110753.25003.3.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/30/20 5:05 AM, Mimi Zohar wrote:
> On Wed, 2020-07-29 at 20:41 -0700, Lakshmi Ramasubramanian wrote:
>> On 7/29/20 8:23 PM, Mimi Zohar wrote:
>>
>>> On Wed, 2020-07-29 at 10:17 -0700, Lakshmi Ramasubramanian wrote:
>>>> Hi Mimi,
>>>>
>>>> I have a query related to measuring data (by IMA subsystem) when that
>>>> data has been already been measured.
>>>>
>>>> Consider the following sequence of events:
>>>>
>>>> => At time T0 IMA hook is called by another subsystem to measure data
>>>> "foo". IMA measures it.
>>>>
>>>> => At time T1 data is "bar". IMA measures it.
>>>>
>>>> => At time T2 data is "foo" again. But IMA doesn't measure it since it
>>>> is already in the measured list.
>>>>
>>>> But for the subsystem making the call to IMA, the state has changed and
>>>> "foo" has to be measured again.
>>>>
>>>> One way to address the above is to use unique "event name" in each call
>>>> so that IMA measures the given data every time.
>>>>
>>>> Is there a better way to address the above?
>>>
>>> Most likely the file is being re-measured, but the new value already exists in
>>> the hash table so it isn't being added to the IMA measurement list or extending
>>> the TPM.  When IMA was upstreamed, there was concern about TPM performance and
>>> the number of measurements being extended.  We've improved TPM performance quite
>>> a bit.  If you're not concerned about TPM performance, I would define a new
>>> template data field based on i_version.
>>
>> In the use case I am considering the entity being measured is not a
>> file, but a memory buffer - it is for measuring an LSM's data
>> constructs. So i_version is not available in this case.
>>
>> When LSM's data changes from A to B and then back to A, hash(A) already
>> exists in IMA's hash table. So A is not measured again.
>>
>> Since LSM state change is not expected to be frequent, TPM performance
>> shouldn't be a concern.
> 
> Wouldn't a unique event name result in a new measurement every time?
> 

Adding Stephen.

Yes - but the LSM would call the IMA hook only when there is a change in 
the state.

I have posted a patch set for this last night -
it defines IMA hooks for measuring LSM data and uses that to measure 
SELinux data constructs. It can be used by other security modules as 
well. Please take a look.

thanks,
  -lakshmi




