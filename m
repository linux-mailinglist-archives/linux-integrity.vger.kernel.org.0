Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9851F884
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiEIJv1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiEIJWc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 05:22:32 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 02:18:38 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699CA1CD248
        for <linux-integrity@vger.kernel.org>; Mon,  9 May 2022 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652087537;
    s=strato-dkim-0002; d=thson.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Cuy874WVpPgMlVqFfMj9/hA5iZsWUVqBiEN1TpB821Q=;
    b=au7BSmtq2+LvVYDpDtYKZhBaXEaWufEb4a7G1ANyF3UGhLMhk8iZYDCpdPOmcTYEXE
    Ektz9SSBKI8v+tENaAXHV+rk2LzME4EVHTBLiIDhavzRmedmwKkiYYzzjwtkSZy0ftsf
    Y40NVENDYAq23COOOOpTy/91P8dF2xdOowlQHgBkWmeuCtitPaA0Voif0G0StLzmWhGM
    YOu3uvKIrZbF8KCXhkai3m7pe/NcPkTNRm8rv/kU17Lk9XKe/CSE+aAoJCKuvqvAjN9P
    sesq9LXrmnHvkDgRslMWP813PYznYHp9QewesBdrFfXJ9JnvMET6MYGcdGiKfNwhz2iY
    oZPQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7j/79t2yVxcUdnYNcUb5wZPHWwAJ3XYfSj54="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.22]
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey499CHTay
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 9 May 2022 11:12:17 +0200 (CEST)
Message-ID: <8f8d7334-0812-7489-44a7-34c2bf0c9973@thson.de>
Date:   Mon, 9 May 2022 11:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 0/3] dm ima: allow targets to remeasure their state
Content-Language: en-US
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20220106203436.281629-1-public@thson.de>
 <9fefc681-c8dd-0312-2d6b-ffe3fec05dcf@linux.microsoft.com>
From:   Thore Sommer <public@thson.de>
In-Reply-To: <9fefc681-c8dd-0312-2d6b-ffe3fec05dcf@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

thank you for taking a closer look at this patch set.

On 06.05.22 22:16, Lakshmi Ramasubramanian wrote:
> Hi Thore,
> 
> On 1/6/2022 12:34 PM, Thore Sommer wrote:
>> The current DM IMA events do not cover the case where a device changes
>> their attributes to indicate a state change. 
> It would be good to state here what issue(s) are caused, if any, or what 
> data\event we might be missing as a result of not measuring the device 
> attribute changes. And, then state the benefits of the changes you have 
> implemented in this patch series.

The existing behavior only measures the table content on target/device 
creation. This is fine for targets where the table content never 
changes, but some targets like verity, multipath and raid also use the 
table to indicate state changes. Those state changes are currently not 
measured via the device mapper IMA integration.

Measuring the state changes for verity this is especially important 
because after the initial creation the target is never corrupted and 
only marked as such when a corrupted block read. We want to measure that 
change to remotely attest that the correct file system is used and not 
tampered with. Doing that is not possible with the current features in 
the kernel.

> This adds a new event
>> (dm_target_update) which allows targets to remeasure their table entries.
>> The event includes the dm version, device metadata and the target data.
>>
>> Currently only verity supports this event to ensure that device 
>> corruption
>> can be detected using IMA which is useful for remote attestation.
> Using the term "currently" in this context seems to indicate that this 
> is the current state (existing behavior) in the Linux kernel 
> implementation. You could instead reword it to indicate that your 
> proposed measurement change is used by verity to add support for 
> detecting device corruption.

Yes "currently" is confusing here, I will change it in v2.

Regards,
Thore


> 
>>
>> The current implementation does not update the active table hash because
>> it would require to rehash the entire table on every target change.
> Similar to the above comment - could be reworded to indicate this is the 
> proposed change and not the existing behavior.
> 
> thanks,
>   -lakshmi
> 
>>
>> Thore Sommer (3):
>>    dm ima: allow targets to remeasure their table entry
>>    dm verity: add support for IMA target update event
>>    dm ima: add documentation target update event
>>
>>   .../admin-guide/device-mapper/dm-ima.rst      | 33 ++++++++
>>   drivers/md/dm-ima.c                           | 76 +++++++++++++++++++
>>   drivers/md/dm-ima.h                           |  2 +
>>   drivers/md/dm-verity-target.c                 |  6 ++
>>   4 files changed, 117 insertions(+)
>>
