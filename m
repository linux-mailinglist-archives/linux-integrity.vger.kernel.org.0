Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF952033A
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiEIRLL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiEIRLK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 13:11:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70B1613C366
        for <linux-integrity@vger.kernel.org>; Mon,  9 May 2022 10:07:15 -0700 (PDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7402420EC5B6;
        Mon,  9 May 2022 10:07:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7402420EC5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652116034;
        bh=KE6IG536wFkahQuq34fEmd4fC2uLbcfNjVDvNxNvdkY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hj27LDC9LIONKk0UzSFVobAjlq8htEmTUcL9M3N3qY8pof0eKozS1mxVZg1n0hzwA
         6qh7Kr7nOdxarQOnjKF7lkJgV5PXCzq/CGStZaXNBRS/WThkHqhDIO9eaSoEutifFJ
         cgt7v/8U6fJ+0AUoy8ikqFncxiv+eyxfhkYhMSn4=
Message-ID: <3090f056-8f06-fcb5-6ab8-501d8438bc0b@linux.microsoft.com>
Date:   Mon, 9 May 2022 10:07:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/3] dm ima: allow targets to remeasure their table
 entry
Content-Language: en-US
To:     Thore Sommer <public@thson.de>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20220106203436.281629-1-public@thson.de>
 <20220106203436.281629-2-public@thson.de>
 <796b7d69-6000-d4bf-d29b-f1fdfec6e332@linux.microsoft.com>
 <00030b50-d888-1562-e33c-24f7ee38cd99@thson.de>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <00030b50-d888-1562-e33c-24f7ee38cd99@thson.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/9/2022 2:55 AM, Thore Sommer wrote:
> Hi Lakshmi,
> 
> On 06.05.22 22:25, Lakshmi Ramasubramanian wrote:
>> Hi Thore,
>>
>> On 1/6/2022 12:34 PM, Thore Sommer wrote:
>>> A new DM event dm_target_update is introduced for targets to remeasure
>>> their table entry. This is intended for targets that indicate security
>>> relevant events by updating one of their table entries (e.g. verity for
>>> corruption).
>> In the patch description please state the existing problem (or, 
>> limitation in the existing implementation) and then describe how the 
>> proposed change addresses the issue.
> 
> For v2 I will add the problem description from the cover letter also to 
> this patch description.
Sounds good Thore.

You may know this already - when the patch is merged, description in the 
cover letter is not included. Only the information in the patch 
description is included in the git history. So please describe the 
problem and how it is addressed in the patch description for each patch.

> 
>>
>>>
>>> In the event the dm version, device metadata and target data gets
>>> measured.
>>>
>>> This does not update the hash of the active table because it would 
>>> require
>>> to rehash the whole table with all the other targets entries.
>>>
>>> Signed-off-by: Thore Sommer <public@thson.de>
>>> ---
>>>   drivers/md/dm-ima.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/md/dm-ima.h |  2 ++
>>>   2 files changed, 78 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
>>> index 957999998d70..3b1bb97263d9 100644
>>> --- a/drivers/md/dm-ima.c
>>> +++ b/drivers/md/dm-ima.c
>>> @@ -750,3 +750,79 @@ void dm_ima_measure_on_device_rename(struct 
>>> mapped_device *md)
>>>       kfree(new_dev_name);
>>>       kfree(new_dev_uuid);
>>>   }
>>> +
>>> +/*
>>> + * Give the option for targets to remeasure on state change.
>>> + */
>>> +void dm_ima_measure_on_target_update(struct dm_target *ti)
>>> +{
>>> +    char *ima_buf = NULL, *target_metadata_buf = NULL, 
>>> *target_data_buf = NULL;
>>> +    struct dm_target *ti2;
>>> +    size_t target_metadata_buf_len, target_data_buf_len;
>>> +    unsigned int num_targets, target_index;
>>> +    struct dm_table *table = ti->table;
>>> +    struct mapped_device *md = table->md;
>>> +    bool found = false;
>>> +    bool noio = true;
>>> +    int l = 0;
>>> +
>> Initializing "ima_buf" to NULL is not necessary since the statement 
>> below initializes it.
> Yes, I will remove that.
> 
>>
>>> +    ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, GFP_KERNEL, 
>>> noio);
>>> +    if (!ima_buf)
>>> +        return;
>>> +
>>> +    target_metadata_buf = 
>>> dm_ima_alloc(DM_IMA_TARGET_METADATA_BUF_LEN, GFP_KERNEL, noio);
>>> +    if (!target_metadata_buf)
>>> +        goto exit;
>>> +
>>> +    target_data_buf = dm_ima_alloc(DM_IMA_TARGET_DATA_BUF_LEN, 
>>> GFP_KERNEL, noio);
>>> +    if (!target_data_buf)
>>> +        goto exit;
>>> +
>>> +    /*
>>> +     * Get the index of the target in the table.
>>> +     */
>>> +    num_targets = dm_table_get_num_targets(table);
>>> +    for (target_index = 0; target_index < num_targets; 
>>> target_index++) {
>>> +        ti2 = dm_table_get_target(table, target_index);
>>> +        if (!ti)
>>> +            goto exit;
>> This check for "ti" can be done on function entry to avoid memory 
>> allocations and calls to dm_table_get_num_targets(), 
>> dm_table_get_target() when "ti" is NULL.
> 
> I actually wanted to check for ti2, but I think this entire loop can be 
> simplified to:
> 
>      num_targets = dm_table_get_num_targets(table);
>      for (target_index = 0; target_index < num_targets; target_index++) {
>          ti2 = dm_table_get_target(table, target_index);
>          if (ti == ti2)
>              break;
>      }
>      if (target_index == num_targets)
>          goto exit;
> 
> This should work and because we iterate over all targets and if we 
> iterated over all and did not find a match then we skip the measuring.
> I do not know if checking if "ti" is NULL is required because it should 
> never be NULL in my understanding.
Sounds good.

> 
>>
>>> +        if (ti == ti2) {
>>> +            found = true;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (!found)
>>> +        goto exit;
>>> +
>>> +    scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,
>>> +              "target_index=%d,target_begin=%llu,target_len=%llu,",
>>> +              target_index, ti->begin, ti->len);
>> Check return status of "scnprintf()" and handle any error.
> 
> The other code in dm-ima.c also does not check for errors "scnprintf()".
> Do you have an example on how to handle "scnprintf()" errors?
scnprintf returns the number of characters written into the buffer not 
including the trailing '\0'. Instead of calling strlen on 
target_metadata_buf, the return value of scnprintf can be used.

scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,			 
"target_index=%d,target_begin=%llu,target_len=%llu,",
		  target_index, ti->begin, ti->len);

