Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E997DD22BB
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfJJI1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Oct 2019 04:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJI1t (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Oct 2019 04:27:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56AF121920;
        Thu, 10 Oct 2019 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696069;
        bh=9glaKBn2ZmyMdC4E+Z9hvdn6xoVdAeOtB7Jesq2lVLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV9Ceoz+R62iEkWAZQsjL+Q1KdeNih1Ded2cv15r/DNrvqUWUL1l+VG7LkTk6Q2v7
         Gdt42LIjSfSTActMGCl7k+edat/cXyA1O6A1wN/W1F2FgUy68bwVQVveLp8I9vv+pG
         RMQ+OJzjpfGRKrCeGTje/U4guWQGVbVaCO68SkTY=
Date:   Thu, 10 Oct 2019 10:27:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] tpm: use tpm_try_get_ops() in tpm-sysfs.c.
Message-ID: <20191010082746.GB326087@kroah.com>
References: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
 <20191009212831.29081-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009212831.29081-3-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 10, 2019 at 12:28:30AM +0300, Jarkko Sakkinen wrote:
> commit 2677ca98ae377517930c183248221f69f771c921 upstream
> 
> Use tpm_try_get_ops() in tpm-sysfs.c so that we can consider moving
> other decorations (locking, localities, power management for example)
> inside it. This direction can be of course taken only after other call
> sites for tpm_transmit() have been treated in the same way.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 134 ++++++++++++++++++++++-------------
>  1 file changed, 83 insertions(+), 51 deletions(-)

This is already in the 4.14.148 4.19.78 5.1 releases.

greg k-h
