Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F756751182
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGLTty (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGLTtx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 15:49:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9791989
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 12:49:52 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1227E21C44E3;
        Wed, 12 Jul 2023 12:49:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1227E21C44E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689191392;
        bh=ViYk1dHUP0PzQJOj4xP3Ncph/FRmJwJ5E2AzHzwCZ+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=di63AnOmtZIPjP08PqwbuZ6NWzDZ0ShWal6MvmlVnmb2sz1/D5TagY7rU2nU9OC18
         b6Cm6MP99R4OplFUTxJmpjQm1+7gsO7va0fohuCbj35zfrXAdpgrRpYehNu+Ahjiz9
         N4KZdF2N11l6Yi/9XV6P4t/9rDgRJx5/a6Ea6y28=
Message-ID: <ea63d19e-af38-69a5-d253-3ba7fbeeca6c@linux.microsoft.com>
Date:   Wed, 12 Jul 2023 12:49:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/10] ima: implement function to allocate buffer at kexec
 load
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
 <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
 <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
 <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/11/23 14:11, Mimi Zohar wrote:
> On Tue, 2023-07-11 at 10:59 -0700, Tushar Sugandhi wrote:
>> Adding Eric to cc.
>>
>> On 7/7/23 06:00, Mimi Zohar wrote:
>>> Hi Tushar,
>>>
>>> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>>>> IMA does not provide a mechanism to allocate memory for IMA log storage
>>>> during kexec operation.
>>> The IMA measurement list is currently being carried across kexec, so
>>> obviously a buffer is being allocated for it.  IMA not allocating
>>> memory for the measurment list is not the problem statement.  Please
>>> concisely provide the problem statement, explaining why IMA needs to
>>> allocate the buffer.
>>>
>> I meant IMA does not provide separate functions to allocate buffer and
>> populate measurements.  Both operations are wrapped in an atomic
>> ima_dump_measurement_list().
> Ok.
>
>> As I mentioned in the comment in the cover letter, if there is no such
>> technical limitation to allocate the buffer and copy the measurements at
>> kexec ‘execute’ – I will make the necessary code changes and update the
>> above line in the patch description accordingly.
> The "normal" way of making this type of change would be to split the
> existing ima_dump_measurement_list() function.  Copying the measurement
> list would still be named ima_dump_measurement_list().  The other could
> be named ima_alloc_kexec_buf().  Both functions initially would be
> called.
>
Sounds good.  I will make that change.
I will define ima_alloc_kexec_buf() to allocate memory at kexec 'load'.
And update ima_dump_measurement_list() to only copy the measurements.

Both the functions will be called during kexec 'load'.

And only the updated ima_dump_measurement_list() will be called
during kexec 'execute'.

Please correct me if I misunderstood.

BTW, as discussed elsewhere I am hoping to get clarity on if we can move
everything (memory allocation and copying measurements) to kexec 'execute'.

My current understanding is segment mapping must happen at kexec 'load'.
Hopefully someone on this thread can validate if its true or not.

> Eric, besides updating the buffer at kexec execute, is there anything
> else that needs to be done (e.g. updating digests)?
>
I will also wait for his response. :)
>>>> The function should handle the scenario where
>>>> the kexec load is called multiple times.
>>> Currently the buffer is being freed with the kexec 'unload'.  With this
>>> patch IMA is allocating a buffer for the measurement list, which needs
>>> to be freed independently of the kexec 'unload'.
>> If we end up allocating the buffer at kexec ‘execute’ (which results in
>> soft boot to next Kernel) – is it technically possible that
>> kexec ‘unload’ being called after calling kexec ‘execute’?
>> If not, should I still free the buffer at kexec ‘unload’ in this
>> scenario?
> The question is how to access the buffer once kexec_add_buffer() is
> called.
>
> Mimi
