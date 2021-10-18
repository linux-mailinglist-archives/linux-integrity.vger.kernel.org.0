Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8B4319F9
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhJRMui (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Oct 2021 08:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhJRMui (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Oct 2021 08:50:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949BA60FF2;
        Mon, 18 Oct 2021 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634561307;
        bh=iUCyCMM2FKcF5aARf6r4eS3ztMciGwsmxK7BcZeTtVk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=gNeC13ZwtB4aP0GVC8EgFI6A/3typ7w2TZhIW25frk/eJt30bN4wWuqlxE0vfI4Py
         g36RTS9q5p6tpusanojngeCX2QvAR2WSAd0gzNNtCB6dySZ15JsQ92DnPug9UhpqLO
         8sWzkzYs5j29+WndETA1q/YPhL9+tUx71UWengpSk6JDx1nv/humDJWP8MkNbi5bAc
         t4jLioiVWCIR9Y6vI1CD1jN0uHyKRsNN3Afng0ijl41JShDCocPeHgG7MROD/m8K9t
         683qVN6imLGqPDz6rAP13QFkAoftLbGZhPiSsNT6U5YpDv6psc6/526NGWJ9TrqgLS
         qSxJpGoNpK8UA==
Message-ID: <8ca00c48a987278a85435d6e046ce9a12bc9050b.camel@kernel.org>
Subject: Re: [PATCH 2/2] tpm: use SM3 instead of SM3_256
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:48:24 +0300
In-Reply-To: <5b0bc02a-eeb5-9d86-852b-d3041f3c6286@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
         <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
         <5db32f21-1df7-c92e-42a1-a2a85b29dfbf@linux.alibaba.com>
         <31d49f7785dd82fd2f0c1078c9a94153e3c389ac.camel@kernel.org>
         <5b0bc02a-eeb5-9d86-852b-d3041f3c6286@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-10-18 at 10:37 +0800, Tianjia Zhang wrote:
> Hi Jarkko,
>=20
> On 10/15/21 11:19 PM, Jarkko Sakkinen wrote:
> > On Thu, 2021-10-14 at 17:46 +0800, Tianjia Zhang wrote:
> > > Hi Jarkko,
> > >=20
> > > On 10/12/21 11:21 PM, Jarkko Sakkinen wrote:
> > > > On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> > > > > According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.ht=
ml,
> > > > > SM3 always produces a 256-bit hash value and there are no plans f=
or
> > > > > other length development, so there is no ambiguity in the name of=
 sm3.
> > > > >=20
> > > > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > >=20
> > > > This is not enough to make any changes because the commit message
> > > > does not describe what goes wrong if we keep it as it was.
> > > >=20
> > > > /Jarkko
> > > >=20
> > >=20
> > > This did not cause an error, just to use a more standard algorithm na=
me.
> > > If it is possible to use the SM3 name instead of SM3_256 if it can be
> > > specified from the source, it is of course better. I have contacted t=
he
> > > trustedcomputinggroup and have not yet received a reply.
> > >=20
> > > Best regards,
> > > Tianjia
> >=20
> > Why don't you then create a patch set that fully removes SM3_256, if it
> > is incorrect?
> >=20
> > This looks a bit half-baked patch set.
> >=20
> > /Jarkko
> >=20
>=20
> This series of patch is a complete replacement. Patch 1 is a replacement=
=20
> of the crypto subsystem, and patch 2 is a replacement of the tpm driver.
>=20
> Best regards,
> Tianjia

In which patch that symbol is removed?

/Jarkko
