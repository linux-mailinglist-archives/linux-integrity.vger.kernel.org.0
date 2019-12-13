Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925FF11E3A3
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 13:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLMMgA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 07:36:00 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37674 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfLMMgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 07:36:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DCC268EE19A;
        Fri, 13 Dec 2019 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576240559;
        bh=LiCa97eoJ6ZMa24YwVIPMN+cp+meKpW13V7r/z/5n/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R/lZlQE1esNZPyw5wGu5gAHQQXXJH2I2FKP2+FXOQTESqT9aoQaHllrHPRX9H/Xa7
         gXl4WkY9xwvT217SEkb39XiVTp0c6ya6acdkvApi6/NRGhhdDkToDeW6gKYi+79FIh
         T2UaFfw7+SQbUjZAM8obBU2SRVkAcRFO7LUgDPYc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FE2cMGe3btM4; Fri, 13 Dec 2019 04:35:59 -0800 (PST)
Received: from [192.168.101.75] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6C1EF8EE0E0;
        Fri, 13 Dec 2019 04:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576240559;
        bh=LiCa97eoJ6ZMa24YwVIPMN+cp+meKpW13V7r/z/5n/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R/lZlQE1esNZPyw5wGu5gAHQQXXJH2I2FKP2+FXOQTESqT9aoQaHllrHPRX9H/Xa7
         gXl4WkY9xwvT217SEkb39XiVTp0c6ya6acdkvApi6/NRGhhdDkToDeW6gKYi+79FIh
         T2UaFfw7+SQbUjZAM8obBU2SRVkAcRFO7LUgDPYc=
Message-ID: <1576240555.3382.5.camel@HansenPartnership.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle
 flush
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Fri, 13 Dec 2019 07:35:55 -0500
In-Reply-To: <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
References: <1576173515.15886.7.camel@HansenPartnership.com>
         <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-13 at 11:10 +0530, Sumit Garg wrote:
> On Thu, 12 Dec 2019 at 23:28, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > The original code, before it was moved into security/keys/trusted-
> > keys had a flush after the blob unseal.  Without that flush, the
> > volatile handles increase in the TPM until it becomes unusable and
> > the system either has to be rebooted or the TPM volatile area
> > manually flushed. Fix by adding back the lost flush, which we now
> > have to export because of the relocation of the trusted key code
> > may cause the consumer to be modular.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
> > 
> 
> Overall looks good to me with following minor comment.
> 
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
> >                     struct tpm_digest *digests);
> >  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> > -void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> >  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
> >                         u32 *value, const char *desc);
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-
> > cmd.c
> > index fdb457704aa7..13696deceae8 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -362,6 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip,
> > u32 handle)
> >         tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> >         tpm_buf_destroy(&buf);
> >  }
> > +EXPORT_SYMBOL_GPL(tpm2_flush_context);
> > 
> >  struct tpm2_get_cap_out {
> >         u8 more_data;
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 0d6e949ba315..03e9b184411b 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -403,6 +403,7 @@ extern int tpm_pcr_extend(struct tpm_chip
> > *chip, u32 pcr_idx,
> >  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t
> > buflen);
> >  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t
> > max);
> >  extern struct tpm_chip *tpm_default_chip(void);
> > +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> 
> Shouldn't this be declared as "extern" similar to other APIs?

extern has no meaning for function declarations and our coding guide
does say do not use it but I think it's advisory not mandatory so I've
no objection to changing it if we prefer consistency over the style
guide.

>  Also, I think we need "#else" part for this API as well.

No, we shouldn't ... the #else part is only for functions which are
called when the TPM isn't compiled in.  That should never happen with
tpm2_flush_context, so if it ever does we want the compile to break.

James

