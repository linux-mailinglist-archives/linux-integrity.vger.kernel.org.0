Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF308DAF
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhA2TqQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 14:46:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57688 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhA2TpS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 14:45:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l5Zgd-0007R1-Eh; Sat, 30 Jan 2021 06:44:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 30 Jan 2021 06:44:07 +1100
Date:   Sat, 30 Jan 2021 06:44:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] crypto: Add support for ECDSA signature
 verification
Message-ID: <20210129194407.GA24780@gondor.apana.org.au>
References: <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
 <20210129150355.850093-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129150355.850093-2-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 29, 2021 at 10:03:52AM -0500, Stefan Berger wrote:
>
> +		.cra_name = "ecdsa-nist-p256",
> +		.cra_driver_name = "ecdsa-nist-p256",

The driver name should have a "-generic" suffix in case a driver
provides this algorithm too.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
