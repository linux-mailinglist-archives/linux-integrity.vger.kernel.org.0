Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CEBC9D4C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfJCLbP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 07:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfJCLbP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 07:31:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C58B20830;
        Thu,  3 Oct 2019 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570102274;
        bh=L5QzbVAsls8qitJom+2MsYWRpUVL7rpChg5mZ9JGQ4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mY93TulDp3NeDtrEixgOQs9CTaomFf/67X+WdbWC2iZCT7G7KwTb0XH7EYXhv8IxZ
         FGh9k434aZIDwoDwTylrtKwuks9YkSUHw97a5ksjItDZ2PBU2sJrVS1KiWq7/Wm6S2
         pAoFKtkP9zCYtRSYibIEF25IkHRbx9Xe4V2jTx/8=
Date:   Thu, 3 Oct 2019 13:31:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: migrate pubek_show to struct tpm_buf
Message-ID: <20191003113112.GB2447460@kroah.com>
References: <20191003112424.9036-1-jarkko.sakkinen@linux.intel.com>
 <20191003112424.9036-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003112424.9036-2-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 02:24:22PM +0300, Jarkko Sakkinen wrote:
> commit da379f3c1db0c9a1fd27b11d24c9894b5edc7c75 upstream
> 
> Migrated pubek_show to struct tpm_buf and cleaned up its implementation.
> Previously the output parameter structure was declared but left
> completely unused. Now it is used to refer different fields of the
> output. We can move it to tpm-sysfs.c as it does not have any use
> outside of that file.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 87 ++++++++++++++++++++----------------
>  drivers/char/tpm/tpm.h       | 13 ------
>  2 files changed, 48 insertions(+), 52 deletions(-)

Again, what kernel tree(s) do you want this, and the other 2 patches
applied to?  And why?

thanks,

greg k-h
