Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F551F8F5
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiEIJv1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiEIJmM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 05:42:12 -0400
X-Greylist: delayed 1547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 02:38:16 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D317994D
        for <linux-integrity@vger.kernel.org>; Mon,  9 May 2022 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652088815;
    s=strato-dkim-0002; d=thson.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ONSAThtJLuBaszJyYYfU6xGCTarcn2ZJ8kr0lArhcUA=;
    b=tpDSPz6+G2qa3xVbab+ur6wCSaeEdw4gdZiFicjymse2ijlS1prizpx/AYrUvN0k/M
    /Qeae16bxOq6i2Szuqdgs2FFyKChY1+AbfEgqG5Z5xScd0E9OainlFgl+LBEqekhWqfS
    K7EG/MExA5e1nvF6DrPZA97PeFecZrvXbc62quQtYxUKhY8M8T2gFwh0z1yXyLOPFICr
    vfp/cEs3k+NabH6/87iX8VCMu51sNl3HnXHje5IDbGdfnGzZL3vbrtnEjNz1xpCQNTku
    WWh7j00QGLLBeR5m8D7f5RxXxv194lhBUfgOhPuREvocgM3/rwke17TICtttmglr44yh
    G5MA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7j/79t2yVxcUdnYNcUb5wZPHWwAJ3XYfSj54="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.22]
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey499XYTma
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 9 May 2022 11:33:34 +0200 (CEST)
Message-ID: <6d306aff-aa9c-0723-a44f-620e2885483b@thson.de>
Date:   Mon, 9 May 2022 11:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] dm verity: add support for IMA target update
 event
Content-Language: en-US
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20220106203436.281629-1-public@thson.de>
 <20220106203436.281629-3-public@thson.de>
 <b4c21ae2-3980-c7ca-7719-7477d0acaa72@linux.microsoft.com>
From:   Thore Sommer <public@thson.de>
In-Reply-To: <b4c21ae2-3980-c7ca-7719-7477d0acaa72@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On 06.05.22 22:35, Lakshmi Ramasubramanian wrote:
> Hi Thore,
> 
> On 1/6/2022 12:34 PM, Thore Sommer wrote:
>> On first corruption the verity targets triggers a dm_target_update event.
>> This allows other systems to check using IMA if the state of the 
>> device is
>> still trustworthy via remote attestation.
> In the patch description please state the existing problem (or, 
> limitation in the existing implementation) and then describe how the 
> proposed change addresses the issue.

The problem is that we never see a IMA entry when a target gets marked 
as corrupted. The proposed change uses the new dm_target_update event to 
remeasure the table when the target table entry changes from valid to 
corrupted. I will add a more complete description to v2.

> 
>>
>> Signed-off-by: Thore Sommer <public@thson.de>
>> ---
>>   drivers/md/dm-verity-target.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/md/dm-verity-target.c 
>> b/drivers/md/dm-verity-target.c
>> index 80133aae0db3..09696e25bf1c 100644
>> --- a/drivers/md/dm-verity-target.c
>> +++ b/drivers/md/dm-verity-target.c
>> @@ -16,6 +16,7 @@
>>   #include "dm-verity.h"
>>   #include "dm-verity-fec.h"
>>   #include "dm-verity-verify-sig.h"
>> +#include "dm-ima.h"
>>   #include <linux/module.h>
>>   #include <linux/reboot.h>
>>   #include <linux/scatterlist.h>
>> @@ -218,10 +219,15 @@ static int verity_handle_err(struct dm_verity 
>> *v, enum verity_block_type type,
>>       char *envp[] = { verity_env, NULL };
>>       const char *type_str = "";
>>       struct mapped_device *md = dm_table_get_md(v->ti->table);
>> +    int old_hash_failed = v->hash_failed;
>>       /* Corruption should be visible in device status in all modes */
>>       v->hash_failed = 1;
>> +    /* Only remeasure on first failure */
>> +    if (!old_hash_failed)
>> +        dm_ima_measure_on_target_update(v->ti);
> It is not obvious to me why the call to measure on target update is not 
> done here immediately. Updating the comment to explain the logic would 
> help.
The change should be only measured once, because otherwise we would 
create many IMA entries each for every corrupted block read if I 
understand the verity code correctly. So we need to check if the state 
before was valid, but we need to measure after the table was changed to 
corrupted (v->hash_failed = 1).

Something like this might be a bit clearer and does not use a extra 
variable:

+    if (!v->hash_failed)
+        v->hash_failed = 1;
+        dm_ima_measure_on_target_update(v->ti);


Regards,
Thore

> 
> thanks,
>   -lakshmi
> 
>> +
>>       if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
>>           goto out;
