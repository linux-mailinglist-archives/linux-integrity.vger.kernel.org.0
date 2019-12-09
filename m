Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260D11170AC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIPiS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 10:38:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57008 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfLIPiS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 10:38:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E69078EE112;
        Mon,  9 Dec 2019 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575905897;
        bh=yUKIS3uLCavdxTzMlfqIQ29J2ir9okLFp46KZxy2WrI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cENL5whXDIDPkefkHbZaqHrwl4dTb/ZGqEQi0WRqOo1LM9YcpwoL3xt6sxpSV4Zhk
         AyLbKWoXQ5d1hGUhoFurrT0a0obHh6XwaWj9k1JZSD1uwyUP/j0vJp8fJUIBaQCVpL
         MWkwCOTxrAOP4wXo4aMNcc1MTkS0fnzTLsxZo49U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n8eOD2uRWAko; Mon,  9 Dec 2019 07:38:16 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71FF48EE0FC;
        Mon,  9 Dec 2019 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575905896;
        bh=yUKIS3uLCavdxTzMlfqIQ29J2ir9okLFp46KZxy2WrI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FQbSxaM6Rbrbgj3jgi4M4hcqUbretlikbPW+BPsp4Z8Tb18/BDGZD3xJ/PtApNBCX
         ie7Bd6HqC9aJ9UHxpeYrzgn3qPMExBD8GyavVaT/3zdgHjGilLYCOixJAqkLVy3DEg
         grC+1eqgQ7eSVtGIntgTPwZVCtF4gIh7ChKROFKM=
Message-ID: <1575905895.3340.8.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/8] security: keys: trusted: flush the key handle after
 use
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 07:38:15 -0800
In-Reply-To: <89e3c7c531b228673089ad892d5e6390642ced85.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781659.14069.9.camel@HansenPartnership.com>
         <89e3c7c531b228673089ad892d5e6390642ced85.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 08:31 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:07 -0800, James Bottomley wrote:
> > The trusted keys code currently loads a blob into the TPM and
> > unseals
> > on the handle.  However, it never flushes the handle meaning that
> > volatile contexts build up until the TPM becomes unusable.  Fix
> > this
> > by flushing the handle after the unseal.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > ---
> >  drivers/char/tpm/tpm.h                    | 1 -
> >  drivers/char/tpm/tpm2-cmd.c               | 1 +
> >  include/linux/tpm.h                       | 1 +
> >  security/keys/trusted-keys/trusted_tpm2.c | 1 +
> >  4 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index b9e1547be6b5..5620747da0cf 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -218,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32
> > pcr_idx,
> >  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  		    struct tpm_digest *digests);
> >  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> > -void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> >  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
> >  			u32 *value, const char *desc);
> >  
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-
> > cmd.c
> > index fdb457704aa7..b87592f4a6c7 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -362,6 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip,
> > u32 handle)
> >  	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> >  	tpm_buf_destroy(&buf);
> >  }
> > +EXPORT_SYMBOL(tpm2_flush_context);
> 
> 
> Everything else is EXPORT_SYMBOL_GPL(). Why EXPORT_SYMBOL() here?

No reason ... well, except I'm not sure the difference has any utility,
but since I don't really care either way, I'll change all the exports.

James

