Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9716A7110
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfICQxt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbfICQxt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:53:49 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15C0F4E925
        for <linux-integrity@vger.kernel.org>; Tue,  3 Sep 2019 16:53:49 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id 91so19616946qtf.13
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TIiAFZIjHlLz7PBS/03pE3hbJ7hhmKmUaMbhV6zq5dw=;
        b=lXsWOuJ5WKk8UKGS3PlNCD0SIBodDi26aG3z3iDvecNlhRTwXzW7t9AdboBRjdlyv4
         oiG04OoZvHBYtT3CnVOcfpCWnu26MzNbY7Fw3rvqkZvCU8Yx06zY/G5VlfZQdyutmA+7
         ctIeMwiSC/iuBS+AkXFMYQMte04CWig2keRlY64+wXePCMQPYBm7xOdk1bYIytcORFK3
         ZmC9Kf8YP8CxTY9i0oj9FQ5kN9oUurXsXPJ5FA2jIQBwYWE3qVuNyL4eAAk/MqKBkYHR
         gTD19CipDbeBypYEnuhSnFMk2Jnl9++wpF9ZHaNsGN0j/t2nWYgmvWlsB8I+6MscgvLk
         mp6w==
X-Gm-Message-State: APjAAAWsVvL6zGlthHbQzJ68rimmpnwBlJAH0Vg8r6sJ85EoFGVnQJja
        hkU25H3Zlky+MJCDXoAq0GUjc1Npxmbi+LjkW1CUc4TssmeWoM/rf2khrCAAjVZy2qayuukDD86
        4/hzYwVA7YP3hw4YTZEBoPQLdbS3j
X-Received: by 2002:a37:9f46:: with SMTP id i67mr12460265qke.108.1567529628438;
        Tue, 03 Sep 2019 09:53:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2RtxOu0+e/HYiXoLPNfFZTtLwLtQQ5mVN9iBaXKzoZQiTiwfOglHbKL3LXBPDM4/BcEk4ZA==
X-Received: by 2002:a37:9f46:: with SMTP id i67mr12460240qke.108.1567529628217;
        Tue, 03 Sep 2019 09:53:48 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p77sm6894259qke.6.2019.09.03.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:53:47 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:53:46 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH AUTOSEL 4.19 126/167] tpm: Fix TPM 1.2 Shutdown sequence
 to prevent future TPM operations
Message-ID: <20190903165346.hwqlrin77cmzjiti@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-126-sashal@kernel.org>
 <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Sep 03 19, Doug Anderson wrote:
>Hi,
>
>On Tue, Sep 3, 2019 at 9:28 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Vadim Sukhomlinov <sukhomlinov@google.com>
>>
>> [ Upstream commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 ]
>>
>> TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
>> future TPM operations. TPM 1.2 behavior was different, future TPM
>> operations weren't disabled, causing rare issues. This patch ensures
>> that future TPM operations are disabled.
>>
>> Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
>> [dianders: resolved merge conflicts with mainline]
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/char/tpm/tpm-chip.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
>Jarkko: did you deal with the issues that came up in response to my
>post?  Are you happy with this going into 4.19 stable at this point?
>I notice this has your Signed-off-by so maybe?
>

I think that is just the signed-off-by chain coming from the upstream patch.
Jarkko mentioned getting to the backports after Linux Plumbers, which is next week.

>-Doug
