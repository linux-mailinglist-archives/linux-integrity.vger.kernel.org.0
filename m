Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF23B4323
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFYMbl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:31:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50880 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYMbl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:31:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwkxD-0008Um-SF; Fri, 25 Jun 2021 20:29:03 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwkwy-0006no-Iw; Fri, 25 Jun 2021 20:28:48 +0800
Date:   Fri, 25 Jun 2021 20:28:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
Message-ID: <20210625122848.GA26048@gondor.apana.org.au>
References: <20210614201620.30451-1-richard@nod.at>
 <20210614201620.30451-2-richard@nod.at>
 <CAFLxGvyyybqsgXOQ2f2BmpTCnC=7UdWhwnCpGfZMxYuK-AQ-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvyyybqsgXOQ2f2BmpTCnC=7UdWhwnCpGfZMxYuK-AQ-_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 25, 2021 at 02:21:16PM +0200, Richard Weinberger wrote:
>
> This patch was judged as not applicable in your patchwork.
> Is something missing? How can we proceed?

I'm happy to take this patch.  I marked it as not applicable
mainly because the other two patches didn't have acks and I'm
not sure if they were meant for the crypto tree or not.

Would you like me to take just the first patch?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
