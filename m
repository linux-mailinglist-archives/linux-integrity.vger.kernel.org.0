Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4A3BB79E
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGEHSM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 03:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhGEHSK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 03:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9D61613CB;
        Mon,  5 Jul 2021 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625469334;
        bh=5FA99aT8AlQo8ThOr2IJaWRk3P9WQBrY5qaUGtfHvs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6gandPZMrXwFhwu490RJIaSzqBnKDBaJ7fsSHrLrihi6ruUI+R+r/bDk0rrmk5re
         HDONk/m2k1GRGw7RC+4L4IUpqlbsDmmycyvvPvflWTHgJTtTtQEpMXjFM7GIxlqCtx
         syei3TT6TC1rW76M16iMeCpIKd8r8PBRJXqKiBwZY4g3BW+86i1GVJK3P0yOl4q2+k
         yN1eAo7LA5qrzkawQr32/H9Y4wP5dvpI1aTFENb8Dv8uPYGUTZkRcL8U6llRN2XjgG
         1XUM0uKtWRJ2Q904I0j3mkkbmNf9ZYHyvD63Bl1piXAo7AIoCYT6GkdgSNH88/fywH
         Lj28YLGTEG5bw==
Date:   Mon, 5 Jul 2021 10:15:31 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     shrihari.kalkar@rubrik.com, seungyeop.han@rubrik.com,
        anish.jhaveri@rubrik.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
Message-ID: <20210705071531.axxzyvecf52foik2@kernel.org>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210704000754.1384-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704000754.1384-1-hao.wu@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Is this really the first version? Please, use git-format-patch -vX.

On Sat, Jul 03, 2021 at 05:07:54PM -0700, Hao Wu wrote:
> This is a fix for the ATMEL TPM crash bug reported in
> https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> 
> According to the discussions in the original thread,
> we don't want to revert the timeout of wait_for_tpm_stat
> for non-ATMEL chips, which brings back the performance cost.
> For investigation and analysis of why wait_for_tpm_stat
> caused the issue, and how the regression was introduced,
> please read the original thread above.

Please, no xrefs. Instead, describe what you are doing.

> Thus the proposed fix here is to only revert the timeout
> for ATMEL chips by checking the vendor ID.

What do you mean by reverting?

The long description needs a full rewrite.

You can add

Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/

But do not expect anyone to read the thread in order to
understand what the commit is doing.

> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> ---
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash
> has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> the timeout has not been changed.

The changelog is missing.

Please read section 14 of

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

/Jarkko
