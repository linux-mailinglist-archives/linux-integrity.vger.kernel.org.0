Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9B100142
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRJ1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 04:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRJ1Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 04:27:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8500520727;
        Mon, 18 Nov 2019 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574069245;
        bh=Rps6VHNZkf0Vw651PAQcvS5aj/kdFjBNct/TEC/byN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdlMt0eutnDFaTXmS4gGFIT/SNFiG3KL7VQ3A+tyzTo69xBX/HJBUYh789u8geWPS
         8y11hoOFVLMo++Klgx3tuBbQONJVkQEzMMaGSqA3GUsnRgEazMdTW0oXpvTtU1WO8K
         k1WAP2xMOCTNXKSFTr8YT5AfjjkGID/hg1v9Wzn8=
Date:   Mon, 18 Nov 2019 10:27:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735: possible missing
 return value check
Message-ID: <20191118092721.GA154812@kroah.com>
References: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 18, 2019 at 09:24:32AM +0000, David Binderman wrote:
> Hello there,
> 
> linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735:5: style: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
> 
> Source code is
> 
>     if (tpm_suspend_pcr)
>         rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
>                      "extending dummy pcr before suspend");
> 
>     rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
> 
> Suggest add test of rc after call to tpm1_pcr_extend.

Great, how about you submit a patch to resolve this?  That way you can
get the full credit for finding and resolveing the issue?

thanks,

greg k-h
