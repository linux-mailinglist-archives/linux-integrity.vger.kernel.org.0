Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3D254953
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Aug 2020 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH0PZG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0PZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 11:25:05 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94299C061264
        for <linux-integrity@vger.kernel.org>; Thu, 27 Aug 2020 08:25:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so4792225qtr.8
        for <linux-integrity@vger.kernel.org>; Thu, 27 Aug 2020 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Km+0VritnjkBe1TttSbRAg7QrI7KHuBAc0afzDcqO98=;
        b=UXPOeRMIQ0GaYur+EdRgWE9I8VjWUv0/1BuBrQ1UvTvhNcFwmbfRWtn68CrjL32LLf
         XyV1d79Hzo2SeL/mfyNvhOlbj3eO/Qb8gSOas8h4pBKz8pWfinufWvvuppIABqPS2C3L
         mT6tFZN3zyquUT2G77rlsWP7SwgtsQsTZjYrkUgntkLHMBq30gl6iHkR9q0W5IffTRFc
         D0UIVuJVRsC5HO7Int2mKsm3qDlly0E8ghsnBSdsvsSmenV+bQz3IRybLs8vwSuSMbfi
         aniz6kxKSBW4PiqPLkT2LzTTEuM1Hm8dF9pgdUENiykahDSlUKalyHkkwlJP0Y6rvnvG
         8R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Km+0VritnjkBe1TttSbRAg7QrI7KHuBAc0afzDcqO98=;
        b=rauPW0ZBiM8qdSY1Y3/7zelK2ZYAA7QAgsEHzgcN8iBM/JMyun0kQRRk64iK7cTZwU
         2xeGyU98tzS8fqEE941OLdn/5DjovnOk9U5N4jwvGYsNSbOPPmJi+cbXMTtTKA8M5jKi
         475tbf82w94kR9HximnBMyqzeF5L0CsxE4AGR9HSkqCoS4t39ixuvGoa8azomBbv8tL5
         QOonhDpY8OIO+dYsY3q93Lhx1fLLPmP47NtJCU/mC427hjBw3Gj/pfJIKoOCdzIeegl6
         0i2+HdXwQBkuT4ZWn4UahFblyfneTloQeik2l07XpeasChFxPsEDGY/5O6wnklQBXS2I
         l7xQ==
X-Gm-Message-State: AOAM533mS+Ukqv0ENQqH40xKqmmgyuiKXrK0ev+QMBDI4nvN4RAqBNRO
        +beuo9KdH11HIl8CHKouxSXeRBb6q5k=
X-Google-Smtp-Source: ABdhPJwtEqr6UyEwBlpiwqYZ68o4FhEiITT1txOwnb/Jl/CnSFhWk2OuO3rb7pHvGjr67zuOVBZfwA==
X-Received: by 2002:ac8:441a:: with SMTP id j26mr1936486qtn.286.1598541904729;
        Thu, 27 Aug 2020 08:25:04 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id j190sm2022776qkd.22.2020.08.27.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:25:04 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in STMicroelectronics TPM
Date:   Thu, 27 Aug 2020 11:24:45 -0400
Message-Id: <20200827152445.15439-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1586994699.3931.18.camel@HansenPartnership.com>
References: <1586994699.3931.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley wrote:
>On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>> 
>> We've encountered a particular model of STMicroelectronics TPM that
>> transiently returns a bad value in the status register. This causes
>> the kernel to believe that the TPM is ready to receive a command when
>> it actually isn't, which in turn causes the send to time out in
>> get_burstcount(). In testing, reading the status register one extra
>> time convinces the TPM to return a valid value.
>
>Interesting, I've got a very early upgradeable nuvoton that seems to be
>behaving like this.
>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/drivers/char/tpm/tpm_tis_core.c
>> b/drivers/char/tpm/tpm_tis_core.c
>> index 27c6ca031e23..277a21027fc7 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>>  	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
>>  	if (rc < 0)
>>  		return 0;
>> +	/*
>> +	 * Some STMicroelectronics TPMs have a bug where the status
>> register is
>> +	 * sometimes bogus (all 1s) if read immediately after the
>> access
>> +	 * register is written to. Bits 0, 1, and 5 are always
>> supposed to read
>> +	 * as 0, so this is clearly invalid. Reading the register a
>> second time
>> +	 * returns a valid value.
>> +	 */
>> +	if (unlikely(status == 0xff)) {
>> +		rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
>> &status);
>> +		if (rc < 0)
>> +			return 0;
>> +	}
>
>You theorize that your case is fixed by the second read, but what if it
>isn't and the second read also returns 0xff?  Shouldn't we have a line
>here saying
>
>if (unlikely(status == 0xff))
>	status = 0;
>
>So if we get a second 0xff we just pretend the thing isn't ready?

Thanks for the fix, Omar!

I tried the patch and it helps with STM TPM2 issues where commands fail
with the kernel reporting:
tpm tpm0: Unable to read burstcount
tpm tpm0: tpm_try_transmit: send(): error -16

My testing was with 5.4, and I'd like to see this CC-ed stable.

When trying to diagnose the issue before finding this patch, I found it
was timing sensitive.  I was seeing failures in the OpenXT installer.
The system is basically idle when issuing TPM commands which frequently
failed.  The same hardware booted into a Fedora Live USB image didn't
have any TPM command failures.  One notable difference between the two
is Fedora is CONFIG_PREEMPT=y and OpenXT is CONFIG_PREEMPT_NONE=y.
Switching OpenXT to PREEMPT=y helped some, but there were still some
issues with commands failing.  The second interesting thing was running tpm
commands in OpenXT under trace-cmd let them succeed.  I guess that was enough
to throw the timing off.

Anyway, I'd like to see this patch applied, please.

Thanks,
Jason
