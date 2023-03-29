Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6246CF7C4
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Mar 2023 01:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjC2Xwb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 19:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjC2Xwb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 19:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3711722
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 16:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A4DA6114C
        for <linux-integrity@vger.kernel.org>; Wed, 29 Mar 2023 23:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3FC4339B;
        Wed, 29 Mar 2023 23:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680133948;
        bh=46ZIW/j2Wh4ofSsRj2iMYehR0Mzk95fAtmlmFwTR9Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3r1NTFiCreLxMr7P4udBAHD1MiS/NjE5Mk+Yjjr4tP9raxg1b2V1/ePDunr06Le4
         NDtgezBXuWNiQo91VfPVNWwsWIEixOp3WwqO6v5b9+NZIxhGYjW1u8KWQtv/aYaJ3C
         3Qp9RNkpygILbgt4gtw9JNreQ163IjXxru4atgaq6EA4U0D2WRH/BifGPvF8vkbuPo
         KmNnc2ANiQWQnllkybVSg1FDmxGoUXcAW7H0H2LESxsqNffVk+gFEp898ROavsnU1o
         rp3OY3nevVNDmOKMEZsKIyHriP8EiRQ+9Jt3UwL9MSEmrvTSHb+iEeZNC5nmAzwl78
         YQK8FGvMmGg7g==
Date:   Thu, 30 Mar 2023 02:52:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
Message-ID: <20230329235225.e5ordkagimfthh5c@kernel.org>
References: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
 <5cf966e97f9a0fabdf8d3b5a0cbae90abe484813.camel@HansenPartnership.com>
 <20230320134721.w7rcpk7ecbqvxrtg@kernel.org>
 <2a8671aaae43738f45f7812a9e0d93a99c5ebc69.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a8671aaae43738f45f7812a9e0d93a99c5ebc69.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 23, 2023 at 08:20:29AM -0400, James Bottomley wrote:
> On Mon, 2023-03-20 at 15:47 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 20, 2023 at 07:22:52AM -0400, James Bottomley wrote:
> > > On Mon, 2023-03-20 at 07:15 -0400, James Bottomley wrote:
> > > > The test for the AMD fTPM problem, which just went in, actually
> > > > uses the wrong function template for request_locality().  It's
> > > > missing an argument so the build breaks:
> > > > 
> > > > drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to
> > > > function ‘tpm_request_locality’
> > > >   ret = tpm_request_locality(chip);
> > > >         ^~~~~~~~~~~~~~~~~~~~
> > > > drivers/char/tpm/tpm-chip.c:43:12: note: declared here
> > > >  static int tpm_request_locality(struct tpm_chip *chip, int
> > > > locality)
> > > >             ^~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > Fix this by requesting zero locality.
> > > 
> > > Actually, this is a bad interaction with the non-upstream patch to
> > > run the kernel in locality two to allow key policy to distinguish
> > > kernel release from user space release, which goes back to the
> > > debate over hibernation keys.  I'll carry it separately until (or
> > > if ever) we get a resolution on how to do this.
> > 
> > BTW, do you have a newer version of
> > 
> > https://lore.kernel.org/linux-integrity/20230216201410.15010-1-James.Bottomley@HansenPartnership.com/
> > 
> > I'm planning to flush testing queue as I have now more bandwidth
> > for TPM and keyring (actually I'm looking RISC-V fTPM's at work).
> 
> Hopefully next week.  I'm on a business trip and conference this week,
> so most of my cycles have been going into that and converting the TPM2
> engine to a provider, but I'm back home next week and the provider
> conversion is pretty much done.

Yeah, as said in other reponse things have not moved because I got sick
on Friday... Anyway, I'm planning to test the current version, unless
new comes available before I get on it.

BR, Jarkko
