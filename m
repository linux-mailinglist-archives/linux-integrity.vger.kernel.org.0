Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D635EF22E0
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 00:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfKFXwM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 18:52:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53368 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFXwM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 18:52:12 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2FC6F20B7192;
        Wed,  6 Nov 2019 15:52:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FC6F20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573084331;
        bh=7+TITNWnuuqtobgXFF9AfJ8kAcAt4vZ2t9MtwS6OXX4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Gu1APcN4pyax71gcqYaAGdCtpIOmXf+wnCOL+xZC42h5YzThdJ0hzJk82wr3IR8sr
         1OMthYH/qbPa2X011zafPUPpOwABgK8hFxmOm96D/wJbfa5DVYlr44SFXuITIHb7CI
         6HV2JMReS+0R5u4OtMJlXQ+E29piD77UmskPLmck=
Subject: Re: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue keys
 for measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-9-nramas@linux.microsoft.com>
 <1573080281.5028.314.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8b2fd578-7429-f5b8-4286-1face91e1ae6@linux.microsoft.com>
Date:   Wed, 6 Nov 2019 15:52:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573080281.5028.314.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/6/2019 2:44 PM, Mimi Zohar wrote:

>> +int ima_queue_or_process_key_for_measurement(struct key *keyring,
>> +					     struct key *key)
>> +{
>> +	int rc = 0;
>> +	struct ima_measure_key_entry *entry = NULL;
>> +	const struct public_key *pk;
>> +
>> +	if (key->type != &key_type_asymmetric)
>> +		return 0;
>> +
>> +	mutex_lock(&ima_measure_keys_mutex);

> 
> Unless the key is being queued, there's no reason to take the lock.

Reason the lock is taken even in the case the key is not queued is to 
avoid the following race condition:

  => ima_init() sets ima_initialized flag and calls the dequeue function

  => If IMA hook checks ima_initialized flag outside the lock and sees 
the flag is not set, it will call the queue function.

  => If the above two steps race, the key could get added to the queue 
after ima_init() has processed the queued keys.

That's the reason I named the function called by the IMA hook to 
ima_queue_or_process_key_for_measurement().

But I can make the following change:

  => IMA hook checks the flag.
  => If it is set, process key immediately
  => If the flag is not set, call ima_queue_or_process_key_for_measurement()

ima_queue_or_process_key_for_measurement() will do the following:

  => With the lock held check ima_initialized flag
  => If true release the lock and call process_buffer_measurement()
  => If false, queue the key and then release the lock

Would that be acceptable?

> Measuring the key should be done in ima_post_key_create_or_update()
> unless, it is being deferred.  Please update the function name to
> reflect this.

Just wanted to confirm:
Rename ima_post_key_create_or_update() to a more appropriate name?

Another reason for doing all key related operations in 
ima_queue_or_process_key_for_measurement() is to isolate key related 
code in a separate C file and build it if and only if the CONFIG 
dependencies are met.

With respect to loading custom policy, I will take a look at how to 
handle that case. Thanks for pointing that out.

> Mimi

thanks,
  -lakshmi
