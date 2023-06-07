Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5B7267C0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjFGRt5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jun 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjFGRtz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jun 2023 13:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4451FC2;
        Wed,  7 Jun 2023 10:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3EC63F95;
        Wed,  7 Jun 2023 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779ADC433EF;
        Wed,  7 Jun 2023 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686160193;
        bh=kGX0qEd54Qgv90p2G878MpRZiHthXw2miPZqsUOHgn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vs0ohzxaCSiaUtAgZ8JCY0ss5FDs4L4CgEor0c0YhE63rsVVN+/nKcnXYTke39SMI
         WzMw3/SSi82jTXvDqiBMBI0EIy6sidbUkzo7Vpnq9k/EYkMjeaB8eG599pgpzcCKJK
         nJM3vKiQut6O7DoIYLWYaXpneAScvgKOv59N/rG4=
Date:   Wed, 7 Jun 2023 19:49:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Message-ID: <2023060736-immodest-doormat-f957@gregkh>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me>
 <2023060606-unlatch-yiddish-a45f@gregkh>
 <ac5b76af-87dc-b04d-6035-8eda8ba5ed12@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5b76af-87dc-b04d-6035-8eda8ba5ed12@kunbus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 07, 2023 at 05:47:57PM +0200, Lino Sanfilippo wrote:
> 
> Hi Greg,
> 
> On 06.06.23 08:45, Greg KH wrote:
> >>
> >> Lino, it looks like this regression is caused by (backported) commit of yours.
> >> Would you like to take a look on it?
> >>
> >> Anyway, telling regzbot:
> >>
> >> #regzbot introduced: 51162b05a44cb5
> > 
> > There's some tpm backports to 5.15.y that were suspect and I'll look
> > into reverting them and see if this was one of the ones that was on that
> > list.  Give me a few days...
> > 
> 
> Could you please consider to apply (mainline) commit 0c7e66e5fd69 ("tpm, tpm_tis: Request threaded
> interrupt handler") to 5.15.y?
> 
> As Chris confirmed it fixes the regression caused by 51162b05a44cb5 ("tpm, tpm_tis: Claim locality
> before writing interrupt registers").
> 
> Commit 0c7e66e5fd69 is also needed for 5.10.y, 6.1.y and 6.3.y.

Now queued up, thanks.

greg k-h
