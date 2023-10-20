Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD37D103B
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbjJTNFt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377137AbjJTNFs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 09:05:48 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351089F
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697807145;
        bh=GG6kCDaGMeh4F+FFX1xDTzUOYVltEmnBZEhtJCbzonA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Gh+lhBGqGTRRO0VUTMOgyKEMdsiGCLc2rgi4Do6ZECIXVf6JoetiGGt8MmT4dpjy2
         0qYldP1LPHKCin4l5Tq5BoR4dgKEvGtSu4gCOaepJzddLGfWZZy1kO5pS1x6B78X2z
         7mE4oWEb/fc9pVvrFk+XxNHNOH+F+01SOe+tFPLA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 19C5C12873D6;
        Fri, 20 Oct 2023 09:05:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id rM7INElx8vmh; Fri, 20 Oct 2023 09:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697807144;
        bh=GG6kCDaGMeh4F+FFX1xDTzUOYVltEmnBZEhtJCbzonA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PRNQ6/Fq2oqq8wSqE17AsxUNGPpNjJnC3duSVyh9FbQ0jFIcp3+1LvFw5lFQN7dR3
         qsMyoIm9tjSuTzsD0YjCFwJxxVnDqz28vN/WQQzpnXRlo6JcfnByWeLRUg9yzekc3Y
         tIbyY+9sQi0ID0S0yRtCdzojD/AbsBYeUISeIUuU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 590801287299;
        Fri, 20 Oct 2023 09:05:44 -0400 (EDT)
Message-ID: <17c803dfb04505e35d4bdd831ef5c63ccb312e32.camel@HansenPartnership.com>
Subject: Re: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andreas.Fuchs@infineon.com, juergen_repp@web.de,
        linux-integrity@vger.kernel.org
Cc:     christian.plappert@sit.fraunhofer.de
Date:   Fri, 20 Oct 2023 09:05:41 -0400
In-Reply-To: <23488b27daae488e97323ff07f52db6f@infineon.com>
References: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
         <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
         <23488b27daae488e97323ff07f52db6f@infineon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-10-19 at 16:16 +0000, Andreas.Fuchs@infineon.com wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com> 
> > On Thu, 2023-10-19 at 16:05 +0200, Juergen Repp wrote:
> > > There is an issue related to this problem on github for tpm2-tss:
> > > https://github.com/tpm2-software/tpm2-tss/issues/2691 (/dev/tpmrm
> > > 0 was 
> > > used) The error did occur after abbout 200 signing operations
> > > when a second session was opened by a second process at the same
> > > time.
> > > Kernel log:
> > > [ 401.923826] tpm tpm0: tpm2_save_context: failed with a TPM
> > > error 0x0901
> > > [  401.925049] tpm tpm0: A TPM error (459) occurred flushing
> > > context
> > 
> > I'm afraid that's a known problem with the Intel TSS: it saves the
> > context, which will cause a gapping error if you keep it saved
> > while doing other context requiring operations.  The solutions are
> > either to implement degapping in the kernel or persuade the Intel
> > TSS not to save contexts unnecessarily.
> 
> This is independent of the TSS used.
> When you have one long lasting session being used seldomly (i.e. in
> Application A) and another session or multiple sessions being used
> frequently (i.e. in Application B), then you will hit this problem at
> some point.
> As such ANY resource manager (in kernel or outside) needs to
> implement session ungaping, otherwise it will fail such scenarios.

That's true, but in real life the use of sessions tends to be short
lived and not context saved (usually short enough that this doesn't
even cause a context save inside the kernel rm).  You can see this in
the TPM code in gnupg, or any of the engines/providers. That's not to
say we shouldn't do degapping but, because most common uses in the
field don't need it, there's been little pressure on anyone to actually
write the code.

> James; on a different note:
> Any contextSaves by an application or middleware will just make this
> problem appear earlier but the Kernel's RM will do the contextSave of
> A's sessions anyways.
> You can easily make the same problem appear in ANY TSS and you know
> this very well.
> So, please stop bad mouthing "not your TSS"es.

Well, OK, how about this: there is a unique feature of the tpm tools
allied with the Intel TSS in that they any use of sessions always seem
to induce a session context save which can lead to a gapping problem.

James



