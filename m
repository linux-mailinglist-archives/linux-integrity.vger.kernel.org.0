Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618A876EB1B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjHCNsb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjHCNsA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 09:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CBA211F;
        Thu,  3 Aug 2023 06:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7119661D99;
        Thu,  3 Aug 2023 13:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F63C433C8;
        Thu,  3 Aug 2023 13:46:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OJRebfLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691070410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgxmWQdd35pAiceUmGoEUjztaUSu8B0Cmt3Acw7F7f8=;
        b=OJRebfLau7fIAA68evzbiRoZUVhvMmbsdySypqXjzHZnigR0aEcwVTuByPVsImmEMM+1Ab
        fjcPa2l0q0qRzFZBfy2FV4cOX6rRe/HHjyVSxUb8p1HhA1xVfrmnLbsEN1vmtrdJlQKC5p
        ss54kYjcSOFK0KgWJoQylAYL5m4/OEA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e35afd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Aug 2023 13:46:49 +0000 (UTC)
Date:   Thu, 3 Aug 2023 15:45:40 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux@dominikbrodowski.net,
        linux-integrity@vger.kernel.org, daniil.stas@posteo.net,
        bitlord0xff@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Disable RNG for all AMD fTPMs
Message-ID: <ZMuvhEwN41qEhY9r@zx2c4.com>
References: <20230802122533.19508-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802122533.19508-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 02, 2023 at 07:25:33AM -0500, Mario Limonciello wrote:
> The TPM RNG functionality is not necessary for entropy when the CPU
> already supports the RDRAND instruction. The TPM RNG functionality
> was previously disabled on a subset of AMD fTPM series, but reports
> continue to show problems on some systems causing stutter root caused
> to TPM RNG functionality.
> 
> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> that claim to have fixed or not. To accomplish this, move the detection
> into part of the TPM CRB registration and add a flag indicating that
> the TPM should opt-out of registration to hwrng.
> 
> Cc: stable@vger.kernel.org # 6.1.y+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")

Users can trigger this by reading from /dev/hwrng, which some userspace
daemons are known to do. So I think the proper fixes tag and stable@
version range actually begins with whenever fTPM support was introduced.

> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Hopefully future AMD hardware won't be broken and we can revisit this.
Until then, LGTM:

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
