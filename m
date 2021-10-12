Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398DE42AAED
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJLRmh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 13:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhJLRmh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 13:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BF1D610C9;
        Tue, 12 Oct 2021 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634060435;
        bh=oHNW8iAwbLiMCjrD2yZb/l/38uU1PY+XDUI9AYIgDSw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JvXQduYyAbXhNr5vuechmeVPWZyzChGeSQ+79iVtPuL9rzOlBZV0VAlN1v76MWzuI
         CpNFrsAhXr9w2S0J2n6xu1dpL/IrQVM4i3YfQuUEdkwDmxOA09dReDy1YJGT2BHLMG
         LD1IRF2h+YgL/N2KoP/Rvjj+FYeBnoww/jDU4HalsPKsKL5OGEZ8sVg+uzgG+MTsj6
         ArjKPRNf885la5mJXmUihbKMcR9tV5zovLcDM8Lp2un6KWV1JLhYHMeBPrPYT0UIYE
         5k5pGTuV+t8A1A1aYTaf9ORTDczgvJNgOSl/cX9rw8oSIF6DN67yRrKx7vCMqxZKTM
         FlyfyXwYTOWDg==
Message-ID: <c36327cce24449b3eb79209c374514e750b38eb4.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Oct 2021 20:40:32 +0300
In-Reply-To: <20211012154325.GI2688930@ziepe.ca>
References: <20211010160147.590-1-caihuoqing@baidu.com>
         <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
         <20211012154325.GI2688930@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-10-12 at 12:43 -0300, Jason Gunthorpe wrote:
> On Tue, Oct 12, 2021 at 06:29:58PM +0300, Jarkko Sakkinen wrote:
> > On Mon, 2021-10-11 at 00:01 +0800, Cai Huoqing wrote:
> > > Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
> > =C2=A0 ~~~~~~~~~
> > =C2=A0 Replace
> >=20
> > > dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
> > > helps to reduce code size, and simplify the code, and coherent
> > > DMA will not clear the cache every time.
> > >=20
> > > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> >=20
> > If this does not do functionally anything useful, there's no
> > reason to apply this.
>=20
> At least in this case it looks like the ibmvtpm is not using the DMA
> API properly. There is no sync after each data transfer. Replacing
> this wrong usage with the coherent API is reasonable.

Thank you. As long as this is documented to the commit message,
I'm cool with the change itself.

E.g. something like this would be perfectly fine replacement for the
current commit message:

"The current usage pattern for the DMA API is inappropriate, as
data transfers are not synced. Replace the existing DMA code
with the coherent DMA API."

/Jarkko
