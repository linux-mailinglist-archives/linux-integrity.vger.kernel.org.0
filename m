Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACE6BFC3
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGQQme (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 12:42:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41715 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQQme (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 12:42:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so11113101pff.8
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=1AorsIxKukv4QHmBEQpBYg3oWB5yXI20Vjy+qfW9lkc=;
        b=aPBwkLHRyP3zBfKz3S3KZH+l1+ZuRHEihIf2pUKXtkCweo+Ivk/jGG+X/fvdZIAoSM
         ZVu2DoZFhluTMuDDK3FJB7NZs0E5xyrn51mWlvLtQgjKe6f7kE46St5/G8CznBdRPtnz
         2XTizW1TMIpWX99cp06TCUJwuHnGHkuegzNLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=1AorsIxKukv4QHmBEQpBYg3oWB5yXI20Vjy+qfW9lkc=;
        b=qK4WwBBEVPWMskdDiqnC3e+3++1shNs4EFUWGxdjiSqXRqX5KMe2BOieJI1W4QcMxZ
         bBuiQxX3jl9WalIDrnR94ssybcmK2MwKbpbZOaRrG4u6F5gz1pEEmSzcLuEUv7zmbtGH
         vsmZd6T+4vif1rJMfwruwrgSSPEgjX+zuc+5m1gZzgR+87i0KPcNn/6k6K4q+eGHUGty
         oYtMdaAWJ6FKZoR6u+GcwuAu6TLU/jeg9C9+HZPgoZobNXGIJPTmXtoM+WlP9+pXKDUs
         Ay1rJ1gZ0YpyrIsF+V7m0KfwA67CbFVUccynAVXMEYrraTdKCLPXE1m1bxiiENix+BOD
         EXhQ==
X-Gm-Message-State: APjAAAUpkjkEnjDvR9G7Prut1kWi6H4VjPRy8f31ug+YVznPXeJUTr3k
        sfch4tS07IA0wdEmytZEvdrf+A==
X-Google-Smtp-Source: APXvYqxZuX+kytE+ZiGzvIKhMhXtYWj9yk9FEuNeG1kHCHbkJhLViY62UlNKE2ks3nGqJgwjpLalwQ==
X-Received: by 2002:a63:d950:: with SMTP id e16mr44043545pgj.271.1563381753703;
        Wed, 17 Jul 2019 09:42:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a20sm20571581pjo.0.2019.07.17.09.42.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 09:42:33 -0700 (PDT)
Message-ID: <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717113956.GA12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190717113956.GA12119@ziepe.ca>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 09:42:32 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 04:39:56)
> On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > The hwrng_fill() function can run while devices are suspending and
> > resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> > is suspended, the hwrng may hang the bus while attempting to add some
> > randomness. It's been observed on ChromeOS devices with suspend-to-idle
> > (s2idle) and an i2c based hwrng that this kthread may run and ask the
> > hwrng device for randomness before the i2c bus has been resumed.
>=20
> You mean the TPM here right?

In my case yes, but in general it isn't the TPM.

>=20
> Should we be more careful in the TPM code to check if the TPM is
> suspended before trying to use it, rather than muck up callers?
>=20

Given that it's not just a TPM issue I don't see how checking in the TPM
is going to fix this problem. It's better to not try to get random bytes
from the hwrng when the device could be suspended.

