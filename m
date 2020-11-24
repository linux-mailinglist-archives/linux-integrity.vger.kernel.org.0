Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B852C2FBA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbgKXSKZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Nov 2020 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404318AbgKXSKZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Nov 2020 13:10:25 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AAFC0613D6;
        Tue, 24 Nov 2020 10:10:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 823D01280043;
        Tue, 24 Nov 2020 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606241423;
        bh=9bNSodWP10rYEh+2Q0UUXuz2PN4QPQBYDPPj4mCWa+o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CNoT1w+r2SuCu3uIdlUtolKGNg832mPiE0xTZFk/7dj+nZ4t/BN8r5NhverRvwBBE
         xYLHXBI61oHbw8+Ws2fUbtrN786L1h/fLhiPShDbiRG1OffuLsxfW8fb7eAoz1W67w
         0QgYUAG/8B2Ghz6h5veYhsJiTpG+oTJfefY4Og20=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LwrDD7nnCZmy; Tue, 24 Nov 2020 10:10:23 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EBA171280021;
        Tue, 24 Nov 2020 10:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606241423;
        bh=9bNSodWP10rYEh+2Q0UUXuz2PN4QPQBYDPPj4mCWa+o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CNoT1w+r2SuCu3uIdlUtolKGNg832mPiE0xTZFk/7dj+nZ4t/BN8r5NhverRvwBBE
         xYLHXBI61oHbw8+Ws2fUbtrN786L1h/fLhiPShDbiRG1OffuLsxfW8fb7eAoz1W67w
         0QgYUAG/8B2Ghz6h5veYhsJiTpG+oTJfefY4Og20=
Message-ID: <67628c88a9ddc85d9957c1847514afe24a6fcebf.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Tue, 24 Nov 2020 10:10:21 -0800
In-Reply-To: <871rgiod53.fsf@redhat.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
         <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
         <87d009c0pn.fsf@redhat.com> <20201124032623.GA40007@kernel.org>
         <871rgiod53.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-11-24 at 10:52 -0700, Jerry Snitselaar wrote:
> Before diving further into that though, does anyone else have an
> opinion on ripping out the irq code, and just using polling? We've
> been only polling since 2015 anyways.

Well only a biased one, obviously: polling causes large amounts of busy
waiting, which is a waste of CPU resources and does increase the time
it takes us to do TPM operations ... not a concern if you're doing long
computation ones, like signatures, but it is a problem for short
operations like bulk updates of PCRs.  The other potential issue, as we
saw with atmel is that if you prod the chip too often (which you have
to do with polling) you risk upsetting it.  We've spent ages trying to
tune the polling parameters to balance reduction of busy wait with chip
upset and still, apparently, not quite got it right.  If the TPM has a
functioning IRQ then it gets us out of the whole polling mess entirely.
The big question is how many chips that report an IRQ actually have a
malfunctioning one?

James



