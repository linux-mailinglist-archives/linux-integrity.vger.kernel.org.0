Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6076CD9674
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfJPQJO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 12:09:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35554 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393426AbfJPQJM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 12:09:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so23289880qkf.2
        for <linux-integrity@vger.kernel.org>; Wed, 16 Oct 2019 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BnF2IZmhjIW84VvdZm5AoWBPYSXJXJ17rtvesl9UOs=;
        b=XBD9T8mUFqNwZP7qE0pJ15N2JxgNpzwCpN2kvySvjcsCnpvKsiVGhsiOib70CjClEs
         GcSPqWMlOKEjhoPYfl7umshBxX6WoJZ7zBNgRJGvDiKQnQt+7ZSfssTwE/tkUf7065lO
         aDlgZzLYD+esDMmn1Yp//npJ7w8d204/Caxz3UywArr89d2HQUpG19VhqNdX+L8cKPvE
         dru8RxTeZTZLHtFT2wspNrpdqan0ghvRfB7EKOBbnZ10rlwKJ5sbBtZfKxjwD3bkiZVQ
         L8GyR7UsYSsZ3ryJXZFwHXUgcnvMfZAjmmy6gV3o7GVNhlKoDtdnZM4EzR0scuMajnoo
         Od2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BnF2IZmhjIW84VvdZm5AoWBPYSXJXJ17rtvesl9UOs=;
        b=lc7eJ3MDk8U3IqHmjx5/pdS/XMsbFGlwgQ0aca8n4+0Yi7lEl852eWT9J21xFVWKzX
         GimuD6+hG+5rnABl45A/pE2AY/Y3PMh9EiZ2IrOIx7Ry5W7igc4nO/wt5MEXnXdRUmtX
         w3olHOC5NcoIQHcEakWQx7xZf+hszxrYWmL4Y3ji+IYV3i7V17LOlu4s6Y2y6qxt0n+/
         u1GQjbxktaeB9w9MdKQ+vOIEszvr2GiFZX+4vH2HfLD5wWXo5GxJJZjVr3sUu2pKVLPU
         KJrAII1DerB1y/cqDprc/Bnu7AxKMV9wlyIYqSKyyUmNVt4uQGeBgBLjHt0a2CLsAaQ3
         93KQ==
X-Gm-Message-State: APjAAAX6wbuI3ZKHDAtPke70qN8jWgsv2Esr8FrA6LBySCvarMTojuk6
        jetzOa/YPfHjMaWgfs4cnXXNQpVafAY=
X-Google-Smtp-Source: APXvYqxUVnepfpuQgammVeMLj+t7frCVIF1BgpCVWvbOx6Ad/L+BOZFtY4oMDEYGDKUtYSCyoqkfWA==
X-Received: by 2002:a37:7dc2:: with SMTP id y185mr28705614qkc.236.1571242151268;
        Wed, 16 Oct 2019 09:09:11 -0700 (PDT)
Received: from ziepe.ca (ip-66-51-117-131.syban.net. [66.51.117.131])
        by smtp.gmail.com with ESMTPSA id q44sm16058005qtk.16.2019.10.16.09.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:09:10 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKlrI-0000xM-A4; Wed, 16 Oct 2019 13:09:08 -0300
Date:   Wed, 16 Oct 2019 13:09:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191016160908.GA3637@ziepe.ca>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <20191015170450.GB5444@ziepe.ca>
 <20191016103805.GA10184@linux.intel.com>
 <20191016104322.GC10184@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016104322.GC10184@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 16, 2019 at 01:43:22PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 16, 2019 at 01:38:05PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 15, 2019 at 02:04:50PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 15, 2019 at 03:47:02PM +0300, Jarkko Sakkinen wrote:
> > > > Salt the result that comes from the TPM RNG with random bytes from the
> > > > kernel RNG. This will allow to use tpm_get_random() as a substitute for
> > > > get_random_bytes().  TPM could have a bug (making results predicatable),
> > > > backdoor or even an inteposer in the bus. Salting gives protections
> > > > against these concerns.
> > > 
> > > Seems like a dangerous use case, why would any kernel user that cared
> > > about quality of randomness ever call a tpm_* API to get quality
> > > random data?
> > 
> > This is related to this discussion:
> > 
> > https://lore.kernel.org/linux-integrity/CAE=NcrY3BTvD-L2XP6bsO=9oAJLtSD0wYpUymVkAGAnYObsPzQ@mail.gmail.com/T/#t
> > 
> > I could also move this to the call site.
> 
> But I hear you anyway.
> 
> I think for trusted keys the best strategy would be to do
> exactly this:
> 
> 1. Generate one random value with get_random_bytes_arch()
> 2. Generate another with backend specific technology (we
>    have now two TPM and TEE) if an RNG available.
> 3. Xor the values together.

Feels like something the random core should handle - maybe some way to
say 'my trust model requires trust in this RNG' and then the random
core can more heavily weight data from that RNG

Jason
