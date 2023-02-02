Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B48687E0E
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 13:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjBBM5x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 07:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBBM5t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 07:57:49 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26226C11F;
        Thu,  2 Feb 2023 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1675342664;
        bh=b0+JBu7+hicXZS/ZVb10lf4TBhXVyuFoDEk7dU9kzZU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=F3z58H/Vxe98tjskmvHl2JnlqqmFVq6LnScVUrplDkbVaHFkOjr5DqPQNIRp7+CIo
         aSp20BVPLsyhliD2kwMIXy1RbP+Zf9SqT2iMR7o40pYwwquTcC5QCZJd1hQbIuPqxc
         KjepfFAftyq2FuMYt0ZChd0F3+SWNvcQ9GMUSjVo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A51961280C9A;
        Thu,  2 Feb 2023 07:57:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YBosZ22p1qzS; Thu,  2 Feb 2023 07:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1675342664;
        bh=b0+JBu7+hicXZS/ZVb10lf4TBhXVyuFoDEk7dU9kzZU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=F3z58H/Vxe98tjskmvHl2JnlqqmFVq6LnScVUrplDkbVaHFkOjr5DqPQNIRp7+CIo
         aSp20BVPLsyhliD2kwMIXy1RbP+Zf9SqT2iMR7o40pYwwquTcC5QCZJd1hQbIuPqxc
         KjepfFAftyq2FuMYt0ZChd0F3+SWNvcQ9GMUSjVo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8E09C1280A87;
        Thu,  2 Feb 2023 07:57:43 -0500 (EST)
Message-ID: <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, reach622@mailcuk.com,
        1138267643@qq.com, "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 02 Feb 2023 07:57:37 -0500
In-Reply-To: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
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

On Thu, 2023-02-02 at 11:28 +0100, Linux kernel regression tracking
(Thorsten Leemhuis) wrote:
[...]
> So it's a firmware problem, but apparently one that Linux only
> triggers since 6.1.
> 
> Jason, could the hwrng changes have anything to do with this?
> 
> A bisection really would be helpful, but I guess that is not easy as
> the problem apparently only shows up after some time...

the problem description says the fTPM causes system stutter when it
writes to NVRAM.  Since an fTPM is a proprietary implementation, we
don't know what it does.  The ms TPM implementation definitely doesn't
trigger NV writes on rng requests, but it is plausible this fTPM does
... particularly if they have a time based input to the DRNG.  Even if
this speculation is true, there's not much we can do about it, since
it's a firmware bug and AMD should have delivered the BIOS update that
fixes it.

The way to test this would be to set the config option

CONFIG_HW_RANDOM_TPM=n

and see if the stutter goes away.  I suppose if someone could quantify
the bad bioses, we could warn, but that's about it.

James

