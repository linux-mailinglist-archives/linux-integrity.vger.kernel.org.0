Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE447AB24
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfG3Ogb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 10:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbfG3Ogb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 10:36:31 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A87FD20657;
        Tue, 30 Jul 2019 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564497391;
        bh=xv5GDxdiD9drDPG1PDHBdNioIrIODtWpqupo7lCf7x0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sWxDUrYn+Ojn5Xx10Lef2pSXqp1tV0mCuq+8ukI/m54MIeZOGRspEgAV8YKgyKkjI
         u25VrjzrsQSjmov7yaN6fx9eUHbcViHW39bQva0EV3t7O885w7+PeujSsUbgAirCzd
         2vOUfYuuQE0j+zO12Z/1bw5miEyy+Anhm7S5czRg=
Message-ID: <1564497374.4189.84.camel@kernel.org>
Subject: Re: ima-evm-utils: git tagging for release
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Cc:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Tue, 30 Jul 2019 10:36:14 -0400
In-Reply-To: <1564486237.4189.28.camel@kernel.org>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
         <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
         <1564486237.4189.28.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-30 at 07:30 -0400, Mimi Zohar wrote:
> Hi Vitaly,
> 
> On Tue, 2019-07-30 at 09:26 +0300, Vitaly Chikunov wrote:
> > Mimi,
> > 
> > It seems that you are released v1.2 of ima-evm-utils. (I did not receive
> > any announcement on linux-integrity.) I noticed that you are not using
> > annotated tags for release versions.
> 
> In the future, I'll announce it here.
> 
> > 
> > I suggest you use annotated tags (possible even signed) for release
> > versions. (You will need to delete existing v1.2 local tag if you are
> > going to retag it with annotated tag.)

Done

> There are a couple of additional bug fixes that need to be applied
> against the v1.2 release.  Maybe it would be better to release v1.2.1
> with these additional bug fixes, using the annotated tag.

I've also pushed out some of the bug fixes to next and ima-evm-utils-
1.2.y.  Which of your remaining patches are bug fixes and should be
applied to both branches?

thanks,

Mimi
