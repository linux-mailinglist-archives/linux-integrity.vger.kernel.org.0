Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548942F6EA
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Oct 2021 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhJOPWH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Oct 2021 11:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbhJOPWG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Oct 2021 11:22:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E2F361181;
        Fri, 15 Oct 2021 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634311200;
        bh=fWcVkFP52FOs/xPDPEmntNU+EM79bIknhYN49kApNB4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=YYOZC4O91hPiL10R/oH31GOv5+FZW9yAD+ts/qdMMK/TcNeY9mPXAB0gH71liXiic
         99nPBL5dLmNzjPFxqZAsnhnwpeZjtx4vVunzgJlnuA2bb/3XVQN8Go3D7y23I/ST4K
         3ORRS0xJy+bBt9TNFJThGvytaAPCrzbSMCr6hSUYoPkGysgTvAGb9KO1w4y7ONwbxk
         mf47iBiT9GeewpngVjCJxzHp7u8/L9lHRNPqL1oZWDG6E6nZwa5mrugJUSUBX+wvpp
         nSXtdyiDm4POrtW70M3cx/IL8vZh/JMTuJHxOvdjlgllK7/A++/v9ZnBOZRJmUubU3
         FqUD22sGJLv5A==
Message-ID: <31d49f7785dd82fd2f0c1078c9a94153e3c389ac.camel@kernel.org>
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
Date:   Fri, 15 Oct 2021 18:19:57 +0300
In-Reply-To: <5db32f21-1df7-c92e-42a1-a2a85b29dfbf@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
         <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
         <5db32f21-1df7-c92e-42a1-a2a85b29dfbf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-10-14 at 17:46 +0800, Tianjia Zhang wrote:
> Hi Jarkko,
>=20
> On 10/12/21 11:21 PM, Jarkko Sakkinen wrote:
> > On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> > > According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> > > SM3 always produces a 256-bit hash value and there are no plans for
> > > other length development, so there is no ambiguity in the name of sm3=
.
> > >=20
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >=20
> > This is not enough to make any changes because the commit message
> > does not describe what goes wrong if we keep it as it was.
> >=20
> > /Jarkko
> >=20
>=20
> This did not cause an error, just to use a more standard algorithm name.=
=20
> If it is possible to use the SM3 name instead of SM3_256 if it can be=20
> specified from the source, it is of course better. I have contacted the=
=20
> trustedcomputinggroup and have not yet received a reply.
>=20
> Best regards,
> Tianjia

Why don't you then create a patch set that fully removes SM3_256, if it
is incorrect?

This looks a bit half-baked patch set.

/Jarkko
