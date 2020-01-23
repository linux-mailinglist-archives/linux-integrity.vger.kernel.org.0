Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06D1467FA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWMaI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jan 2020 07:30:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51205 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgAWMaI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 07:30:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so2371533wmi.1
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2020 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGSddkn2oPOfmTp45og+40fbCbT5YOVg/hcLGMG+SRk=;
        b=iPWd6aqZDSVrowqY+yXr1t9T8eaRJ1u9DG41qvU1O/8NZKaepvdruPPR1G72He/3ab
         DgGnv0WNIMRDUFPC+37qhVZjcINw1xTizwvb6gP5948KHncNbjO03x2lN7Kyr27i9Pux
         I63pzRi/28bAVU0gr1Aa1lXXrvT+KZH5r3zB7YYjqctolvbmW3nCsYXepFsDnwxloaMU
         uzWlqF2sjgPrSFenojEg1eDKzz81bJYbYP6WWoDs0QtB+1ImRZOeUmVT1snmvSDlLq0Q
         kyKoS6w4efa6VYEQKGe5MOuYkO8HEOe8VJL28Lj7v9eWiUjXMNkwqZ8oFEl54l/aGAPg
         5n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGSddkn2oPOfmTp45og+40fbCbT5YOVg/hcLGMG+SRk=;
        b=UEzCnYWBWDnhan8k2XB1puGsx9FmpLrhBudcqw9rEYn3hC4DvuiVyykB+n9UaaS35K
         IXkaiPQ3JDymwMe4QlsJnJNvRPXBU4Dyseojd0SW15cXRJHDYt6VOArTh1o2JKdsdPax
         SCpY9M0fSb0PC0E5cCdFT5NflpLkus67AsBPgzGJZ3TlA0XKrq7IG9M/SxY1s2wuYfJo
         A1T3z7ex1dG9Wa7O6lA2wLKwLnipGM/OlGL+dN5UCQhyEmPvf8fd6T3xMfC9Wlsh8wEr
         sipqu5vZ0yhOm+BtA4x4ppBRqxXYLSh08ZNCDMiEsZd3IgG/pNp3btgvK3EAw70tw+SD
         +aqw==
X-Gm-Message-State: APjAAAUzW6QyWnu/avqvFIvW8c3EeXas8gIhFrSEZVK45S2PN1JlN6Kr
        Oxj/1HoGQu/pdiuEyN8t7HZj9Hvr40tHlH/XTTiNXA==
X-Google-Smtp-Source: APXvYqwRdDw6IKpVxqtsb6wHOmHsoYFzKFkd0ur/MlxkxDjV/8oc+nyjFNKke74ZHCyQ/IDGPGm8XXZQ+xfwl2i5HHk=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr2273208wmj.1.1579782606500;
 Thu, 23 Jan 2020 04:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114141647.109347-1-ardb@kernel.org> <20200114141647.109347-3-ardb@kernel.org>
 <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
In-Reply-To: <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 23 Jan 2020 13:29:55 +0100
Message-ID: <CAKv+Gu-9KvzLEcNQnRfsOkU=5oc1otY_NS15fR5Oi4Z4UVvurw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 23 Jan 2020 at 13:27, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > window that is backed by the SPI command sequencer in the SPI bus
> > controller. This arrangement has the limitation that only byte size
> > accesses are supported, and so we'll need to provide a separate set
> > of read and write accessors that take this into account.
>
> What is SynQuacer platform?
>

It is an arm64 SoC manufactured by Socionext.

> I'm also missing a resolution why tpm_tis.c is extended to handle both
> and not add tpm_tis_something.c instead. It does not follow the pattern
> we have in place (e.g. look up tpm_tis_spi.c).
>

We could easily do that instead, if preferred. It's just that it would
duplicate a bit of code.
