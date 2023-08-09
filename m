Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B33776B03
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Aug 2023 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjHIVdp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjHIVdp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 17:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F811718;
        Wed,  9 Aug 2023 14:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE35964A6C;
        Wed,  9 Aug 2023 21:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC3CC433C7;
        Wed,  9 Aug 2023 21:33:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XqrQjeMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691616819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0eKTcHstXKpJm61TCqIQK1VlktzWVHthhysULNzNQ+E=;
        b=XqrQjeMeCcQ2go+IEgGvwHicLoEmxAxRRDihJqKaNXTJ3ENvpzTbl1p0bzgo9K64UV3qax
        Dok2+TENTGKwCUr3dFCCmWsHd+qpfbC9El6vfPbvQ/lB0VETdf/ASS8YdVnppCPU+QJn8b
        KaE/IM1aM1MM3QUJG7i+1My3xXqLMUY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d3327f23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Aug 2023 21:33:39 +0000 (UTC)
Date:   Wed, 9 Aug 2023 23:33:35 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     mario.limonciello@amd.com, jarkko@kernel.org
Subject: AMD fTPM patches for stable
Message-ID: <ZNQGL6XUtc8WFk1e@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey Greg,

There was recently a bit of a snafoo with a maintainer taking the wrong
version of a patch and sending that up to Linus. That patch had
incorrect stable@ annotations and had a bug in it. That bug was fixed
with a follow up patch. But of course the metadata couldn't be changed
easily retroactively.

So I'm emailing to ask you to backport these two patches back to 5.5:

- 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
- cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")

I know the stable@ tag says 6.1+, but the actual right tags from the
newer versioned patch that didn't get picked are:

Cc: stable@vger.kernel.org # 5.5+
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
Reported-by: daniil.stas@posteo.net
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
Reported-by: bitlord0xff@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Let me know if you need any more info.

Thanks,
Jason
