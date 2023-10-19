Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EA7CFDA0
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Oct 2023 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbjJSPNn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Oct 2023 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbjJSPNn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2023 11:13:43 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EFC11B
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697728421;
        bh=KC47Waj/YdWhuSt4A0ibwYS6wVOhntam6tIaqUOBhho=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rzwc/inAG25a0vNzeSvIFKbl54bCbBNdKEbp//KMcxUeO7bBO81rbPESskjZXZ3MP
         7g0jm+n6TpiS80t976cBVI+yh9hGb2IMZ9cbXSIKoLDYPO3v66x5tKhd94OTAc10L0
         C8rAGVNrv0KJ7vy7k010BoURhn7OVjpRpAMl03E4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2307612873DC;
        Thu, 19 Oct 2023 11:13:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id MoBN4RvCCHVT; Thu, 19 Oct 2023 11:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697728421;
        bh=KC47Waj/YdWhuSt4A0ibwYS6wVOhntam6tIaqUOBhho=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rzwc/inAG25a0vNzeSvIFKbl54bCbBNdKEbp//KMcxUeO7bBO81rbPESskjZXZ3MP
         7g0jm+n6TpiS80t976cBVI+yh9hGb2IMZ9cbXSIKoLDYPO3v66x5tKhd94OTAc10L0
         C8rAGVNrv0KJ7vy7k010BoURhn7OVjpRpAMl03E4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8F57C12873D9;
        Thu, 19 Oct 2023 11:13:40 -0400 (EDT)
Message-ID: <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
Subject: Re: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Juergen Repp <juergen_repp@web.de>, linux-integrity@vger.kernel.org
Cc:     Andreas Fuchs <andreas.fuchs@infineon.com>,
        "Plappert, Christian" <christian.plappert@sit.fraunhofer.de>
Date:   Thu, 19 Oct 2023 11:13:38 -0400
In-Reply-To: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
References: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-10-19 at 16:05 +0200, Juergen Repp wrote:
> There is an issue related to this problem on github for tpm2-tss:
> https://github.com/tpm2-software/tpm2-tss/issues/2691 (/dev/tpmrm0
> was used)
> The error did occur after abbout 200 signing operations when a second
> session was opened by a second process at the same time.
> Kernel log:
> [ 401.923826] tpm tpm0: tpm2_save_context: failed with a TPM error
> 0x0901
> [  401.925049] tpm tpm0: A TPM error (459) occurred flushing context

I'm afraid that's a known problem with the Intel TSS: it saves the
context, which will cause a gapping error if you keep it saved while
doing other context requiring operations.  The solutions are either to
implement degapping in the kernel or persuade the Intel TSS not to save
contexts unnecessarily.

James

