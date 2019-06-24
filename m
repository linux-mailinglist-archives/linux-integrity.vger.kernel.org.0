Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94250DEB
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 16:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfFXO1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 10:27:23 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:44882 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFXO1X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 10:27:23 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hfPvz-0008Pa-02; Mon, 24 Jun 2019 22:27:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hfPvq-00056P-KS; Mon, 24 Jun 2019 22:26:54 +0800
Date:   Mon, 24 Jun 2019 22:26:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Message-ID: <20190624142654.zprcpz42hivuyrjq@gondor.apana.org.au>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-2-swboyd@chromium.org>
 <20190613232613.GH22901@ziepe.ca>
 <5d03e394.1c69fb81.f028c.bffb@mx.google.com>
 <20190617225134.GA30762@ziepe.ca>
 <5d0c2cd6.1c69fb81.e66af.32bf@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0c2cd6.1c69fb81.e66af.32bf@mx.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 20, 2019 at 06:03:17PM -0700, Stephen Boyd wrote:
>
> What do you think of the attached patch? I haven't tested it, but it
> would make sure that the kthread is frozen so that the hardware can be
> resumed before the kthread is thawed and tries to go touch the hardware.

Looks good to me.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
