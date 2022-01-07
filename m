Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A084876B3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiAGLpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 06:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiAGLpG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 06:45:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB05C061245;
        Fri,  7 Jan 2022 03:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56BE0B8259E;
        Fri,  7 Jan 2022 11:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B9EC36AE9;
        Fri,  7 Jan 2022 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641555903;
        bh=ETS/HS/74MY5r0BinUUiMCS97lB/3KlbR9VTps9j1Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibFNg2VpNvF799jh/L46hrVgNHZdxLGJoffDhUuZ/40gxZ60gNDlfM+7j2xbSEsNi
         iq40JEssQ7U3xzourmN0izjweRNLrhDKs4p2leYyLnPHONf6tROTVWsfl1gU/af+wg
         usPmHoyH6uQxxyDuNJB9r4cFhmJxHalcDNBH0pxgfcYO6UP2NvQryBn6Hju4/xfPhT
         0v4gewGVdXoJiL1WVc6lqkhjNFE6sdCcbG6kEXU1Wapo9PrJqah4GzL7G2UpqwjX0r
         PeP47ID4TWcOPOHOO0eGE12wniPvlKMDcQotqC3jdBH6zmPa4dLZSSqoUofXC5LbOT
         8tRsktbaaXPpQ==
Date:   Fri, 7 Jan 2022 13:44:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3] tpm: st33zp24: Make st33zp24_remove() a void function
Message-ID: <YdgnuvGIq1DcLlJT@iki.fi>
References: <20220104231103.227924-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104231103.227924-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 05, 2022 at 12:11:03AM +0100, Uwe Kleine-König wrote:
> Up to now st33zp24_remove() returns zero unconditionally. Make it return
> no value instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This patch does not improve functinality in any possible way, and neither
does it fix any bug.

/Jarkko
