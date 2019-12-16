Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1B1219D9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 20:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLPTUA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 14:20:00 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58508 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLPTUA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 14:20:00 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2F9A62010C1C;
        Mon, 16 Dec 2019 11:19:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F9A62010C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576523999;
        bh=Ez8+9qHJjTzpNI++1nr7MYvBifA2xRwHbnv0WHsRdmA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DL4rsunrNxkbz/507oOb+nYxBAwRFit6DeGxF0u7jw1DRxtUocwhZxrpInQOGbUya
         3N47TnUyaZbeOZ4JujE/9sq4H9CrFO9+0HKtUcbEUoKbvFOqEiNLLW5xBLlkPsQ3c4
         ukrtRRjJeVmYMLtD0MDeEa/X+M8OA2hwzWdFLimI=
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-3-nramas@linux.microsoft.com>
 <1576257955.8504.20.camel@HansenPartnership.com>
 <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
 <1576423353.3343.3.camel@HansenPartnership.com>
 <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
 <1576479187.3784.1.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
Date:   Mon, 16 Dec 2019 11:20:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576479187.3784.1.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/15/2019 10:53 PM, James Bottomley wrote:

Hi James,

> On Sun, 2019-12-15 at 17:12 -0800, Lakshmi Ramasubramanian wrote:
>> On 12/15/2019 7:22 AM, James Bottomley wrote:
>>
>> Hi James,
>>
>>>
>>> This is the problem:
>>>
>>> if (!flag)
>>>       pre()
>>> .
>>> .
>>> .
>>> if (!flag)
>>>       post()
>>>
>>> And your pre and post function either have to both run or neither
>>> must.
>>>    However, the flag is set asynchronously, so if it gets set while
>>> another thread is running through the above code, it can change
>>> after
>>> pre is run but before post is.
>>>

> 
> That doesn't matter ... the question is, is the input assumption that
> both pre/post have to be called or neither must correct?  If so, the
> code is wrong, if not, explain why.
> 
> James
> 

I assume you are asking
"What happens if the flag changes between the check done without the 
mutex held (pre()) and the check done after the mutex is taken (post())".

If I misunderstood your question, please clarify.

"READER" functions: ima_post_key_create_or_update() and ima_queue_key()
***********************************************************************
In ima_post_key_create_or_update() the flag is checked first without the 
mutex taken:

  => If the flag is true, then there is no need to queue the key and it 
can be processed immediately.

     This condition means that either queued keys have already been 
processed OR there is another thread in the middle of processing queued 
keys. In both these conditions, the new key should NOT be queued, but 
processed immediately.

  => If the flag is false, ima_queue_key() is called. In this function, 
the mutex is taken and flag checked again.

Say, the flag changed from false to true at this point, the key will NOT 
be queued. ima_queue_key() will return false and in response 
ima_post_key_create_or_update() will process the key immediately.

But if the flag is still false, the key will be queued by 
ima_queue_key() and will be processed later.

"WRITER" function: ima_process_queued_keys()
********************************************
In ima_process_queued_keys() the flag is checked first without the mutex 
taken:

  => If the flag is true, either the queued keys have already been 
processed OR is in the middle of being processed. So no further action 
is required.

  => If the flag is false, mutex is taken and the flag is checked again. 
If the flag changed from false to true between the above two tests, that 
means another thread had raced to call ima_process_queued_keys() and has 
processed the queued keys. So again, no further action is required.

  But if the flag is still false (after the mutex is taken), then the 
queued keys are processed and the flag is set to true.

The above sequence ensures that queued keys are processed one and only 
once. Subsequent keys are always processed immediately.

To the best of my knowledge, there is no condition under which a key 
would ever be dropped or be queued up without ever getting processed.
I hope that answers your question.

If you are still not convinced, please describe a sequence of steps that 
can cause incorrect functionality.

thanks,
  -lakshmi

