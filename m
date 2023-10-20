Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D67D172B
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJTUjm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 16:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjJTUjm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 16:39:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABFBED7E
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 13:39:38 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 125D020B74C3;
        Fri, 20 Oct 2023 13:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 125D020B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697834378;
        bh=nUkytYBweex8FSgiBNfhqS2Sgayb8/6IvaMM7FHfpuw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rhia76cNBiD4gCSlrI5nPiVXjYyRYpSd1a606ghhKEF+3VR0DhHlY5P592bT5PrLI
         Y7qDls4yaoOq8fmRYVPxG22lfsmf6zKXhF1QhTFpK3V3zX7cEx0ratVQoDKM6MKiwd
         r8DzH2CRK3MVkPWVWUEuINinPQgHSZTglkT0rz4c=
Message-ID: <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 13:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/12/23 17:27, Stefan Berger wrote:
> 
> On 10/5/23 14:26, Tushar Sugandhi wrote:
>> IMA currently allocates half a PAGE_SIZE for the extra events that would
>> be measured between kexec 'load' and 'execute'.  Depending on the IMA
>> policy and the system state, that memory may not be sufficient to hold
>> the extra IMA events measured after kexec 'load'.  The memory
>> requirements vary from system to system and they should be configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
>> of extra pages to be allocated for IMA measurements added in the window
>> from kexec 'load' to kexec 'execute'.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hardcoded one.
>>
>> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     |  9 +++++++++
>>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig 
>> b/security/integrity/ima/Kconfig
>> index 60a511c6b583..1b55cd2bcb36 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>       default n
>>       help
>>          This option disables htable to allow measurement of duplicate 
>> records.
>> +
>> +config IMA_KEXEC_EXTRA_PAGES
>> +    int
>> +    depends on IMA && IMA_KEXEC
>> +    default 16
>> +    help
>> +      IMA_KEXEC_EXTRA_PAGES determines the number of extra
>> +      pages to be allocated for IMA measurements added in the
>> +      window from kexec 'load' to kexec 'execute'.
> 
> 
> On ppc64 a page is 64kb. I would ask for additional kb here.
> 
> 
Not sure I understand.  Do you mean I should make the default value of
the config IMA_KEXEC_EXTRA_PAGES 64 or something?

In code, I multiply the config value with PAGE_SIZE.  So more memory
would be allocated on ppc64 for given default config value. Could you
please clarify what change you are suggesting here?


+        binary_runtime_size = ima_get_binary_runtime_size() +
+                               sizeof(struct ima_kexec_hdr) +
+                               (CONFIG_IMA_KEXEC_EXTRA_PAGES *
PAGE_SIZE);

~Tushar

>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 13fbbb90319b..6cd5f46a7208 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       int ret;
>>       /*
>> -     * Reserve an extra half page of memory for additional measurements
>> -     * added during the kexec load.
>> +     * Reserve extra memory for measurements added in the window from
>> +     * kexec 'load' to kexec 'execute'.
>>        */
>> -    binary_runtime_size = ima_get_binary_runtime_size();
>> +    binary_runtime_size = ima_get_binary_runtime_size() +
>> +                  sizeof(struct ima_kexec_hdr) +
>> +                  (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
>> +
>>       if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>           kexec_segment_size = ULONG_MAX;
>>       else
>> -        kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -                       PAGE_SIZE / 2, PAGE_SIZE);
>> +        kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>       if ((kexec_segment_size == ULONG_MAX) ||
>>           ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>           pr_err("Binary measurement list too large.\n");
