Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54F4D20A9
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 19:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349288AbiCHSwQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 13:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbiCHSwO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 13:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FD5468B;
        Tue,  8 Mar 2022 10:51:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CD361616;
        Tue,  8 Mar 2022 18:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D0CC340EF;
        Tue,  8 Mar 2022 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646765471;
        bh=RHG0KltsQ/iNz7I3cyFsYH9JfTC3E50D/WQVf4Xzs7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQiyN1VOJHW0v8HEfFNclw2S3i3D3T2hBDvEYao3oNf43Ga18/BQiE3y8/HKGQRYf
         wzCF3+XyThN3IJDsnBpUPjq3CUnEYAXgfzLYv1d/3SfnRvpBreJYdw8JwQ5efCz+DC
         NSE7Pn0YzMoI2XcPeckPp/CXQqj/8KILvtLQqU72w85t9LWmEy8jDuupKWIy+brJnz
         cUNJ8SuDqHaZ6sM4YNH6ZISkCIt8vB+IL8iJByj607kjNDcxfMO3g/Cn62MSbXr+qO
         nqeQwaia22xtVpSjU/A7Aoy3PUoO0KZozf2YSKx13k+dwsI7caYChioEW/tHd6Dr/a
         x5dfFsMFlitgQ==
Date:   Tue, 8 Mar 2022 20:50:30 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <YieldvygMyiqmZbT@iki.fi>
References: <YidTCX0NOgDfHCp9@kernel.org>
 <YiecF6W2XAcpC7dF@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiecF6W2XAcpC7dF@sol.localdomain>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 08, 2022 at 10:10:31AM -0800, Eric Biggers wrote:
> On Tue, Mar 08, 2022 at 02:58:49PM +0200, Jarkko Sakkinen wrote:
> >       KEYS: asymmetric: enforce that sig algo matches key algo
> 
> It looks like you applied v1 of this patch
> (https://lore.kernel.org/r/20220201003414.55380-2-ebiggers@kernel.org) rather
> than v2 (https://lore.kernel.org/r/20220208052448.409152-2-ebiggers@kernel.org).
> I think that v2 is necessary because some callers of
> public_key_verify_signature() leave pkey_algo as NULL.
> 
> Sorry for not spotting that you applied v1 earlier.
> 
> - Eric

I can do another pull request.

Linus, please ignore this first one.

BR, Jarkko
