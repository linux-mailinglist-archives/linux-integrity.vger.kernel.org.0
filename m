Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16520390FCB
	for <lists+linux-integrity@lfdr.de>; Wed, 26 May 2021 06:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhEZEwO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 May 2021 00:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhEZEwO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 May 2021 00:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD33B6138C;
        Wed, 26 May 2021 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622004643;
        bh=xWZssZLzeeutnbtwx05LnJcWgG7rsPibYpQf/tb43JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FULZA0ZuZUvdtLWim8eh0Y1evYUEFKESPHdKSs+ZgmA/TAiFi8asT+bT2XBiMQ6MO
         nRmbLMz5Q1xQfUju/40pJu5VZePnuS2N2UAtoNq3jaJYshdTgaUDsN0lxYmJcIjR3a
         F0SjPIo8uItnZUCO6MuDVTu/7Vifv6eRwfiVsLGDi3n9y+lPe+O2TaJwOPaHJ8hrDP
         1BuergTPFwkvBVPeZRkTmITVELbOoyZ7Frh+AkjOc4ciRoId3ZojuNo8zz1bUoxMWY
         OwEHX79EuVTnQImKFOyYANtDe8/7b2BRtxtAub17NsTFIrSbjK+by+MNskdVqBownT
         DtHRQ8pNFDoYw==
Date:   Wed, 26 May 2021 07:50:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4] tpm2: add longer timeout for verify signature command
Message-ID: <YK3ToDAiIUQ5whAN@kernel.org>
References: <20210525111325.158790-1-amirmizi6@gmail.com>
 <20210525111325.158790-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525111325.158790-2-amirmizi6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 25, 2021 at 02:13:25PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> While running a TPM2_CC_VERIFY_SIGNATURE operation with RSA 3072-bit
> keys the TPM driver fails with the following error:
> 
> "kernel: [ 2416.187522] tpm tpm0: Operation Timed out"
> 
> Since the TPM PC Client specification does not specify a number for
> verify signature operation timeout, and the duration of
> TPM2_CC_VERIFY_SIGNATURE with RSA 3072-bit keys exceeds the current timeout
> of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
> possible.
> 
> Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
> (5 minutes).
> 
> Link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

/Jarkko

