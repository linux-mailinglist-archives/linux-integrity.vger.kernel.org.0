Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E118653FA58
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiFGJwB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiFGJvy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 05:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BCE8B98
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jun 2022 02:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74FBA611DE
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jun 2022 09:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7EC385A5;
        Tue,  7 Jun 2022 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654595396;
        bh=oNic5a98tpP9ffjsjNPqtEoYrMrm04L1CCrj0GC9M3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrdtkhej+RknW/GIQaDfHaWGD+SMNtxQ3P0ZqT8PNAIbobLwXz9lld0aYjTwMfknP
         zWvrNqdeq8U70m4LtvuCN2CzUMUe0pvZCCvrecp2WKbRZB67GNm799Dm8MPxBBTWJV
         4u621YkVSOCMbB3JGnpQhxV8Ot4jGMCQ2ttqmRSqzeDAfBoZ+uuqcRJ7XPF8czqmMq
         b8AhCL76thJTZ0wiI3URutdkhrdDNuHKT9OTw3HS4OcpzXnMql5ggCP7505CLGUx5q
         bKSIqxQ9evsuCAOCI0wVooc3aICg/319BbklrUxJ7nzbkzAtQXYqmICWK4f12/J9VC
         d7Fh1vjzUkhzg==
Date:   Tue, 7 Jun 2022 12:48:01 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     david.safford@gmail.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH] trusted-keys-fix-migratable-logic
Message-ID: <Yp8e0X+jkg3HWSA0@iki.fi>
References: <874177b3b34b10679829dbf011e5bde7f37a4c9c.camel@gmail.com>
 <1eda7b47-1f9f-9188-efbe-e135326d7585@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eda7b47-1f9f-9188-efbe-e135326d7585@pengutronix.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 07, 2022 at 08:15:49AM +0200, Ahmad Fatoum wrote:
> Hello David,
> 
> On 03.06.22 15:28, david.safford@gmail.com wrote:
> > When creating (sealing) a new trusted key, migratable
> > trusted keys have the FIXED_TPM and FIXED_PERM attributes
> > set, and non-migratable keys don't. This is backwards, and
> > also causes creation to fail when creating a migratable key
> > under a migratable parent. (The TPM thinks you are trying to
> > seal a non-migratable blob under a migratable parent.)
> > 
> > The following simple patch fixes the logic, and has been
> > tested for all four combinations of migratable and non-migratable
> > trusted keys and parent storage keys. With this logic, you will
> > get a proper failure if you try to create a non-migratable 
> > trusted key under a migratable parent storage key, and all other
> > combinations work correctly.
> > 
> > david safford
> 
> Thanks for your patch. It looks sensible, but needs some work to
> be aligned to the kernel patch guidelines, documented here:
> Documentation/process/submitting-patches.rst
> 
> What I noticed in particular:
> 
>   - Your Signed-off-by is missing
>   - Your patch title needs alignment to others in the revision history,
>     you could change it e.g. "KEYS: trusted: tpm2: Fix migratable logic"
>   - The To:/Cc: list is incomplete. Patches to this file are normally
>     merged via Jarkko's tree. get_maintainers.pl will produce a full list
>     of people and mailing lists to copy.
> 
> Looking forward to your v2.

The code change looks legit but it also needs to have this:

Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")


> Cheers,
> Ahmad

BR, Jarkko
