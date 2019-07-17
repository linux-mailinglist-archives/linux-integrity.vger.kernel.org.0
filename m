Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A66C04D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfGQRWX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 13:22:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34099 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQRWW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 13:22:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so11169443pfo.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=l2ulz+HEZ33TLtGD0gtyTHpRn0lM8VKKeKFHaHpL698=;
        b=Y8q8WGxHQQll47oGZMGDyQeU9t4dUPA+MBl5AUYiBoRR/gNrknxYpikGgCHTVq8WA6
         iFKJS7m79cR/x0ODwjsBeAGh11f2A8JJ3glgAg7yT9UXyUlRJwPbXftAvjnAFx/nEBn/
         REQVFCLRerodwlpY2V4mzgpjgU1C3OjDrwW00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=l2ulz+HEZ33TLtGD0gtyTHpRn0lM8VKKeKFHaHpL698=;
        b=H0hCR+NUp8VIuO4xpwYw56jNHHwxKrlamLZ4W1lw/Wd5/e+6hSZFi4KaCdaO7pbLBf
         1P+xnhHv2T2L0F6DbtUZhfrV8/0Fzn5rdaA8Y0ZIeTa/ijHLAyq/O5xMhnzNSrhtD9w6
         DFplVYcJXz+OcIdSxGnhznyMPgsScjAFoLo4FTu8Mgci/bTTd8P6F8EAEA9mhXpsyavl
         vPsWN2dJ5LT8ZlXAV8MR0/i25+iyHpuijqabwCzQ/jGrD0v3IF4tm6qq6qkY/e3Df/1L
         L7Yc8M+jI5cl/iohOygxstp95k0gBjN/jIwqt05NkegmY8iz5y83jOXm7ek0HtxEZotD
         FmJg==
X-Gm-Message-State: APjAAAXn1uIvWADPB39WAxj4bTJllf9zNe4h5xwSyYC/NNDebiSYdpjX
        5ZV/OgDbet9UuhO7EY00yQEH5g==
X-Google-Smtp-Source: APXvYqyWQKoNBIXLCon0D7eQpNio5dhXZcv2k6RF9k4MMwut6x0yKBuJ5c1e1zhHJI+aGoqMy60GIg==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr43006226pgh.149.1563384142245;
        Wed, 17 Jul 2019 10:22:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f12sm22308136pgo.85.2019.07.17.10.22.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:22:21 -0700 (PDT)
Message-ID: <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717171216.GK12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca> <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca> <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com> <20190717171216.GK12119@ziepe.ca>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 10:22:20 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> >=20
> > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > holds almost nothing at all when the two drivers are modules.
>=20
> I'm not sure it is an actual savings, there is alot of minimum
> overhead and alignment to have a module in the first place.
>=20

Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
symbol. A module has overhead that is not necessary for these little
helpers.

