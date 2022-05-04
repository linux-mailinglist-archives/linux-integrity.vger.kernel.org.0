Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3451963A
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 06:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiEDELn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 00:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDELm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 00:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981392180E
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 21:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C2861A6A
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 04:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA415C385AA;
        Wed,  4 May 2022 04:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651637286;
        bh=axJMczegSwMWKaMQABy2dlymfTdZEK2k7ibXP3gNfD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqoNqBZtcMW7zTp9i8N0ycgIkTfzPCI8CLVhl9d8RSn+nkJNdWDrc8KrzI/ZoQhaA
         q/az3Qzf0ME8lR743PKj0VzItecSGna6ed06DJedtI04gbBr2in63rIpqBbiLwaEqp
         pUd1ryjc+m4ZwTmmJIFXQYNdUJn09QC+buOl5lp35E9tcW2eaprf+DoRmrvGXuBqPp
         u76uVLQGzE7Jb5MCMiNd6E8ypfoiMNM29BSFXuqJfp59ig2ZY0JV999CwdLWT5RDzN
         YqQzmr88tVYKQ3d3gXmUGWXc75DMh2Z5BP0tN4wNsJlCvOf+bBHy26lHqO5f/sYP24
         /XrT536bQ9NZQ==
Date:   Wed, 4 May 2022 07:06:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] char: tpm: cr50_i2c: Suppress duplicated error message
 in .remove()
Message-ID: <YnH70MJdQGqFBMKh@kernel.org>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
 <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
 <20220425191132.nm66acqichx4fmel@pengutronix.de>
 <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
 <20220426080602.wdquj6ra3vhufur4@pengutronix.de>
 <YnH4qge2KmmM27sC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnH4qge2KmmM27sC@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 04, 2022 at 06:53:17AM +0300, Jarkko Sakkinen wrote:
> On Tue, Apr 26, 2022 at 10:06:02AM +0200, Uwe Kleine-König wrote:
> > -		dev_err(dev, "Could not get client data at remove\n");
> > -		return -ENODEV;
> > +		dev_crit(dev, "Could not get client data at remove, memory corruption ahead\n");
> > +		return 0;
> 
> Just change the return value 0 and log-level, message can be as it is.

Ignore, I applied the patch.

BR, Jarkko
