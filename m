Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D71E5526
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 06:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgE1Ek2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgE1Ek2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 00:40:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED5C05BD1E;
        Wed, 27 May 2020 21:40:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so11011973plr.4;
        Wed, 27 May 2020 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SEFEjOeVaCb6nRVJJoHwrwcnuKr7Yd2WmIU8A9Wz24w=;
        b=gUMu+KpzmcRaYBU3gFRGvFKQqtwZpCg/gRJKUF0aRETBDeFJ7Ei88kCtWIUF1VzI/N
         DUXzKkdoRhcH1MC3CsrigOaqUpojb/ol9B1tL5RY4VXO6UPyGb6xwamjluCvDtbRzyhp
         gpHUXBDBZtMYK1qlCvFSDoSEmlTlboRJxvRFN8JmfV8orlCJwGKMeXKZ3s31Mb20qHXH
         JFIs+4cLo7FXGjYkoM4Nvrj0d7+HVq/PUNdJFLifxie0t7YJlVq3eYbPMffgPS8zcj9P
         9x+X0ERXkoa87dOfsTKOS1RR4sfGzzgHKxoZbUV/UC4Cu4qBlpgcNX1ehhKVJcol8Rsr
         B+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SEFEjOeVaCb6nRVJJoHwrwcnuKr7Yd2WmIU8A9Wz24w=;
        b=HRdy11BAVkmmSDhxWgFwbzv/HZj94nedyIFq3nhM+thQxC9g0ChWQRbFM3r5NeTenh
         WNymQRm13VUg0ENnZ08rQ0wiogTU/hk0Pl6+BOJFx7t+MK7bTc3HZ5X1MTaZKd0k+oxz
         gaBfZtPxJE9em1fWzIvid0pdXtTJdcgEJ9/DTV/vocp6TYzol+XbbENzj2BDPlEgGH5O
         bFV3X2R5BrB+9g5x6YLHwiyK9sDyk312cVUhsMYwT0uzdaul0AAoXb3vguUhYZdpCokH
         DWJ6y0wq02rFAvCS120dPpKLOngCPT2jHhje+pfDGtUFmVLOJj0kedQ3A5x1oClqcGmR
         2Reg==
X-Gm-Message-State: AOAM53098QPHuCQ/Dz82hOFRJhqFSlQyjsq6K5jBfDMOdFG2Gpt943JP
        cQYIbsugFVYjTJszOl74Kqw=
X-Google-Smtp-Source: ABdhPJyjB8szJpiEjE7QVqILRUwFv3h+Joj2z5+3aAbN8VXbd1T5YQksO13/m9WhGbwQmgW/OChQQg==
X-Received: by 2002:a17:902:9b88:: with SMTP id y8mr1754669plp.171.1590640826833;
        Wed, 27 May 2020 21:40:26 -0700 (PDT)
Received: from [192.168.1.5] ([75.164.7.205])
        by smtp.gmail.com with ESMTPSA id i29sm3450648pfk.38.2020.05.27.21.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 21:40:26 -0700 (PDT)
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
 <20200528003040.GA4781@linux.intel.com>
From:   Tadeusz Struk <tstruk@gmail.com>
Message-ID: <e939739d-d193-95e8-c142-4efa57be2502@gmail.com>
Date:   Wed, 27 May 2020 21:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528003040.GA4781@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/27/20 5:30 PM, Jarkko Sakkinen wrote:
>> This won't help if the message is read by an async tcti. If the problem lies
>> in the chip get locality code, perhaps this could help to debug the root-cause
>> instead of masking it out in the upper layer code:
> What is TCTI and async TCTI? Not following.

TPM Command Transmission Interface (TCTI) as defined by TCG in
https://trustedcomputinggroup.org/resource/tss-tcti-specification/

the reason we added the O_NONBLOCK mode was to satisfy the TCG spec for async TCTI.

Thanks,
Tadeusz
