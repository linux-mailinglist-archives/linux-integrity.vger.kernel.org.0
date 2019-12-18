Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC768123D4E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 03:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLRCoG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 21:44:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfLRCoF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 21:44:05 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A3D262010BB5;
        Tue, 17 Dec 2019 18:44:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3D262010BB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576637044;
        bh=lhbqkcIxtSGFiHrpURYzmG/2lyOyf1FLYAbQkLhbFoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LMCpS0kRwj8p+N5zhvFRGGx/1yYQCKbwK8lQFQb55D9dE72G9lNdS/OsftJWwrlfb
         Do3v/0cq4iDtnX0naXP9sAL92Moq0BnzNJKM9aYEt3njkeqxqdTEFfOV2kc7FnzbMy
         rEMdH/5+zzH3qNSrcIvA/jYFul8XA9cbn8/eV1xs=
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
 <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
 <1576531022.3365.6.camel@HansenPartnership.com>
 <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
 <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
 <152580f3-2a1f-fa33-cc25-f25747a470a5@linux.microsoft.com>
 <1576634499.14900.10.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <edda07dc-c615-58f1-5689-4692c3fb3315@linux.microsoft.com>
Date:   Tue, 17 Dec 2019 18:44:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576634499.14900.10.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/2019 6:01 PM, James Bottomley wrote:

> 
> This code is confusing me:
> 
> +       /*
> +        * To avoid holding the mutex when processing queued keys,
> +        * transfer the queued keys with the mutex held to a temp list,
> +        * release the mutex, and then process the queued keys from
> +        * the temp list.
> +        *
> +        * Since ima_process_keys is set to true, any new key will be
> +        * processed immediately and not be queued.
> +        */
> +       INIT_LIST_HEAD(&temp_ima_keys);
> +
> +       mutex_lock(&ima_keys_mutex);
> +
> +       if (!ima_process_keys) {
> +               ima_process_keys = true;
> +
> +               if (!list_empty(&ima_keys)) {
> +                       list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> +                               list_move_tail(&entry->list, &temp_ima_keys);
> +                       process = true;
> +               }
> +       }
> +
> +       mutex_unlock(&ima_keys_mutex);
> +
> 
> The direct implication of the comment and the lock dance with the
> temporary list and the processed flag is that stuff can be added to the
> ima_keys list after you drop the mutex.  Your explanation in the prior
> couple of emails says that nothing can be added because the
> ima_process_keys flag setting prevents it.  If the latter is true, you
> can simply drop the lock after setting the flag and rely on ima_keys
> not changing to run it through process_buffer_measurement without
> needing any of the intermediate list or the processed flag.  If the
> latter isn't true then any key added to ima_keys after the mutex is
> dropped is never processed.
> 
> James

Once the flag is set no new key will be added to ima_keys list.

You are right - if the flag is set with the lock taken, then there is no 
need for the temp list. After dropping the lock, measurement can be done 
directly from ima_keys list.

Thanks for reviewing the code. I'll send an update tomorrow.

  -lakshmi
