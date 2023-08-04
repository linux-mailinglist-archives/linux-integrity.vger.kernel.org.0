Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621A17706DA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjHDRMA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjHDRMA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 13:12:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF4D41994
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 10:11:58 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id F161F207F58A;
        Fri,  4 Aug 2023 10:11:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F161F207F58A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691169118;
        bh=5HYDNc5C5jxcr2IsCCVYRz1Hk0NvwCMwdDwURbIbniw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ksoqh+tmbAFT1bqzrfLCEfdbS1cYLvKRZyEUV+yGutAvYU/g2CmuYxAdg+keVSqfL
         DSWomwETuL1g1DoQEKGAldmz6c1eLcy+yehRrqX5w2nLyxhBOgz6e3tjx3bHM+3PGE
         qTv6lzQc6Hq3g5Jhxyj5HLR+C8wRhcF6uma4944o=
Message-ID: <299c6b9d-a9d6-b5c9-697f-3c320fad91c6@linux.microsoft.com>
Date:   Fri, 4 Aug 2023 10:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] ima: measure TPM update counter at ima_init
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-6-tusharsu@linux.microsoft.com>
 <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
 <da91b56a-83c8-d12e-71f8-887b6701f021@linux.microsoft.com>
 <e9ab98a823c2e6c536fb2acbe86229a0085bd34a.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e9ab98a823c2e6c536fb2acbe86229a0085bd34a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/3/23 18:18, Mimi Zohar wrote:
> On Thu, 2023-08-03 at 16:34 -0700, Tushar Sugandhi wrote:
>
>>>> +++ b/security/integrity/ima/ima_init.c
>>>> @@ -154,5 +154,8 @@ int __init ima_init(void)
>>>>    				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>>>>    				  NULL, 0);
>>>>    
>>>> +	/* Measures TPM update counter at ima_init */
>>>> +	ima_measure_update_counter("ima_init_tpm_update_counter");
>>>> +
>>> With "ima_policy=critical_data" on the boot command line, the IMA
>>> measurement list record looks like:
>>>
>>> 6e190cc643ff0b718485966a0300473baedface735 ima_init_tpm_update_counter 7570646174655f636f756e7465723d3330383b
>>>
>>> Please change the "ima_init_tpm_update_counter" to something shorter
>>> and the hex encoded ascii string and pcr counter to something readable.
>> I believe you are seeing the above line in ascill_runtime_measurements log.
> Yes, the ascii_runtime_measurements are suppose to be readable to the
> end user.
We were passing string literals to 'buf' param in 
ima_measure_critical_data().
I believe we need to convert them first.

>> The ascii logging format is consistent with other event data for
>> critical_data event e.g. kernel_version.
> Then you got it wrong.
I see.  I will fix it for tpm in this patch series.
I think I should spin up another series to fix it for
selinux, kernel info, DM etc.
>> 10 8f449175bbf88bc55fc1127466628c39a3957d15 ima-buf
>> sha1:4acab4fbb08db663b7b7b4528e8729187d726782 kernel_version
>> 362e332e302d7263332b
>> 10 f10678b63c4b2529339dff02282e63d9c6bb0385 ima-buf
>> sha1:d8c187524412f74a961f2051a9529c009e700337
>> ima_init_tpm_update_counter 7570646174655f636f756e7465723d3133303b
>>
>> Entries in the binary runtime measurements look readable to me.
> You've inverted the meaning of the ascii and binary runtime measurement
> lists.  For comparison look at the ima-ng/ima-sig records.
Yup.  Agreed.
>> ima_init_tpm_update_counter update_counter=130;
>> ...
>> kexec_load_tpm_update_counte rupdate_counter=133;
>>
>> Please let me know if you still want me to change the format.
> OI course the ascii measurement list should be human readable.
Yup.  I will make the changes as I mentioned above.
>
>>> Perhaps name this critical-data "tpm" and "tpm-info", similar to the
>>   From patch 4/6:
>> +    result = ima_measure_critical_data("tpm_pcr_update_counter",
>> event_name,
>> +                  buf, buf_len, false, NULL, 0);
>>
>> The critical_data event_label value is currently set to
>> "tpm_pcr_update_counter".
> Why is the string so long?   Long strings or variables don't make the
> code or logs more understandable.  Please shorten both the strings and
> variables.
Agreed.  I will name this "tpm" and "tpm-info" or something similar.
>> I can rename event_label to "tpm-info", so that the admins can filter the
>> event in IMA policy based on the label if needed.
> The new record needs to be self containd and verifiable.  The
> additional info I suggested were just examples.  Please take the time
> to consider what needs to be included in the new record.  Decide
> whether this is a TPM security critical data record.  Only then, decide
> on the naming.
Yes.  I will explore what other potential attributes can be added to 
this record.
And I'll share them here for the community feedback.
