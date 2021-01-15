Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984352F7304
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 07:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbhAOGs4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 01:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGsz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 01:48:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76A1C22597;
        Fri, 15 Jan 2021 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610693295;
        bh=rA8n7nZk/SuKc1QVpatHxvj8itVBTkAFKFLIRENn0Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngRiYzDvtW4Lim+dh3eE/Mu8hinYp2KF87pp0UKpHT8Vld0Z77olfZP8nF5z9PMgT
         JJVE+C9hQMuW0DlYYtFXyWT9R78djYBZpzFp2+zw1ALaWgR26hZR0kgvUCFVwo0xRY
         v2fdxH0NfLR/kUQjTiLIDBcyoV3UFVNE+GccLYY2zcU/GwTKfjjn3cLMx5pFdPvvYJ
         pAXX1oNkD7NXcQdc07nGt5XtcIdFwmruNNlWHGj9N9ZFOWS2B7z9cYqhd22NwOaqpi
         EBc74o5uXSJ7kClVjUC2TUwcDWZbmsY3GHRtTO+QlP4zWC9aR+cpsJJbv6UAlTV20H
         VBIu+uWt4MSUw==
Date:   Fri, 15 Jan 2021 08:48:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <YAE6q/qxpVcpJ9BJ@kernel.org>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
 <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 03:26:33PM -0800, James Bottomley wrote:
> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> ---

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

