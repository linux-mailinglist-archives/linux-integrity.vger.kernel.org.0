Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32223029F0
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Jan 2021 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbhAYSTU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Jan 2021 13:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbhAYRND (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jan 2021 12:13:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5068922B37;
        Mon, 25 Jan 2021 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611594725;
        bh=BcVGUAj+xGkXTNYxyy4IxxVaL7E+SB7aCoaGZIuUUnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oH5Kk7O7hHPy8/A3oe0/u0LK3AdK1Ne/NgUI169mmX2a4GGyFX5JJrxRH1tx1SLoY
         V+prgZ2dqh/mFbhwq/zNrev0D7zIKvJi9TzuCJbvN1CIHGYKPsuIai0kebZK1n4M7x
         Y6C46nfaRsxPDTEV0+A2RdDQfCl4cB4hfZ7mSudQtDB8amKLtWrwHANaxGIBaWoyrv
         Eay7EALxoG6VkxDfzCK69rMjbtXt9/67tUgr93f1tgBHFcXX3hLg80JbBhodyzkUDv
         jdS8oQEAvZHCsDdDffKqSY1NpArvftSeL4ZC7duBAKBW0I08HFKzWvjo0E5ER0XE8U
         DaSIsWoFTFRwg==
Date:   Mon, 25 Jan 2021 19:12:02 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YA774rPm1a39y/V7@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123014247.989368-1-lma@semihalf.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 23, 2021 at 02:42:47AM +0100, Lukasz Majczak wrote:
> There is a missing call to start_tpm_chip before the call to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> approach maight work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
> transmit TPM commands on a disabled chip what what doesn't succeed
> and in turn causes tpm_tis_core_init() to fail.
> Tested on Samsung Chromebook Pro (Caroline).
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>

Do you have a log demonstrating the failure?

/Jarkko
