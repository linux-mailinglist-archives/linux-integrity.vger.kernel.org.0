Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B492E776B06
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Aug 2023 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHIVfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVfp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 17:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E71718
        for <linux-integrity@vger.kernel.org>; Wed,  9 Aug 2023 14:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCDB63B46
        for <linux-integrity@vger.kernel.org>; Wed,  9 Aug 2023 21:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F764C433C8;
        Wed,  9 Aug 2023 21:35:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lk3Kc5vL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691616941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmOexc8eZVUX7tFhjIt8c+H/1Pas6Fx2yaPNE9dN3TQ=;
        b=lk3Kc5vLp4IW0tHUEfw38eWKUKNQtdI8FI6uVfs4gHCMmkZoB9fDogVA0LzWu1YPbvzdSl
        VZMnOn8Zrup1K/75ebleGGHA2fe5gHABu4cJ1GebGIhu9pgv9Oqvz5+jWc2U2OQHeTS/1z
        /9mHz+AvQPnzFhVigxYSWzciB+j95oE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ee57af3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Aug 2023 21:35:41 +0000 (UTC)
Date:   Wed, 9 Aug 2023 23:35:41 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZNQGrXLMXLh+0Wmr@zx2c4.com>
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
 <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
 <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
 <ZNJ5IZjpOdOBFFja@zx2c4.com>
 <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 09, 2023 at 10:06:31AM -0700, Linus Torvalds wrote:
> On Tue, 8 Aug 2023 at 10:19, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Alright, looks like Mario took care of that:
> 
> Ok, I just took that patch directly, so that we can close this issue.
> 
> It's
> 
>     cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")
> 
> in my tree, and I'll push out shortly after it's gone through my trivial tests.

Thanks. Sent onward to stable:
https://lore.kernel.org/stable/ZNQGL6XUtc8WFk1e@zx2c4.com/

Jason
