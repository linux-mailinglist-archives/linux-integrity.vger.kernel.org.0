Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4471D22C4
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 01:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbgEMXJn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 19:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732151AbgEMXJl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 19:09:41 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961762054F;
        Wed, 13 May 2020 23:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589411381;
        bh=MDKKhxS3qnWK4BCrQ1PaiGfthIWnaDdy/Elx3PLfxkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vxxgJDwVu3ejPYUlWha5J3HdCxu1uNF6+1tzoc0keVPog+ccKulCDqnX0bKh9CCf4
         goBt6UPCK6LGM9Yu17EJznVJqD3FEgEeY7C1Wf/qn/nEpimeMT2k27ycRqxONiI1I3
         FTbcaYC3kbXd3voWoeI84psE+sh1BbAVXRBhDLY0=
Date:   Wed, 13 May 2020 18:14:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200513231416.GQ4897@embeddedor>
References: <20200507040912.GA31382@embeddedor>
 <20200513213905.GB31974@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513213905.GB31974@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 14, 2020 at 12:39:05AM +0300, Jarkko Sakkinen wrote:
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > [4] https://github.com/KSPP/linux/issues/43
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 

Hi Jarkko,

Thanks for your RB.

There is a v2 of this patch:

https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/

Thanks
--
Gustavo
