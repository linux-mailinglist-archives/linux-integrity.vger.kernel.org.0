Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966B93A6EBF
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 21:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFNTVz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 15:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhFNTVy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 15:21:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE5461076;
        Mon, 14 Jun 2021 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623698391;
        bh=NQBklGVerSpRXCeIFhcT9srvsqM7Ilq8/ae/R7QiO8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbuCgKGrQtzWpphJqRBuup/QMyyieIWlT8MaOR0amac2RPFzK4hHxClIBbXaY/lCs
         a3Xy0T/iOKMY8VMyLPB3emTUcf1hSEncDUkTKRDOvQLY5FvZKSA7k0aTBjFzakJ55I
         Gp7vRtarSmSuAq9B/+uCKBqChCw4diQSo8r43+WqE3teuBtrANLlBD+3+QgO5jNdVY
         FRLQzxJqvXF8lR65Im54A4wVW5DxBGCYyfkLs9aR92zr47W4IAZAmYoW4pGC62Nysh
         YuUxqvvIVZXnYvkIlkVe2liUclfJmvicz1zJz4C2stbTjKuZUnZPPVlryhnfD7Bcb9
         938yesVJT+BZA==
Date:   Mon, 14 Jun 2021 22:19:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add support for ECDSA-signed kernel modules
Message-ID: <20210614191948.io4waff5aisah36q@kernel.org>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 08:56:19AM -0400, Stefan Berger wrote:
> This series adds support for ECDSA-signed kernel modules. It also
> attempts to address a kbuild issue where a developer created an ECDSA
> key for signing kernel modules and then builds an older version of the
> kernel, when bisecting the kernel for example, that does not support
> ECDSA keys.
> 
> The first patch addresses the kbuild issue of needing to delete that
> ECDSA key if it is in certs/signing_key.pem and trigger the creation
> of an RSA key. However, for this to work this patch would have to be
> backported to previous versions of the kernel but would also only work
> for the developer if he/she used a stable version of the kernel to which
> this patch was applied. So whether this patch actually achieves the
> wanted effect is not always guaranteed.
> 
> The 2nd patch adds the support for the ECSDA-signed kernel modules.
> 
> This patch depends on the ECDSA support series currently queued here:
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc
> 
>   Stefan
> 
> v6:
>   - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
>     patches to be squashed.
> 
> v5:
>   - do not touch the key files if openssl is not installed; likely
>     addresses an issue pointed out by kernel test robot
> 
> v4:
>   - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
>   
> v3: - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
>   - added recommendation to use string hash to Kconfig help text
> 
> v2:
>   - Adjustment to ECDSA key detector string in 2/2
>   - Rephrased cover letter and patch descriptions with Mimi
> 
> 
> Stefan Berger (4):
>   certs: Trigger creation of RSA module signing key if it's not an RSA
>     key
>   certs: Check whether openssl tool is available
>   certs: Add support for using elliptic curve keys for signing modules
>   certs: Adjustment due to 'Check whether openssl tool is available'
> 
>  certs/Kconfig                         | 26 ++++++++++++++++++++++++++
>  certs/Makefile                        | 21 +++++++++++++++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>  3 files changed, 55 insertions(+)
> 
> -- 
> 2.29.2
> 
> 

Since you know the commit ID's in

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

you could just use fixes-tags and send exactly two patch series. Works
better with various tools (e.g. https://pypi.org/project/b4/)

/Jarkko
