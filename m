Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6D5ED30D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiI1Cc2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 22:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1Cc1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 22:32:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0168E119A;
        Tue, 27 Sep 2022 19:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530C6B81E5A;
        Wed, 28 Sep 2022 02:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5B5C433D6;
        Wed, 28 Sep 2022 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664332344;
        bh=PL2FMsLKGpn9FSub/HBKXmqfJ+EeTMDzVV4Voy27WZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1EuZrC0rLPe7I5kXFJmOCDIp3WawnFWd0s4wALhOgaKUNXcgRdEZi6n2KDwhwSmm
         BL/PcB/gz2QKr4pMOtLZ5NP+ZIW7ji3K1G59DUyh/VS+CW0LDCanKEVxYdZSMVYzFh
         68VqFqJ4q1vUl04GWg8kbqGe0qVCTL6DXIBs4RgJL2TKzu308yAAWCLx65fc2G5IM7
         YM7BIW8jRw6n2XczwmVy8D6GN78ZF5JDxt2W22Z3Hu8XpHPehPZ3wKWBiQ9BhPiY6F
         ycQaJu31KzPHHVGvnzTyMBc/gKVgvDDSZdU3gfLFD2fMMN4R9yEW4PE67zbibrDbAv
         pNTvjD0f1WvOw==
Date:   Wed, 28 Sep 2022 05:32:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] linux-tpmdd updates for v6.0-rc1
Message-ID: <YzOyMwnNnzetJYU2@kernel.org>
References: <20220928005852.10729-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928005852.10729-1-jarkko@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 28, 2022 at 03:58:52AM +0300, Jarkko Sakkinen wrote:
> Hi,
> 
> Just some bug fixes.
> 
> BR, Jarkko
> 
> The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:
> 
>   Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.0-rc1
> 
> for you to fetch changes up to 603fd3d42e144ca36e8340c81b0144c5e7f8b9c2:
> 
>   selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle (2022-09-28 03:53:47 +0300)
> 
> ----------------------------------------------------------------
> tpmdd updates for Linux v6.0-rc1
> 
> ----------------------------------------------------------------
> Stefan Berger (1):
>       selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle
> 
> Vincenzo Frascino (1):
>       security/keys: Remove inconsistent __user annotation
> 
> Wolfram Sang (1):
>       char: move from strlcpy with unused retval to strscpy
> 
>  drivers/char/tpm/tpm_ppi.c           | 2 +-
>  security/keys/keyring.c              | 2 +-
>  tools/testing/selftests/tpm2/tpm2.py | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)

Oops, please ignore.

BR, Jarkko
