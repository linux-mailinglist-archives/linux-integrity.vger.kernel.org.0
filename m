Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974627A501
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 03:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1BDj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 21:03:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgI1BDj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 21:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 447AC8EE17F;
        Sun, 27 Sep 2020 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601255019;
        bh=9P5Apnyzg3qLkU3x9gPCWthEFy+mEPW3HykqIyWvAno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kl/4BN8ak7aOj45iWlHcnKTUdIlOq+D8SLcfFM5ih9uZoIOFYwJvaSgoWnzWMhnRv
         gxHKYC66KmZ4JR8MMJftdDHC3P0AFCP9WGnh8ZPw1Mvu0iy5I+3uJinFYipF/KPKMC
         t1Zi+hY7jm2IyEa/Fwx4LzBqe4dDTjNUxCHGan50=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k6OAGeY8NIdE; Sun, 27 Sep 2020 18:03:38 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 668F48EE012;
        Sun, 27 Sep 2020 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601255018;
        bh=9P5Apnyzg3qLkU3x9gPCWthEFy+mEPW3HykqIyWvAno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OdMP/1DXzpaEKGpHrI5B2/807bITeTCYEucuNsTT39VilA95/gtcD0BisIKXhLkUJ
         vyubet1BvlivyZB1cv14mZGS/2NzVZVVJM+oIKLgkDOidjH4d7GdD1bTAHC78o0oby
         5pqOEPfiZZz9OFnXnt5A9lDZQPCcYn5xfnlUPcko=
Message-ID: <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Sun, 27 Sep 2020 18:03:37 -0700
In-Reply-To: <20200928001138.GE5283@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
         <20200928001138.GE5283@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-28 at 03:11 +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 27, 2020 at 04:17:40PM -0700, James Bottomley wrote:
> > Remove the currently exported version of flush context, which is
> > designed for tpm core internal use only and substitute a corrected
> > version that does the necessary tpm ops get/put.  This fixes a bug
> > with trusted keys in that some TIS TPMs are unable to flush the
> > loaded secret because the status register isn't reading correctly.
> > 
> > Fixes: 45477b3fe3d1 ("security: keys: trusted: fix lost handle
> > flush")
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/char/tpm/tpm.h                    |  1 +
> >  drivers/char/tpm/tpm2-cmd.c               | 23
> > ++++++++++++++++++++++-
> >  include/linux/tpm.h                       |  2 +-
> >  security/keys/trusted-keys/trusted_tpm2.c |  2 +-
> >  4 files changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 21ac88d4076c..cba09be7ce23 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -240,6 +240,7 @@ int tpm2_prepare_space(struct tpm_chip *chip,
> > struct tpm_space *space, u8 *cmd,
> >  		       size_t cmdsiz);
> >  int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space
> > *space, void *buf,
> >  		      size_t *bufsiz);
> > +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> >  
> >  void tpm_bios_log_setup(struct tpm_chip *chip);
> >  void tpm_bios_log_teardown(struct tpm_chip *chip);
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-
> > cmd.c
> > index 9b84158c5a9e..d5aaea72d578 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -362,7 +362,28 @@ void tpm2_flush_context(struct tpm_chip *chip,
> > u32 handle)
> >  	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> >  	tpm_buf_destroy(&buf);
> >  }
> > -EXPORT_SYMBOL_GPL(tpm2_flush_context);
> > +
> > +/**
> > + * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
> > + * @chip:	TPM chip to use
> > + * @handle:	context handle
> > + *
> > + * This version of the command is designed to be used outside the
> > + * TPM core so acquires and releases the tpm ops.
> > + */
> > +void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle)
> > +{
> > +	int rc;
> > +
> > +	rc = tpm_try_get_ops(chip);
> > +	if (rc) {
> > +		dev_err(&chip->dev, "Failed to acquire tpm ops for
> > flush\n");
> > +		return;
> > +	}
> > +	tpm2_flush_context(chip, handle);
> > +	tpm_put_ops(chip);
> > +}
> > +EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);
> 
> Otherwise fine but please rename the existing function as
> __tpm2_flush_context() and exported as tpm2_flush_context().

If I do this it churns the code base more: we have one external
consumer and four internal ones, so now each of the internal ones would
have to become __tpm_flush_context().  We also have precedence for the
xxx_cmd form with tpm2_unseal_cmd, tpm2_load_cmd.

> >  struct tpm2_get_cap_out {
> >  	u8 more_data;
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index ae2482510f8c..c4ca52138e8b 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -411,7 +411,7 @@ extern int tpm_pcr_extend(struct tpm_chip
> > *chip, u32 pcr_idx,
> >  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t
> > buflen);
> >  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t
> > max);
> >  extern struct tpm_chip *tpm_default_chip(void);
> > -void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> > +void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle);
> >  #else
> >  static inline int tpm_is_tpm2(struct tpm_chip *chip)
> >  {
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > b/security/keys/trusted-keys/trusted_tpm2.c
> > index 08ec7f48f01d..38bb33333cdf 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -309,7 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> >  		return rc;
> >  
> >  	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> > -	tpm2_flush_context(chip, blob_handle);
> > +	tpm2_flush_context_cmd(chip, blob_handle);
> >  
> >  	return rc;
> 
> It will also elimintate this change.

Well, yes, but it will add four other changes.

James


