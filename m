Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62376F378
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjHCTd5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCTd4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 15:33:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CF6EE77
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 12:33:55 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B33B207F5B0;
        Thu,  3 Aug 2023 12:33:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B33B207F5B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691091234;
        bh=rfoxZMZ2hyhRIAWppNtheFwJlnTpKt2nHIchOzxIXPY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V2YuPDHyoo0gKow3V7av5aCdZ3WkjHujn4xvjWGSuaS9B49p1bq4DO2jcjXhDWLc6
         1I8MBMcLemv7wOYsN/b2fKlSYmjY/PpVVrzJK43VePYp5WQT7TPFg0/9oYytK1Qpjd
         adlWLpCPy0kM2486SiNGWLCGiXLR2uDUSqXdSmyE=
Message-ID: <d9e7297a-cda7-74e5-70a8-dd128f68f726@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 12:33:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
 <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
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


On 8/3/23 01:57, Jarkko Sakkinen wrote:
> On Thu Aug 3, 2023 at 4:22 AM EEST, Mimi Zohar wrote:
>> On Wed, 2023-08-02 at 06:58 +0300, Jarkko Sakkinen wrote:
>>>  From long description I see zero motivation to ack this change, except
>>> some heresay about IMA requiring it. Why does IMA need update_cnt and
>>> why this is not documented to the long description?
>> The motivation is to detect whether the IMA measurement list has been
>> truncated, for whatever reason.  A new IMA record should be defined
>> containing the "pcrCounter" value.  (I have not had a chance to review
>> this patch set.)
>>
>> This new record would be a pre-req for both Tushar's "ima: measure
>> events between kexec load and execute" patch set and Sush's proposal to
>> trim the measurement list.  (I haven't looked at it yet either.)
> Please describe the story in a bit more understandable form. In the
> commit messages it is not good to have some redundancy in patch sets.
>
> BR, Jarkko
Thanks Jarkko.  I had provided the overall context in the cover letter.
But I understand the cover letter will be lost when the patches are
merged. I will describe the story in the patch descriptions as well,
in the next version of this series.

~Tushar
