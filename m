Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4574F818
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGKSl0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKSlZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 14:41:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53A071704
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 11:41:24 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9840721C3A8D;
        Tue, 11 Jul 2023 11:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9840721C3A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689100883;
        bh=0GFCMNg+hUxtyeZcShJCkgLrUpGQ8MTiJMhSHuPwS3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iP1W+zVrSVAQrGy8cXoByzhI3bZaukOYdGVH9EqFojNZgzR1e2zhow2HqDQ4cHdG5
         G3X1AbagoCZucIyEr0cVQ5GMrdFyeQ9FB7al/pBwTH3SPhKHWGOV+r+nWwp4sgwyw+
         psN/2zIbasw6jX6ScpjiXYUqNGYaOCLGcFVWE9VQ=
Message-ID: <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
Date:   Tue, 11 Jul 2023 11:41:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] kexec: implement functions to map and unmap segment
 to kimage
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
 <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
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

On 7/7/23 05:28, Stefan Berger wrote:
>
>
> On 7/3/23 17:57, Tushar Sugandhi wrote:
>> Currently, there's no mechanism to map and unmap segments to the kimage
>> structure.  This functionality is needed when dealing with memory 
>> segments
>> in the context of a kexec operation.
>>
>> The patch adds two new functions: kimage_map_segment() and
>> kimage_unmap_segment().
>>
>> Implement kimage_map_segment() which takes a kimage pointer, an address,
>> and a size.  Ensures that the entire segment is being mapped by 
>> comparing
>> the given address and size to each segment in the kimage's segment 
>> array.
>> Collect the source pages that correspond to the given address range,
>> allocate an array of pointers to these pages, and map them to a 
>> contiguous
>> range of virtual addresses.  If the mapping operation is successful, the
>> function returns the start of this range.  Otherwise, it frees the page
>> pointer array and returns NULL.
>>
>> Implement kimage_unmap_segment() that takes a pointer to a segment 
>> buffer
>> and unmaps it using vunmap().
>>
>> Finally, move for_each_kimage_entry() macro to kexec.h.
>>
>> Note: Use kimage_map_segment() and kimage_unmap_segment() carefully to
>> avoid memory leaks and ensure that all mapped segments are properly
>> unmapped when they're no longer needed.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>
>> +
>> +    i = 0;
>> +    for_each_kimage_entry(image, ptr, entry) {
>> +        if (entry & IND_DESTINATION)
>> +            dest_page_addr = entry & PAGE_MASK;
>> +        else if (entry & IND_SOURCE) {
>> +            if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>> +                src_page_addr = entry & PAGE_MASK;
>> +                src_pages[i++] = phys_to_page(src_page_addr);
>
> Since phys_to_page is not defined on many/most architectures I change 
> it for ppc64 and have successfully used the following:
>
> +                               src_pages[i++] = 
> virt_to_page(__va(src_page_addr))
>
>
> After several kexecs the following check still works:
>
> # evmctl ima_measurement --ignore-violations 
> /sys/kernel/security/ima/binary_runtime_measurements
> Matched per TPM bank calculated digest(s).
>
>
>    Stefan
Thank you so much Stefan for reviewing this series, and catching this
issue.  Are you suggesting I should use virt_to_page on all architectures
unconditionally, or use it only when phys_to_page is not available?

~Tushar
