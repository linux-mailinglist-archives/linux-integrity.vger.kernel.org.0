Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF78121C2E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 22:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLPVwA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 16:52:00 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56548 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVwA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 16:52:00 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4EFDF2010C1C;
        Mon, 16 Dec 2019 13:51:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EFDF2010C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576533119;
        bh=WpWDij33SIAh2NLdE1iFnpr1lDw8hAjerLphRfg5j8s=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dnrh2CdQywSAEHIqti0vrXPOoP3XlYxGnnGbWkyPpM9d0QAvMeq2S3WKqub453VZP
         8hIdX9/Z0zHrKzzq8/iOCPYkjqtyMrYuSUbKTD7SI5Fz9aplaoRsHd27OeLNnBW6yS
         m85vQVBIZ+N2K59leOloIYfclg98fkN9tTLAu1v0=
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
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
Message-ID: <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
Date:   Mon, 16 Dec 2019 13:52:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/16/2019 1:37 PM, Lakshmi Ramasubramanian wrote:
> 
> On 12/16/2019 1:17 PM, James Bottomley wrote:
>> On Mon, 2019-12-16 at 11:20 -0800, Lakshmi Ramasubramanian wrote:
>>>    => If the flag is false, mutex is taken and the flag is checked
>>> again. If the flag changed from false to true between the above two
>>> tests, that means another thread had raced to call
>>> ima_process_queued_keys() and has  processed the queued keys. So
>>> again, no further action is required.
>>
>> This is the problem: in the race case you may still be adding keys to
>> the queue after the other thread has processed it. Those keys won't get
>> processed because the flag is now false in the post check so the
>> current thread won't process them either.
>>
>> James
>>

Please keep in mind that ima_queue_key() returns a boolean indicating 
whether or not the key was queued. This flag is set inside the lock - 
please see the code snippet from ima_queue_key() below:

+	mutex_lock(&ima_keys_mutex);
+	if (!ima_process_keys) {
+		list_add_tail(&entry->list, &ima_keys);
+		queued = true;
+	}
+	mutex_unlock(&ima_keys_mutex);

If ima_process_keys had changed from false to true, ima_queue_key() will 
not queue the key and return false to ima_post_key_create_or_update().

Code snippet in ima_post_key_create_or_update():

+	if (!ima_process_keys)
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;

If the "queued" is false, ima_post_key_create_or_update() will process 
the key immediately.

  -lakshmi
