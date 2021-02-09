Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFB31567D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 20:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhBITF5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 14:05:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhBIS45 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:56:57 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7089D2020E9E;
        Tue,  9 Feb 2021 10:31:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7089D2020E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612895504;
        bh=wGYdUbhWR5y9KoUnFO9IRu5Hqx5/3X+QjRRHMVd3EHI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bBpT7yfHfMpytdV83pn28BmzOiyTLc1T0B+pzDQ3hBh0YKIATeBHVdzevnaRWHOp/
         4LayizfSQ7VyW1d6V5S37JjCejSjQ3iyaz9oFGbNChIRMrz8ypKLiVYkU7rg7psdXs
         8iHk8gRVIzPt36YlYxG/oGKbbj08xHP7pLqS6fl4=
Subject: Re: [PATCH 3/3] IMA: add support to measure duplicate buffer for
 critical data hook
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
 <20210130004519.25106-4-tusharsu@linux.microsoft.com>
 <158dc2d3398316edefbafdb1cfea5eca840a06e6.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <8af5bf67-54d3-f358-6cb6-34733fc72df2@linux.microsoft.com>
Date:   Tue, 9 Feb 2021 10:31:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <158dc2d3398316edefbafdb1cfea5eca840a06e6.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021-02-08 12:24 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
> 
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>>
>> index c096ef8945c7..fbf359495fa8 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -158,7 +158,7 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>>    */
>>   int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>   			   const char *op, struct inode *inode,
>> -			   const unsigned char *filename)
>> +			   const unsigned char *filename, bool allow_dup)
>>   {
>>   	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
>>
>   	struct tpm_digestate_entry(struct ima_template_entry *entry, int violation,
Not sure I understand this.  Maybe a typo?  Could you please explain?

>>   
>>   	mutex_lock(&ima_extend_list_mutex);
>>   	if (!violation) {
>> -		if (ima_lookup_digest_entry(digest, entry->pcr)) {
>> +		if (!allow_dup &&
>> +		    ima_lookup_digest_entry(digest, entry->pcr)) {
> 
> Can't this change be simplified to "if (!violation && !allow_dup)"?
> 
Sure.  Will do.

Earlier I wasn't sure if 'violation' would touch any other use-cases 
inadvertently.  That's why I localized the change as above.

But now since we are supporting other scenarios as well,
I believe "if (!violation && !allow_dup)" would be cleaner.

> Also perhaps instead of passing another variable "allow_dup" to each of
> these functions, pass a mask containing violation and allow_dup.
> 
There were examples of both approaches in ima_match_policy().
  - int *pcr/ima_template_desc **template_desc as an out-param;
  - and various actions as flags in return int.

Earlier I couldn't decide one way or the other, so I picked the 
out-param approach.

But since allow_dup is just a single bit info, returning it as a bit in 
the action flag is a cleaner solution.
Will implement it with flag in the next iteration.

Thanks again for reviewing the series.  Really appreciate it.

Thanks,
Tushar

>>   			audit_cause = "hash_exists";
>>   			result = -EEXIST;
>>   			goto out;
> 
> thanks,
> 
> Mimi
> 
