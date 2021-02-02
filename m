Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26730BB43
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBBJoe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 04:44:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44820 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhBBJng (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 04:43:36 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l6sCn-0006Ze-9k; Tue, 02 Feb 2021 20:42:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Feb 2021 20:42:41 +1100
Date:   Tue, 2 Feb 2021 20:42:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
Message-ID: <20210202094241.GB28856@gondor.apana.org.au>
References: <20210202085537.GA28682@gondor.apana.org.au>
 <20210202035655.GA26997@gondor.apana.org.au>
 <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com>
 <20210129150355.850093-3-stefanb@linux.vnet.ibm.com>
 <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
 <4162801.1612185801@warthog.procyon.org.uk>
 <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
 <4170408.1612192055@warthog.procyon.org.uk>
 <110279.1612254455@warthog.procyon.org.uk>
 <114435.1612258403@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114435.1612258403@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 09:33:23AM +0000, David Howells wrote:
>
> No idea.  It seems straightforward enough, at least on the keyrings side, that
> I was going to add it.

In that case please wait for the discussion on how we handle curves
to be finalised.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
