Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0B31A863
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 00:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBLXq6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 18:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLXq6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 18:46:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A25F64D9A;
        Fri, 12 Feb 2021 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613173577;
        bh=A+JkqwrwmUynFKQPXSuQrAHNjKCgXWo26xLnZdfjpW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEkKEgQ+mt54ZAE87wJdaroWrXKLx0jd4QhaUHaUFE/HeJNb21uSAq7laCUbq9f37
         Al0BlwPDZECpzRFgumKMZWDxU7w4i+4a3pz11pHgiVaAVx1Elfh6n8BH02/bfm4R1R
         evI9gYSA8Qv1eh5Znh4l0aQ7JPR4HhUKSzc4J9vU8pXFb5TizxjfE5KgAsk8ZsD1XK
         8I29hbb8ueuduKQSfRWtag1t7/1ekJh79GL0B/Tw0HF5S5h+2ItAidn38PJQkEgaYI
         fWKwlX16wGrSMND4OvH7xM1WTG2wrXgCJIXofXKw1DOnxWW8h0y3qKJRUHYNXhg3e0
         TH05UIVGmeRKg==
Date:   Sat, 13 Feb 2021 01:46:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "florian.manoel@siemens.com" <florian.manoel@siemens.com>,
        apronin@chromium.org
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>,
        "joshz@google.com" <joshz@google.com>
Subject: Re: TPM V2: kernel panic on linux reboot
Message-ID: <YCcTQFkAy+JMp7a5@kernel.org>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <YASDd5pphvndrsm+@kernel.org>
 <AM0PR10MB25481FFED2CDFBEC5596098F84BB0@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
 <YBSZWPNUV2y09Yg0@kernel.org>
 <AM0PR10MB254856FDA3E44D4373C17451848B9@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB254856FDA3E44D4373C17451848B9@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 12, 2021 at 07:20:02AM +0000, florian.manoel@siemens.com wrote:
> Hi,
> 
> => Last update and happy end
> 
> To remember what the issue was : kernel panic on reboot on a custom board equipped with CPU NXP LS1043a and TMP V2.0 Infineon slb9670 (spi interface).
> What we did but didn't fix the issue : update our kernel to 5.10.8 => panic still occurs
> What we did and fix the issue => use this patch : https://lkml.org/lkml/2020/7/9/1242

Andrey,

I re-read the thread, and it's been a while and I'm not sure if
I fully get my old review comments.

Your commit message refers to these commits:

A. b4c6230bb0ba spi: Fix controller unregister order
B. f40913d2dca1 spi: pxa2xx: Fix controller unregister order

So I presume that either A or B causes this sequence to trigger:

1. tpm_class_shutdown()
2. tpm_del_char_device()

... and either A or B causes this sequence to trigger:

1. tpm_class_shutdown()
2. tpm_del_char_device()

So:

- Does that fix bundle two separate bug fixes, and if yes, which
  on is associated with which?
- Why do they cause the sequences to trigger, and why these sequences
  did not trigger before?

/Jarkko
