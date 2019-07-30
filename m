Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEB7AEF5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfG3RIl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 13:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfG3RIl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 13:08:41 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE15206A2;
        Tue, 30 Jul 2019 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564506520;
        bh=IANQ5fvEJp3Cs3+DxoI73cZ+MZ+3dX0kZDbVNxvV8Js=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nCIcFx2ovvm2/gGxxLCXnFFUOXB4umty5tyZQtMD8JFMuvUhX3c7LzcbhLJI68KHB
         1OxGzVrYpugp1RiehF+LxSLs757tLyYdc6CBHAZCBJx7RAxpq2ltThxywjaD/c2vn3
         C44hqgztGbXtpfMzD9a6W18jsJi3L+osFhswXCms=
Message-ID: <1564506503.4189.114.camel@kernel.org>
Subject: Re: ima-evm-utils: git tagging for release
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Tue, 30 Jul 2019 13:08:23 -0400
In-Reply-To: <20190730152829.y3nf54dq6md2pafy@altlinux.org>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
         <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
         <1564486237.4189.28.camel@kernel.org> <1564497374.4189.84.camel@kernel.org>
         <20190730152829.y3nf54dq6md2pafy@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-30 at 18:28 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Jul 30, 2019 at 10:36:14AM -0400, Mimi Zohar wrote:
> > 
> > I've also pushed out some of the bug fixes to next and ima-evm-utils-
> > 1.2.y.  Which of your remaining patches are bug fixes and should be
> > applied to both branches?
> 
> "ima-evm-utils: Do not load keys from x509 certs if user pass --rsa"
> - This allows user to not see the confusing error message for v1 signatures
>   if user knows to pass --rsa. This error message is not affecting
>   behavior, though.
> 
> All others are applied, I think.

Ok, this is now there as well.  Unless there are problems with this
version, I'll tag it and upload the tar.

thanks,

Mimi
