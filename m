Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1774D15851F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 22:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJVmU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 16:42:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53486 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVmU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 16:42:20 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 20CA020B9C02;
        Mon, 10 Feb 2020 13:42:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20CA020B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581370939;
        bh=c0TukwmucTy5RNLXk2xO2mRGV73gFeBoYmLm/yU+Twk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ld3OZ01zdXOclFIWk5fVyoBn2BoPxcahsNhaHF7p201N+Pyo3e7z2DMLjXSe13BV7
         i1Krue3xOgrTAUbmrNVFeHPW8K4YbUjvDrwjXdTvj6GuHJ37Xm7LLLWCBi2S63M8nK
         ZcWNhPKfwTWZ7u6/IyF1QHWx5UQyyGK+MccGbpxA=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
To:     Joe Perches <joe@perches.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, khan@linuxfoundation.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
 <20200207195346.4017-2-tusharsu@linux.microsoft.com>
 <1581253027.5585.671.camel@linux.ibm.com>
 <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
 <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
 <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <16d31f10-012c-5b3c-7069-841070f6b84f@linux.microsoft.com>
Date:   Mon, 10 Feb 2020 13:42:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-10 8:50 a.m., Joe Perches wrote:
> On Mon, 2020-02-10 at 08:40 -0800, Lakshmi Ramasubramanian wrote:
>> On 2/9/20 6:46 PM, Joe Perches wrote:
>>
>>>> In addition, as Shuah Khan suggested for the security/integrity/
>>>> directory, "there is an opportunity here to add #define pr_fmt(fmt)
>>>> KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
>>>> defines."
>>
>> Good point - we'll make that change.
>>
>> With Joe Perches patch (waiting for it to be re-posted),
>>>> are all the pr_fmt definitions needed in each file in the
>>>> integrity/ima directory?
>>>
>>> btw Tushar and Lakshmi:
>>>
>>> I am not formally submitting a patch here.
>>>
>>> I was just making suggestions and please do
>>> with it as you think appropriate.
>>
>> Joe - it's not clear to me what you are suggesting.
>> We'll move the #define for pr_fmt to integrity.h.
>>
>> What's other changes are you proposing?
> 
> https://lore.kernel.org/lkml/4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com/
> 
Thanks Joe.

Joe, Shuah:

Could one of you please clarify if the changes proposed in the above URL 
will be part of Shuah's future patchset?

Or should I include those in my patchset? I am referring to the 
following snippet in security/integrity/integrity.h.


+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
+

If I add the above in my patchset, I believe I should remove #defines 
for pr_fmt in the .c files under /security/integrity? (except the below one)
latform_certs/efi_parser.c:#define pr_fmt(fmt) "EFI: "fmt

Please let me know.

Thanks,
Tushar
