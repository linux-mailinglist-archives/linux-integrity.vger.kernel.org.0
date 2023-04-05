Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E36D8716
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Apr 2023 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjDETmP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Apr 2023 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjDETmO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Apr 2023 15:42:14 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B97D9F;
        Wed,  5 Apr 2023 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680723673;
        bh=WwuIsKsRnrJXpbGBbSebam2VU6JJdv+oDgyM0sUtqsk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=irLWqNk7bsFN7ntwyOQdzgY+DX1YoxV6cOD+CdSO9nKK07Ds3TqSqdjqHsEm1bFK1
         4fpsr+4ibkufxfmd+pLA2Pbi6C5hTNg1N+d14peenAoyXu4mi0P+8PyZ09YvmCqFuR
         BbiNkmmlFHd2Zlm8H4vq9bysn8uxfgWIYPQZtUDE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CDBAF1281873;
        Wed,  5 Apr 2023 15:41:13 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TXq4f9sDP_mt; Wed,  5 Apr 2023 15:41:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680723673;
        bh=WwuIsKsRnrJXpbGBbSebam2VU6JJdv+oDgyM0sUtqsk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=irLWqNk7bsFN7ntwyOQdzgY+DX1YoxV6cOD+CdSO9nKK07Ds3TqSqdjqHsEm1bFK1
         4fpsr+4ibkufxfmd+pLA2Pbi6C5hTNg1N+d14peenAoyXu4mi0P+8PyZ09YvmCqFuR
         BbiNkmmlFHd2Zlm8H4vq9bysn8uxfgWIYPQZtUDE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2D0A71281826;
        Wed,  5 Apr 2023 15:41:13 -0400 (EDT)
Message-ID: <a94021ce2b2a9fc74ad1609f114f62c7b9f279d5.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 05 Apr 2023 15:41:11 -0400
In-Reply-To: <CAFftDdpbJ1Y7tupzPicXbX352Xk0zE-gSShg1WXGyTFJ22mdbA@mail.gmail.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <CAFftDdpbJ1Y7tupzPicXbX352Xk0zE-gSShg1WXGyTFJ22mdbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-04-05 at 13:39 -0500, William Roberts wrote:
> On Mon, Apr 3, 2023 at 4:44 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > The most insidious interposer attack of all is a reset attack:
> > since the interposer has access to the TPM bus, it can assert the
> > TPM reset line any time it wants.  When a TPM resets it mostly
> > comes back in the same state except that all the PCRs are reset to
> > their initial values.
> > Controlling the reset line allows the interposer to change the PCR
> > state after the fact by resetting the TPM and then replaying PCR
> > extends to get the PCRs into a valid state to release secrets, so
> > even if an attack event was recorded, the record is erased.  This
> > reset attack violates the fundamental princible of non-
> > repudiability of TPM logs.  Defeating the reset attack involves
> > tying all TPM operations within the kernel to a property which will
> > change detectably if the TPM is reset.  For that reason, we tie all
> > TPM sessions to the null hierarchy we obtain at start of day and
> > whose seed changes on every reset.
> 
> Rather than doing this, wouldn't the session be flushed from the TPM
> on reset and thus subsequent commands using the session and session
> key fail?

That would happen only if we kept a context saved session, which we
can't because the current session manager doesn't do de-gapping.  To
get around this we start a new, short lived, session for most
operations.

There has been a thought that it would be faster if we did context save
a session to keep re-using it, so adding de-gapping is on the list
somewhere, it's just not near the top yet.

> If that's true, couldn't we just pin the trust to an existing trusted
> key that we have the name of and move on? The kernel would know that
> something happened when session protections started failing without
> the complexity and time of generating a key in the NULL hierarchy and
> certifying it.

If the goal is to check not only the kernel but also the boot
components (like OVMF/EDK2), then we need a handoff protocol.  The
beauty of the NULL seed is the name is a nice short thing to handoff. 
If we relied on sessions, we'd have to hand off a whole context saved
session and all its nonces, which is a bit of a security risk.

James

