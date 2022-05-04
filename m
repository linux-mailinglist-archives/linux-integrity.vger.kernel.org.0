Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7651962C
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 05:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbiEDD6R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 May 2022 23:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiEDD6Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 May 2022 23:58:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94716183A2
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 20:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F789B821D4
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 03:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D37C385B1;
        Wed,  4 May 2022 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651636480;
        bh=KB7m4QGOHWFRdS821pCvdJZPTt21tPfxKB5L4g+aKd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHwSp2n/JJH0GUoA2AIx0vVc+aPIBVLewNcbDQrsIrwh0SnwiKvVrRSCDTnTQIrYy
         J4UEmeSQ5lYSxxTrr4UJnIuBWZhJiU3o5u0lY69Ge4WmiscLOgfKQl08+2se5Fy+8z
         T+xRWTbuE0ThF3ClBFeomiXTEziPY/CuL/kfn6AoGMMl4U+coNuvgzisnEHqA3CREo
         /YHCBJnVtBWSf82J5y856ISerLhU14f+PLTL51On7xuiupOEtECethYatoCP5+urRJ
         N3xAoSGNGYGrIONYjwS2S0Cy4WP/dK9hohyU5ANK2RC1E/Aae8Z27alQXA7Z+i7tn4
         jIfs7uoxaPMFw==
Date:   Wed, 4 May 2022 06:53:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] char: tpm: cr50_i2c: Suppress duplicated error message
 in .remove()
Message-ID: <YnH4qge2KmmM27sC@kernel.org>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
 <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
 <20220425191132.nm66acqichx4fmel@pengutronix.de>
 <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
 <20220426080602.wdquj6ra3vhufur4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426080602.wdquj6ra3vhufur4@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 10:06:02AM +0200, Uwe Kleine-König wrote:
> -		dev_err(dev, "Could not get client data at remove\n");
> -		return -ENODEV;
> +		dev_crit(dev, "Could not get client data at remove, memory corruption ahead\n");
> +		return 0;

Just change the return value 0 and log-level, message can be as it is.

BR, Jarkko
