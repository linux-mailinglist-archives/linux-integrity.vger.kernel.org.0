Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE652C42B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiERUVr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbiERUVo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 16:21:44 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C43941B7;
        Wed, 18 May 2022 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652905301;
        bh=y0A2BWRq1McAJFUfsdLLvi8h6nC7UBpUcvXL7ZJHL/0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cBXbx8If6KIbk5ozgnpmwWIpOe3UOW3PN+5WsojyQr9qRzy+rjB9R5zdLAVJ45j9I
         N8ZVWwwpj4AbN5y5TmhgLV3wh+J+A6i2+Oj7db7ToFiwYcV39F6etwg3vjN4wXMlFZ
         gtJI8M3QVU6bi5zVNnQgKTUThhshtXF5bZbAppRI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 71F301288C2B;
        Wed, 18 May 2022 16:21:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SPuWgJSoP4Gq; Wed, 18 May 2022 16:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652905301;
        bh=y0A2BWRq1McAJFUfsdLLvi8h6nC7UBpUcvXL7ZJHL/0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cBXbx8If6KIbk5ozgnpmwWIpOe3UOW3PN+5WsojyQr9qRzy+rjB9R5zdLAVJ45j9I
         N8ZVWwwpj4AbN5y5TmhgLV3wh+J+A6i2+Oj7db7ToFiwYcV39F6etwg3vjN4wXMlFZ
         gtJI8M3QVU6bi5zVNnQgKTUThhshtXF5bZbAppRI=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A1C6C1287E83;
        Wed, 18 May 2022 16:21:40 -0400 (EDT)
Message-ID: <6df9f7af232bbe10a570e426c2bef0e673ab63fe.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Wed, 18 May 2022 16:21:39 -0400
In-Reply-To: <e5327191-50c5-85b5-6c01-3f43cffc142b@linux.vnet.ibm.com>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
         <YnvTSqRgYkWu0qgp@kernel.org>
         <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
         <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
         <YoKQchfJ//FUws7i@kernel.org>
         <e5327191-50c5-85b5-6c01-3f43cffc142b@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-05-18 at 15:26 -0400, Nayna wrote:
> On 5/16/22 13:57, Jarkko Sakkinen wrote:
> > On Thu, May 12, 2022 at 08:32:55AM -0400, James Bottomley wrote:
> > > On Thu, 2022-05-12 at 08:21 -0400, Mimi Zohar wrote:
[...]
> > > > This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep()
> > > > value as max delay").    Are you experiencing TPM issues that
> > > > require it?
> > > I am:
> > > 
> > > https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/
> > > 
> > > I'm about 24h into a soak test of the patch with no TPM failure
> > > so far.  I think it probably needs to run another 24h just to be
> > > sure, but it does seem the theory is sound (my TPM gets annoyed
> > > by being poked too soon) so reverting 5ef924d9e2e8 looks to be
> > > the correct action.  The only other ways I've found to fix this
> > > are either revert the usleep_range patch altogether or increase
> > > the timings:
> > > 
> > > https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/
> > > 
> > > Which obviously pushes the min past whatever issue my TPM is
> > > having even with 5ef924d9e2e8 applied.
> > > 
> > > Given that even the commit message for 5ef924d9e2e8 admits it
> > > only shaves about 12% off the TPM response time, that would
> > > appear to be an optimization too far if it's going to cause some
> > > TPMs to fail.
> > > 
> > > James
> > What if TPM started with the timings as they are now and use the
> > "reverted" timings if coming up too early?  The question here is
> > though,  is such complexity worth of anything or should we just
> > revert and do nothing else.
> 
> TCG Specification(TCG PC Client Device Driver Design Principles,
> Section  10), says - General control timeouts, denoted as TIMEOUT_A
> (A), TIMEOUT_B (B), TIMEOUT_C (C) and TIMEOUT_D (D), are the maximum
> waiting time from a certain control operation from the DD until the
> TPM shows the expected status change.

Actually, this is nothing to do with the TIMEOUTS_A-D: those are the
maximum times before a command should complete.  This is the minimum
time we should wait between pokes of the TPM to see if it is ready. 
Usually the use case is:

while (read device status gives not ready)
   tpm_msleep(something)

The tpm_msleep gives up CPU control (to prevent huge amounts of busy
waiting) but before 424eaf910c32 ("tpm: reduce polling time to usecs
for even finer granularity") we would sleep for an entire tick (time
taken to make the process runnable) before the next poll, and since
most TPM commands don't return immediately, that was a gate on how fast
you could do simple TPM operations (like PCR extend).

As far as I know, no TCG spec gives any details of the minimum wait
time between poll cycles, so this is really something the manufacturer
has to tell us.

Just for completeness, my soak test did run to completion, but my TPM
has since failed and dropped off the bus, so simply reverting this
patch (5ef924d9e2e8) isn't sufficient to fully fix my problem.

James


