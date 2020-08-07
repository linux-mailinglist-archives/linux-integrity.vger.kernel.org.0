Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED13F23EEF0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgHGOTh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 10:19:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37968 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGOTh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 10:19:37 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A27420B4908;
        Fri,  7 Aug 2020 07:19:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A27420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596809976;
        bh=9UTKQRLLAv9PZnTXUwjNrOzFDyjSffWMD+Uhbj7o5Y4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eqyVzfeSKUxwkTRZzpEOwAAVXq4Zn4jWSv6SMoWhJYULxCOkPhKHSkuR20J0TjMjx
         9Z1A2uTsiEvDehBbQjBCnBQf32ZmOp6v3wZB8NAqbC0xNlvci+rU15vyOC/rKVgMaE
         /tBww1X295wBXF0tSL+M3mRuldnmzMCoF17mx8rI=
Subject: Re: [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
References: <20200807112929.8984-1-pvorel@suse.cz>
 <20200807141524.GA3247@dell5510>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <51daca31-72b6-2a59-bed2-40609af9e420@linux.microsoft.com>
Date:   Fri, 7 Aug 2020 07:19:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807141524.GA3247@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/7/20 7:15 AM, Petr Vorel wrote:
> Hi all,
> 
> ...
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> @@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
>>   # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
>>   test1()
>>   {
>> -	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
>> +	local keyrings keycheck_lines keycheck_line templates
>> +	local policy="func=KEY_CHECK"
>> +	local test_file="file.txt"
> 
>>   	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
> 
>> -	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
>> +	require_ima_policy_content $policy
>> +	keycheck_lines=$(check_ima_policy_content $policy "")
>>   	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
> While working on this patchset, I wonder, why we don't check for
> 'func=KEY_CHECK.*keyrings' in single grep call instead of grepping it twice.
> IMHO single grep call is enough. Or am I missing something?
> 

Instead require_ima_policy_content calling "tst_brk" in error condition, 
it can just return false and the caller can handle it as appropriate. 
Would that avoid two grep calls?

thanks,
  -lakshmi
