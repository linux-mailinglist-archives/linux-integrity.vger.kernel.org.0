Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030326BB9A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGQLkA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 07:40:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45216 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQLj7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 07:39:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so17164071qkj.12
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSvzcNAlvNMAYCm/YJl3mpBEw5Mw791e9dlXQtrTDLs=;
        b=atYDAKiAWWuYPVJoI5MZmHauaKDshOGDSMajBPtJT5raO1sr++gQwv/yMBgH/a1XMq
         8qv/NVGSajrBnh4BunGj5GdfUnrynp9ykfJsDkPb3QqhD+/fJ6WCpldH3YBVNPAMSLSJ
         YwPLNm8FfAcnmZZeqdM8QuTYs6aTBmsUZm1flRacu7OrRxDm3A6kAKvi1qrVtHW/J/Ou
         8GkS+z4pg9oxDqXuT1vt6nTfOKWHxgW84GKOqWjaVKffXyYPuxOdryhl/8rWIS9nrZ2j
         UZbP9GCaGivtsMxSe3bwoKw0yBcS1Nk+yDaYWOxpj9UTTrotPcXZW9Ab53KwgQ8yvmwO
         h4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSvzcNAlvNMAYCm/YJl3mpBEw5Mw791e9dlXQtrTDLs=;
        b=LuTgNGLlnWaG9EbJaxrLNGY9ZkB9JTzzz5V3/gz4c//YeDLs8h0CXmf2xT2VIJjJ4L
         Fj8yP66sNOVlxoxtUmxH5VSu79I78D7vZBIFlvtCS3pgSdReUYeUxBWstS+Q4v45dXIw
         3HStcEeVZYg3UaYLTnfLY/PEvgaSJR6xX6EXaKF6ecnPlnbXKm4rZ10e5RS9kjgWgsm3
         o13+4l+opwwZG/CJKHHGKCIL4XmKXIudPERzncgeSN2GFWiRdtbeyr7rUTCVAno9Grhs
         F12NVu+6ETW8O27ZmoCGqn2Jq0AddiJlLjqFNG5L+KeMleMmmoH0Um7gJWmllScDaO8o
         oH/w==
X-Gm-Message-State: APjAAAVL6rNGSOTvsv9oqQuFtlXUurshK1WxiUhDjJrarxwGoRYWRvJv
        qN5fVH37VuQtPd1bVlzuNOP5Fg==
X-Google-Smtp-Source: APXvYqxh4a7oktNEIEB4+ryoRkMaMG/7Gx7/ezkuM4kYq4aZo0Mz0ejz93AR7q7yC16RM9Zje7iHng==
X-Received: by 2002:a05:620a:1329:: with SMTP id p9mr26444980qkj.224.1563363597972;
        Wed, 17 Jul 2019 04:39:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y14sm10703331qkb.109.2019.07.17.04.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:39:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hniHt-0003KS-0D; Wed, 17 Jul 2019 08:39:57 -0300
Date:   Wed, 17 Jul 2019 08:39:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Message-ID: <20190717113956.GA12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716224518.62556-2-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> The hwrng_fill() function can run while devices are suspending and
> resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> is suspended, the hwrng may hang the bus while attempting to add some
> randomness. It's been observed on ChromeOS devices with suspend-to-idle
> (s2idle) and an i2c based hwrng that this kthread may run and ask the
> hwrng device for randomness before the i2c bus has been resumed.

You mean the TPM here right?

Should we be more careful in the TPM code to check if the TPM is
suspended before trying to use it, rather than muck up callers?

Jason
