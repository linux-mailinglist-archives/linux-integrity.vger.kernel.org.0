Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB85649776
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Dec 2022 01:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiLLAuj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Dec 2022 19:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiLLAui (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Dec 2022 19:50:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD04BCA9;
        Sun, 11 Dec 2022 16:50:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A4E60EB3;
        Mon, 12 Dec 2022 00:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A75C433D2;
        Mon, 12 Dec 2022 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670806237;
        bh=3c2vbNCIeCOuoNK7LIpxSFxMSG+DIPY3s77NDUk4nLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ldcg7sCNLvJfHRE6fYcxM04ru2u1GgWL9eW0y/0Vi/Q+2kQJPDOnRz4w6IXoZB/nH
         xUHSFwax5Qg5EcjBlkQOu9nd+YpL9+lsA6RCEvAyq4iNDIkvNbk8Ys+MWiGWRpZkIn
         D8IuDf0NLKoHER0TY1DQwVdK8gSXvZw+NjjfeNgORYb2ckH1pMMo2AYojytwmJ3JYN
         u7Xww26nKwz7DbASmufUM+4bupT1p/eelwdNDEDp9pWWl3uCoMppmTuU+q+ve4pRnl
         oE1KRdpLSCLGcpEBGwa1PpfoUWK2WKnXinZ6dtq2UAeBq0D6HX2ayQrahpBJtsALcA
         MTxP6e3M91kXA==
Date:   Mon, 12 Dec 2022 00:50:32 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 03/11] tpm: add cursor based buffer functions for
 response parsing
Message-ID: <Y5Z62HPEDHGaK+Uq@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
 <20221209160611.30207-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209160611.30207-4-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 09, 2022 at 11:06:03AM -0500, James Bottomley wrote:
> It's very convenient when parsing responses to have a cursor you
> simply move over the response extracting the data.  Add such cursor
> functions for the TPM unsigned integer types.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Saying that something is convenient is not really an argument.

What you are going to use it for? Is it complex enough that what we have
not doesn't scale. I'd just answer these questions and write more
reasonable commit message.

BR, Jarkko
