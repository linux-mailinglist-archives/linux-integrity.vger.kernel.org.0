Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2A6C13E5
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 14:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCTNr1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCTNr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 09:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BC1984
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 06:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DBBC614DA
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 13:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55441C433EF;
        Mon, 20 Mar 2023 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320044;
        bh=pdJ6cMn/UIys2C4sYaixmogenKds8YtbMdRBmEbjrIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SO5GuT97tIfuAf6HKxu6uRKL1DLvcY9lzfhtDZkhw8Pog51wqPrp9XFP5ecmT1kxb
         mYhJLEcEI9hr121JVHeAFWzFdePH7uYBTcJ81IPaKEmhmygajExvQfPgbX4dTclSPE
         Zto53T9Zij1xsVWUTk7i7vnAxJu76ev7pJK4ZEjun531Bn4DUShwFlp3EaBNOixDSb
         0d9MScEZbMwAxfn8NOGl96W6jyithh/zSuqdl3yDE+QEyHkFhgLuxnVtuGYvkga6jh
         a+fCqcIWnm/nskdnJTliWvcjCmSNJkmqpXGSZr4a4yvRi+SoYtR1r04ud097gxq5oG
         D5AvXLPvl7jsQ==
Date:   Mon, 20 Mar 2023 15:47:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
Message-ID: <20230320134721.w7rcpk7ecbqvxrtg@kernel.org>
References: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
 <5cf966e97f9a0fabdf8d3b5a0cbae90abe484813.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf966e97f9a0fabdf8d3b5a0cbae90abe484813.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 07:22:52AM -0400, James Bottomley wrote:
> On Mon, 2023-03-20 at 07:15 -0400, James Bottomley wrote:
> > The test for the AMD fTPM problem, which just went in, actually uses
> > the wrong function template for request_locality().  It's missing an
> > argument so the build breaks:
> > 
> > drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to
> > function ‘tpm_request_locality’
> >   ret = tpm_request_locality(chip);
> >         ^~~~~~~~~~~~~~~~~~~~
> > drivers/char/tpm/tpm-chip.c:43:12: note: declared here
> >  static int tpm_request_locality(struct tpm_chip *chip, int locality)
> >             ^~~~~~~~~~~~~~~~~~~~
> > 
> > Fix this by requesting zero locality.
> 
> Actually, this is a bad interaction with the non-upstream patch to run
> the kernel in locality two to allow key policy to distinguish kernel
> release from user space release, which goes back to the debate over
> hibernation keys.  I'll carry it separately until (or if ever) we get a
> resolution on how to do this.

BTW, do you have a newer version of

https://lore.kernel.org/linux-integrity/20230216201410.15010-1-James.Bottomley@HansenPartnership.com/

I'm planning to flush testing queue as I have now more bandwidth
for TPM and keyring (actually I'm looking RISC-V fTPM's at work).

BR, Jarkko

BR, Jarkko
