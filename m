Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E71D2386
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgENATE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 20:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbgENATE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 20:19:04 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB0120693;
        Thu, 14 May 2020 00:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589415544;
        bh=CD4N2kYHsBTuzKadIQVU6xv0hw2/L6I5nqN2IoegrMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iljR2kEvoMGCgeKYu1CpDI03KJtk5CLSDGaxm9j1dl8hFoO9d4XC3ZGRzRl2ks1yt
         TPR1i2ld9vaYI+otu5Zgxc5q6HWOA+fw4neL9si/NuNbi86CrR8/P/KPZDY3ixR/BD
         XBxFOGorkdIoMlDMi2XijG+66gQRY32nk2evGSsc=
Date:   Wed, 13 May 2020 19:23:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200514002339.GR4897@embeddedor>
References: <20200508163826.GA768@embeddedor>
 <202005112224.9EFD07F5@keescook>
 <2a77f3bc9e7ed88343bbd206eaf25f10a697de90.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a77f3bc9e7ed88343bbd206eaf25f10a697de90.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 14, 2020 at 03:08:58AM +0300, Jarkko Sakkinen wrote:
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thank you.
> 
> I applied this patch, will include it to the next PR.
> 

Awesome. :)

Thanks, Jarkko.
--
Gustavo
