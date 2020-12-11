Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C673C2D6E9B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 04:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbgLKD3M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 22:29:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40434 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395096AbgLKD26 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 22:28:58 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8633220B717A;
        Thu, 10 Dec 2020 19:28:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8633220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607657297;
        bh=QfKvD7nczC7dNulMBg6BKzGgSG3r+S/OeqbB6AeHj8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NumacvLNkph46dhWqG0xW5nAxs7cvMaftjS5/58D7e1N+gSf7uQlzYpesM1yw8imS
         /ZGpXcDYi3EqXw7QikDtZ6l4JoRRbRQU3lXLvXTMdwVCKtzqGIRJn6XYQ2g/tE9gZn
         oDAknC34ljJ5Z5zy6zfZH7Tx7E+7z+EDDiSauYXg=
Subject: Re: [PATCH v7 4/8] IMA: add policy rule to measure critical data
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-5-tusharsu@linux.microsoft.com>
 <20201210231045.GI489768@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <472dc503-295c-1723-b329-c9e08fff4574@linux.microsoft.com>
Date:   Thu, 10 Dec 2020 19:28:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210231045.GI489768@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-10 3:10 p.m., Tyler Hicks wrote:
> On 2020-12-09 11:42:08, Tushar Sugandhi wrote:
>> A new IMA policy rule is needed for the IMA hook
>> ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
>> measuring the input buffer. The policy rule should ensure the buffer
>> would get measured only when the policy rule allows the action. The
>> policy rule should also support the necessary constraints (flags etc.)
>> for integrity critical buffer data measurements.
>>
>> Add a policy rule to define the constraints for restricting integrity
>> critical data measurements.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_policy.c | 35 +++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 2a0c0603626e..9a8ee80a3128 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -34,6 +34,7 @@
>>   #define IMA_PCR		0x0100
>>   #define IMA_FSNAME	0x0200
>>   #define IMA_KEYRINGS	0x0400
>> +#define IMA_DATA_SOURCE	0x0800
> 
> You introduce data_source= in the next patch. This macro shouldn't be
> added until the next patch.
> 
Ok I will move IMA_DATA_SOURCE to the next patch.

>>   
>>   #define UNKNOWN		0
>>   #define MEASURE		0x0001	/* same as IMA_MEASURE */
>> @@ -85,6 +86,7 @@ struct ima_rule_entry {
>>   	} lsm[MAX_LSM_RULES];
>>   	char *fsname;
>>   	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>> +	struct ima_rule_opt_list *data_source; /* Measure data from this source */
>>   	struct ima_template_desc *template;
>>   };
>>   
>> @@ -479,6 +481,12 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
>>   		else
>>   			opt_list = rule->keyrings;
>>   		break;
>> +	case CRITICAL_DATA:
>> +		if (!rule->data_source)
>> +			return true;
>> +		else
>> +			opt_list = rule->data_source;
> 
> If you take my suggestions on patch #1, remove the else and simply
> assign opt_list here, too.
> 
Yup. Will do.
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -518,13 +526,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>   {
>>   	int i;
>>   
>> -	if (func == KEY_CHECK) {
>> -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
>> -			ima_match_rule_data(rule, func_data, cred);
>> -	}
>>   	if ((rule->flags & IMA_FUNC) &&
>>   	    (rule->func != func && func != POST_SETATTR))
>>   		return false;
>> +
>> +	switch (func) {
>> +	case KEY_CHECK:
>> +	case CRITICAL_DATA:
>> +		return ((rule->func == func) &&
>> +			ima_match_rule_data(rule, func_data, cred));
>> +	default:
>> +		break;
>> +	}
>> +
>>   	if ((rule->flags & IMA_MASK) &&
>>   	    (rule->mask != mask && func != POST_SETATTR))
>>   		return false;
>> @@ -1119,6 +1133,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>>   		if (ima_rule_contains_lsm_cond(entry))
>>   			return false;
>>   
>> +		break;
>> +	case CRITICAL_DATA:
>> +		if (entry->action & ~(MEASURE | DONT_MEASURE))
>> +			return false;
>> +
>> +		if (!(entry->flags & IMA_DATA_SOURCE) ||
>> +		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
>> +		    IMA_DATA_SOURCE)))
> 
> IMA_DATA_SOURCE shouldn't exist in this patch. This isn't the right
> indentation, either. See how IMA_KEYRINGS is indented in the KEY_CHECK
> case above.
> 
Will do.
~Tushar
> Tyler
> 
>> +			return false;
>> +
>> +		if (ima_rule_contains_lsm_cond(entry))
>> +			return false;
>> +
>>   		break;
>>   	default:
>>   		return false;
>> -- 
>> 2.17.1
>>
