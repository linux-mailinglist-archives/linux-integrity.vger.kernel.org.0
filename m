Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C59397773
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFAQG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 12:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhFAQG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 12:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622563484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5f4rpDEZeBPUfCooEvy5nXOw1uohkmmD4sB1XQ3ya1o=;
        b=CkXOK0C1eoPa6BTpkl8ipBefi1ctCI9AmTUgqqma0tS5m83PHUsfQQ8O4x2GjTyYxrrH4q
        AMylAo8WwK2AqMj4DAxeR0XtKSgSskVsb+O9uEJJ+Ikrs8+/hda9C5oyVIjcV4dzxfUiAa
        3gmu8/t6ezE75g4hGIiaybu887R5xUc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-ONDaE3qnNhGwT1sZ4Qm6VQ-1; Tue, 01 Jun 2021 12:04:43 -0400
X-MC-Unique: ONDaE3qnNhGwT1sZ4Qm6VQ-1
Received: by mail-ej1-f72.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so2480314ejc.19
        for <linux-integrity@vger.kernel.org>; Tue, 01 Jun 2021 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5f4rpDEZeBPUfCooEvy5nXOw1uohkmmD4sB1XQ3ya1o=;
        b=JfQ7vkHEl75jNQLU9ZVpZ3J0t1cjpoJWHsTHBJ4UxpNJ8aGQaKaPPZl3BZLvd1XJne
         sbqg5GVx1exs+hm1SwVGW2U3l2I0qztSio5wFg584BEHJxB3dgKW1YDLUkfmiqiPGdGp
         2GiGlNzUO2cV49Ov50xxZZip0UctMHZnj8bxWBzGifGN9s7aPDJpdVDu+ZYGLtElzlSJ
         Kw+eNhp9c8o5r82XDwd9UXE/qIGrDjPhV0NnKUP7Rq1MXNtYcNmOqbqV091DaA+zpu0d
         D3yIUJUDM8SjSxHusz+2XsHEyBNkgmqjKVRhNNhyCFjyA79AkBLbAkNp0T6GtiQTfpIu
         y40w==
X-Gm-Message-State: AOAM533wZJx18iwT5WOKcDQ+XB81zXST8QJTZP5Bex2SUWw+OMylVGoA
        TegSb1A3JuDH6kYtY32uJqRXKCLTdkM9Q4oTx4nWxWC+Vv3uf3BQsyC2ZSKXfRL2kweG/EIl4m1
        hWTMvAc7FiO8usIU3+rTYPqC5kwW7
X-Received: by 2002:a17:906:80c8:: with SMTP id a8mr13190551ejx.195.1622563481960;
        Tue, 01 Jun 2021 09:04:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2AK3kb21bchElIkxgjAYYQ1D/AlA85ITY8eQ/qV3OnqvQCS9aTBSClB3Bcs16bike0FP2lA==
X-Received: by 2002:a17:906:80c8:: with SMTP id a8mr13190542ejx.195.1622563481815;
        Tue, 01 Jun 2021 09:04:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l19sm7927027edw.58.2021.06.01.09.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:04:41 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
Message-ID: <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
Date:   Tue, 1 Jun 2021 18:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531043616.u3v25qzkkrik5apq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>> Interestingly enough the first backtrace is also happening on a:
>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>
>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>> all reports are about the XPS 13 9310. I wonder if there is an
>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> 
> This is helpful for sure that these all are happening on matching hardware.

So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:

1. Backtrace starting with a call to ima_add_boot_aggregate
https://bugzilla.redhat.com/show_bug.cgi?id=1963712

2. Backtrace starting with a call to tpm_dev_async_work:
https://bugzilla.redhat.com/show_bug.cgi?id=1964974
(note this one is not easily reproducible)

3. Backtrace starting with a call to rng_dev_read:
https://bugzilla.redhat.com/show_bug.cgi?id=1920510

3. is the new one. All bugs linked above are public, all 3 backtraces
so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.

Regards,

Hans

