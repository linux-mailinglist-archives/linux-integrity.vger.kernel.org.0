Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BF30F7C6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhBDPCf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 10:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237042AbhBDPAW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 10:00:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9E1864F60;
        Thu,  4 Feb 2021 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612450711;
        bh=Gkl5QjMLL9cstN7D689exW6RO9F/yfq6ZQ1XMZN1V+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1FvdF0heZuFmuqdo0dHu3sLr8/I8cmWlT2CSDUdGkPM/JF0RyifSAFkwLaPLumqI
         4sOOu4MH1lODcMRT4j5Ncjve0F5oGTNNamwSzKrdbYhzmd0K+5Dpc3nIuqaGI3OSpI
         B4/xOw4I5xKsdGR9v6dqRwSDaPIPO2cNTrO9aZPONvd6sS+ksHXU56ovqPJk8Xqz4Y
         9xuDQiz32W/CoLoiLjgOEBiuyUQOGW9A32jKRkPor9SCx9+Pw67Gs8PhhwKgifCOVy
         RYyy7eTRduNvneoqUyJui+ZV1Jm2w2TNAJ+N+Nd2FbmMIKndRxSup9Fr7QAzNh8+Ga
         AdXSDhTqCNbtA==
Date:   Thu, 4 Feb 2021 16:58:23 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Saulo Alessandre <saulo.alessandre@gmail.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 1/4] crypto: Add support for ECDSA signature
 verification
Message-ID: <YBwLj+8kHIHMA3xH@kernel.org>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <20210201151910.1465705-2-stefanb@linux.ibm.com>
 <20210204052738.GA7086@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204052738.GA7086@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 04, 2021 at 04:27:39PM +1100, Herbert Xu wrote:
> On Mon, Feb 01, 2021 at 10:19:07AM -0500, Stefan Berger wrote:
> > Add support for parsing the parameters of a NIST P256 or NIST P192 key.
> > Enable signature verification using these keys. The new module is
> > enabled with CONFIG_ECDSA:
> >   Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
> >   is A NIST cryptographic standard algorithm. Only signature verification
> >   is implemented.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: linux-crypto@vger.kernel.org
> > ---
> >  crypto/Kconfig               |  10 +
> >  crypto/Makefile              |   6 +
> >  crypto/ecc.c                 |  13 +-
> >  crypto/ecc.h                 |  28 +++
> >  crypto/ecdsa.c               | 361 +++++++++++++++++++++++++++++++++++
> >  crypto/ecdsasignature.asn1   |   4 +
> >  crypto/testmgr.c             |  12 ++
> >  crypto/testmgr.h             | 267 ++++++++++++++++++++++++++
> >  include/linux/oid_registry.h |   4 +
> >  9 files changed, 694 insertions(+), 11 deletions(-)
> >  create mode 100644 crypto/ecdsa.c
> >  create mode 100644 crypto/ecdsasignature.asn1


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Great, ECDSA has been lacking for a way too long. Just wanted to
acknowledge support for this, I just now also skimmed the change
from patchwrok (way too quickly for reviewed-by but well enough
for ack).

/Jarkko
