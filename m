Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3A3A82A4
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFOOYe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhFOOWy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 10:22:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12292C061767;
        Tue, 15 Jun 2021 07:16:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o21so746253pll.6;
        Tue, 15 Jun 2021 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y0N7iXHC9NRZHHT1sVsEGqpkSzM7RgjJPUfTTbkEtZg=;
        b=U+IUdmgUEQLyg9NYxoe1XHbdwrMCJytqYvgfrqYeCNRAUZ4CRRki7/XSQWfz50QprR
         OgdN19KPf9OQqmyNmRfW6JSaW6VzF+DWsmsWotYE2jWnHlWCnDEt6wsT2ILMSszDTdz8
         PwFCB6fHM/QzYTb5S7IVyktaI7xUr8+Yu6IKpaXDjNnR2H3/YVZc9a1QQjGlgaJOxjJZ
         6VCuaen8H4JL9qbX4Hl3L+MDKlGTTu9hsBWQbeTWlPMwqeTMvyHfDToVoF14dUBTpKsc
         h9l4hCG20Yk/SCVjvGYddsmG/t/q+ubXT50S2mTeZcV5KgCBgOvcpWcBDPB2MACkyBV8
         F37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y0N7iXHC9NRZHHT1sVsEGqpkSzM7RgjJPUfTTbkEtZg=;
        b=INjdepTAOViHpMud88LXUIE3Ufcwc1O2eyLsxzt0b9mzj72puLzSG8cONUnga/7Mw0
         N+Jx74zAfv3QLfylmQbYNYLsevA0CO/O3o8UlHynt/cJHz19Yo8hrS44Bp44DA6cdiry
         GYQTcjsC3HhMTmAwIjYx68gNQTNJ1cA4HW6af93cSfaTvgrQnL5LfHS/DIAc0c9ZLBrJ
         69Uq8UOc0cVIGzNezb1blIcwysBr3hjNd94b8fJZYBEcrE3mG+70LSvsCADF2iJgVbk9
         8JyQUR9Iddl1ziSeYttVy5yBvLI3JXhhWonrhQMDD0PXt1ER5QQ1hr1OJshCODAVnk4x
         +5+Q==
X-Gm-Message-State: AOAM531XYDtvgGRkxz4juxNUj+Vv6HhQYCw46k/quanrV236oXTmBBkg
        B3n614wvkbixFozduRx/F7bls5zTw3c=
X-Google-Smtp-Source: ABdhPJxRRY90sW6KWr0RQgfZt3FHCbFXC+zq1UXzijlTdTWZTK70JUMqYj58/5/Rfy0+R6Ir4zJZiw==
X-Received: by 2002:a17:902:9f93:b029:104:9bae:f56a with SMTP id g19-20020a1709029f93b02901049baef56amr4130671plq.75.1623766562127;
        Tue, 15 Jun 2021 07:16:02 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id c7sm16356683pgh.72.2021.06.15.07.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:16:01 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
 <CAHUa44ErgoxT3L1W-ouoQwUg1fNC-zagOOgy=KBuGN_pETnYaw@mail.gmail.com>
 <20210615133734.GY4910@sequoia>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <944c1df8-3e9f-0026-c83c-d778f42fa1b3@gmail.com>
Date:   Tue, 15 Jun 2021 07:15:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615133734.GY4910@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/15/2021 6:37 AM, Tyler Hicks wrote:
> On 2021-06-15 09:23:25, Jens Wiklander wrote:
>> It looks like we're almost done now. Thanks for your patience to see
>> this through.
>>
>> I suppose it makes most sense to take this via my tree, but before I
>> can do that I'll need acks from the maintainers of
>> drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
>> TEE shared memory during kexec") and
>> drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
>> TEE shm, session, and context during kexec").
> 
> @Rafał Miłecki, we just need an ack from you for the tee_bnxt_fw.c
> change:
> 
>  https://lore.kernel.org/lkml/20210614223317.999867-9-tyhicks@linux.microsoft.com/

Rafal is listed as the maintainer of drivers/firmware/broadcom/ but he
did not author that file, Vikas did, adding him.
-- 
Florian
