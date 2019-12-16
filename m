Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6647111FC76
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 02:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLPBLh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Dec 2019 20:11:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50334 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPBLh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Dec 2019 20:11:37 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E6BE20B7187;
        Sun, 15 Dec 2019 17:11:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E6BE20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576458696;
        bh=Pzwok10KfFEpjY2IugMLpWf937V1EUtkBukPFshHWsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e9MJBnHbj2MrEr3+LPw7oEQPfnsCVvzhy/VqmEnGR4Ny1lZM0IUySpU3L8asH+AEB
         8oYI77Sf6R94AK02bHllM/i/wrm7JtOu3HeaSew0RjLkV6QFubKaL7Gj1QM3JsYAOV
         i1FuHWnS9kQfbKu6MRYaveZQN2vpcAFUav5K0S3Q=
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
Date:   Sun, 15 Dec 2019 17:12:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576423353.3343.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/15/2019 7:22 AM, James Bottomley wrote:

Hi James,

> 
> This is the problem:
> 
> if (!flag)
>      pre()
> .
> .
> .
> if (!flag)
>      post()
> 
> And your pre and post function either have to both run or neither must.
>   However, the flag is set asynchronously, so if it gets set while
> another thread is running through the above code, it can change after
> pre is run but before post is.
> 
> James

The pre() and post() functions you have referenced above including the 
check for the flag are executed with the mutex held.

Please see Mimi's response to the v3 email. I have copied it below:

************************************
Reading the flag IS lock protected, just spread across two functions.
For performance, ima_post_key_create_or_update() checks
ima_process_keys, before calling ima_queue_key(), which takes the
mutex before checking ima_process_keys again.

As long as both the reader and writer, take the mutex before checking
the flag, the locking is fine.  The additional check, before taking
the mutex, is simply for performance.
************************************

The flag is checked with the mutex held in the "reader" - 
ima_queue_key(). The key is queued with the mutex held only if the flag 
is false.

The flag is protected in the "writer" also - ima_process_queued_keys(). 
The flag is checked with the mutex held, set to true, and queued keys 
(if any) are transferred to the temp list.

As Mimi has pointed out the additional check of the flag, before taking 
the mutex in ima_post_key_create_or_update() and in 
ima_process_queued_keys(), is for performance reason.

If the flag is true, there is no need to take the mutex to check it 
again in those functions.

thanks,
  -lakshmi
