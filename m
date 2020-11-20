Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118582BBA37
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Nov 2020 00:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgKTXdo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 18:33:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44502 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTXdm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 18:33:42 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89BC420B717A;
        Fri, 20 Nov 2020 15:33:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89BC420B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605915221;
        bh=zmpsSKY4r1FjWqHBJ/nPiw3LVnG+vNwkCnUTsFeLSRM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VzXBAcAfAz5Ayii51kKy40d0qTGct8L6HwgiTEnBqNwIDE99VdQSgw5O3QTe6/oGF
         YVbjddqbqrGxB13ZGH2jr4YTVbTRmMj0vj7IFXSHQBlEFomqRDvoAhy1O8EP/gtYxX
         EKtEfEIhW/YrDq6NxVjwIIkoO2lon0aagWOwdNJc=
Subject: Re: [PATCH v6 7/8] IMA: add a built-in policy rule for critical data
 measurement
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201119232611.30114-8-tusharsu@linux.microsoft.com>
 <e151e67e0749766c1b501ecc54dbeb0450c0cea2.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <58607cc2-2a20-03d7-9f38-9c3bebb1c494@linux.microsoft.com>
Date:   Fri, 20 Nov 2020 15:33:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e151e67e0749766c1b501ecc54dbeb0450c0cea2.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/20/20 6:30 AM, Mimi Zohar wrote:

Hi Mimi,

> 
> On Thu, 2020-11-19 at 15:26 -0800, Tushar Sugandhi wrote:
>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>> The IMA hook to measure kernel critical data, namely
>> ima_measure_critical_data(), could be called before a custom IMA policy
>> is loaded.
>> Define a new critical data builtin policy to allow measuring
>> early kernel integrity critical data before a custom IMA policy is
>> loaded.
> 
> Everything needing to be said seems to be included in the second
> sentence.  Does the first sentence add anything?  "Define a new
> critical data builtin policy" makes for a good Subject line.

Agreed - will update.

> 
>>
>> Add critical data to built-in IMA rules if the kernel command line
>> contains "ima_policy=critical_data".
> 
> The boot command line parameters are defined in Documentation/admin-
> guide/kernel-parameters.txt.  Please update "ima_policy".

Will do.

> 
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_policy.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index c9e52dab0638..119604a3efa0 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -206,6 +206,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
>>   	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
>>   };
>>
>> +static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
>> +	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
>> +};
>> +
>>   /* An array of architecture specific rules */
>>   static struct ima_rule_entry *arch_policy_entry __ro_after_init;
>>   
>> @@ -228,6 +232,7 @@ __setup("ima_tcb", default_measure_policy_setup);
>>   
>>   static bool ima_use_appraise_tcb __initdata;
>>   static bool ima_use_secure_boot __initdata;
>> +static bool ima_use_critical_data __ro_after_init;
> 
> Unlike ima_fail_unverifiable_sigs, ima_use_critical_data is only used
> during __init.  Please change "__ro_after_init" to "__initdata".  (The
> critical data policy itself is defined properly as __ro_after_init.)

Will do.

> 
>>   static bool ima_fail_unverifiable_sigs __ro_after_init;
>>   static int __init policy_setup(char *str)
>>   {
>> @@ -242,6 +247,8 @@ static int __init policy_setup(char *str)
>>   			ima_use_appraise_tcb = true;
>>   		else if (strcmp(p, "secure_boot") == 0)
>>   			ima_use_secure_boot = true;
>> +		else if (strcmp(p, "critical_data") == 0)
>> +			ima_use_critical_data = true;
>>   		else if (strcmp(p, "fail_securely") == 0)
>>   			ima_fail_unverifiable_sigs = true;
>>   		else
>> @@ -875,6 +882,11 @@ void __init ima_init_policy(void)
>>   			  ARRAY_SIZE(default_appraise_rules),
>>   			  IMA_DEFAULT_POLICY);
>>   
>> +	if (ima_use_critical_data)
>> +		add_rules(critical_data_rules,
>> +			  ARRAY_SIZE(critical_data_rules),
>> +			  IMA_DEFAULT_POLICY);
>> +
>>   	ima_update_policy_flag();
>>   }
>>   
> 

thanks,
  -lakshmi
