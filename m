Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217DF6564E1
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Dec 2022 21:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiLZUDh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Dec 2022 15:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZUDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Dec 2022 15:03:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC6E7F;
        Mon, 26 Dec 2022 12:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C0AB80D71;
        Mon, 26 Dec 2022 20:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BAC433F0;
        Mon, 26 Dec 2022 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672085013;
        bh=ruvWFFpoU47k2uWNCQx9jR/dxjDlgYDepRVz1qrUACk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHqu5TEAAiEMhjsA4+REG3drQw7+7hTP3RSiXwZKXDYmuZ5qz0bNuu0VlUUQXgTH1
         gJG3vcgVM0v8uj8xJ8e94enxqhDGjdtvSIP71Lqiv67vwwMFfM67Xk9n5SNTP1WmaF
         jFsBZxxTc3VS3EHZwGRIG7bfFK5Ux9CParSeX7wMINQwXj4IRmRshcxifLuLdrJlmv
         6kslj+YM9CmN/3dbx//uQo1woCDrQL6eQLN+fOstiFSdDp+5+mih8IvwZbg5a6652p
         +xR+odmlpnlCZpAFPSXDW9aqjhZPq75ST8ZZ717h5ddw2DVdHqdd7tIF7XW1sRDliv
         tWxj9X4NRYdsQ==
Date:   Mon, 26 Dec 2022 20:03:27 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 01/11] tpm: move buffer handling from static inlines to
 real functions
Message-ID: <Y6n+D37PYXyuRILN@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
 <20221209160611.30207-2-James.Bottomley@HansenPartnership.com>
 <Y5PqRdlEdBjj72KM@kernel.org>
 <704a88efc2a7cf5c2679af2ca37a682efd6ceaa2.camel@HansenPartnership.com>
 <Y5Z7awuHL9Wsn2l/@kernel.org>
 <e32ead8270f65fe7bf828fe90d457caac4234dce.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e32ead8270f65fe7bf828fe90d457caac4234dce.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 11, 2022 at 10:16:42PM -0500, James Bottomley wrote:
> On Mon, 2022-12-12 at 00:52 +0000, Jarkko Sakkinen wrote:
> > On Sun, Dec 11, 2022 at 03:01:57PM -0500, James Bottomley wrote:
> > > On Sat, 2022-12-10 at 02:09 +0000, Jarkko Sakkinen wrote:
> > > > On Fri, Dec 09, 2022 at 11:06:01AM -0500, James Bottomley wrote:
> > > > > This separates out the old tpm_buf_... handling functions from
> > > > > static
> > > > > inlines in tpm.h and makes them their own tpm-buf.c file.  This
> > > > > is
> > > > > a
> > > > > precursor so we can add new functions for other TPM type
> > > > > handling
> > > > > 
> > > > > Signed-off-by: James Bottomley
> > > > > <James.Bottomley@HansenPartnership.com>
> > > > 
> > > > I don't comprehend that explanation at all.
> > > > 
> > > > Please, add a bit more detail why this precursory change is
> > > > required.
> > > 
> > > It's the usual submitting-patches requirement of moving code first
> > > before modifying it.  Since it's the recommended way of doing
> > > things in our process docs, I'm not sure how much more explanation
> > > can be given.
> > 
> > It doesn not contain any reasonable argument for not continue
> > using inline functions.
> 
> In principle nothing prevents them being inlines in tpm.h.  There's
> quite a lot of them, so it's growing unweildy and __tpm_buf_init can't
> be hidden in that scenario but it could, in theory, be done.

So: all I'm asking write this down. I'm cool with it, i.e. since complexity
will grow heavily because of TPM2B structure handling etc. it is better to
encapsulate he implementation, correct?

BR, Jarkko
