Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991CC551FEA
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jun 2022 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiFTPLG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jun 2022 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243163AbiFTPKp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jun 2022 11:10:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB97193F0
        for <linux-integrity@vger.kernel.org>; Mon, 20 Jun 2022 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655737156;
  x=1687273156;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=sIiRPEXuEKZy+WDb8S9OksRnjxpUxWxglcFurlwlvH8=;
  b=mpfp2DHMFxAyNu9no0ZUZjKZIx5ThcEwmdOksRkt9WmqgEKQGVlTnkEk
   96tkONpWDvL8NHb2ZMqxiZy2d9QVRqnkwUOl3ZulSMCg+ibFmtHrzowPv
   WBWKS6yJlEdBR/pog+9VK5NePGJZm5jEnnQ3F5ppTBYydaUmBU3hUIFWJ
   c5qbeZMkP7rwxsOS1HpqPWzFXH26BdGtaZmiuTPRWD+C/HbqiL5SDXmZb
   W5jrxokWkNVJ2Rj1LgtQM9LVpX5oa0Rpa7hq96BfBzy3F5PgpuxhxRyQu
   gAwOH2a1TdH1jlcJdeYrDS7BfcoyUauCPWsqEA48PtxlaTK6EnCk2KH+b
   g==;
Date:   Mon, 20 Jun 2022 16:59:14 +0200
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YrCLQnVxFU9kvHQh@axis.com>
References: <20220425102552.663069-1-marten.lindahl@axis.com>
 <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
 <YmbDpMUtUK/NrXIY@axis.com>
 <YpTiOdC2W6PaoI2R@axis.com>
 <faf0156e6f735b2d7d793fbf48ae4c6a108e8eb1.camel@kernel.org>
 <YpibzQBKih7QRrei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpibzQBKih7QRrei@kernel.org>
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

On Thu, Jun 02, 2022 at 01:15:25PM +0200, Jarkko Sakkinen wrote:
> On Wed, Jun 01, 2022 at 05:05:08AM +0300, Jarkko Sakkinen wrote:
> > On Mon, 2022-05-30 at 17:26 +0200, Marten Lindahl wrote:
> > > On Mon, Apr 25, 2022 at 05:52:04PM +0200, Mårten Lindahl wrote:
> > > > On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> > > > > On Mon, 2022-04-25 at 12:25 +0200, Mårten Lindahl wrote:
> > > > > > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > > > > > TPM2 modules") it was said that:
> > > > > > 
> > > > > > "If the TPM is in Failure mode, it will successfully respond to both
> > > > > > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > > > > > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > > > > > is in Failure mode."
> > > > > > 
> > > > > > But a check was never added in the commit when calling
> > > > > > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > > > > > This commit corrects this by adding a check.
> > > > > > 
> > > > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > > > > 
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > 
> > > > > I think this should actually have the fixes tag. It's a regression,
> > > > > right? I can add it.
> > > 
> > > Hi Jarkko!
> > > 
> > > Just curious. I can't see this patch was added to linux-next. Was I
> > > expected to do something more to it?
> > 
> > No it's just me failing to do my job properly. I'll pick this and
> > make a 2nd pull request v5.19. Apologies.
> 
> I revisited the patch, and it does not look right to me.
> 

Hi Jarkko!
I'm sorry for the delay.

> If tpm2_get_cc_attrs_tbl() fails, there's no way to deduce
> from that "fact" that the TPM response was TPM_RC_FAILURE.

Yes, that is true. If the TPM responds with TPM2_RC_FAILURE it should be
caught here. I will add it.

Kind regards
Mårten

> 
> BR, Jarkko
