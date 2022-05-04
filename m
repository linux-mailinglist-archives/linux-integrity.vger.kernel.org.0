Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE49519639
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiEDEHr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDEHr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:07:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E8205F3
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 21:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75BE5B822B6
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 04:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA39C385A4;
        Wed,  4 May 2022 04:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651637050;
        bh=d6nsg4DuEkKrQDmpauXHWpmmFQBpHKsIjhOk9V2q1Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWpp6eiM2gR0vBtu/xti42GIHEwW106XLoMsXE8oQqsEXtV6iwjEzK4dC0gytr8jp
         h4pT+cwkSdm5EXs52EqdqZ8douzSHHXSXvybeDsY/BbP7BrVW0JpUo+YqwPeL9MxGZ
         4xbu7gVc7Mu7CDQT+H40i+DRpkchizdg2ySx8oT7vIcZnkW3skcVI7QqYEG5HA246h
         n1Fnm41gd38Z3kdBSgKtu/uL+mwesJYMlObLUXftdvG59aMzwyfug6O6mfreAnd9Yw
         fkznTsyqrPP2pP/jMha++xMuSQf/9YZw7FdyqTJDbmGxB33N12MOt1LhVrNUxdQEej
         AvP5yA3lVvI+A==
Date:   Wed, 4 May 2022 07:02:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
Message-ID: <YnH65MnQdkpZ10pe@kernel.org>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
 <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
 <20220425191132.nm66acqichx4fmel@pengutronix.de>
 <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
 <20220426113541.GA64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426113541.GA64706@ziepe.ca>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 08:35:41AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 26, 2022 at 07:35:29AM +0300, Jarkko Sakkinen wrote:
> 
> > Even if chip is expected not to be NULL, a sanity check costs nothing.
> > As already said, this should be reviewed in the context of the callback
> > change.
> > 
> > Even then, the change should rather be:
> > 
> >        if (!chip) {
> >                dev_err(dev, "Could not get client data at remove\n");
> >                return;
> >        } 
> 
> If it can't happen by design it should be deleted entirely, or be
> turned into a WARN_ON:
> 
> if (WARN_ON(!chip))
>    return;
> 
> But I find this largely unnecessary as a null chip will reliably oops
> later on in the same function.
> 
> Jason

Fine, I applied the patch.

BR, Jarkko
