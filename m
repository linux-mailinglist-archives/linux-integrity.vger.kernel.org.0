Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7512A297955
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 00:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbgJWWiQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 18:38:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33828 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461456AbgJWWiP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 18:38:15 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8447220B4905;
        Fri, 23 Oct 2020 15:38:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8447220B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603492695;
        bh=2/tAyBtYGB8cgYKxut3JbtspLYA7Spm6lLnqtN9/PzI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e5vEP6UUDK9pN9xNXhnq8RMAeKZr6yGJ8ZgYjH4bZm0T2KDw4itqnfji9qmYu4viN
         kyScnA/VKZRy/RZfXxMCFKF5RfmAYZ8+a1JWQs+PNGjoctVOvEyQq+kdmh/LiQSn0s
         a/kOOB7bAChrtuc4jAN0//Ww4huMq3DcZfXhJJVs=
Subject: Re: [PATCH v4 1/6] IMA: generalize keyring specific measurement
 constructs
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
 <20200923192011.5293-2-tusharsu@linux.microsoft.com>
 <45aae09df5c301497efc697c17921e9b2a3c8ae8.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <71db5ccf-c9b3-68b0-4d48-93e2b1ba0d98@linux.microsoft.com>
Date:   Fri, 23 Oct 2020 15:38:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45aae09df5c301497efc697c17921e9b2a3c8ae8.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi for your overall feedback on this series.
Really appreciate it.

On 2020-10-22 12:39 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
> 
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fe1df373c113..31a772d8a86b 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -451,15 +451,19 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
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
>>    * @cred: a pointer to a credentials structure for user validation
>>    *
>> - * Returns true if keyring matches one in the rule, false otherwise.
>> + * Returns true if func_data matches one in the rule, false otherwise.
>>    */
>> -static bool ima_match_keyring(struct ima_rule_entry *rule,
>> -			      const char *keyring, const struct cred *cred)
>> +static bool ima_match_rule_data(struct ima_rule_entry *rule,
>> +				const struct ima_rule_opt_list *opt_list,
>> +				const char *func_data,
>> +				const struct cred *cred)
>>   {
>>   	bool matched = false;
>>   	size_t i;
>> @@ -467,14 +471,14 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
>>   	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>>   		return false;
>>   
>> -	if (!rule->keyrings)
>> +	if (!opt_list)
>>   		return true;
> 
> The opt_list should be based on rule->func.  There shouldn't be a need
> to pass it as a variable.
> 
> Mimi
Makes sense. Will do. Thanks Mimi.
~Tushar
> 
>>   
>> -	if (!keyring)
>> +	if (!func_data)
>>   		return false;
>>   
>> -	for (i = 0; i < rule->keyrings->count; i++) {
>> -		if (!strcmp(rule->keyrings->items[i], keyring)) {
>> +	for (i = 0; i < opt_list->count; i++) {
>> +		if (!strcmp(opt_list->items[i], func_data)) {
>>   			matched = true;
>>   			break;
>>   		}
