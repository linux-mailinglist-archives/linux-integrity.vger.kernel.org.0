Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A707706E2
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjHDRNa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHDRN2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 13:13:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEAC3198B
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 10:13:27 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 12E3B207F58A;
        Fri,  4 Aug 2023 10:13:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12E3B207F58A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691169207;
        bh=/kopZg2eS8L3J5NXUqMLlqBVgWBXjlwKr8Cpu2BqWjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hTmQNlFmuXlrJqcQKWn0IsHDa0iEoxbj338XLljMguLNxyx1bBA+4QdBlDFaWtg3H
         AmSIp/VtYAFUkBiPXiStLTjDPWj/7I7ppO9iZSw5ruGmlSChKOf9ks5oX42lmAdyOO
         l32G4ey9gOnVZ7PrFLQDEspM+2pvdWPsjTjWyQQs=
Message-ID: <dbe58fc4-80f6-664f-e834-c27d64a8c60a@linux.microsoft.com>
Date:   Fri, 4 Aug 2023 10:13:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-5-tusharsu@linux.microsoft.com>
 <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
 <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
 <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/3/23 18:22, Mimi Zohar wrote:
> On Thu, 2023-08-03 at 16:01 -0700, Tushar Sugandhi wrote:
>>>> +    scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
>>>> +                      update_counter);
>>>> +
>>>> +    buf_len = strlen(buf);
>>>> +
>>>> +    result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
>>>> +                              buf, buf_len, false, NULL, 0);
>>>>
>>> The new record should contain everything needed to verify the
>>> pcrCounter.  For example, each IMA measurement record updates the
>>> pcrCounter for each TPM bank enabled.  So the number of enabled TPM
>>> banks and number of IMA measurements should also be included in this
>>> record.
>> Agreed. That should be valuable information.
>> How does the below format look like for the buf above?
>>
>> version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;
> Refer to comment in 5/6.
Responded.
>>> Perhaps include a version number as well, so that if we ever want to
>>> include other information, we could.
>> By version number, do you mean kernel_version, or a new version
>> number specific to this record? Or something else?
> This is a record version type number.  The record format shouldn't
> change, but we should be prepared for it changing.  A single number
> should be fine.
>
Sounds good.

