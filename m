Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682755AF67
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 08:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiFZGIw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZGIw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 02:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC01183F
        for <linux-integrity@vger.kernel.org>; Sat, 25 Jun 2022 23:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6B66101C
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jun 2022 06:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C806C34114;
        Sun, 26 Jun 2022 06:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656223730;
        bh=jpAm3siMhmwo5vwGgOnGIZGjdx2A70Id6AZrXri1yj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRZTE4iYflmkVHO6C9gpppnyeHJKNMVXONMjtjC94TT6FcOJbqXeLydkNMX9pI2sD
         mwtVPcd91zB/rbT0VZameSeSoKRI/9F30ar++AdsXFnzHrc5wwFzQyx6kxiFEJ0Seh
         V4zabIlsT9i1t4YkcKNzoR1MetB+EEmzvHRVkeoBPkbP6GjU4QWTs6G700FYeeaoEC
         d75MO+ZH8hmq382OdKsQjr4N/gNjL9Iq00M7QJaosetY5rkdac6lNEsKB7K48B9zGI
         cO9k5SQ1ZUB06sQVOXcuTZt92QmulQcd2QM5HfnHyZRuHs8jZxzwwzlUnCQGXkWqIh
         Oywq71ytg4e2Q==
Date:   Sun, 26 Jun 2022 09:08:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: Re: CKI team seeing boot failures with 5.19 kernels on VMs with tpm
 device
Message-ID: <Yrf378QEJmdvqT1y@kernel.org>
References: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
 <Yqo4ot+mIW+LsrxB@iki.fi>
 <CALzcdduSg92P7nU3kXEugxq-xysvCPV2SUPRNtrvGMUb0rq6dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcdduSg92P7nU3kXEugxq-xysvCPV2SUPRNtrvGMUb0rq6dg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 15, 2022 at 03:52:14PM -0700, Jerry Snitselaar wrote:
> On Wed, Jun 15, 2022 at 12:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 07:47:40AM -0700, Jerry Snitselaar wrote:
> > > This came to my attention this morning, and I was able to do a quick
> > > test and reproduce in a vm locally, using both the crb and tis
> > > emulation. 5.18 boots up fine.
> > >
> > > The only thing I see that could impact both crb and tis in the tpm
> > > changes would be:
> > >
> > > af402ee3c045 tpm: Add field upgrade mode support for Infineon TPM2
> > > modules | 2022-05-23 | (Stefan Mahnke-Hartmann)
> > > e57b2523bd37 tpm: Fix buffer access in tpm2_get_tpm_pt() | 2022-05-23
> > > | (Stefan Mahnke-Hartmann)
> > >
> > > I'm going to poke around some more and see if I can figure out what is
> > > going on, but wanted to give you a heads up.
> > >
> > > Regards,
> > > Jerry
> > >
> >
> > OK, thanks for spotting this.
> >
> > BR, Jarkko
> >
> 
> Whatever it was it wasn't the tpm code, and it looks like it has
> disappeared with v5.19-rc2.
> 
> Regards,
> Jerry

OK good to hear.

Thank you anyway giving heads up!

BR, Jarkko
