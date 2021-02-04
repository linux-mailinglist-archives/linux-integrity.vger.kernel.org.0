Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65930EC02
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 06:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBDF2b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 00:28:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51552 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBDF2a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 00:28:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7XB5-0001sW-6F; Thu, 04 Feb 2021 16:27:40 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 16:27:39 +1100
Date:   Thu, 4 Feb 2021 16:27:39 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 1/4] crypto: Add support for ECDSA signature
 verification
Message-ID: <20210204052738.GA7086@gondor.apana.org.au>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <20210201151910.1465705-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201151910.1465705-2-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 01, 2021 at 10:19:07AM -0500, Stefan Berger wrote:
> Add support for parsing the parameters of a NIST P256 or NIST P192 key.
> Enable signature verification using these keys. The new module is
> enabled with CONFIG_ECDSA:
>   Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
>   is A NIST cryptographic standard algorithm. Only signature verification
>   is implemented.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  crypto/Kconfig               |  10 +
>  crypto/Makefile              |   6 +
>  crypto/ecc.c                 |  13 +-
>  crypto/ecc.h                 |  28 +++
>  crypto/ecdsa.c               | 361 +++++++++++++++++++++++++++++++++++
>  crypto/ecdsasignature.asn1   |   4 +
>  crypto/testmgr.c             |  12 ++
>  crypto/testmgr.h             | 267 ++++++++++++++++++++++++++
>  include/linux/oid_registry.h |   4 +
>  9 files changed, 694 insertions(+), 11 deletions(-)
>  create mode 100644 crypto/ecdsa.c
>  create mode 100644 crypto/ecdsasignature.asn1

Saulo Alessandre is implementing ecdsa with signing so you two
should coordinate on this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
