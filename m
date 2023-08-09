Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFD776CD1
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjHIXYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHIXYr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41526B5;
        Wed,  9 Aug 2023 16:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20EA64C86;
        Wed,  9 Aug 2023 23:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACFAC433C9;
        Wed,  9 Aug 2023 23:24:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NG4x0rNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691623474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4iT0s5K95ORG241rnNoa0zsLLZzx3uln6LKelhWD5fY=;
        b=NG4x0rNuVOzvYaBDxbvlqW+nSJmtO42UxA+v4zlhKATtedLw1DAExyyEjl9NpdcYpB62DH
        PxFPsioWcaZ/Mb/6etShlHH4Q9+nLyT8L9SGchHIQ2szNeiCSOnfju28ZJzqPS8buHtShb
        CGK5OiaMYUIQY1W3an2Mn0NE2iwge3g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c10ff8d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Aug 2023 23:24:34 +0000 (UTC)
Date:   Thu, 10 Aug 2023 01:24:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, jarkko@kernel.org
Subject: Re: AMD fTPM patches for stable
Message-ID: <ZNQgMF7tOrdBMvK7@zx2c4.com>
References: <ZNQGL6XUtc8WFk1e@zx2c4.com>
 <26bcc3ca-0543-43b0-a43b-2d913505e000@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26bcc3ca-0543-43b0-a43b-2d913505e000@amd.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 09, 2023 at 05:22:02PM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/9/2023 4:33 PM, Jason A. Donenfeld wrote:
> > Hey Greg,
> > 
> > There was recently a bit of a snafoo with a maintainer taking the wrong
> > version of a patch and sending that up to Linus. That patch had
> > incorrect stable@ annotations and had a bug in it. That bug was fixed
> > with a follow up patch. But of course the metadata couldn't be changed
> > easily retroactively.
> > 
> > So I'm emailing to ask you to backport these two patches back to 5.5:
> > 
> > - 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > - cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")
> > 
> > I know the stable@ tag says 6.1+, but the actual right tags from the
> > newer versioned patch that didn't get picked are:
> > 
> > Cc: stable@vger.kernel.org # 5.5+
> > Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
> > Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> > Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> > Reported-by: daniil.stas@posteo.net
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
> > Reported-by: bitlord0xff@gmail.com
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> > Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Let me know if you need any more info.
> > 
> > Thanks,
> > Jason
> 
> So I had a quick try with the backports to see what happens.  6.1.y and 
> 6.4.y apply cleanly no problem.
> 
> However 5.15.y (and presumably 5.5.y) have a variety of issues that I 
> think no longer make it a stable candidate.  I started going down the 
> rabbit hole of dependencies and it's massive unless hand modifications 
> are done.
> 
> Realistically the problem is most severe in 6.1.y because of 
> b006c439d58d.  I don't know it's worth going back any further.

Okay. Your (AMD's) hardware, so I'm fine deferring to your judgement.

Jason
