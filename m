Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9927B46E
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1S0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 14:26:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33642 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgI1S0m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 14:26:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 327888EE17F;
        Mon, 28 Sep 2020 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601317602;
        bh=Y+K5aPh4W5C83LEsG0viF/cwBpcp+43MwPXnYLEy2QQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jhxIMy3PKzuut0hbG3gfpw97SixiVSTO+luHHqwUnW0X6ZQgMZI7eFWcveURMD9v4
         ABjKx+rNRnvHQdLGGLB7hloCj2TXJ6yEljGKSHDehwWUediC/o1yQXZuZB/6afRAvZ
         ihU0m0ldwb9+9Y/g7fcmCkv07u/1KQEENJqF1mfM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R6j5sC-2o_Y4; Mon, 28 Sep 2020 11:26:42 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D942F8EE0F5;
        Mon, 28 Sep 2020 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601317602;
        bh=Y+K5aPh4W5C83LEsG0viF/cwBpcp+43MwPXnYLEy2QQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jhxIMy3PKzuut0hbG3gfpw97SixiVSTO+luHHqwUnW0X6ZQgMZI7eFWcveURMD9v4
         ABjKx+rNRnvHQdLGGLB7hloCj2TXJ6yEljGKSHDehwWUediC/o1yQXZuZB/6afRAvZ
         ihU0m0ldwb9+9Y/g7fcmCkv07u/1KQEENJqF1mfM=
Message-ID: <6720ff958180a9e040c655dcfc281b3260fe88f2.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 28 Sep 2020 11:26:41 -0700
In-Reply-To: <20200928181304.GB122104@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
         <20200928001138.GE5283@linux.intel.com>
         <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
         <20200928112046.GA14051@linux.intel.com>
         <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
         <20200928163114.GC92669@linux.intel.com>
         <20200928170720.GA119268@linux.intel.com>
         <d44256f102c7be01808c5186d2c23b685ff090b7.camel@HansenPartnership.com>
         <20200928181304.GB122104@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-28 at 21:13 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2020 at 10:40:55AM -0700, James Bottomley wrote:
> > On Mon, 2020-09-28 at 20:07 +0300, Jarkko Sakkinen wrote:
> > > On Mon, Sep 28, 2020 at 07:31:18PM +0300, Jarkko Sakkinen wrote:
> > > > > Well, um, that's precisely what this function originally did
> > > > > when it was inside drivers/char/tpm.  You told the guy who
> > > > > did the move into security/keys/trusted-keys to convert
> > > > > everything to use tpm_send which encapsulates the get/put
> > > > > operation, which is why we now have the flush bug.  If you
> > > > > really want it done like this, then I'd recommend moving
> > > > > everything back to drivers/char/tpm so we don't have to do a
> > > > > global exposure of a load of tpm internal functions (i.e.
> > > > > move them from drivers/char/tmp.h to include/linux/tpm.h and
> > > > > do an export on them).
> > > > 
> > > > My BuildRoot test image did not include the patch. I was
> > > > wondering why I did not bump into deadlock with the fix
> > > > candidate :-/
> > > >  Forgot export LINUX_OVERRIDE_SRCDIR.
> > > > 
> > > > But you are absolutely correct, thanks for recalling. I made a
> > > > mistake there.
> > > > 
> > > > I do disagree though that this should be moved back to
> > > > drivers/char/tpm, as also TPM 1.x code lives in trusted-keys.
> > > > It is good to have API for doing sequences TPM commands and
> > > > keep the core in drivers/char/tpm.
> > 
> > I think tpm2_load_cmd is likely going to have to move back anyway
> > just because more things than trusted keys need to use it.  I can't
> > really see any other use for the seal/unseal so they can stay in
> > trusted keys until someone finds a use for them.
> 
> We can obviously do that if there are multiple customers for it.

Yes, let's just leave everything where it is until there's a use case
for moving it.

> > > > If you look at tpm_send() it is in essence just simply locking
> > > > TPM and and calling tpm_transmit_cmd(). And tpm_transmit_cmd()
> > > > is already an exported symbol. It only needs to be declared in
> > > > include/linux/tpm.h.
> > > > 
> > > > I'd suggest that I refine my series to call tpm_transmit_cmd()
> > > > and we have a fairly clean solution where the load sequence is
> > > > atomic.
> > > 
> > > I see that it is perfectly fine to make tpm_transmit_cmd()
> > > globally callable. It is already used by tpm_vtpm_proxy and does
> > > have clear semantics.
> > > 
> > > The way you use it is just:
> > > 
> > > 1. tpm_try_get_ops
> > > 2. Use tpm_transmit_cmd() N times.
> > > 3. tpm_put_ops
> > > 
> > > If we moved TPM 2.x trusted keys code back to
> > > drivers/char/tpm,for the sake of consistency the same would have
> > > to be done for TPM 1.2 code. I'd rather fix the regression and be
> > > done with it.
> > > 
> > > Or if reverted like that, also asym_tpm.c code should also live
> > > inside the TPM driver directory.
> > > 
> > > All this work with tpm_buf and the locking functions makes most
> > > sense if it gives ability for callers to build their own TPM
> > > commands
> > > 
> > > I'm right now building test image with v3 of my fixes (this time
> > > properly included to the kernel image). I also uploaded the
> > > (untested) patches over here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=trusted-fix
> > 
> > I think we can do that ... in which case the fix for the tis
> > interrupt trigger also becomes a get/put ops around the
> > tpm2_get_tpm_pt.
> > 
> > After the transformation is complete, tpm_send() becomes obsolete,
> > doesn't it, so it can be removed?
> 
> Yes.
> 
> BTW, while doing this I think I noticed what was wrong in my test
> kernel when I tested your series that introduces ASN.1 keys. I'll
> test both before sending update to my fix. Hopefully I can give today
> tested-by tags to that series.

Great ... the trusted key code doesn't use tpm_send, but the policy
additions do so the latter will need updating (again).

James