target_metadata_buf_len = strlen(target_metadata_buf);

  -lakshmi

> 
> Regards,
> Thore
> 
> 
>>
>> thanks,
>>   -lakshmi
>>
>>> +    target_metadata_buf_len = strlen(target_metadata_buf);
>>> +
>>> +    if (ti->type->status)
>>> +        ti->type->status(ti, STATUSTYPE_IMA, STATUSTYPE_IMA, 
>>> target_data_buf,
>>> +                    DM_IMA_TARGET_DATA_BUF_LEN);
>>> +    else
>>> +        target_data_buf[0] = '\0';
>>> +    target_data_buf_len = strlen(target_data_buf);
>>> +
>>> +    memcpy(ima_buf + l, DM_IMA_VERSION_STR, 
>>> md->ima.dm_version_str_len);
>>> +    l += md->ima.dm_version_str_len;
>>> +
>>> +    memcpy(ima_buf + l, md->ima.active_table.device_metadata,
>>> +           md->ima.active_table.device_metadata_len);
>>> +    l += md->ima.active_table.device_metadata_len;
>>> +
>>> +    memcpy(ima_buf + l, target_metadata_buf, target_metadata_buf_len);
>>> +    l += target_metadata_buf_len;
>>> +
>>> +    memcpy(ima_buf + l, target_data_buf, target_data_buf_len);
>>> +
>>> +    dm_ima_measure_data("dm_target_update", ima_buf, 
>>> strlen(ima_buf), noio);
>>> +
>>> +exit:
>>> +    kfree(ima_buf);
>>> +    kfree(target_data_buf);
>>> +    kfree(target_metadata_buf);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dm_ima_measure_on_target_update);
>>> diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
>>> index b8c3b614670b..281a8b65f8a9 100644
>>> --- a/drivers/md/dm-ima.h
>>> +++ b/drivers/md/dm-ima.h
>>> @@ -63,6 +63,7 @@ void dm_ima_measure_on_device_resume(struct 
>>> mapped_device *md, bool swap);
>>>   void dm_ima_measure_on_device_remove(struct mapped_device *md, bool 
>>> remove_all);
>>>   void dm_ima_measure_on_table_clear(struct mapped_device *md, bool 
>>> new_map);
>>>   void dm_ima_measure_on_device_rename(struct mapped_device *md);
>>> +void dm_ima_measure_on_target_update(struct dm_target *ti);
>>>   #else
>>> @@ -72,6 +73,7 @@ static inline void 
>>> dm_ima_measure_on_device_resume(struct mapped_device *md, boo
>>>   static inline void dm_ima_measure_on_device_remove(struct 
>>> mapped_device *md, bool remove_all) {}
>>>   static inline void dm_ima_measure_on_table_clear(struct 
>>> mapped_device *md, bool new_map) {}
>>>   static inline void dm_ima_measure_on_device_rename(struct 
>>> mapped_device *md) {}
>>> +static inline void dm_ima_measure_on_target_update(struct dm_target 
>>> *ti) {}
>>>   #endif /* CONFIG_IMA */
