Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53671431B08
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhJRNaP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Oct 2021 09:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhJRN3e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Oct 2021 09:29:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3376761354;
        Mon, 18 Oct 2021 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634563642;
        bh=JiOfsM+VsKz3tI8patwREmt4bHqbUZ+aAXlMIVmYXOc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=TFnATNtwf0XWXRYp8OKidb4lzlJKbPNDZazXF3ANCNd07sXgjBFVFPkNU3u2rl/U5
         vaHPIGGOKumWDKPbZ5s8EkPBlSwAr2bCzYwYkU+kyzXkn0gJS87TZCn4dyZy47liF8
         W1eWAx/vD7lzoQxJsiYwezFlnuesKPFgQ34CcWxO4FNbu40W6CxHzCJgRDI0eOJsjJ
         +y+VThb5770g1DeP/fUIW23a/n1ZstBhrKJqQTPS38sh9D9IQyycvpv+49QxvR5wtO
         x4tZnmSUflt5HcgI+cgl4OzwPPR0KVRSNaQFilyIWLMrzxFIFSfcg2tX2HBulEnaKk
         xt3JClgf5uaqQ==
Message-ID: <dbac037710d711959d5ce0969f80ea0dd18a176e.camel@kernel.org>
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
Date:   Mon, 18 Oct 2021 16:27:20 +0300
In-Reply-To: <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
         <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-10-18 at 09:05 -0400, James Bottomley wrote:
> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> [...]
> > diff --git a/include/uapi/linux/hash_info.h
> > b/include/uapi/linux/hash_info.h
> > index 74a8609fcb4d..1355525dd4aa 100644
> > --- a/include/uapi/linux/hash_info.h
> > +++ b/include/uapi/linux/hash_info.h
> > @@ -32,7 +32,7 @@ enum hash_algo {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_TGR_128,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_TGR_160,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_TGR_192,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_SM3_256,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_SM3,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_STREEBOG_256,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO_STREEBOG_512,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HASH_ALGO__LAST
>=20
> This is another one you can't do: all headers in UAPI are exports to
> userspace and the definitions constitute an ABI.=C2=A0 If you simply do a
> rename, every userspace program that uses the current definition will
> immediately break on compile.=C2=A0 You could add HASH_ALGO_SM3, but you
> can't remove HASH_ALGO_SM3_256
>=20
> James

So: shouldn't then also the old symbol continue to work also
semantically?

/Jarkko
