Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E195216951
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGGJln (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 05:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgGGJln (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 05:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10A52065F;
        Tue,  7 Jul 2020 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594114902;
        bh=RBwXDbkxkjvhcjaR8b3AzukUIIlW1vbcbUAuSiqXJA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIY95owAI/ozE55P33WG/59Xos9pQNKsMXxjB+3cI0UYPuhh1F0aCjJn/1rhyvkzi
         uQGDsDfFUcfg8YZmrLeYWlLHkqBLZtgb3zhFaBbyiaxadFRr6R2DsQ9ziissCJQcd6
         FUhD6MNf/pEFTkB7NR1PhTrA0F/NIvyzWmr2VPaE=
Date:   Tue, 7 Jul 2020 11:41:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID
 IFX0102")
Message-ID: <20200707094140.GB2639362@kroah.com>
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 11:53:42PM +0300, Jarkko Sakkinen wrote:
> Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> and tpm_infineon use the same device ID. Revert the commit and add a
> remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> module parameter").
> 
> Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> Reported-by: Peter Huewe <peterhuewe@gmx.de>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

As the original was asked to be applied to the stable trees, this one
should have as well.

I'll go drop it from the stable queues right now, thanks.

greg k-h
