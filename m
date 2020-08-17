Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28DB247B07
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHQXU1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 19:20:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60590 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHQXU1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 19:20:27 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8422020B4908;
        Mon, 17 Aug 2020 16:20:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8422020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597706425;
        bh=A+zf61jOkHNDiHT7zD/PpNx0R2iUw1Lg8D+5Srdt20k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HeTPrkfo2JeC1OZcPHHMnV8MGL8cu0d1d5OOXT4L9DHQiG8T1Dgn3c7LTfgWTEZZd
         n4Uq67TxTcTfoMKnRYkUQ+g4beV4ftHzQMXyGGcbHtjlrnPOn0lfF5OQ2Q2el9kMP/
         lzlBfI0f+p1Ix+KNyiMLVzg0ZWN+/fUIXlFzdDs8=
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com>
 <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
 <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
 <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
 <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
 <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
 <3679df359c35561f5bf6608911f96cc0292c7854.camel@linux.ibm.com>
 <57f972a7-26f1-3ac7-4001-54c0bc7e12a8@schaufler-ca.com>
 <089ca24d-863b-ca84-4859-d2d6e4f09b4c@linux.microsoft.com>
 <082a4311cd9211475df4c694f310f652d51e5d64.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a5b9e465-bcb5-e56a-513b-6c9094b8fa81@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 16:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <082a4311cd9211475df4c694f310f652d51e5d64.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/20 4:11 PM, Mimi Zohar wrote:
> On Mon, 2020-08-17 at 15:33 -0700, Lakshmi Ramasubramanian wrote:
>> On 8/17/20 3:00 PM, Casey Schaufler wrote:
>>> On 8/17/2020 2:31 PM, Mimi Zohar wrote:
>>>> On Thu, 2020-08-13 at 14:13 -0400, Stephen Smalley wrote:
>>>>> On Thu, Aug 13, 2020 at 2:03 PM Lakshmi Ramasubramanian
>>>>> <nramas@linux.microsoft.com> wrote:
>>>>>> On 8/13/20 10:58 AM, Stephen Smalley wrote:
>>>>>>> On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
>>>>>>> <nramas@linux.microsoft.com> wrote:
>>>>>>>> On 8/13/20 10:42 AM, Stephen Smalley wrote:
>>>>>>>>
>>>>>>>>>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..f21b7de4e2ae
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/security/selinux/measure.c
>>>>>>>>>> @@ -0,0 +1,204 @@
>>>>>>>>>> +static int selinux_hash_buffer(void *buf, size_t buf_len,
>>>>>>>>>> +                   void **buf_hash, int *buf_hash_len)
>>>>>>>>>> +{
>>>>>>>>>> +    struct crypto_shash *tfm;
>>>>>>>>>> +    struct shash_desc *desc = NULL;
>>>>>>>>>> +    void *digest = NULL;
>>>>>>>>>> +    int desc_size;
>>>>>>>>>> +    int digest_size;
>>>>>>>>>> +    int ret = 0;
>>>>>>>>>> +
>>>>>>>>>> +    tfm = crypto_alloc_shash("sha256", 0, 0);
>>>>>>>>>> +    if (IS_ERR(tfm))
>>>>>>>>>> +        return PTR_ERR(tfm);
>>>>>>>>> Can we make the algorithm selectable via kernel parameter and/or writing
>>>>>>>>> to a new selinuxfs node?
>>>>>>>> I can add a kernel parameter to select this hash algorithm.
>>>>>>> Also can we provide a Kconfig option for the default value like IMA does?
>>>>>>>
>>>>>> Would we need both - Kconfig and kernel param?
>>>>>>
>>>>>> The other option is to provide an IMA function to return the current
>>>>>> hash algorithm used for measurement. That way a consistent hash
>>>>>> algorithm can be employed by both IMA and the callers. Would that be better?
>>>>> This is why I preferred just passing the serialized policy buffer to
>>>>> IMA and letting it handle the hashing.  But apparently that approach
>>>>> wouldn't fly.  IMA appears to support both a Kconfig option for
>>>>> selecting a default algorithm and a kernel parameter for overriding
>>>>> it.  I assume the idea is that the distros can pick a reasonable
>>>>> default and then the end users can override that if they have specific
>>>>> requirements.  I'd want the same for SELinux.  If IMA is willing to
>>>>> export its hash algorithm to external components, then I'm willing to
>>>>> reuse that but not sure if that's a layering violation.
>>>> With the new ima_measure_critical_data() hook, I agree with you and
>>>> Casey it doesn't make sense for each caller to have to write their own
>>>> function.  Casey suggested exporting IMA's hash function or defining a
>>>> new common hash function.   There's nothing specific to IMA.
>>>
>>> Except that no one is going to use the function unless they're
>>> doing an IMA operation.
>>
>> Can we do the following instead:
>>
>> In ima_measure_critical_data() IMA hook, we can add another param for
>> the caller to indicate whether
>>
>>    => The contents of "buf" needs to be measured
>>       OR
>>    => Hash of the contents of "buf" needs to be measured.
>>
>> This way IMA doesn't need to export any new function to meet the hashing
>> requirement.
> 
> I'm not sure overloading the parameters is a good idea, but extending
> ima_measure_critical_data() to calculate a simple buffer hash should be
> fine.
> 

Sorry I wasn't clear - I didn't mean to say overload existing 
parameters, but extending the IMA hook to calculate the hash of the 
buffer - like the following:

int ima_measure_critical_data(const char *event_name,
                               const char *event_data_source,
                               const void *buf, int buf_len,
                               bool measure_buf_hash);

If measure_buf_hash is true, IMA will calculate the hash of contents of 
"buf" and measure the hash.
Else, IMA will measure the contents of "buf".

  -lakshmi


