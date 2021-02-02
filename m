Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9592830B61C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 04:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBBD5v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 22:57:51 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43600 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhBBD5v (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 22:57:51 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l6moB-0000J9-Is; Tue, 02 Feb 2021 14:56:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Feb 2021 14:56:55 +1100
Date:   Tue, 2 Feb 2021 14:56:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
Message-ID: <20210202035655.GA26997@gondor.apana.org.au>
References: <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com>
 <20210129150355.850093-3-stefanb@linux.vnet.ibm.com>
 <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
 <4162801.1612185801@warthog.procyon.org.uk>
 <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
 <4170408.1612192055@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170408.1612192055@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 01, 2021 at 03:07:35PM +0000, David Howells wrote:
>
> Herbert wants the first patch to go through the crypto tree.  Maybe all of
> them should proceed by that route if Herbert is willing?

I'm not actually all that fussed about where it goes through.  It's
just the first patch happens to touch an area that is still under
discussion for the Crypto API.  So once that's settled I'm more than
happy for it to go through your tree if that's the easiest way to go.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
