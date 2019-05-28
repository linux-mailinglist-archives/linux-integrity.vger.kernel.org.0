Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8082CF1F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfE1TCx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 15:02:53 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43403 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfE1TCx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:02:53 -0400
Received: by mail-vk1-f194.google.com with SMTP id h72so4984197vkh.10
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 12:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QaUbD1k3WeGIlCfs1lHmeou+m5jZqshP1fny+ubHw14=;
        b=iZnv9yZ3QY5tfU6t9CpSZwjN3Gt+3Y2SyL5+7N51GgupZk1nWjFGpbijh2Iw9Ymc0e
         Rk44B4haEEDwyWYorxkmUmbDvZFVkbrQhWfFDq6sOs0X9k1g1QsCzv5YNmngixznvyG2
         FpfwyJ5v0xTqqpM/JW/A44pzQysEIRdznoen20zh1oeeoE3xZFvsIzd+9OXQBIHu0lfi
         IfYDI/ZTmfMNdVQrzmZ5zwVlBybMKc1egwShhvVYswNEyIZbFdYpjAqI5JO+wnN4KFro
         PcRhIivcjWOoEnbsCg+MdDnFox8Nioz2ZdFjkDDp1QCjcQ4ksQgOPVOnswTuMzKhUrLC
         +XmQ==
X-Gm-Message-State: APjAAAXOnIems3Dcgdy4KWAcxZO2G9et9yr+QLlZF1p7OvulwxTzkpXO
        JXeVIxAGKu8htXk0iGmYoovJQaXcCIE=
X-Google-Smtp-Source: APXvYqy6x5OxBBWw9OwOA+NSda4IRbVfzCZX1cN8Kutel+ftttEGwp2wymufe7CSdHNRgvzb+bNG+w==
X-Received: by 2002:a1f:1102:: with SMTP id 2mr27364526vkr.90.1559070171574;
        Tue, 28 May 2019 12:02:51 -0700 (PDT)
Received: from ?IPv6:2601:543:8101:1d87::b0a3? ([2601:543:8101:1d87::b0a3])
        by smtp.gmail.com with ESMTPSA id 126sm6060970vkt.14.2019.05.28.12.02.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 12:02:50 -0700 (PDT)
Subject: Re: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20190401190607.GA23795@beast>
 <20190401234625.GA29016@linux.intel.com>
 <20190402164057.GA4544@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DAE2759@hasmsx108.ger.corp.intel.com>
 <20190403175207.GC13396@linux.intel.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <bfcb58ef-98b3-a663-c249-3940ec9a39d3@redhat.com>
Date:   Tue, 28 May 2019 15:02:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403175207.GC13396@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/3/19 1:52 PM, Jarkko Sakkinen wrote:
> On Tue, Apr 02, 2019 at 07:13:52PM +0000, Winkler, Tomas wrote:
>>
>>
>>> On Tue, Apr 02, 2019 at 02:46:25AM +0300, Jarkko Sakkinen wrote:
>>>> On Mon, Apr 01, 2019 at 12:06:07PM -0700, Kees Cook wrote:
>>>>> A "get random" may fail with a TPM error, but those codes were
>>>>> returned as-is to the caller, which assumed the result was the
>>>>> number of bytes that had been written to the target buffer, which
>>>>> could lead to a kernel heap memory exposure and over-read.
>>>>>
>>>>> This fixes tpm1_get_random() to mask positive TPM errors into -EIO,
>>>>> as before.
>>>>>
>>>>> [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get
>>> random
>>>>> [   18.092106] usercopy: Kernel memory exposure attempt detected from
>>> SLUB object 'kmalloc-64' (offset 0, size 379)!
>>>>>
>>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
>>>>> Reported-by: Phil Baker <baker1tex@gmail.com>
>>>>> Reported-by: Craig Robson <craig@zhatt.com>
>>>>> Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using
>>>>> tpm_buf structure")
>>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>>> Cc: Tomas Winkler <tomas.winkler@intel.com>
>>>>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>> v3: fix never-succeed, limit checks to tpm cmd return (James, Jason)
>>>>> v2: also fix tpm2 implementation (Jason Gunthorpe)
>>>>> ---
>>>>>   drivers/char/tpm/tpm1-cmd.c | 7 +++++--
>>>>> drivers/char/tpm/tpm2-cmd.c | 7 +++++--
>>>>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm1-cmd.c
>>>>> b/drivers/char/tpm/tpm1-cmd.c index 85dcf2654d11..faacbe1ffa1a
>>>>> 100644
>>>>> --- a/drivers/char/tpm/tpm1-cmd.c
>>>>> +++ b/drivers/char/tpm/tpm1-cmd.c
>>>>> @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
>>>>>    *
>>>>>    * Return:
>>>>>    * *  number of bytes read
>>>>> - * * -errno or a TPM return code otherwise
>>>>> + * * -errno (positive TPM return codes are masked to -EIO)
>>>>>    */
>>>>>   int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)  {
>>>>> @@ -531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chip, u8
>>>>> *dest, size_t max)
>>>>>
>>>>>   		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
>>>>>   				      "attempting get random");
>>>>> -		if (rc)
>>>>> +		if (rc) {
>>>>> +			if (rc > 0)
>>>>> +				rc = -EIO;
>>>>>   			goto out;
>>>>> +		}
>>>>>
>>>>>   		out = (struct tpm1_get_random_out
>>> *)&buf.data[TPM_HEADER_SIZE];
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm2-cmd.c
>>>>> b/drivers/char/tpm/tpm2-cmd.c index e74c5b7b64bf..8ffa6af61580
>>>>> 100644
>>>>> --- a/drivers/char/tpm/tpm2-cmd.c
>>>>> +++ b/drivers/char/tpm/tpm2-cmd.c
>>>>> @@ -301,7 +301,7 @@ struct tpm2_get_random_out {
>>>>>    *
>>>>>    * Return:
>>>>>    *   size of the buffer on success,
>>>>> - *   -errno otherwise
>>>>> + *   -errno otherwise ((positive TPM return codes are masked to -EIO)
>>>>>    */
>>>>>   int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)  {
>>>>> @@ -328,8 +328,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8
>>> *dest, size_t max)
>>>>>   				       offsetof(struct tpm2_get_random_out,
>>>>>   						buffer),
>>>>>   				       "attempting get random");
>>>>> -		if (err)
>>>>> +		if (err) {
>>>>> +			if (err > 0)
>>>>> +				err = -EIO;
>>>>>   			goto out;
>>>>> +		}
>>>>>
>>>>>   		out = (struct tpm2_get_random_out *)
>>>>>   			&buf.data[TPM_HEADER_SIZE];
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>>
>>>>> --
>>>>> Kees Cook
>>>>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>
>>> Applied to my master branch. Jason, Tomas, do you want me to add reviewed-
>>> by's?
>> Sure, it fixes my patch.
> 
> Great, I'll add it. Thank you. Just want to be explicit with these
> things as I consider them as if I was asking a signature from someone
> :-)
> 
> /Jarkko
> 
Was this intended to go in for 5.2? I still don't see it in the tree.

Thanks,
Laura
