Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D34D3DC0
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Mar 2022 00:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiCIXwa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Mar 2022 18:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiCIXwa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Mar 2022 18:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA611C7D9;
        Wed,  9 Mar 2022 15:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3958A61CDE;
        Wed,  9 Mar 2022 23:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E72C340EE;
        Wed,  9 Mar 2022 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646869889;
        bh=KO0dS8WUuQRku/p28rBJEghTMI+8NqGM8QMVzvV2O6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg8j+WLMBP5bnaubjI8AmVHyGZLYSmWJmIs3eq2F5lsbFSkcY4/f0z5zbXZxT6zUA
         8muRYC5PjlrZktqLpeukeslhoVDB45gzaxo3zY4biGUjVm9DRqqdEZ/ThlGMiqOXys
         6W9qu4LJm6SCUmnxjxSf5X9xbhSS/QjG/IcxVha8N+etGrsfJKYFf/69dZrBSQ0CJj
         r5/XXSnmlrzCZkE9KdCy//yEdf6B37yF4O+uWSgvz8OTZ5L7GtdDN3Ec659oD6nseL
         sPW+oQoovTqYjfuNGrCJpgkkyzLW0B5VA4GrakIFrQ9IHrWLdkyBmiWa9UOtN5wgCJ
         AUoQGQQxEBNEQ==
Date:   Thu, 10 Mar 2022 01:50:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <Yik9VIcfuhW5Kd73@kernel.org>
References: <YidTCX0NOgDfHCp9@kernel.org>
 <YiecF6W2XAcpC7dF@sol.localdomain>
 <YieldvygMyiqmZbT@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YieldvygMyiqmZbT@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 08, 2022 at 08:50:30PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 08, 2022 at 10:10:31AM -0800, Eric Biggers wrote:
> > On Tue, Mar 08, 2022 at 02:58:49PM +0200, Jarkko Sakkinen wrote:
> > >       KEYS: asymmetric: enforce that sig algo matches key algo
> > 
> > It looks like you applied v1 of this patch
> > (https://lore.kernel.org/r/20220201003414.55380-2-ebiggers@kernel.org) rather
> > than v2 (https://lore.kernel.org/r/20220208052448.409152-2-ebiggers@kernel.org).
> > I think that v2 is necessary because some callers of
> > public_key_verify_signature() leave pkey_algo as NULL.
> > 
> > Sorry for not spotting that you applied v1 earlier.
> > 
> > - Eric
> 
> I can do another pull request.

Eric, does 'next' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git 

look good to you now?

BR, Jarkko
