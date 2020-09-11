Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C8B266391
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIKQUZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 12:20:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58712 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgIKQTI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 12:19:08 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id BADE820716FA;
        Fri, 11 Sep 2020 09:19:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BADE820716FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599841143;
        bh=IGrl9wd59ouiSwrHZJue38Gb4uezQLGVnD6HcWU/o80=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FsBXu82EbG6MT9yrcRvWBKCe/fCu0gn4AeEUk/dfZHITC7I1H5MCCf54UkUgHic+Q
         Q6RJ62GCP+uXr5rTl3rBDSNCjuooLp9aVofY2HZwXFj/+dwATBdWZ4oRCjIs0kWFaH
         hJ/BhkB7cn3gds8zgReSqdEySHPgV159fhuezYAs=
Subject: Re: [PATCH v3 1/6] IMA: generalize keyring specific measurement
 constructs
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
 <20200828015704.6629-2-tusharsu@linux.microsoft.com>
 <4802c73c2ed22c64ea4f315d3115ead919c3205e.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <1a456a10-bb49-206b-9fb9-cc996eea6e29@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 09:19:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4802c73c2ed22c64ea4f315d3115ead919c3205e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-31 4:55 a.m., Mimi Zohar wrote:
> On Thu, 2020-08-27 at 18:56 -0700, Tushar Sugandhi wrote:
>> IMA functions such as ima_match_keyring(), process_buffer_measurement(),
>> ima_match_policy() etc. handle data specific to keyrings. Currently,
>> these constructs are not generic to handle any func specific data.
>> This makes it harder to extend without code duplication.
>>
>> Refactor the keyring specific measurement constructs to be generic and
>> reusable in other measurement scenarios.
> 
> Mostly this patch changes the variable name from keyring to func_data,
> which is good.  Other changes should be minimized.
> 
The only other change in this patch is introduction of
bool allow_empty_opt_list, which is needed as per my comment below.

Maybe I can move "allow_empty_opt_list" to a new patch after this one in
this series.

>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
> 
> <snip>
> 
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fe1df373c113..8866e84d0062 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -451,15 +451,21 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>>   }
>>   
>>   /**
>> - * ima_match_keyring - determine whether the keyring matches the measure rule
>> - * @rule: a pointer to a rule
>> - * @keyring: name of the keyring to match against the measure rule
>> + * ima_match_rule_data - determine whether the given func_data matches
>> + *			 the measure rule data
>> + * @rule: IMA policy rule
>> + * @opt_list: rule data to match func_data against
>> + * @func_data: data to match against the measure rule data
>> + * @allow_empty_opt_list: If true matches all func_data
>>    * @cred: a pointer to a credentials structure for user validation
>>    *
>> - * Returns true if keyring matches one in the rule, false otherwise.
>> + * Returns true if func_data matches one in the rule, false otherwise.
>>    */
>> -static bool ima_match_keyring(struct ima_rule_entry *rule,
>> -			      const char *keyring, const struct cred *cred)
>> +static bool ima_match_rule_data(struct ima_rule_entry *rule,
>> +				const struct ima_rule_opt_list *opt_list,
> 
> Ok
> 
>> +				const char *func_data,
>> +				bool allow_empty_opt_list,
> 
> As the policy is loaded, shouldn't the rules should be checked, not
> here on usage?
> 
> Mimi

Since "keyrings=" is optional, I cannot check the rule at load time for
keyrings. func=KEY_CHECK may or may not have "keyrings=", and both are
valid scenarios.

However "critical_kernel_data_sources=" is mandatory for 
func=CRITICAL_DATA.

So I am already making that check at policy load time.

See patch 5/6 – function ima_match_rules(), where I check for
IMA_DATA_SOURCES.

+       case CRITICAL_DATA:
<snip>
+               if (!(entry->flags & IMA_DATA_SOURCES) ||
<snip>
+                       return false;
+

Since ima_match_rule_data (this function) handles both func=KEY_CHECK 
and func=CRITICAL_DATA, we have to use the bool "allow_empty_opt_list"
to differentiate between the two scenarios – whether the rule is
optional or not for a given func.

> 
>> +				const struct cred *cred)
>>   {
>>   	bool matched = false;
>>   	size_t i;
>>
