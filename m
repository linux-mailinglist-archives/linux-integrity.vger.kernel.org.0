Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2373C23133F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgG1T4a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgG1T4a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 15:56:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5BC0619D2
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2020 12:56:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so12694722pgk.4
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2020 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W7TAjFONgptqFsxFyzgmBB4VQ+xkKw4I12zGbCqhTiA=;
        b=Lean4Ub7+oqAH2w7CSK/zhYBvH/03JGVymr9ikJ9a2S9xPJHpglUzMrPNOZXJzUyGt
         AmUxkgKY1ag1xSJXgYTwH7XqjkRpVkfJ+feEI5EO2fkecOtj5CJ/n4M0s41a70h7J7Ul
         DcaS/1VEwwD5xzcEmbQx9cHJbeYOMoK5Sgq2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W7TAjFONgptqFsxFyzgmBB4VQ+xkKw4I12zGbCqhTiA=;
        b=phv5WUEoQDKSWgmZMnTgO+QVa53dtorcSZ2BroiY7gwDoJjuEu6JzrHSdFzcs82U74
         IdVdnIIIPAcPZ4QKg/6UEb9mmn/yTojE+5ar56M/xMVBCSZAzcIWBDBo3N1x5dhGLRFS
         Mw/361ooiAi1GG5cT+/lqUH87BHkX9nL8U4oXzeBNpZFg+RWHarwxPIzg4bF9ZBEZ2HX
         j/OSgjRQ9L3BvC9yS7OigFvNItsYtV5HWvVth4vZi07M1AxEHs8MhF1tZPZEEyzBubV5
         deb8QlhXjIxRONlPjyQcGmru4GYXGd2lGL9n1KoqFvBvGi5BVpj1jtVbdYiQe9f/w3EO
         b93Q==
X-Gm-Message-State: AOAM5310HdHJQAQoighe+5dLR6mWTxnMtBfbdtmgjR+dDZJrN+YKLH4p
        tQBAa+g+BuX2vToH9qoksgEe8Q==
X-Google-Smtp-Source: ABdhPJwDLC5Hcr91RvIycgAzmWKCoQjrO6zgvfd7kCTWGqeT9Jyjha673LcU5A/lZ6KCgphV9Abgfg==
X-Received: by 2002:a65:594b:: with SMTP id g11mr27180683pgu.168.1595966189303;
        Tue, 28 Jul 2020 12:56:29 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p187sm18500429pfb.22.2020.07.28.12.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:56:28 -0700 (PDT)
Subject: Re: [PATCH v3 00/19] Introduce partial kernel_read_file() support
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200724213640.389191-1-keescook@chromium.org>
 <1595848589.4841.78.camel@kernel.org>
 <1a46db6f-1c8a-3509-6371-7c77999833f2@broadcom.com>
 <fa96a33641070b1580f21de86fedd5f8da5eff21.camel@linux.ibm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <011f1a63-3935-7ad7-c56f-e1bdf831da73@broadcom.com>
Date:   Tue, 28 Jul 2020 12:56:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fa96a33641070b1580f21de86fedd5f8da5eff21.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 2020-07-28 11:48 a.m., Mimi Zohar wrote:
> On Mon, 2020-07-27 at 12:18 -0700, Scott Branden wrote:
>> Hi Mimi/Kees,
>>
>> On 2020-07-27 4:16 a.m., Mimi Zohar wrote:
>>> On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
>>>> v3:
>>>> - add reviews/acks
>>>> - add "IMA: Add support for file reads without contents" patch
>>>> - trim CC list, in case that's why vger ignored v2
>>>> v2: [missing from lkml archives! (CC list too long?) repeating changes
>> here]
>>>> - fix issues in firmware test suite
>>>> - add firmware partial read patches
>>>> - various bug fixes/cleanups
>>>> v1: 
>> https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/
>>>> Hi,
>>>>
>>>> Here's my tree for adding partial read support in kernel_read_file(),
>>>> which fixes a number of issues along the way. It's got Scott's firmware
>>>> and IMA patches ported and everything tests cleanly for me (even with
>>>> CONFIG_IMA_APPRAISE=y).
>>> Thanks, Kees.  Other than my comments on the new
>>> security_kernel_post_load_data() hook, the patch set is really nice.
>>>
>>> In addition to compiling with CONFIG_IMA_APPRAISE enabled, have you
>>> booted the kernel with the ima_policy=tcb?  The tcb policy will add
>>> measurements to the IMA measurement list and extend the TPM with the
>>> file or buffer data digest.  Are you seeing the firmware measurements,
>>> in particular the partial read measurement?
>> I booted the kernel with ima_policy=tcb.
>>
>> Unfortunately after enabling the following, fw_run_tests.sh does not run.
>>
>> mkdir /sys/kernel/security
>> mount -t securityfs securityfs /sys/kernel/security
>> echo "measure func=FIRMWARE_CHECK" > /sys/kernel/security/ima/policy
>> echo "appraise func=FIRMWARE_CHECK appraise_type=imasig" >
>> /sys/kernel/security/ima/policy
>> ./fw_run_tests.sh
>>
>> [ 1296.258052] test_firmware: loading 'test-firmware.bin'
>> [ 1296.263903] misc test_firmware: loading /lib/firmware/test-firmware.bin
>> failed with error -13
>> [ 1296.263905] audit: type=1800 audit(1595905754.266:9): pid=5696 uid=0
>> auid=4294967295 ses=4294967295 subj=kernel op=appraise_data cause=IMA-
>> signature-required comm="fw_namespace" name="/lib/firmware/test-firmware.bin"
>> dev="tmpfs" ino=4592 res=0
>> [ 1296.297085] misc test_firmware: Direct firmware load for test-firmware.bin
>> failed with error -13
>> [ 1296.305947] test_firmware: load of 'test-firmware.bin' failed: -13
> The "appraise" rule verifies the IMA signature.  Unless you signed the firmware
> (evmctl) and load the public key on the IMA keyring, that's to be expected.  I
> assume you are seeing firmware measurements in the IMA measuremenet log.
Yes, I see the firmware measurements in the IMA measurement log.
I have not signed the firmware nor loaded a public key on the IMA keyring.
Therefore everything is working as expected.
>
> Mimi
>
Thanks,
 Scott
