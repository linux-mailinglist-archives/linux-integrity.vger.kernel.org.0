Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318B51FECF
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiEINvQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiEINu6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 09:50:58 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74B195925
        for <linux-integrity@vger.kernel.org>; Mon,  9 May 2022 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652104024;
  x=1683640024;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=F8+BKYzCZC7tK5PepGJ3v1I84uxxgGXxY4XgewLZNSI=;
  b=MzHitQoapUJ5D0/6nriGTMPAcFHVyvIewWNCBljUoAK9br37CnBHVZCw
   Ry+RTbHrljBtSN7SStB1WjP4zKlfIrATrP7ZjAKAIlxQqNpiKAhHb6eIF
   Y/n2FOdAE6fkP5aW3QaDpR/3ZlSmendBWK873BUSzmw6GHAJoO6rgHzKj
   8Uze5yUFZPLlc0wlVjeayAM/nY7e4r1A8D0e9MIAnTGqg/v3mzQ/OwxIn
   sxBfE1iBw7w7d1XNYJCVM9zfPzmCDhdS72hV43jLpxrq24CavDGJRW6dW
   XXUPBJA7T3qtQr3sS0ohDxTIzscJO1SjZqJc6xYMR1RymeqjWsCUvNJCf
   g==;
Date:   Mon, 9 May 2022 15:47:01 +0200
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YnkbVTDnrVD/FfjY@axis.com>
References: <YmbDpMUtUK/NrXIY@axis.com>
 <20220506120041.228769-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506120041.228769-1-stefan.mahnke-hartmann@infineon.com>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 06, 2022 at 02:00:41PM +0200, Stefan Mahnke-Hartmann wrote:
> > On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, 2022-04-25 at 12:25 +0200, Mårten Lindahl wrote:
> > > > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > > > TPM2 modules") it was said that:
> > > > 
> > > > "If the TPM is in Failure mode, it will successfully respond to both
> > > > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > > > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > > > is in Failure mode."
> > > > 
> > > > But a check was never added in the commit when calling
> > > > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > > > This commit corrects this by adding a check.
> > > > 
> > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > I think this should actually have the fixes tag. It's a regression,
> > > right? I can add it.
> >
> > Hi Jarkko!
> >
> > Thank you. Yes it should have a fixes tag for the mentioned commit.
> >
> > Kind regards
> > Mårten
> >
> > > 
> > > BR, Jarkko
> 
> Hi Mårten,
> 
> your patch introduces redundant code. The code block of the if below
> contains exactly the same code.

Hi!

The checks are for different cases. The TPM may sucessfully pass
startup and selftest but still be in failure mode. In this case only
some capabilities are required to work (Trusted Platform Module
Library Specification, Family "2.0", Level 00, Revision 01.59 –
November 2019 Part 3, page 348 and 349), but other capabilities may
fail. So in order for userspace to handle the TPM, this check is
needed.

The already existing check (below the out label) is specifically for
upgrade mode.

Yes the code blocks looks very similar, though the print is different.

> 
> Additionally, your patch masks a bug (derefencing uninitialized
> memory). I will send a patch set shortly.

Masking bugs are never good. Please send a patch for this.

Kind regards
Mårten

> 
> Regards
> Stefan
