Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40F63A7F6
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiK1MLG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 07:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiK1MKr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 07:10:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229D222B8;
        Mon, 28 Nov 2022 04:04:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107B361149;
        Mon, 28 Nov 2022 12:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADEBC433C1;
        Mon, 28 Nov 2022 12:03:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YeseauXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669637015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Deg2zp7dwT9o3e/HySvPJHslvn3AjSP4JHQTJYiaB/k=;
        b=YeseauXBsvMz5Okw2aUPDHv/z2Z2pedguidoFR1Oak/sJdZ2xKe1BQ/5R53pACPZEgm8aY
        LAa8kSyngl3hU5oe7fUF/NPr563SSZyqNOJ8eD2/l84YtG2Uc/RvzLLeHVeNdW6kOhkMsv
        gB1GP5vjzDTNm2b0Jyv4v0dvADG9iT4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 64c5fbf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 12:03:35 +0000 (UTC)
Date:   Mon, 28 Nov 2022 13:03:31 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] suspend to ram fails in 6.1 due to tpm errors
Message-ID: <Y4Sjk+Fibcsihg4Y@zx2c4.com>
References: <c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vlastimil,

Thanks for CC'ing me.

On Mon, Nov 28, 2022 at 09:15:33AM +0100, Vlastimil Babka wrote:
> Dominik on IRC pointed me to commit b006c439d58d ("hwrng: core - start hwrng
> kthread also for untrusted sources"), which could make sense if the TPM was not
> used at all before and now it's used for randomness. But then it probably "just"
> uncovered a pre-existing issue? Maybe there's a race with getting the randomness
> and suspend? Could it be exactly what this patch is attempting to fix?
> https://lore.kernel.org/all/20221103145450.1409273-2-jsd@semihalf.com/

The commit you referenced just turns on some functionality that most
people previously didn't have (but maybe could have, manually). So this
is a case of a new commit unearthing a bug in some old code. We had
something similar happen with a raspi driver and fixed the bug there.
From the looks of the lore link you provided, it sounds like the same
thing has happened already there to tpm? That this is already fixed by
that commit? I think if you have a system that's readily exhibiting the
issue, the best thing to do would be to try that series, and report
back, maybe even providing your `Tested-by:` line if it works.

I'll play around and see if I can repro too. Looks like you have a T460?
I don't have exactly that but maybe something close enough.

Jason
