Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4B3CF225
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbhGTCBf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 22:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344729AbhGTBvl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 21:51:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5643C061574;
        Mon, 19 Jul 2021 19:32:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j4so4502248pgk.5;
        Mon, 19 Jul 2021 19:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqBs+GBsePvxuJ7T8oHVXE+0kUbw069/LeZuzlfCcZ4=;
        b=Y8rwWbhutI/72cKs7u3tfozo23N3gKPMg7M7gXJxUUL05fnTor/0vMW8ITphOZ07di
         t1ufc7bEALcX29N5gjnfrr5+6IkuHSU+BwG0NLp0dxVHA4tRhfnRuEURjo3Y8FnPLvMo
         ECw05xbWVF3VgTroOacoQa5xRo1j7P/m9cGc3VAQycZjy4WQnh1WkZyrQgBAsUvjFqOZ
         WcHjzeD5eKDIandf518ZhU263ot2QuZvn+2ztZl7zYOBeZQiU52unpSewO9Mqy6V8a9r
         6W7x8uxCXgN+mHusr3BagM4mujAsfh+OhDS64ZZK1RhRrKkSMYYrvzF49Sbk2aHMkKLt
         jC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqBs+GBsePvxuJ7T8oHVXE+0kUbw069/LeZuzlfCcZ4=;
        b=ROKJcOui9FhSwu9GZg28gKjwQ2233vWEZA/xAVT0TWQorFVyJVrMYZIsRxp9O0x9ag
         crnZJi+mfv4hadQ3EnxkOyCDXa5O1iqMPbbNvwoUf2ZfK6KSmUiPb/7QUN0OEnbsLptC
         6m3VTzMKxctG1LXSL9Qc1MF/pNABCpyk59dlz7eIL38Q1FNGKiFFUa/BE9BuhIO4qUyZ
         WQxw4Zk2/Bj0qi4waWBaW5lpWt6MLgaV7CEnzns/IIf8XU76V+vTG/5yGeOXTcuAEn4g
         XAFrMZfGRdEj2F7jJBeEyxs2bIvPCgDmIinO9/UCOnTmLF1uQzA266UgPBpEa+xE7vIs
         gaew==
X-Gm-Message-State: AOAM532xeQ4PAn648yYxh98ROLYBz5RlIqnqo1BLupdx+jTmPL7z7TJ6
        8MRuheyYI2SnFGMxR33njgav+rL3vLJm+g==
X-Google-Smtp-Source: ABdhPJw8ChIR3kg8fmYEnI2nUmPF2K/iGGfyPWq7h36woPrYS3chjEBD9WWev0KDp2gqdtGrUu1oDg==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr28529616pff.13.1626748339693;
        Mon, 19 Jul 2021 19:32:19 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t26sm23317435pgu.35.2021.07.19.19.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 19:32:18 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210716022332.GC3232@sequoia>
 <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
 <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
Date:   Mon, 19 Jul 2021 19:32:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/19/2021 3:49 AM, Jens Wiklander wrote:
> Hi,
> 
> On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta <vikas.gupta@broadcom.com> wrote:
>>
>> Hi Allen/Tyler,
>>   The patch looks good to me.
> 
> Thanks.
> 
> Rafal, is it OK if I include this patch together with the rest of the
> patches in this patch set in a pull request to arm-soc?

I can take those patches through the Broadcom ARM SoC pull request, 
Rafal would that work for you? We seem to have a bit of a maintainer 
coverage blind spot for that directory.
-- 
Florian
