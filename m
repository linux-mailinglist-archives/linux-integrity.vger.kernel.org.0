Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026B615ABED
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 16:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLP0F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 10:26:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44658 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbgBLP0F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 10:26:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0AE9A8EE130;
        Wed, 12 Feb 2020 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581521164;
        bh=UhcYb0ZNwAagddp1CNcph1z/cpfPqKHLWN5VnXSpzB8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vwPpezumiMiTxHYDUVegYOsDShiJFb4ZyJ2PugmBo92PG97bIWjMRL3TmAZk5gxDA
         kO+vQ3kwJZ4dsj/hVEEFHztGptF8MNvaDHjM3jesSSDZtkkXvcAeF2KwgE8ufX9ODE
         uZq+24aKYhaT6rClXGbVamceVxMx3plyuL96aPt0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id da-hWHbLZEOZ; Wed, 12 Feb 2020 07:26:03 -0800 (PST)
Received: from jarvis.ibmmobiledemo.com (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E077C8EE0CF;
        Wed, 12 Feb 2020 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581521163;
        bh=UhcYb0ZNwAagddp1CNcph1z/cpfPqKHLWN5VnXSpzB8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FsvrSx+Kegav2PJGjL+E4NihbAerQ+mwGf+YerTwM1xQU8ng8rmQf24P/vlF7cGwj
         JsbPuLTSn/3bT3v4IOGN/AWsSMUOLOEoS8etEFrRyayIqmL+ual+A2cCE0dBfR+Zs8
         GsWlyYE7ivyE1m+ryJg/GT1kGT6KmHQSsNNkb82c=
Message-ID: <1581521161.3494.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 10:26:01 -0500
In-Reply-To: <1581517770.8515.35.camel@linux.ibm.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
         <20200211231414.6640-4-tusharsu@linux.microsoft.com>
         <1581517770.8515.35.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-12 at 09:29 -0500, Mimi Zohar wrote:
> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
> > The #define for formatting log messages, pr_fmt, is duplicated in
> > the
> > files under security/integrity.
> > 
> > This change moves the definition to security/integrity/integrity.h
> > and
> > removes the duplicate definitions in the other files under
> > security/integrity. Also, it adds KBUILD_MODNAME and
> > KBUILD_BASENAME prefix
> > to the log messages.
> > 
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Joe Perches <joe@perches.com>
> > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> <snip>
> 
> > diff --git a/security/integrity/integrity.h
> > b/security/integrity/integrity.h
> > index 73fc286834d7..b1bb4d2263be 100644
> > --- a/security/integrity/integrity.h
> > +++ b/security/integrity/integrity.h
> > @@ -6,6 +6,12 @@
> >   * Mimi Zohar <zohar@us.ibm.com>
> >   */
> >  
> > +#ifdef pr_fmt
> > +#undef pr_fmt
> > +#endif
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
> > +
> >  #include <linux/types.h>
> >  #include <linux/integrity.h>
> >  #include <crypto/sha.h>
> 
> Joe, Shuah, including the pr_fmt() in integrity/integrity.h not only
> affects the integrity directory but everything below it.  Adding
> KBUILD_BASENAME to pr_fmt() modifies all of the existing IMA and EVM
> kernel messages.  Is that ok or should there be a separate pr_fmt()
> for the subdirectories?

Log messages are often consumed by log monitors, which mostly use
pattern matching to find messages they're interested in, so you have to
take some care when changing the messages the kernel spits out and you
have to make sure any change gets well notified so the distributions
can warn about it.

For this one, can we see a "before" and "after" message so we know
what's happening?

James

