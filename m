Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B364F63AE4B
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiK1RCK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 12:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiK1RCI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 12:02:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938818342;
        Mon, 28 Nov 2022 09:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93DEAB80E56;
        Mon, 28 Nov 2022 17:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75FC433D6;
        Mon, 28 Nov 2022 17:02:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="onr0UUoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669654922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUuLSVxoi2T3v92DIrHeANXGii/LdTyi4KZ94Wo1K4o=;
        b=onr0UUoiqYUMl4xaK+epdJ8eymzn1X6ZfwmueHjkJ5d1dXgYQ2qPVM/Md7neOaVnG25ImQ
        1AUZyOQqJamWWhFAIGiASlEyqtrzlgWS7p8kwGwTjjDMGNXZ5j5JrFlO8lT2lhKtY1w8pK
        enbXtL/J+l3owR5I/t1s/Y8ZNyBz384=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d1a12627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 17:02:01 +0000 (UTC)
Date:   Mon, 28 Nov 2022 18:01:53 +0100
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
Message-ID: <Y4Tpgb+qJpNad7gG@zx2c4.com>
References: <c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz>
 <Y4Sjk+Fibcsihg4Y@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4Sjk+Fibcsihg4Y@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 01:03:31PM +0100, Jason A. Donenfeld wrote:
> I'll play around and see if I can repro too. Looks like you have a T460?
> I don't have exactly that but maybe something close enough.

I reproduced it, and then tried that commit you linked, and it appears
to fix the problem. So maybe just poke the author/maintainer there and
make sure that gets in somewhere.

Jason
