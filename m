Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7050930B620
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 05:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhBBEAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 23:00:14 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43614 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhBBEAM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 23:00:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l6mqU-0000MM-FM; Tue, 02 Feb 2021 14:59:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Feb 2021 14:59:18 +1100
Date:   Tue, 2 Feb 2021 14:59:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Add support for x509 certs with NIST p256 and
 p192 keys
Message-ID: <20210202035918.GB26997@gondor.apana.org.au>
References: <7836898a-0a42-5c9b-3a42-7ff4c7a03ea4@linux.ibm.com>
 <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <32177.1612196003@warthog.procyon.org.uk>
 <33903.1612197412@warthog.procyon.org.uk>
 <ab3f4f96-6aec-4586-21fa-318fcee997a5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3f4f96-6aec-4586-21fa-318fcee997a5@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 01, 2021 at 11:45:16AM -0500, Stefan Berger wrote:
>
> With the crypto module missing in the kernel you will get an error trying to
> load an x509 certificate that needs the algorithm to verify the self-signed
> signature.
> 
> Before I post yet another series I hope that Herbert can say whether option
> 1) would work for him.

Please be patient.  We need to make sure that whatever scheme you
use for your algorithm also works for the driver authors who are
working in the same area.  Because if we end up having to change
the scheme then that'll just create more churn for you and David.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
