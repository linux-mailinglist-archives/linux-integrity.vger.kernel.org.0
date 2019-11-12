Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E629F9789
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLRrR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:47:17 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59726 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfKLRrR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:47:17 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A0FC020B7192;
        Tue, 12 Nov 2019 09:47:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0FC020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573580836;
        bh=7Kt5Wc/Am4vLaRBG7Pci6TyveGeHnN0SpQV4X3XO9EI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=itGVmsgjze45PFuFQHgL2h8w0PMmNiHPhp0540ZwqwWnVKp/uZubLR0JaMurjOJrb
         fOmEbYYnLWeLY7dR8bdQ73Rp0zP0OY++KEGLCzA5qqduhyxdPo/VTn/ekYlxPQ13hi
         i0bwvoPc1lQ2hvOagO6jfBrwURAg2jSY+Fxx/+lU=
Subject: Re: [PATCH v5 04/10] IMA: Updated IMA policy functions to return
 keyrings option read from the policy
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
 <20191111193303.12781-5-nramas@linux.microsoft.com>
 <1573578316.17949.43.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <407b93e1-f474-7b01-816f-62b45690f417@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 09:47:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573578316.17949.43.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2019 9:05 AM, Mimi Zohar wrote:

>>   int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>>   		     enum ima_hooks func, int mask, int flags, int *pcr,
>> -		     struct ima_template_desc **template_desc)
>> +		     struct ima_template_desc **template_desc,
>> +		     char **keyrings)
>>   {
>>   	struct ima_rule_entry *entry;
>>   	int action = 0, actmask = flags | (flags << 1);
>> @@ -527,6 +529,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>>   		if ((pcr) && (entry->flags & IMA_PCR))
>>   			*pcr = entry->pcr;
>>   
>> +		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
>> +			*keyrings = entry->keyrings;
> 
> ima_match_rules() determines whether the rule is in policy or not. It
> returns true on rule match, false on failure.  There's no need to
> return the list of keyrings.

But the above code change is in ima_match_policy() - not in 
ima_match_rules() function.

ima_match_rules() function is updated in Patch #1 -
[PATCH v5 01/10] IMA: Added KEYRING_CHECK func in IMA policy to measure keys

I've updated that function to check if func is "KEYRING_CHECK" and 
return true\false as appropriate.

Am I missing something?

  -lakshmi
