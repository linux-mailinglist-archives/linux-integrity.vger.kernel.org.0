Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BA431E60
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhJROAj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Oct 2021 10:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234664AbhJRN63 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Oct 2021 09:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAF7F61A40;
        Mon, 18 Oct 2021 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634564489;
        bh=iyQNCJw3F2btWylGkoSsJbiuAqzwxr7VZp84T8arEwk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Muk1xW0O5fPkNs1SObNldVoKqidRwndzDDCkNEC0B0lO2IyZKUCtY8K+mMfUuaYZd
         cL0KbWMGwXTcZritJ7+AqX/i/Slq2vQ3TFT8qH4dnzifxwAlHnTB0R7fXbt/9Ydo6o
         R6TW5vdR2I6vipcf13Wm9iIo7VWkS1eEmHIv3H14gJR2CmDKO2uFtJ4JYn5d5YXnpq
         vEb7U3LYwRzjycvD69cavPuejBiYJODJwHhnF1zOLy2p7gCguIkj9PfbV2Ef/Rzk88
         Ktx6XBGnB9cYIhgCbMozT4+fkladPBDQqNT0gUOFJuK42Tvn0S19FEBuRX06p0kTdR
         7iRo20kZTREzw==
Message-ID: <41aba1e1c5849b58f83108eb9f9f115d0cd5826f.camel@kernel.org>
Subject: Re: [PATCH 1/2] crypto: use SM3 instead of SM3_256
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     jejb@linux.ibm.com,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
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
Date:   Mon, 18 Oct 2021 16:41:26 +0300
In-Reply-To: <af8c2098c4cfe23b941a191f7b4ec0e3a5251760.camel@linux.ibm.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
         <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
         <dbac037710d711959d5ce0969f80ea0dd18a176e.camel@kernel.org>
         <af8c2098c4cfe23b941a191f7b4ec0e3a5251760.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-10-18 at 09:32 -0400, James Bottomley wrote:
> On Mon, 2021-10-18 at 16:27 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2021-10-18 at 09:05 -0400, James Bottomley wrote:
> > > On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> > > [...]
> > > > diff --git a/include/uapi/linux/hash_info.h
> > > > b/include/uapi/linux/hash_info.h
> > > > index 74a8609fcb4d..1355525dd4aa 100644
> > > > --- a/include/uapi/linux/hash_info.h
> > > > +++ b/include/uapi/linux/hash_info.h
> > > > @@ -32,7 +32,7 @@ enum hash_algo {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_TGR_128,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_TGR_160,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_TGR_192,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_SM3_256,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_SM3,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_STREEBOG_256,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO_STREEBOG_512,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HASH_ALGO__LAST
> > >=20
> > > This is another one you can't do: all headers in UAPI are exports
> > > to userspace and the definitions constitute an ABI.=C2=A0 If you simp=
ly
> > > do a rename, every userspace program that uses the current
> > > definition will immediately break on compile.=C2=A0 You could add
> > > HASH_ALGO_SM3, but you can't remove HASH_ALGO_SM3_256
> > >=20
> > > James
> >=20
> > So: shouldn't then also the old symbol continue to work also
> > semantically?
>=20
> Yes, that's the point: you can add a new definition ... in this case an
> alias for the old one, but you can't remove a definition that's been
> previously exported.

Thanks, this of course obvious :-) I forgot temporarily that crypto
has uapi interface. Tianjia, this patch set break production systems,
so no chance we would ever merge it in this form.

Why not just do this:

...
HASH_ALGO_SM3_256,
HASH_ALOG_SM3 =3D HASH_ALOG_SM_256,
...

There is not good reason to mod the implementation because both symbols
are kept.

/Jarkko
