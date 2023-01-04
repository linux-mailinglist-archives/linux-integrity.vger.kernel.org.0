Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D965CF40
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjADJLk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 04:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbjADJLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 04:11:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CF9DC;
        Wed,  4 Jan 2023 01:11:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g1so33463339edj.8;
        Wed, 04 Jan 2023 01:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwljbFY9Lfjs8WqYNdIuIbwZd1SqYR0YdLKGV8vB66I=;
        b=BLHa+qhetCVIaxZ2fzWLFOSv3sXntflfxV9QOIndkE6ywBBR19tqJHGiYB4lqLjMXR
         7xaQSvuPe4qMZ89saXEr8cwls4o+8WC2oxDOeM592v31F8qq9Q+3l3DEgjh16d1zyngT
         qsPG3QgGoKOGaXbuMY36Dzue08wDJIJGLTp+hLsNvrhi8eKWsjjbH/4ZgCR2a8iTmSB9
         /PmCXya7qZ4bWjEoN08GBX+V8J1/WJLz88ldudVNIWUbo2biFgFaHQLcSy8IQcNew2wD
         Cur3zHsjL2DOXfuqYRZqh3T5vRnOXDnwyTyGQUVN7vvSOU2E6ZQOUshcFuYQqB8ZqXjr
         ucwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwljbFY9Lfjs8WqYNdIuIbwZd1SqYR0YdLKGV8vB66I=;
        b=OzT7sCoJXZaK6tUVo3Kig9u8gu/roCxtYcS8nPKAqembpWZ3TlsBRRXP7C9oqEr1hA
         CtC299hk1Ha7FquGU/KHDe//hCIQvAOq33oYRl+5qfVhoOfNLO0CX1drFY2Ib3J4TMxn
         MSB0Zt2jtPqUAPlZh8rmSDaHesBbXG6IjrRhZ7IlTGSclwjdk7s93eHmAQb97hSR0BPl
         k4x14yKa0OPSxnw9yWy/2t53o18PzXiexg9+fXlDK2NcdzJnWyiKIYx+1eB8qBUxbbT2
         KYLCQK9InSvZrfv3fK2fiG2uzXCoJbCpPHPr7Lu/gxVkKrwb+5tujWTYULm8/ySwXIxR
         ZCjQ==
X-Gm-Message-State: AFqh2koy+nQbIWRS1MWhvzR46tnKAc/fpWklbTHfvd9HYjh9cre12BQa
        OFqqAOZoNOU3sH6QA9Kqk2g=
X-Google-Smtp-Source: AMrXdXvwM+6Mbb80KUkrXkmtrQ9IxQGbERV+Bjh6Dt31qvk4eaOptGabK546Ivunu0L1ByeYK6Exdw==
X-Received: by 2002:a05:6402:538f:b0:45c:835c:1ebb with SMTP id ew15-20020a056402538f00b0045c835c1ebbmr49094439edb.9.1672823474738;
        Wed, 04 Jan 2023 01:11:14 -0800 (PST)
Received: from gmail.com (cpe90-146-206-21.liwest.at. [90.146.206.21])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b0046b00a9eeb5sm14571437edh.49.2023.01.04.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:11:14 -0800 (PST)
Date:   Wed, 4 Jan 2023 10:10:10 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Message-ID: <Y7VCcgHUC6JtnO2b@gmail.com>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 28, 2022 at 09:22:56PM +0100, Vlastimil Babka wrote:
> Ugh, while the problem [1] was fixed in 6.1, it's now happening again on
> the T460 with 6.2-rc1. Except I didn't see any oops message or
> "tpm_try_transmit" error this time. The first indication of a problem is
> this during a resume from suspend to ram:
> 
> tpm tpm0: A TPM error (28) occurred continue selftest
> 
> and then periodically 
> 
> tpm tpm0: A TPM error (28) occurred attempting get random
> 
> and further suspend to ram attempts fail:
> 
> tpm tpm0: Error (28) sending savestate before suspend
> tpm_tis 00:08: PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns 28
> tpm_tis 00:08: PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 28
> tpm_tis 00:08: PM: failed to suspend: error 28
> PM: Some devices failed to suspend, or early wake event detected
> 
> Unfortunately I doubt I would be able to bisect it as any "good" kernel might
> be a false negative.
> 
> [1] https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
> 
> #regzbot introduced: v6.1..v6.2-rc1

I see almost exactly the same symptoms with v6.1.1 on a T460s.
No "tpm_try_transmit" etc. The only difference is that I get 0x20 instead
of 0x10 (that's probably immaterial).

Also, I have this line immediately before the tpm error.

	psmouse serio2: Failed to disable mouse on synaptics-pt/serio0
	tpm tpm0: Error (28) sending savestate before suspend
	[...]

In the past I have had similar problems on another Thinkpad where a touchpad
driver prevented suspend.  Unloading the module (I think psmouse, not sure)
helped. I haven't tried this here since it only happens sometimes.
