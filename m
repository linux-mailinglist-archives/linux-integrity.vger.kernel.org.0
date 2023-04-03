Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B566D4E73
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjDCQyt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 12:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDCQys (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 12:54:48 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB272700;
        Mon,  3 Apr 2023 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680540883;
        bh=XAYIocX34S8mc6qeTtt+bg/dTnW/CVuGdT/Rb0uE6Vc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=gk03H71UOjn9CwJHlk8DCvNxAwGVcEAyV4ozQgrsDYhxFNgYSSr9O0yDkN8OoHR3B
         pH0BATiqOhsSFW+O1EhcXC2WQHDFbvphNzTLbopiyLmIrOFmulr/YA9oxVb2XtAM+r
         dkDjPT0mPHVsCSL6E+Y/pp+eAvE+Y6OG+dwoOrW4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E28D312812F6;
        Mon,  3 Apr 2023 12:54:43 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Dqm3KErzXFor; Mon,  3 Apr 2023 12:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680540883;
        bh=XAYIocX34S8mc6qeTtt+bg/dTnW/CVuGdT/Rb0uE6Vc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=gk03H71UOjn9CwJHlk8DCvNxAwGVcEAyV4ozQgrsDYhxFNgYSSr9O0yDkN8OoHR3B
         pH0BATiqOhsSFW+O1EhcXC2WQHDFbvphNzTLbopiyLmIrOFmulr/YA9oxVb2XtAM+r
         dkDjPT0mPHVsCSL6E+Y/pp+eAvE+Y6OG+dwoOrW4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4489A128123B;
        Mon,  3 Apr 2023 12:54:43 -0400 (EDT)
Message-ID: <39ceac9c8dfdb0101bbf386966599fa5d2dc8877.camel@HansenPartnership.com>
Subject: Re: [PATCH 06/12] tpm: export the context save and load commands
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 03 Apr 2023 12:54:41 -0400
In-Reply-To: <Y/xr53SmY3aDZV2D@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
         <20230216201410.15010-7-James.Bottomley@HansenPartnership.com>
         <Y/xr53SmY3aDZV2D@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-27 at 10:37 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 16, 2023 at 03:14:04PM -0500, James Bottomley wrote:
> > The TPM2 session HMAC and encryption handling code needs to save
> > and restore a single volatile context for the elliptic curve
> > version of the NULL seed, so export the APIs which do this for
> > internal use.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> 
> These did not need EXPORT_SYMBOL_GPL()?

No, because they're still internal to the overall tpm.ko even if it is
compiled as a module.  I don't think there's a huge reason to keep them
as an internal only to the tpm core API, but equally without a consumer
outside the core module, there's no reason to export them.

James

