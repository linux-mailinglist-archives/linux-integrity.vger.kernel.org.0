Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA122AA191
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Nov 2020 00:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKFXwQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 18:52:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35246 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKFXv5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 18:51:57 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 65C7C20B4905;
        Fri,  6 Nov 2020 15:51:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65C7C20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604706716;
        bh=kxGG60RxNjicxicPDbW3b+qxMgL79W4w0YXfA5Y3vXU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ex4EsTrt+j5vt4L1eNjZYdFgpeTFKDoZ5jgR2zpjEXTnRPKKHXcfm+Ynn9jNE9hvc
         NwVziSgFGzqJfvGTP9cytdr4U6rByB3I49bfWK3vXJZSrSfWDqjltnJgYD04Tksm/k
         Gr8k8DbOaTjLewSUY1EooTrwSI9KK+zMWouAhXG4=
Subject: Re: [PATCH v5 6/7] IMA: add critical_data to the built-in policy
 rules
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-7-tusharsu@linux.microsoft.com>
 <7219f4404bc1bed6eb090b94363c283ec3266a17.camel@linux.ibm.com>
 <cdcd63f7-ce1f-4463-f886-c36832d7a706@linux.microsoft.com>
Message-ID: <d92869b5-7244-e29e-5d30-c0e06cf45be1@linux.microsoft.com>
Date:   Fri, 6 Nov 2020 15:51:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cdcd63f7-ce1f-4463-f886-c36832d7a706@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/6/20 7:37 AM, Lakshmi Ramasubramanian wrote:

Hi Mimi,

> 
>> Hi Lakshmi, Tushar,
>>
>> This patch defines a new critical_data builtin policy.  Please update
>> the Subject line.
>>
>> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>
>>> The IMA hook to measure kernel critical data, namely
>>> ima_measure_critical_data(), could be called before a custom IMA policy
>>> is loaded. For example, SELinux calls ima_measure_critical_data() to
>>> measure its state and policy when they are initialized. This occurs
>>> before a custom IMA policy is loaded, and hence IMA hook will not
>>> measure the data. A built-in policy is therefore needed to measure
>>> critical data provided by callers before a custom IMA policy is loaded.
>>
>> ^Define a new critical data builtin policy to allow measuring early
>> kernel integrity critical data before a custom IMA policy is loaded.
> 
> I will add the above line in the patch description.
> 
>>
>> Either remove the references to SELinux or move this patch after the
>> subsequent patch which measures SELinux critical data.
> 
> I will remove the reference to SELinux.
> I think it would be better to have this patch before the SELinux 
> measurement patch.
> 
>>
>>>
>>> Add CRITICAL_DATA to built-in IMA rules if the kernel command line
>>> contains "ima_policy=critical_data". Set the IMA template for this rule
>>> to "ima-buf" since ima_measure_critical_data() measures a buffer.
>>>
>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>>> ---
>>>   security/integrity/ima/ima_policy.c | 32 +++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/security/integrity/ima/ima_policy.c 
>>> b/security/integrity/ima/ima_policy.c
>>> index ec99e0bb6c6f..dc8fe969d3fe 100644
>>> --- a/security/integrity/ima/ima_policy.c
>>> +++ b/security/integrity/ima/ima_policy.c
>>
>>> @@ -875,6 +884,29 @@ void __init ima_init_policy(void)
>>>                 ARRAY_SIZE(default_appraise_rules),
>>>                 IMA_DEFAULT_POLICY);
>>> +    if (ima_use_critical_data) {
>>> +        template = lookup_template_desc("ima-buf");
>>> +        if (!template) {
>>> +            ret = -EINVAL;
>>> +            goto out;
>>> +        }
>>> +
>>> +        ret = template_desc_init_fields(template->fmt,
>>> +                        &(template->fields),
>>> +                        &(template->num_fields));
>>
>> The default IMA template when measuring buffer data is "ima_buf".   Is
>> there a reason for allocating and initializing it here and not
>> deferring it until process_buffer_measurement()?
>>
> 
> You are right - good catch.
> I will remove the above and validate.
> 

process_buffer_measurement() allocates and initializes "ima-buf" 
template only when the parameter "func" is NONE. Currently, only 
ima_check_blacklist() passes NONE for func when calling 
process_buffer_measurement().

If "func" is anything other than NONE, ima_match_policy() picks
the default IMA template if the IMA policy rule does not specify a template.

We need to add "ima-buf" in the built-in policy for critical_data so 
that the default template is not used for buffer measurement.

Please let me know if I am missing something.

thanks,
  -lakshmi

>>
>>> +        if (ret)
>>> +            goto out;
>>> +
>>> +        critical_data_rules[0].template = template;
>>> +        add_rules(critical_data_rules,
>>> +              ARRAY_SIZE(critical_data_rules),
>>> +              IMA_DEFAULT_POLICY);
>>> +    }
>>> +
>>> +out:
>>> +    if (ret)
>>> +        pr_err("%s failed, result: %d\n", __func__, ret);
>>> +
>>>       ima_update_policy_flag();
>>>   }
>>
> 

