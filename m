Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74227A252
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Sep 2020 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgI0SZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 14:25:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48264 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgI0SZn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 14:25:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD2C28EE17F;
        Sun, 27 Sep 2020 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601231142;
        bh=R770Mu0NynuMLR8a6WS6mHs3dr0pesAuzxOJVSlYl90=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DFl8Mb2N2EKEWZ8NEhsJcpWtvxtnUaC7xkZL69Dx2jI6F34lnObQx4t23ZOx2EEUz
         RvrXwyamYvkvWP2Kk8a1Ehf4h3nSjrP7fgem2DgYbCWUB+UGC6qaQqk8r6KJwAbt0w
         bQbJRt9bnQEscRD5w6euYTjM59yzC03ANdEeMDdQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0letzfqBxHsg; Sun, 27 Sep 2020 11:25:42 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9AA8C8EE012;
        Sun, 27 Sep 2020 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601231142;
        bh=R770Mu0NynuMLR8a6WS6mHs3dr0pesAuzxOJVSlYl90=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DFl8Mb2N2EKEWZ8NEhsJcpWtvxtnUaC7xkZL69Dx2jI6F34lnObQx4t23ZOx2EEUz
         RvrXwyamYvkvWP2Kk8a1Ehf4h3nSjrP7fgem2DgYbCWUB+UGC6qaQqk8r6KJwAbt0w
         bQbJRt9bnQEscRD5w6euYTjM59yzC03ANdEeMDdQ=
Message-ID: <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Sun, 27 Sep 2020 11:25:39 -0700
In-Reply-To: <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
         <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
         <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-09-26 at 16:10 -0700, Hao Wu wrote:
> Resending following email in plaintext.
> 
> ----
> 
> Hi James,
> 
> Thanks for following up.
> 
> We have actually tried change 
> TPM_TIMEOUT_USECS_MIN / TPM_TIMEOUT_USECS_MAX 
> according to https://patchwork.kernel.org/patch/10520247/
> It does not solve the problem for ATMEL chip. The chips facing crash
> is 
> not experimental, but happens commonly in 
> the production systems we and our customers are using.
> It is widely found in Cisco 220 / 240 systems which are using
> Ateml chips.

Well, I came up with the values in that patch by trial and error ....
all I know is they work for my nuvoton. If they're not right for you,
see if you can find what values actually do work for your TPM.  The
difference between msleep and usleep_range is that the former can have
an indefinitely long timeout and the latter has a range bounded one. 
If you think msleep works for you, the chances are it doesn't and
you're relying on the large upper bound to make the bug infrequent
enough for you not to see it.  Playing with the values in usleep range
will help you find what the actual timeout is and eliminate the problem
for good.

James


