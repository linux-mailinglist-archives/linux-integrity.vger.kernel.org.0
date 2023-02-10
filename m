Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A670269160D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 02:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBJBI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 20:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBJBI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 20:08:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8632007C;
        Thu,  9 Feb 2023 17:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8254B82399;
        Fri, 10 Feb 2023 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9524DC4339B;
        Fri, 10 Feb 2023 01:08:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AKVCFBcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675991300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGifqOoR9bZo8/vQwUBuPjj6tQBc+UX+xXtpTfNPi00=;
        b=AKVCFBcCRxl5vn5Sv8oY4GoA7mDM8xAJUkPanrttxiBdkce2ec81CZPbBinmB+bERwwcoG
        IeIqlJK99DbEr3v9Qd7yG1MyjbEB0TdH7pgrN+MvI8FxguOjVzrVgS1B8rlmi57NoZJQkX
        PmG/sdP/rID4Cid29hQpYnsnATY2qn4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9a095af6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 10 Feb 2023 01:08:19 +0000 (UTC)
Date:   Fri, 10 Feb 2023 02:08:17 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     regressions@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH RFC] tpm: disable hwrng for known-defective AMD RNGs
Message-ID: <Y+WZAV10cp7zKo1R@zx2c4.com>
References: <20230209153120.261904-1-Jason@zx2c4.com>
 <Y+WVzAt/ZCBdLEkx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+WVzAt/ZCBdLEkx@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 10, 2023 at 02:54:36AM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 09, 2023 at 12:31:20PM -0300, Jason A. Donenfeld wrote:
> > Do not register a hwrng for certain AMD TPMs that are running an old
> 
> What do you mean by "certain AMD TPMs"?
> 
> > known-buggy revision. Do this by probing the TPM2_PT_MANUFACTURER,
> 
> Which revision?
> 
> > TPM2_PT_FIRMWARE_VERSION_1, and TPM2_PT_FIRMWARE_VERSION_2 properties,
> > and failing when an "AMD"-manufactured TPM2 chip is below a threshold.
> 
> What do you mean by "threshold"?
> 
> This also lacks desription of:
> 
> 1. What kind of changes are done.
> 2. Why do they they are reasonable.

YEP! And guess what? It doesn't matter at all one bit. Why? Because
Mario, the AMD engineer working on this, is tuned into the goal here and
he's the one who will be reworking this PoC draft into a real non-RFC
commit. We've been discussing this over on the bugzilla Thorsten sent to
you on Feb 2: https://bugzilla.kernel.org/show_bug.cgi?id=216989

> > BROKEN BROKEN BROKEN - I just made the version numbers up and haven't
> > tested this because I don't actually have hardware for it. I'm posting
> > this so that Mario can take over its development and submit a v2 himself
> > once he has confirmed the versioning info from inside AMD.
> 
> Is this paragraph meant for commit log?

Obviously not; did you read it?

Jason
