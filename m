Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3376D926
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Aug 2023 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjHBVFA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Aug 2023 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHBVFA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Aug 2023 17:05:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43CDF26AB
        for <linux-integrity@vger.kernel.org>; Wed,  2 Aug 2023 14:04:59 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 515BD238C43B;
        Wed,  2 Aug 2023 14:04:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 515BD238C43B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691010298;
        bh=lDhGmfOqOASIVIWXuGXoYoWxEku+AuKF6Qlgy+mAwtU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bU9/BT1+pCU9BG6swaQw91EZJeOBr4XQsaCuEhORCtzAm2tWmwVLxpCePkXMCd94r
         ya5C3hChz2Ax3H8zeh1WuxjCSNA5sZGGxq4QSHQx0obmVtsfTt7XU5BRjfi1m2kJXr
         OcsZhZ4RdSCjMMlbTWveU7naD+yvYEYmmiEDLvlQ=
Message-ID: <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
Date:   Wed, 2 Aug 2023 14:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
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


On 8/1/23 20:58, Jarkko Sakkinen wrote:
> On Wed Aug 2, 2023 at 12:01 AM EEST, Tushar Sugandhi wrote:
>> Thanks for the response Jarkko.
>>
>> On 8/1/23 12:02, Jarkko Sakkinen wrote:
>>> The short summary is cryptic to say the least.
>> Do you mean the patch subject line, or the description below?
> It is in the process documentation:
>
> https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#the-canonical-patch-format
Sounds good.  I will cleanup both the summary phrase and the patch 
description.
>>> "update counter" does not map it to have anything to do with PCRs.
>> Agreed.  I noticed that when I was testing the patches.
>> The update counter is same for all PCRs.  It was also the same for
>> the two hash algo's I tested it for (SHA1 and SHA256). But the spec
>> description and Kernel implementation requires to pass the
>> pcr_idx and hash algo to PCR_Read command to get the update counter.
> I was referring to the fact that TPM2_PCR_Read does not have a field
> called "update counter" in its response but it has a field called
> "pcrUpdateCounter". Please refer to thigs that actually exist.
>
> In the long description you are in some occasions referring to the same
> object as:
>
> 1. "update counter"
> 2. "pcrUpdateCounter"
> 3. "PcrUpdateCounter"
>
> This is ambiguous and wrong.
Thanks. I will consistently use pcrUpdateCounter going forward.
> >From long description I see zero motivation to ack this change, except
> some heresay about IMA requiring it. Why does IMA need update_cnt and
> why this is not documented to the long description?
Since patch 2 of this series exposes the functionality to IMA,
it is described in the long description of patch 2.

But I can add the description here as well for completeness.
>> But I can update tpm2_pcr_read() if you are ok with it.
>> Please let me know.
> You can add "u32 *update_cnt".
Sounds good.  Will do.

Btw, the function tpm2_pcr_read is not exposed directly to the other
subsystems (like IMA).  It is exposed via tpm_pcr_read.

Do you want to expose tpm2_pcr_read directly,
or do you want me to update the function signature of tpm_pcr_read as well?

Updating the function signature of tpm_pcr_read as well -
to return "u32 *update_cnt" seems like the right approach.
In that case, I can set *update_cnt to say 0 or -1 for TPM1
(because pcrUpdateCounter is not available for TPM1).

Please let me know what do you think.

I will make the changes accordingly.

I will also wait for IMA/Kexec maintainers to take a look at the 
remaining patches
in this series, incorporate their feedback, and send the V2 of this series.

Thanks again for your feedback. Really appreciate it.

~Tushar
>
> BR, Jarkko
