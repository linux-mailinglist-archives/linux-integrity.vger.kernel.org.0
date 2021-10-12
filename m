Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2C42A843
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhJLPcD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 11:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237355AbhJLPcD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 11:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C843160F3A;
        Tue, 12 Oct 2021 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634052601;
        bh=JpF6An/Riv/dMcUkrhm8JSEkFKJMUWfWjMUX6PwjxwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pgxa5ioPEQcnUN4WhfnouRG3+p0X4c1Fi/dcxyxpGiHcKIBi06OUe7KEFSmwQnEj4
         9CKnSJy3J9R8HsExGL6hXZYoLmQ+sxuj4KL+EPjfyAuG3d13IiqBOrlo2oRzAIULso
         7eZcbjqZAQHghUA65lYc4vOS4QvnxbPN9TqnzCdpZ2F78zYQZ3vA1KBEw6oEPOiXlj
         BirBxvEBgeoRDGprFFcSgTdznJV5JOklg4yzuG54yHVd4/JPB5YLqe4vUo/oXTu9MU
         2SX9eh/7lEHihPPkibIqfDcSq1xls9O6cJkqA/IH7wtdWXeMiD5WDE+PFMWDpceM8l
         8yCsauCyBBbfA==
Message-ID: <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Oct 2021 18:29:58 +0300
In-Reply-To: <20211010160147.590-1-caihuoqing@baidu.com>
References: <20211010160147.590-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-10-11 at 00:01 +0800, Cai Huoqing wrote:
> Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
  ~~~~~~~~~
  Replace

> dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
> helps to reduce code size, and simplify the code, and coherent
> DMA will not clear the cache every time.
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

If this does not do functionally anything useful, there's no
reason to apply this.

It is also missing information why the substitution is possible.

Field tested code is better than clean code, i.e. we don not
risk at having possible new regressions just for a bit nicer
layout...

/Jarkko


