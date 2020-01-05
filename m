Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6F130999
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAETQM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jan 2020 14:16:12 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36490 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgAETQM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jan 2020 14:16:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 482F98EE148;
        Sun,  5 Jan 2020 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578251771;
        bh=iQhd1WEUGJWDISkQAFzPZyIl/MR1YXKm3rKQqg/CUYs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wpy7BSDDRWGavyns2ejlh71CMRnzB+i3EePtkYf4jGevOB7jcZNnvbYuFsI5nvVV8
         l6/nROcVAVsWNLLw9ExbRt3fnjCpd4flW1i4TPlMl41kHkRlnapPArcpCA0hKC8AYk
         pZ9vi6E69gtyu4OUpxHo9J42Z0QYRU59UEwhZCP8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AOo22OsbtvMc; Sun,  5 Jan 2020 11:16:11 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B36138EE0D2;
        Sun,  5 Jan 2020 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578251770;
        bh=iQhd1WEUGJWDISkQAFzPZyIl/MR1YXKm3rKQqg/CUYs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qf6FirrmgdF6OafoIZ67Z0MJxudMhCQ+TEPsp2Z6Jo9dNzhfHYIXs4Fksp+DjYgD+
         cxsRiSPTVktqvGAm7pYyPYTUTdVdz36AfOx7aC1D0mbBJtNDy2Kg5ahQeudXxtDi50
         Z4eobt3ZKEh7zly/NdI2cuOb1TS4yKg2Sff1XX4A=
Message-ID: <1578251768.3310.49.camel@HansenPartnership.com>
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Sun, 05 Jan 2020 11:16:08 -0800
In-Reply-To: <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
         <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
         <1578248115.3310.41.camel@HansenPartnership.com>
         <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-01-05 at 10:56 -0800, Lakshmi Ramasubramanian wrote:
> On 1/5/2020 10:15 AM, James Bottomley wrote:
> 
> > > #ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > void ima_init_key_queue(void);
> > > #else
> > > static inline void ima_init_key_queue(void) {}
> > > #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> > > 
> > > If I understand the reported build error, it looks like
> > > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was disabled first and then
> > > enabled later - in the same build sequence.
> > > 
> > > Is that correct?
> > 
> > I don't think so.  The specific problem is that
> > ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined as a tristate in
> > crypto/asymmetric_keys/Kconfig, so the above m setting for it is
> > perfectly legal regardless of the IMA setting.  This line you
> > introduced to the Makefile:
> > 
> > obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) +=
> > ima_asymmetric_keys.o
> > 
> > Then causes ima_asymmetric_keys.o to be added to obj-m causing the
> > kernel to think it's building it as a module.
> > 
> > To fix this, I think you have to force
> > ASYMMETRIC_PUBLIC_KEY_SUBTYPE to
> > be built in if IMA is.
> > 
> > James
> 
> Thanks for the info James. That explains the other error reported 
> earlier - ima_asymmetric_keys.c being built as a kernel module.
> 
> Since IMA can currently be enabled without enabling the KEYS
> subsystem, I feel forcing ASYMMETRIC_PUBLIC_KEY_SUBTYPE to be built
> if IMA is may  not be safe. Right?

In general trying to force via select can have unintended consequences
for options with large dependencies, yes.

> Instead can CONFIG_ASYMMETRIC_KEY_TYPE be used to enable key
> measurement code in IMA?

Well, yes, you just need to condition the build of ima_asymmetric_keys
on a boolean instead of a tristate, so you introduce an intermediate
one:

config IMA_ASYMMETRIC_KEYS
	bool
	default y
	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y

James

