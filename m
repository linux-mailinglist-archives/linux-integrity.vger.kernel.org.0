Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563C76B378
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 03:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfGQBob (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 21:44:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49234 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfGQBob (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 21:44:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnYzF-0003JW-NM; Wed, 17 Jul 2019 09:44:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnYz9-0002Lm-Gn; Wed, 17 Jul 2019 09:43:59 +0800
Date:   Wed, 17 Jul 2019 09:43:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Message-ID: <20190717014359.5xcnubpmazl3vqg5@gondor.apana.org.au>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716224518.62556-2-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
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
> 
> Let's make this kthread freezable so that we don't try to touch the
> hwrng during suspend/resume. This ensures that we can't cause the hwrng
> backing driver to get into a bad state because the device is guaranteed
> to be resumed before the hwrng kthread is thawed.
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/char/hw_random/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Do you want this to go through the crypto tree? If so you need
to cc the linux-crypto mailing list.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
