Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E96203A1C
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2020 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgFVO5J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 10:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgFVO5J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 10:57:09 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B1C061573
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2020 07:57:09 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x126so1243533vkb.1
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2020 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaQaRL/n2na4izh2TsmRyDKAg7niGqHtN8UJRlkcUNk=;
        b=Yh6uQc0Tk44UUcYHHPdxzcHe4JMuPLNwLsMpf1hfB3Jh8Tu5KzLiUZOVxNrSzFNeRC
         1VX+uZFI62Ls1+BJbg7pP2QF3IogycASPqdpS7cK4qx+8UL3mK0h3koU2KF86qJLyXNp
         ISsh8AdquX9pm+IhFbc8LzxKYCLQ8dhUJwD7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaQaRL/n2na4izh2TsmRyDKAg7niGqHtN8UJRlkcUNk=;
        b=nPVNpX3zrZK5EFge8CuBfpH1TSwa1EcAMNnJqqqd1JXCkK5rf/r0ckGXyuFn6AVV3g
         gNKdeqysGXpl9WdDPhl7UoalnyTbuqXq7HcLXpzo/MjVwwZzO63yCNpPorXPSA4nIpQ1
         IHm8fBFymSKQtkjerIHENv7GRfIbJX0nQxmgnmoVs79AxfJ268TxWN+rzEO74qQTe2RE
         buhWHAnf8+4GVq+6JJ5IOvY2kCKjbpJKBzVj6uV5czNFK7zO+wA8H5TT650lYWVYieIs
         3K655xukx6X2ea4SVuvmi6femhSFk18byAUmvyfMUu7FgIi2w3uW+r11URc61qV6erIR
         Fcmg==
X-Gm-Message-State: AOAM5304jgzQr47GKwIEG7+lYGYNA7Rh6jOjlyvA6Rl8OPxh5Mk/Roya
        N8hlVt8kfShgdTVn23Rpnk642ndRCW8=
X-Google-Smtp-Source: ABdhPJybgLrYtvT2rfDv2AESTTprsLEN0B0LkvjxAHM5G5vcbs0aM0BYZsp4qrB1Go2zAt1OQu5BEg==
X-Received: by 2002:a1f:2c0d:: with SMTP id s13mr16121590vks.9.1592837827444;
        Mon, 22 Jun 2020 07:57:07 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id u4sm1681341uaq.16.2020.06.22.07.57.06
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:57:06 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id n188so4004404vkc.11
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2020 07:57:06 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr16311424vke.75.1592837825897;
 Mon, 22 Jun 2020 07:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
In-Reply-To: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jun 2020 07:56:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VCX27cMs4q+jJ528UdEM93yZ96+kYTQPgU3ZqZ-whgEw@mail.gmail.com>
Message-ID: <CAD=FV=VCX27cMs4q+jJ528UdEM93yZ96+kYTQPgU3ZqZ-whgEw@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Prefer async probe
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Fri, Jun 19, 2020 at 2:20 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On a Chromebook I'm working on I noticed a big (~1 second) delay
> during bootup where nothing was happening.  Right around this big
> delay there were messages about the TPM:
>
> [    2.311352] tpm_tis_spi spi0.0: TPM ready IRQ confirmed on attempt 2
> [    3.332790] tpm_tis_spi spi0.0: Cr50 firmware version: ...
>
> I put a few printouts in and saw that tpm_tis_spi_init() (specifically
> tpm_chip_register() in that function) was taking the lion's share of
> this time, though ~115 ms of the time was in cr50_print_fw_version().
>
> Let's make a one-line change to prefer async probe for tpm_tis_spi.
> There's no reason we need to block other drivers from probing while we
> load.
>
> NOTES:
> * It's possible that other hardware runs through the init sequence
>   faster than Cr50 and this isn't such a big problem for them.
>   However, even if they are faster they are still doing _some_
>   transfers over a SPI bus so this should benefit everyone even if to
>   a lesser extent.
> * It's possible that there are extra delays in the code that could be
>   optimized out.  I didn't dig since once I enabled async probe they
>   no longer impacted me.

I will note that I did continue to dig into the delays, actually.  I
haven't fully resolved all of them, but I'm fairly sure that most of
them are actually inefficiencies in the SPI driver on my platform,
which seems to have a lot of overhead in starting a new transfer.
I'll work on fixing that, but in any case we should still do the async
probe because it's very safe and gives a perf boost.  Why do I say
it's safe?

1. It's not like our probe order was defined by anything anyway.  When
we probe is at the whim of when the SPI controller probes and that can
be any time.

2. If someone needs to access the TPM from another driver then they
have to handle the fact that it might not have probed yet anyway
because perhaps the SPI controller hasn't probed yet.

3. There may be other drivers probing at the same time as us anyway
because _they_ used async probe.

While I won't say that it's impossible to tickle a bug by turning on
async probe, I would assert that in almost all cases the bug was
already there and needed to be fixed anyway.  ;-)


-Doug
