Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504581ACF2E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgDPR4V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 13:56:21 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48100 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727777AbgDPR4U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 13:56:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2A3848EE25B;
        Thu, 16 Apr 2020 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587059780;
        bh=82Qr0AFV+1LnnLuetQHn6qqP96LLR9FydwuZ39KZWAw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=x0l8ZBa4OaBKmL0HK/L1vFlc5quxg9hl9DWc2bCR4RnpvUFtNg5rLb2wluZjvpPpU
         XdJZfKLA9NgD8Y2P/jbSPeUYtF3ViqXKA9Kofl/w+Qm4y5pCjLepJP/7MtACH6nF5s
         mUWA1Val/Gsj2XBNOvjjMahWmnPZrPwQruu5lX2A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1JsWFS-VgRux; Thu, 16 Apr 2020 10:56:19 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 799FB8EE0A4;
        Thu, 16 Apr 2020 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587059779;
        bh=82Qr0AFV+1LnnLuetQHn6qqP96LLR9FydwuZ39KZWAw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N5vsivRCFKpKw4WuRAkQ1BRC7tqNTboXp65fsoGHR4ZjI+YjG/x0eW7/rzNkDselY
         CEXkWXNn0fcopjQ0NcDPzraZnjsEsJm/nv19H/tG1bEAzx12RJzGCN1C2pVYAzX0SJ
         rO5gffuVnS+ZO+Urfw9bK956fZTeR4EmIkIUsgsM=
Message-ID: <1587059778.15329.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Thu, 16 Apr 2020 10:56:18 -0700
In-Reply-To: <20200416170944.GE199110@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
         <1586994699.3931.18.camel@HansenPartnership.com>
         <20200416170944.GE199110@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-04-16 at 20:09 +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 15, 2020 at 04:51:39PM -0700, James Bottomley wrote:
> > On Wed, 2020-04-15 at 15:45 -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > We've encountered a particular model of STMicroelectronics TPM
> > > that
> > > transiently returns a bad value in the status register. This
> > > causes
> > > the kernel to believe that the TPM is ready to receive a command
> > > when
> > > it actually isn't, which in turn causes the send to time out in
> > > get_burstcount(). In testing, reading the status register one
> > > extra
> > > time convinces the TPM to return a valid value.
> > 
> > Interesting, I've got a very early upgradeable nuvoton that seems
> > to be
> > behaving like this.
> > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > > b/drivers/char/tpm/tpm_tis_core.c
> > > index 27c6ca031e23..277a21027fc7 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip
> > > *chip)
> > >  	rc = tpm_tis_read8(priv, TPM_STS(priv->locality),
> > > &status);
> > >  	if (rc < 0)
> > >  		return 0;
> > > +	/*
> > > +	 * Some STMicroelectronics TPMs have a bug where the
> > > status
> > > register is
> > > +	 * sometimes bogus (all 1s) if read immediately after
> > > the
> > > access
> > > +	 * register is written to. Bits 0, 1, and 5 are always
> > > supposed to read
> > > +	 * as 0, so this is clearly invalid. Reading the
> > > register a
> > > second time
> > > +	 * returns a valid value.
> > > +	 */
> > > +	if (unlikely(status == 0xff)) {
> > > +		rc = tpm_tis_read8(priv, TPM_STS(priv-
> > > >locality),
> > > &status);
> > > +		if (rc < 0)
> > > +			return 0;
> > > +	}
> > 
> > You theorize that your case is fixed by the second read, but what
> > if it
> > isn't and the second read also returns 0xff?  Shouldn't we have a
> > line
> > here saying
> > 
> > if (unlikely(status == 0xff))
> > 	status = 0;
> > 
> > So if we get a second 0xff we just pretend the thing isn't ready?
> 
> If it eventually settles, would it be better to poll it for a while?

Omar said they'd never seen the double read fail, so I don't think
polling would be helpful in this case.  If we do get a double read of
0xff I think returning 0 is correct which basically means the TPM isn't
ready and the caller needs to wait a bit.  If you look, most of the
callers of tpm_tis_status will do their own wait and retry in this
case, so effectively we're getting the caller to poll for us.

James


> Also, the commit message is ambiguous. "bad value" can be any random
> bit sequence.
> 
> /Jarkko
> 

