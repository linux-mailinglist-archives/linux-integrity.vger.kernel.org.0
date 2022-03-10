Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6744D4040
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Mar 2022 05:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiCJEWB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Mar 2022 23:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiCJEWA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Mar 2022 23:22:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753312CC38;
        Wed,  9 Mar 2022 20:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1B0EB824AB;
        Thu, 10 Mar 2022 04:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFC0C340E8;
        Thu, 10 Mar 2022 04:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646886057;
        bh=C6YzQXJ4A8f7EpImKUHh1ypfIfiOwjesz0ZXkF9WljM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctXacqoP2eLru8nzvqT1Glp5o155hlw5401WQ72RTYnPI0GNph0gSVhjBMBiiXuSY
         EiV6HyAMhs52vewTGuy7PC9pBiU3VcC16119q2GPZu0/cxARiizQa9ghdNdtiZreKt
         c/ZerLPYH3cSg8EPEE8yZFpuHw/usQrU0yW4WQGqEQy/TH0TlUaBLxLazpj+esxPSu
         WBli+prOvmsKCzLImOpfeUX3QUbrfL8vQL85VliJBBF4qy/u++j2JUykI6oT8xxiIg
         gO4G/86I0aLqs+Y6dSIdKKkUz4A7mYZPi+IMKNPbQdoXHt1t25RcwyqA5VroHAQQRp
         6m8VVHniwwnKA==
Date:   Wed, 9 Mar 2022 20:20:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <Yil8p6OVFzXH1pzM@sol.localdomain>
References: <YidTCX0NOgDfHCp9@kernel.org>
 <YiecF6W2XAcpC7dF@sol.localdomain>
 <YieldvygMyiqmZbT@iki.fi>
 <Yik9VIcfuhW5Kd73@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yik9VIcfuhW5Kd73@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 10, 2022 at 01:50:44AM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 08, 2022 at 08:50:30PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Mar 08, 2022 at 10:10:31AM -0800, Eric Biggers wrote:
> > > On Tue, Mar 08, 2022 at 02:58:49PM +0200, Jarkko Sakkinen wrote:
> > > >       KEYS: asymmetric: enforce that sig algo matches key algo
> > > 
> > > It looks like you applied v1 of this patch
> > > (https://lore.kernel.org/r/20220201003414.55380-2-ebiggers@kernel.org) rather
> > > than v2 (https://lore.kernel.org/r/20220208052448.409152-2-ebiggers@kernel.org).
> > > I think that v2 is necessary because some callers of
> > > public_key_verify_signature() leave pkey_algo as NULL.
> > > 
> > > Sorry for not spotting that you applied v1 earlier.
> > > 
> > > - Eric
> > 
> > I can do another pull request.
> 
> Eric, does 'next' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git 
> 
> look good to you now?
> 

Yes, that looks good, thanks.

- Eric
