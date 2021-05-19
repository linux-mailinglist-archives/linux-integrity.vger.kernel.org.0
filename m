Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1C3888C6
	for <lists+linux-integrity@lfdr.de>; Wed, 19 May 2021 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhESH4z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 May 2021 03:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhESH4z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 May 2021 03:56:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79CA060FDC;
        Wed, 19 May 2021 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621410936;
        bh=yUbE+px/6gOPTPVPQfpUK35kefreBxxbJ76GQwwDZs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjtMlupdr4JiIPMb/7FeiANrvoq4Pyz32YH1n6tRgM6QhtPlS3Ugghe/IdvNwi+9D
         BaNcpCJDwI1zjqrYW0P5590cSRL/uKSvmHC8VtXV0wZWPgW37GyMMJicrmU5Ig7nYr
         p07d4y0BZB12bWbYBnBAXYYDQys8xd/nQAcYqHNRB0QG43lSES18xIrghAa9+W5k4U
         7VhRK/TJCX0VYB0a6RPAmA0TxDvnejiS9RSKyDhOt5ioURQEXEA1S7oGnT2or4SpYA
         l4yzGgjNgTkzQqlk1/foV1MIrl9Vg1Dr52yEhT/U/T12Iv9E5yHi8WIYx8syR++flH
         W8sDnAEFa4QJQ==
Date:   Wed, 19 May 2021 10:55:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
Message-ID: <YKTEdWgwy0R1qpOE@kernel.org>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517225714.498032-1-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 17, 2021 at 06:57:11PM -0400, Eric Snowberg wrote:
> This series is being sent as an RFC. I am looking for feedback; if
> adding additional MOK variables would be an acceptable solution to help
> downstream Linux distros solve some of the problems we are facing?
> 
> Currently, pre-boot keys are not trusted within the Linux boundary [1].
> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> keys are loaded into the platform keyring and can only be used for kexec.
> If an end-user wants to use their own key within the Linux trust
> boundary, they must either compile it into the kernel themselves or use
> the insert-sys-cert script. Both options present a problem. Many
> end-users do not want to compile their own kernels. With the
> insert-sys-cert option, there are missing upstream changes [2].  Also,
> with the insert-sys-cert option, the end-user must re-sign their kernel
> again with their own key, and then insert that key into the MOK db.
> Another problem with insert-sys-cert is that only a single key can be
> inserted into a compressed kernel.
> 
> Having the ability to insert a key into the Linux trust boundary opens
> up various possibilities.  The end-user can use a pre-built kernel and
> sign their own kernel modules.  It also opens up the ability for an
> end-user to more easily use digital signature based IMA-appraisal.  To
> get a key into the ima keyring, it must be signed by a key within the
> Linux trust boundary.
> 
> Downstream Linux distros try to have a single signed kernel for each
> architecture.  Each end-user may use this kernel in entirely different
> ways.  Some downstream kernels have chosen to always trust platform keys
> within the Linux trust boundary.  In addition, most downstream kernels
> do not have an easy way for an end-user to use digital signature based
> IMA-appraisal.
> 
> This series adds two new MOK variables to shim. The first variable
> allows the end-user to decide if they want to trust keys contained

Nit: would be nice to just say "what it is" instead "what it allows".

> within the platform keyring within the Linux trust boundary. By default,
> nothing changes; platform keys are not trusted within the Linux kernel.
> They are only trusted after the end-user makes the decision themself.
> The end-user would set this through mokutil using a new --trust-platform
> option [3]. This would work similar to how the kernel uses MOK variables
> to enable/disable signature validation as well as use/ignore the db.
> 
> The second MOK variable allows a downstream Linux distro to make

...

> better use of the IMA architecture specific Secure Boot policy.  This
> IMA policy is enabled whenever Secure Boot is enabled.  By default, this 
> new MOK variable is not defined.  This causes the IMA architecture 
> specific Secure Boot policy to be disabled.  Since this changes the 
> current behavior, it is placed behind a new Kconfig option.  Kernels
> built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
> to enable this through mokutil using a new --ima-sb-enable option [3].
> This gives the downstream Linux distro the capability to offer the
> IMA architecture specific Secure Boot policy option, while giving
> the end-user the ability to decide if they want to use it.
> 
> I have included links to both the mokutil [3] and shim [4] changes I
> made to support this new functionality.
> 
> Thank you and looking forward to hearing your reviews.
> 
> [1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
> [2] https://lore.kernel.org/patchwork/cover/902768/
> [3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars
> [4] https://github.com/esnowberg/shim/tree/mokvars
> 
> Eric Snowberg (3):
>   keys: Add ability to trust the platform keyring
>   keys: Trust platform keyring if MokTrustPlatform found
>   ima: Enable IMA SB Policy if MokIMAPolicy found
> 
>  certs/system_keyring.c                        | 19 ++++++++-
>  include/keys/system_keyring.h                 | 10 +++++
>  security/integrity/ima/Kconfig                |  8 ++++
>  security/integrity/ima/ima_efi.c              | 24 ++++++++++++
>  .../platform_certs/platform_keyring.c         | 39 +++++++++++++++++++
>  5 files changed, 99 insertions(+), 1 deletion(-)
> 
> -- 
> 2.18.4
> 
> 

/Jarkko
