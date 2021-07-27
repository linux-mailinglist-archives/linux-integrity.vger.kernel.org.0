Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6BC3D6C53
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhG0C0U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234516AbhG0C0T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D31760FEE;
        Tue, 27 Jul 2021 03:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627355207;
        bh=DIiftXJQJ/lWkr5d0rvqxWwra+Io5sKwN69YIcUr7NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4ahC8PqXKKMzUmS/EoQJ4WavKf7Z+0d5pu4KdZZRGVvUSmBk+PdYbZc7fcU8wy+j
         mTtEJ2LEZbWEjJt6VT8Qvo+8c7Rp2Sioz9aLDgM1DTJgDSS/saB3KP/BMya2CgTfAU
         c1aVOM2b2kOn2duq+qqwh6SZ0eYfj6D+HzLmQvTmsEaFX2e+XDGe5it5h1q7kdFVG4
         nugWNIiDjBHsTgXH2e32ou7lGCQBOvUZcLqvmz4mjC/HMeyaAWMFF6N4HlYJj0u66R
         yd+k9H0zZmr/Tr5MEHA0X6Q3+8kJhZNAbXSFiYtWYqlf7psCAQ8jpEgFIzL6SN0+0x
         ZMWB/7SSyVbSw==
Date:   Tue, 27 Jul 2021 06:06:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/2] char: tpm: Kconfig: remove bad i2c cr50 select
Message-ID: <20210727030645.apyjqlfbj3do7jlr@kernel.org>
References: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 23, 2021 at 09:41:49PM +0300, Adrian Ratiu wrote:
> This fixes a minor bug which went unnoticed during the initial
> driver upstreaming review: TCG_CR50 does not exist in mainline
> kernels, so remove it.
> 
> Fixes: 3a253caaad11 ("char: tpm: add i2c driver for cr50")
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>



Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Also, for this I'd add:

Cc: stable@vger.kernel.org

?

/Jarkko
