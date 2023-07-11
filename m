Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9BD74F844
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGKTLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGKTLp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 15:11:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841B81705
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 12:11:44 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id CC79821C3A89;
        Tue, 11 Jul 2023 12:11:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC79821C3A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689102704;
        bh=GKxqe8os36wp7SYz7yVh3qvFrnisvzs2Xal1CiLRFEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bjc9zA9OXJ702Uod3JO53hYvRvEMpOq0vUS3W/UpYRr65esp35gNOyAp6KUgimsEg
         mMQLmOCzeuQAbyJKaf6MQtUXaPK6yEV6+0PkQmHQmSFJ6Q746/aY1tkmMJ7EAfUODI
         yNIbcXlHcxzVomn47p170Kg8kX3e+LbtEPAPVBfM=
Message-ID: <ed466669-994c-4e19-1582-4ebf48492e68@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 12:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] ima: remove function ima_dump_measurement_list
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
 <3a67093401f6d14224e9cef748a9e2c191d21fa1.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <3a67093401f6d14224e9cef748a9e2c191d21fa1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding Eric to cc.


On 7/7/23 06:55, Mimi Zohar wrote:
> Hi Tushar,
>
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>> The ima_dump_measurement_list function was designed to iterate over the
>> IMA measurement list and store each entry into a buffer.  The buffer,
>> along with its size, would be returned to the caller.  However, the
>> function is no longer required in the IMA subsystem.  It previously served
>> to dump the measurement list during the kexec 'load' operation, but this
>> functionality has been replaced by an alternative approach in this patch
>> series.
>>
>> Remove the unused ima_dump_measurement_list function from the IMA
>> subsystem, to ensure a cleaner and more maintainable code.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Have you compiled the code and tested after applying each patch?
> Removing the caller before removing the code should have resulted in a
> warning.
>
Yes, I compiled each patch separately, and I did see this warning.
But removing ima_dump_measurement_list after implementing and
calling the alternate ima_allocate_buf_at_kexec_load() and
ima_populate_buf_at_kexec_execute() felt cleaner in terms of organizing
the patches.

I can remove the definition when I deprecate the usage, if we end up
using the alternate two functions.

~Tushar
