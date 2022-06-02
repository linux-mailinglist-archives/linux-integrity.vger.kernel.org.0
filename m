Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065C53B7AB
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jun 2022 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiFBLRV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jun 2022 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiFBLRT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jun 2022 07:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DE32A
        for <linux-integrity@vger.kernel.org>; Thu,  2 Jun 2022 04:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA85B6165A
        for <linux-integrity@vger.kernel.org>; Thu,  2 Jun 2022 11:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A32C3411A;
        Thu,  2 Jun 2022 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654168637;
        bh=YmkDMpUPF4vo7l5fag9UeZxkvcyvmwCihiv2YafDjNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azsBftbI7XhzD0XLoK4P4DWAv0ps9xRYfHUKxjxZGx+sLL7vjO6yLBDV6bDzRdBtQ
         CCPj5CUGq3Bbj8VlmjMWeHLzYefrGB+cwjTSM3RiznJu2FHMdVmhcdvKCXoWWjkppw
         ThvCXRHZd74IzYaYyON0dqGgNftGk5AsLn6zqapSvwhYeVZRY1HcWkej3kRamwxevW
         OG8IqTP9+a+1XVkt1hOHQYKKEjvjHsrcpB/pLWQjUBNQ+aGfrajsBRmEpfx7o1jgQj
         Ily2mSaDWKHRnxbrcdpEWOz/ZFERmrcZrT2HQAsjmXpL0GIB/DW8owtFmOAgOgUZpJ
         WPOb0zKnz+5jg==
Date:   Thu, 2 Jun 2022 14:15:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YpibzQBKih7QRrei@kernel.org>
References: <20220425102552.663069-1-marten.lindahl@axis.com>
 <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
 <YmbDpMUtUK/NrXIY@axis.com>
 <YpTiOdC2W6PaoI2R@axis.com>
 <faf0156e6f735b2d7d793fbf48ae4c6a108e8eb1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faf0156e6f735b2d7d793fbf48ae4c6a108e8eb1.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 01, 2022 at 05:05:08AM +0300, Jarkko Sakkinen wrote:
> On Mon, 2022-05-30 at 17:26 +0200, Marten Lindahl wrote:
> > On Mon, Apr 25, 2022 at 05:52:04PM +0200, Mårten Lindahl wrote:
> > > On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> > > > On Mon, 2022-04-25 at 12:25 +0200, Mårten Lindahl wrote:
> > > > > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > > > > TPM2 modules") it was said that:
> > > > > 
> > > > > "If the TPM is in Failure mode, it will successfully respond to both
> > > > > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > > > > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > > > > is in Failure mode."
> > > > > 
> > > > > But a check was never added in the commit when calling
> > > > > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > > > > This commit corrects this by adding a check.
> > > > > 
> > > > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > > > 
> > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > 
> > > > I think this should actually have the fixes tag. It's a regression,
> > > > right? I can add it.
> > 
> > Hi Jarkko!
> > 
> > Just curious. I can't see this patch was added to linux-next. Was I
> > expected to do something more to it?
> 
> No it's just me failing to do my job properly. I'll pick this and
> make a 2nd pull request v5.19. Apologies.

I revisited the patch, and it does not look right to me.

If tpm2_get_cc_attrs_tbl() fails, there's no way to deduce
from that "fact" that the TPM response was TPM_RC_FAILURE.

BR, Jarkko
