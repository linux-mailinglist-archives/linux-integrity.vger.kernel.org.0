Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332576587CA
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Dec 2022 00:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiL1XHr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Dec 2022 18:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiL1XHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Dec 2022 18:07:36 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBB15FC7
        for <linux-integrity@vger.kernel.org>; Wed, 28 Dec 2022 15:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672268848;
        bh=z/pnCfuIKIXDj13eYnbayH6ODEfVRX13nZ1+QqmRYgA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q6WQmYfolCRjLBquRpO0qucEzV1fSLJIbfILDph8IzKzjADKWxWMGMcsKz3BNKNMt
         1kFKAm/LwiaDSvIWv+cMifusbm4Hy/7xDxtlAKFYdYJ0/MMDgHrGvZNqFOk6w+Bk6w
         KPL8W4xQ43t85O5e3jOAq38XYlFGfSzAWs/N/EBQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 42EA61285ECE;
        Wed, 28 Dec 2022 18:07:28 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wBBD4wdbpq5X; Wed, 28 Dec 2022 18:07:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1672268848;
        bh=z/pnCfuIKIXDj13eYnbayH6ODEfVRX13nZ1+QqmRYgA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q6WQmYfolCRjLBquRpO0qucEzV1fSLJIbfILDph8IzKzjADKWxWMGMcsKz3BNKNMt
         1kFKAm/LwiaDSvIWv+cMifusbm4Hy/7xDxtlAKFYdYJ0/MMDgHrGvZNqFOk6w+Bk6w
         KPL8W4xQ43t85O5e3jOAq38XYlFGfSzAWs/N/EBQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 20D761281B54;
        Wed, 28 Dec 2022 18:07:27 -0500 (EST)
Message-ID: <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>
Cc:     regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Dec 2022 18:07:25 -0500
In-Reply-To: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
> on the T460 with 6.2-rc1. Except I didn't see any oops message or
> "tpm_try_transmit" error this time. The first indication of a problem
> is this during a resume from suspend to ram:
> 
> tpm tpm0: A TPM error (28) occurred continue selftest
> 
> and then periodically 
> 
> tpm tpm0: A TPM error (28) occurred attempting get random

That's a TPM 1.2 error which means the TPM failed the selftest.  The
original problem was reported against TPM 2.0  because of a missing
try_get_ops().  The tpm 1.2 command path was never changed to require
this (and in fact hasn't changed for ages, TPM 1.2 being a bit
obsolete).  So this looks like a new problem with TPM 1.2 and
suspend/resume, likely in the BIOS of your system.

James

