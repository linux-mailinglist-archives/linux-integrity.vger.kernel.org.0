Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5B22144D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGOSeJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 14:34:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38982 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOSeJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 14:34:09 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0456D20B4908;
        Wed, 15 Jul 2020 11:34:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0456D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594838048;
        bh=h/hY55Q0qtm8L3rDWYxgRPeKHyFR7vIM/95MK08uoXY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ENfLP4xnfL87tgV8bYKfz92gup/o0XmaYAr+T2UGIZhJW860xPQ5YxZUznSchJTxn
         GHmpXHtBTgrY48padhK2h6/aqsJrBj6X9abd+M9RE+9iyXjHt5b43Q/u3EbyiYhWvZ
         aOX3AM4xbrCHDMgVdUB3IWeUaHkvalD8r3+0cpGg=
Subject: Re: [PATCH v1 4/5] LSM: Define SELinux function to measure security
 state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
 <20200715154853.23374-5-nramas@linux.microsoft.com>
 <CAEjxPJ6UsK9QqFTpMKjgSin2Q6D-5NCNDS0enuRNuixVP9H2wQ@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fec80278-1306-787d-a8ed-615a3709ae77@linux.microsoft.com>
Date:   Wed, 15 Jul 2020 11:34:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6UsK9QqFTpMKjgSin2Q6D-5NCNDS0enuRNuixVP9H2wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/15/20 11:04 AM, Stephen Smalley wrote:

>> +static inline bool selinux_checkreqprot(void)
>> +{
>> +       struct selinux_state *state = &selinux_state;
>> +
>> +       return state->checkreqprot;
>> +}
> 
> Probably should use READ_ONCE().
Will do.

> 
>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>> new file mode 100644
>> index 000000000000..b909e8e61542
>> --- /dev/null
>> +++ b/security/selinux/measure.c
>> @@ -0,0 +1,122 @@
>> +int selinux_security_state(void)
> 
> Let's call this selinux_measure_state() or similar.  Needs a verb. And
> pass it a struct selinux_state * pointer argument to be measured, even
> though initially it will always be passed &selinux_state.  The
> encapsulation of selinux state within selinux_state was to support
> multiple selinux namespaces in the future, each with their own state.
Will do.

>> +       static char *security_state_string =
>> +                       "enabled=%d;enforcing=%d;checkreqprot=%d;"        \
>> +                       "netpeer=%d;openperm=%d;extsockclass=%d;"         \
>> +                       "alwaysnetwork=%d;cgroupseclabel=%d;"             \
>> +                       "nnpnosuidtransition=%d;genfsseclabelsymlink=%d;";
> 
> Rather than hardcoding policy capability names here, I would recommend
> using the selinux_policycap_names[] array for the names and the
> selinux_state.policycap[] array for the values.  Also recommend
> passing in a struct selinux_state * here to allow for future case
> where there are multiple selinux states, one per selinux namespace.
Will do.

> 
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index ef0afd878bfc..0c289d13ef6a 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -3724,10 +3724,11 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>>    * security_read_policy - read the policy.
>>    * @data: binary policy data
>>    * @len: length of data in bytes
>> - *
>> + * @alloc_kernel_memory: flag to indicate memory allocation
>>    */
>> -int security_read_policy(struct selinux_state *state,
>> -                        void **data, size_t *len)
>> +int security_read_selinux_policy(struct selinux_state *state,
>> +                                void **data, size_t *len,
>> +                                bool alloc_kernel_memory)
> 
> Instead of passing in a boolean to control how the memory is
> allocated, split this into a helper function that takes an
> already-allocated buffer and two
> different front-end wrappers, one for kernel-internal use and one for
> userspace use.
Will do.

> 
>> @@ -3738,7 +3739,10 @@ int security_read_policy(struct selinux_state *state,
>>
>>          *len = security_policydb_len(state);
>>
>> -       *data = vmalloc_user(*len);
>> +       if (alloc_kernel_memory)
>> +               *data = kzalloc(*len, GFP_KERNEL);
> 
> You need vmalloc() since policy image size may exceed kmalloc max (or
> at least that used to be the case).
Will do.

thanks,
  -lakshmi


