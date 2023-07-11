Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32BA74F7A7
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGKR7M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGKR7L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 13:59:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A75F810EF
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 10:59:10 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id F14F721C3A86;
        Tue, 11 Jul 2023 10:59:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F14F721C3A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689098350;
        bh=WSjxDjeKuh5YC4rclUlKkaHpQJmUGwQ/LPglD0lAajY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OOLpHPQ74J0/O6dlN6YUBT8yhJPxTahq8fK6vLAO9dDTS1LS0aF8OdHH7LDA+8Xxi
         4KHrLIK+f/81HZ29Bxx/pu1wHQ8aN/iM+tTXV7rdqTgdWmx6fJsb/qvFIc2Hmhhpke
         wShAU6RiKyaBW34uQRPtE1cHbaMIBA8stWK+3E2w=
Message-ID: <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 10:59:07 -0700
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/7/23 06:00, Mimi Zohar wrote:
> Hi Tushar,
>
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>> IMA does not provide a mechanism to allocate memory for IMA log storage
>> during kexec operation.
> The IMA measurement list is currently being carried across kexec, so
> obviously a buffer is being allocated for it.  IMA not allocating
> memory for the measurment list is not the problem statement.  Please
> concisely provide the problem statement, explaining why IMA needs to
> allocate the buffer.
>
I meant IMA does not provide separate functions to allocate buffer and
populate measurements.  Both operations are wrapped in an atomic
ima_dump_measurement_list().

As I mentioned in the comment in the cover letter, if there is no such
technical limitation to allocate the buffer and copy the measurements at
kexec ‘execute’ – I will make the necessary code changes and update the
above line in the patch description accordingly.
>> The function should handle the scenario where
>> the kexec load is called multiple times.
> Currently the buffer is being freed with the kexec 'unload'.  With this
> patch IMA is allocating a buffer for the measurement list, which needs
> to be freed independently of the kexec 'unload'.
If we end up allocating the buffer at kexec ‘execute’ (which results in
soft boot to next Kernel) – is it technically possible that
kexec ‘unload’ being called after calling kexec ‘execute’?

If not, should I still free the buffer at kexec ‘unload’ in this
scenario?

~Tushar


>> Implement a function to allocate buffer of size kexec_segment_size at
>> kexec load.  If the buffer was already allocated, free that buffer and
>> reallocate.  Finally, initialihze ima_khdr struct.
>>
>> The patch operates under the assumption that the segment size does not
>> change between kexec load and execute.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
