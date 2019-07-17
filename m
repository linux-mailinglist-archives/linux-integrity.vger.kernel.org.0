Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8299B6C058
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfGQRZr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 13:25:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34694 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfGQRZq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 13:25:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so24240918qtq.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3o2MAlK+hZOMib5Fac+i/rBUtNgoVpu1Wg0Rqwft/s=;
        b=DPUUic0kZrEK5De+KOwCI8bpRhFk2KK+ZmZlM56sbOTXqLpgamN78Ag4v9yfk6ha5H
         u56XFFBXun8Schg9m40q0aRD2TZKdDv6ESpYsvcSnWZlYcj8d3dqiezrrkRbhSia2lp9
         dHXiPKsYyKU0FUUIgxbSAoWxn1HlLfjp1eDs0N+OKcO7v/o02m1mKt2yWQKe+y1vftDT
         Ul4Fptj5c/ybCtg0baZpgxb8VXQAxp5Yr4RjuRk8bN9mnLM/XwsmkahyzrVSnV32wX9X
         7RreQ6Z5ik0HALFGwOkE+iqeLPK+SS2TK1e0Kn463bPTaiT0vevLxAfRm64mKxbO1aRz
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3o2MAlK+hZOMib5Fac+i/rBUtNgoVpu1Wg0Rqwft/s=;
        b=o4JXJ3LACBNQtLkJeoyHlpSBVLhy58u4qUtrccs+Y41KRuAJL+XwqCd+WbiSTBjfMm
         oCi+DnZF/3hixzvGRM/h0IjW+l/uXYtRCHEA6nSsYpb7Se6oYjguGBMJn1Uj0Uz3JBR1
         J5FyKtSd09tu5YcNcUfFD/bYZcuZOingdU2+h17FdiBFBoSiULThEO1IXmscuQ3lVCWl
         v52D/4w69xx9l2WZI28Vll8RqhoLF/0N5lN8JoILTwAzCThPB96M4BFBcMIbWb2vnwOv
         DrFSc4VwRHL08SjLr1eGbrUcvzxZVSaDk8uCulQ3a9S1Vxoapj8gPomreRkjVzlT4dZr
         edqA==
X-Gm-Message-State: APjAAAWAIOotUY5TwuMmOK+NNSMKNJy8Ve20snzK/XkHqJ1xhnr/jLOG
        WLSkyNipIQZ6A30AkF5RU2oh5Q==
X-Google-Smtp-Source: APXvYqyHlN70UeDzu9ByPw4va7icrC2D2fl5bsL6h+PrR1CAEoD2mQjrGDPi5Cc4I4CDuQroOsYYWw==
X-Received: by 2002:a0c:b909:: with SMTP id u9mr29849022qvf.10.1563384345959;
        Wed, 17 Jul 2019 10:25:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w16sm10407356qki.36.2019.07.17.10.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 10:25:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnngW-0006Ts-Uq; Wed, 17 Jul 2019 14:25:44 -0300
Date:   Wed, 17 Jul 2019 14:25:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190717172544.GL12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com>
 <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com>
 <20190717171216.GK12119@ziepe.ca>
 <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f594d.1c69fb81.baadd.d81d@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > 
> > > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > > holds almost nothing at all when the two drivers are modules.
> > 
> > I'm not sure it is an actual savings, there is alot of minimum
> > overhead and alignment to have a module in the first place.
> > 
> 
> Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> symbol. A module has overhead that is not necessary for these little
> helpers.

Linking driver stuff like that to the kernel is pretty hacky, IMHO

Jason
