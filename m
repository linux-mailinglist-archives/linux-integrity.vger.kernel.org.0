Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0C292015
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Oct 2020 23:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgJRVOb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Oct 2020 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgJRVOb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 17:14:31 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B57C061755;
        Sun, 18 Oct 2020 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JntMkUcaE6m2axYjHJlpEVkT5Ke5knS/JE2R/iZ99pg=; b=yKMXhIWSdeSD7VBKfA2omx2RaP
        ipWzb5Zgqvx4nMnjkGRqUYU7pO/nR7QaaAXH5vDoqhmD0MPcrqIqxvlBAOCbKD90lhM7Dh6lfWs8K
        Qy0RoERft6mWWfG6z8bI0MWAN9dy3t6pbObmvir1zxyfyBqgkdjdgcgLRzka7DbE57co1XuDSo6dW
        DJETbf+JWegtetCNkitCngSzR2VWrxRKmD8Vu2Ba4pBXpdPgSJ0U0SKCwVfCoKMeM7hrx8rZ1qnf4
        75Z6d0PQ2P54druh3gXQU2U91atwYwRYFgyzbUGkDkaNC7BAyCC6U39M9udWrlttxnBQ+mCONEbWM
        fwaU4GNg==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1kUG0b-0002xD-8l; Mon, 19 Oct 2020 00:14:29 +0300
Date:   Mon, 19 Oct 2020 00:14:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Message-ID: <20201018211428.GD575510@kapsi.fi>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <20201018211143.GC575510@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018211143.GC575510@kapsi.fi>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 12:11:44AM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 15, 2020 at 02:44:30PM -0700, Jerry Snitselaar wrote:
> > There is a misconfiguration in the bios of the gpio pin used for the
> > interrupt in the T490s. When interrupts are enabled in the tpm_tis
> > driver code this results in an interrupt storm. This was initially
> > reported when we attempted to enable the interrupt code in the tpm_tis
> > driver, which previously wasn't setting a flag to enable it. Due to
> > the reports of the interrupt storm that code was reverted and we went back
> > to polling instead of using interrupts. Now that we know the T490s problem
> > is a firmware issue, add code to check if the system is a T490s and
> > disable interrupts if that is the case. This will allow us to enable
> > interrupts for everyone else. If the user has a fixed bios they can
> > force the enabling of interrupts with tpm_tis.interrupts=1 on the
> > kernel command line.
> > 
> > Cc: jarkko@kernel.org
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I'll apply this and make it available in linux-next.

Applied.

Thank you.

/Jarkko
