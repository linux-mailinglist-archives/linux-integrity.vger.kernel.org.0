Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838F62AC21F
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Nov 2020 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgKIRYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Nov 2020 12:24:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgKIRYG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Nov 2020 12:24:06 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0418D20B4905;
        Mon,  9 Nov 2020 09:24:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0418D20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604942645;
        bh=ta06hzgZzpA5ollIFWxpN65xzXn96qZS7d0S0MEGpnE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e20YFcngAW2EheTQNcto50vE8IPR7U6bJ1KFsZZSgd8SV7QIB7x1pSLCf8jIuKGz3
         9osm//coJGoMMv9BUBy4SCs06mVYnb4vDoHn2vf5s3mzq6bkfeRcg5Dwv/QLyS71+O
         6NzLb842Vpdr3vNJtLvTrpCmn6hGwUiqrL4VPRG8=
Subject: Re: [PATCH v5 6/7] IMA: add critical_data to the built-in policy
 rules
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
 <d92869b5-7244-e29e-5d30-c0e06cf45be1@linux.microsoft.com>
 <c2c6efe8b2903949fb7118b56991988ba9c4f582.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4c568853-1e26-0a7b-f83b-022622e46031@linux.microsoft.com>
Date:   Mon, 9 Nov 2020 09:24:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2c6efe8b2903949fb7118b56991988ba9c4f582.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/8/20 7:46 AM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Fri, 2020-11-06 at 15:51 -0800, Lakshmi Ramasubramanian wrote:
>>
>>>>> diff --git a/security/integrity/ima/ima_policy.c
>>>>> b/security/integrity/ima/ima_policy.c
>>>>> index ec99e0bb6c6f..dc8fe969d3fe 100644
>>>>> --- a/security/integrity/ima/ima_policy.c
>>>>> +++ b/security/integrity/ima/ima_policy.c
>>>>
>>>>> @@ -875,6 +884,29 @@ void __init ima_init_policy(void)
>>>>>                  ARRAY_SIZE(default_appraise_rules),
>>>>>                  IMA_DEFAULT_POLICY);
>>>>> +    if (ima_use_critical_data) {
>>>>> +        template = lookup_template_desc("ima-buf");
>>>>> +        if (!template) {
>>>>> +            ret = -EINVAL;
>>>>> +            goto out;
>>>>> +        }
>>>>> +
>>>>> +        ret = template_desc_init_fields(template->fmt,
>>>>> +                        &(template->fields),
>>>>> +                        &(template->num_fields));
>>>>
>>>> The default IMA template when measuring buffer data is "ima_buf".   Is
>>>> there a reason for allocating and initializing it here and not
>>>> deferring it until process_buffer_measurement()?
>>>>
>>>
>>> You are right - good catch.
>>> I will remove the above and validate.
>>>
>>
>> process_buffer_measurement() allocates and initializes "ima-buf"
>> template only when the parameter "func" is NONE. Currently, only
>> ima_check_blacklist() passes NONE for func when calling
>> process_buffer_measurement().
>>
>> If "func" is anything other than NONE, ima_match_policy() picks
>> the default IMA template if the IMA policy rule does not specify a template.
>>
>> We need to add "ima-buf" in the built-in policy for critical_data so
>> that the default template is not used for buffer measurement.
>>
>> Please let me know if I am missing something.
>>
> 
> Let's explain a bit further what is happening and why.   As you said
> ima_get_action() returns the template format, which may be the default
> IMA template or the specific IMA policy rule template format.  This
> works properly for both the arch specific and custom policies, but not
> for builtin policies, because the policy rules may contain a rule
> specific .template field.   When the rules don't contain a rule
> specific template field, they default to the IMA default template.  In
> the case of builtin policies, the policy rules cannot contain the
> .template field.
> 
> The default template field for process_buffer_measurement() should
> always be "ima-buf", not the default IMA template format.   Let's fix
> this prior to this patch.
> 
> Probably something like this:
> - In addition to initializing the default IMA template, initialize the
> "ima-buf" template.  Maybe something similiar to
> ima_template_desc_current().
> - Set the default in process_buffer_measurement() to "ima-buf", before
> calling ima_get_action().
> - modify ima_match_policy() so that the default policy isn't reset when
> already specified.
> 

Sure Mimi - I will try this out and update.

thanks,
  -lakshmi

> 
> 
>>>>
>>>>> +        if (ret)
>>>>> +            goto out;
>>>>> +
>>>>> +        critical_data_rules[0].template = template;
>>>>> +        add_rules(critical_data_rules,
>>>>> +              ARRAY_SIZE(critical_data_rules),
>>>>> +              IMA_DEFAULT_POLICY);
>>>>> +    }
>>>>> +
>>>>> +out:
>>>>> +    if (ret)
>>>>> +        pr_err("%s failed, result: %d\n", __func__, ret);
>>>>> +
>>>>>        ima_update_policy_flag();
>>>>>    }
>>>>
>>>
>>

