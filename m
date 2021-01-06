Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73032EB925
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 06:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbhAFFAu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 00:00:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52480 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFFAu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 00:00:50 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5D80F20B7192;
        Tue,  5 Jan 2021 21:00:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D80F20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609909208;
        bh=nwBMt/PBxl2PWT1Ssl7JTvs6BvtU4tbh0KnWY20aks4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=bjthC3ISI/WD9OOIWlN3NGQyAESnBXaoRY3QuBuxwhgNU0uPqopgLMg1cm5JTHvNX
         hfX1nJTYV2MIOJfOZE0zlKqT3txadd12QSiXDDD9W9ICzNQvTbcgtNPL5yEI0CdpjQ
         RH95+lukw3ZKEmsjRkaCghEWh2cPv4izzWPtzhBA=
Subject: Re: [PATCH v9 2/8] IMA: add support to measure buffer data hash
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-3-tusharsu@linux.microsoft.com>
 <4e83480731b937cea479f688029560444b9cb66a.camel@linux.ibm.com>
 <3fdb72ae-f291-386b-e7b9-688dfe092dc5@linux.microsoft.com>
Message-ID: <e401bb98-6b39-b148-fdba-76e48c7c3932@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 21:00:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3fdb72ae-f291-386b-e7b9-688dfe092dc5@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

<snip>

>>>   void process_buffer_measurement(struct inode *inode, const void 
>>> *buf, int size,
>>>                   const char *eventname, enum ima_hooks func,
>>> -                int pcr, const char *func_data);
>>> +                int pcr, const char *func_data,
>>> +                bool measure_buf_hash);
>>
>> Please abbreviate the boolean name to "hash".   The test would then be
>> "if (hash == true)" or "if (hash)".
>>
> Will do.

<snip>

>>> - * process_buffer_measurement - Measure the buffer to ima log.
>>> + * process_buffer_measurement - Measure the buffer or the buffer 
>>> data hash
>>>    * @inode: inode associated with the object being measured (NULL 
>>> for KEY_CHECK)
>>>    * @buf: pointer to the buffer that needs to be added to the log.
>>>    * @size: size of buffer(in bytes).
>>> @@ -787,12 +787,23 @@ int ima_post_load_data(char *buf, loff_t size,
>>>    * @func: IMA hook
>>>    * @pcr: pcr to extend the measurement
>>>    * @func_data: private data specific to @func, can be NULL.
>>> + * @measure_buf_hash: measure buffer hash
>>
>> ^@hash: measure buffer data hash
>>
> Agreed. Will fix.
<snip>
>>>   void process_buffer_measurement(struct inode *inode, const void 
>>> *buf, int size,
>>>                   const char *eventname, enum ima_hooks func,
>>> -                int pcr, const char *func_data)
>>> +                int pcr, const char *func_data,
>>> +                bool measure_buf_hash)
>>>   {
>>>       int ret = 0;
>>>       const char *audit_cause = "ENOMEM";
>>> @@ -807,6 +818,8 @@ void process_buffer_measurement(struct inode 
>>> *inode, const void *buf, int size,
>>>           struct ima_digest_data hdr;
>>>           char digest[IMA_MAX_DIGEST_SIZE];
>>>       } hash = {};
>>> +    char buf_hash[IMA_MAX_DIGEST_SIZE];
>>> +    int buf_hash_len = hash_digest_size[ima_hash_algo];
>>>       int violation = 0;
>>>       int action = 0;
>>>       u32 secid;
>>> @@ -849,13 +862,27 @@ void process_buffer_measurement(struct inode 
>>> *inode, const void *buf, int size,
>>>           goto out;
>>>       }
>>> +    if (measure_buf_hash) {
>>
>> ^ if (hash) {
> Yes.
>>> +        memcpy(buf_hash, hash.hdr.digest, buf_hash_len);
>>> +
>>> +        ret = ima_calc_buffer_hash(buf_hash, buf_hash_len,
>>> +                       iint.ima_hash);
>>> +        if (ret < 0) {
>>> +            audit_cause = "measure_buf_hash_error";


Hi Mimi,
There already exist a local struct variable named "hash" in p_b_m().
I was thinking of using "buf_hash", but that one is taken too.
Maybe I should use "buf_hash" for the input bool, and rename the
existing "buf_hash" local variable to "digest_hash"?
Does it sound ok?

Thanks,
Tushar


<snip>
