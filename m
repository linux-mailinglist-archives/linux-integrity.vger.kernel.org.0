Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC52F8947
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Jan 2021 00:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAOXQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 18:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAOXQh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 18:16:37 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE3C061757
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jan 2021 15:15:57 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id r9so7274197qtp.11
        for <linux-integrity@vger.kernel.org>; Fri, 15 Jan 2021 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kS2p+Vj0u1A6TZBahSfCk7WONAlYb1Kk5h2sVM3HvGc=;
        b=VFE8vFbc5ziMyiUScbvSXD6fU+FV71KArHbDWJVJ83ZIqOFGWUHcAFfKqWoTIFtXvG
         1Pl9Sy7Ab5awKTk2J9GmGiPYN/bpCCop/js0r6V1fOkwSSn0K3VqHpcESIm6NfQeEkLW
         C7Emckx+koNLrZjO1twf3mDCzZ2yA5sD69OgXD2cdsUUc+AhXJPAOovIFFul1VPmwjw/
         mYRdp+aZgY1NieBCFwdgZtmpLsGM+VzRBNxBQMlVeHO4kjnZevD5/o7Y4+oNoQBYOZm8
         RVnAnS9LevDvAcyxYKBF+1+Pz5olPChv+od0EcN9OeSAN+C5e1064wDDvRxqw3Gf+UWJ
         XGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kS2p+Vj0u1A6TZBahSfCk7WONAlYb1Kk5h2sVM3HvGc=;
        b=kIQ+JJvmkGedhkjqWd4Kb+LD97nYBzTyz/1X/MlT1yGYDQOmZ94Uv6jVWfRcK5xLjT
         YdYxpNfVojkdwhhcMjZp+i1pPMfMfEJ8IKg0cpRgnCaIG//Ir+ptrqw9tSf1mOCzNp7A
         5ns+seOYC/MXp3uSsgc5mqlzF5jTyZflEbdPZeudy0DUigdFv2wE+S+zPLIyPVxC8XRr
         AKL1c5fYF6vNlMQB3phDHl9LcSCVL7jotbBhRNDp88vDRe9KgaXWm/9I/dKW8HBmpkND
         GsYS4EvBy9pgyKv45iIYCYz3Z+NUxME4flrq8NGKJrKEtA/msMvo3gCgayyMTe8D0pwX
         LTjg==
X-Gm-Message-State: AOAM531dKPuHPcS/wrWH48T9uGXPOrFqfNgjpsvOpkeJqj/dKacOnNlA
        2rigjZAni6RVF84XqhWvz/k=
X-Google-Smtp-Source: ABdhPJws6pedeNV/YeW+54N+xI31zq8xiGawGpokxU5h6pRDF3fLK1yyIWp+Z0mQfqmneYZR3K9FnQ==
X-Received: by 2002:a05:622a:93:: with SMTP id o19mr14433550qtw.336.1610752556124;
        Fri, 15 Jan 2021 15:15:56 -0800 (PST)
Received: from elaines-2018-ibm-macbook-pro.lan (c-71-192-139-151.hsd1.nh.comcast.net. [71.192.139.151])
        by smtp.gmail.com with ESMTPSA id 70sm5971892qkk.10.2021.01.15.15.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 15:15:55 -0800 (PST)
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
References: <20201209164249.715178-1-zohar@linux.ibm.com>
 <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
 <X/pxpAfn4MFsXT4g@kernel.org>
 <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
 <X/9k19UoZZdC+y0+@kernel.org>
From:   Elaine Palmer <erpalmerny@gmail.com>
Message-ID: <19d3547b-c285-aa98-0cc3-cc55ef09a1b9@gmail.com>
Date:   Fri, 15 Jan 2021 18:15:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <X/9k19UoZZdC+y0+@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/13/21 4:23 PM, Jarkko Sakkinen wrote:
> On Tue, Jan 12, 2021 at 10:55:44AM +0530, Sumit Garg wrote:
>> On Sun, 10 Jan 2021 at 08:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>> On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
>>>> Hi Jarkko, On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen 
>>>> <jarkko@kernel.org> wrote:
>>>>> On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
>>>>>> From: Elaine Palmer <erpalmer@us.ibm.com> Update trusted key 
>>>>>> documentation with additional comparisons between discrete TPMs 
>>>>>> and TEE. Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com> 
>>>>> Right, so OP-TEE is not the same as TEE. I did not know this and 
>>>>> the patch set does not underline this. I re-checked the patches 
>>>>> and none of them say explicitly that OP-TEE is an application 
>>>>> living inside TEE. 
>>>> This patch-set provides a trust source based on generic TEE 
>>>> interface where underlying TEE implementations like OP-TEE 
>>>> (drivers/tee/optee/), AMD TEE (drivers/tee/amdtee/) etc. can easily 
>>>> be hooked up. And this is similar to the TPM interface where 
>>>> underlying TPM implementations like discrete TPM, virtual TPM, 
>>>> firmware TPM etc. can be easily hooked up.
>>>>> This essentially means that the backend needs to be renamed as 
>>>>> "op_tee". 
>>>> I don't see any need for this, see above. 
>>> Right, TEE is a protocol standard, just like TPM, and OP-TEE is one 
>>> implementation of this interface? I.e. OP-TEE does not define API 
>>> that is hard bound to OP-TEE? 
>> Yes, OP-TEE doesn't define a hard bound client interface API. The 
>> client API is based on TEE client API specification [1] from 
>> GlobalPlatform. [1] 
>> http://globalplatform.org/specs-library/tee-client-api-specification/ 
>> -Sumit 
> Thanks, bookmarked. No need for name change. /Jarkko 
This discussion has illustrated that even those of us who live and
breathe this stuff could use clarification.  Shouldn't we recommend
that the Trust Source have a hardware root of trust?  We could be
even more specific.  For example, the documentation could recommend
that a TPM be evaluated under "TCG Protection Profile for PC Client
Specific TPM 2.0" or later and a TEE be evaluated under GlobalPlatform
"TEE Protection Profile v1.3, GPD_SPE_021" or later.  Of course, our
recommendation would not be a requirement, but it would provide
guidance for deployment as well as precedent for future Trust Sources.

I know where I'm getting stuck is on TEEs as a concept vs
TEEs with specific hardware requirements and interfaces.
The same applies to TPMs.  There are hardware TPMs that meet
the protection profile and there are other implementations
(e.g., vTPMs) that use the same interface, but aren't anchored in
hardware.

I know if I were deploying a server, mobile device, or IoT device, I'd
want to know exactly what is protecting my keys.  A generic TPM or TEE
doesn't tell me enough.

-Elaine


