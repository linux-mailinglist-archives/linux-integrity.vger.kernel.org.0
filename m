Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086FB233527
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgG3PPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 11:15:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56968 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3PPg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 11:15:36 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 75E8C20B4908;
        Thu, 30 Jul 2020 08:15:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75E8C20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596122135;
        bh=DMI1+Fep3jCjujpTgudtLHugxZgOA+dDJ2AJnUQVMV0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pXg55YPIfIUPaIdvFJsoMWQabr5OOGJqa5Ga+U1CdhMcRkGY0xJYXxXfG0x1qx/59
         wzaMYextleS0tyTv9Ozkp53bAz11oV8bJIBXXokGA/TZrkPHnS0i8HiENEGnNK3VPa
         2c6gpt79Sv50mMQUTEmRIYvfPIaSvT/F45bJZG8w=
Subject: Re: [PATCH v5 1/4] IMA: Add func to measure LSM state and policy
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-2-nramas@linux.microsoft.com>
 <20200730150228.GV4181@sequoia>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c2f0c4cc-67a9-d467-1b2c-7edaea47c9d6@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 08:15:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730150228.GV4181@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/30/20 8:02 AM, Tyler Hicks wrote:

>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 07f033634b27..a0f5c39d9084 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -442,13 +442,20 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>   {
>>   	int i;
>>   
>> -	if (func == KEY_CHECK) {
>> -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
>> -		       ima_match_keyring(rule, keyring, cred);
>> -	}
>>   	if ((rule->flags & IMA_FUNC) &&
>>   	    (rule->func != func && func != POST_SETATTR))
>>   		return false;
>> +
>> +	switch (func) {
>> +	case KEY_CHECK:
>> +		return ima_match_keyring(rule, keyring, cred);
>> +	case LSM_STATE:
>> +	case LSM_POLICY:
>> +		return true;
>> +	default:
>> +		break;
>> +	}
>> +
>>   	if ((rule->flags & IMA_MASK) &&
>>   	    (rule->mask != mask && func != POST_SETATTR))
>>   		return false;
>> @@ -1044,6 +1051,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>>   		if (ima_rule_contains_lsm_cond(entry))
>>   			return false;
>>   
>> +		break;
>> +	case LSM_STATE:
>> +	case LSM_POLICY:
>> +		if (entry->action & ~(MEASURE | DONT_MEASURE))
>> +			return false;
>> +
>> +		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
>> +			return false;
>> +
>> +		if (ima_rule_contains_lsm_cond(entry))
>> +			return false;
>> +
>>   		break;
>>   	default:
>>   		return false;
>> @@ -1176,6 +1195,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>   				entry->func = KEXEC_CMDLINE;
>>   			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
>>   				entry->func = KEY_CHECK;
>> +			else if (strcmp(args[0].from, "LSM_STATE") == 0)
>> +				entry->func = LSM_STATE;
>> +			else if (strcmp(args[0].from, "LSM_POLICY") == 0)
>> +				entry->func = LSM_POLICY;
> 
> This patch generally looks really good to me with the exception of one
> thing...
> 
> We should only accept rules with these specified hook functions when an
> LSM that has measurement support is enabled. This messes up the ordering
> of your patch series but it could be as simple as doing this:
> 
> 			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> 				 strcmp(args[0].from, "LSM_STATE") == 0)
> 				 entry->func = LSM_STATE;
> 
> Or you could do something a little more complex, like what's done with
> CONFIG_IMA_LSM_RULES. You could create a CONFIG_IMA_MEASURE_LSM option
> that's default enabled but depends on CONFIG_SECURITY_SELINUX and then
> check for IS_ENABLED(CONFIG_IMA_MEASURE_LSM) in ima_parse_rule().
> 
> I'd personally opt for just placing the
> IS_ENABLED(CONFIG_SECURITY_SELINUX) check directly into
> ima_parse_rule().
> 

The LSM hook can be used by any security module (not just SELinux) to 
measure their data.

I have implemented measurement in SELinux to illustrate the usage. 
Maybe, I can add the check you have suggested for now and when more 
security modules start using this IMA policy additional checks can be 
added as appropriate.

thanks,
  -lakshmi

