Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5510BD22B8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfJJI12 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Oct 2019 04:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJI12 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Oct 2019 04:27:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B03D2067B;
        Thu, 10 Oct 2019 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696047;
        bh=zBl3/UkH++xKHU4rE1SLp1H9yBZ229QKvlXTCt42uCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1vmmrKGaItkB+sPyvIxr81CWN7nShQsRTex4j5bphWg6AOmamJaOeJR8Qw0yHDrR
         m2ak2aD5m7/Yl5FWGgcMUjIyLvcsKn00GRvtpQtu7xNSqgtEKzvwbAC0jRV0KiEs0P
         UXsEUtrh7t+XFWGuopiYJTpn3eXtV6KQs41DXHRo=
Date:   Thu, 10 Oct 2019 10:27:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tpm: migrate pubek_show to struct tpm_buf
Message-ID: <20191010082725.GA326087@kroah.com>
References: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
 <20191009212831.29081-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009212831.29081-2-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 10, 2019 at 12:28:29AM +0300, Jarkko Sakkinen wrote:
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

This is already in the 4.14.148 kernel release.

Why do we need it again?

Also, the mailing list is stable@vger, not linux-stable@vger.

thanks,

greg k-h
