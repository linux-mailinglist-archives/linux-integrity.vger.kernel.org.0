Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD05A11FEAB
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfLPHA2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 02:00:28 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49936 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfLPHA1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 02:00:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8144D8EE163;
        Sun, 15 Dec 2019 23:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576479627;
        bh=A2Wr8ZBumwPTGC+iCR15HaQ2BGuod8PFDC0HEORQZ4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cm3LHlHw1zkoVRaYGSzzS4I2xxR8W9I9v1LMd4SipKLMJS81my9E3qAmDFLM2gmjL
         ddeAEQoPUCim8civWVL0042+wfhxl5AN1GalOmQUKoWJwkzLfJBmm1qrTVgU7g1aZn
         GnXCL6gv+F+eR3Y35dviLmUgC4j/zQixZZjnSVjo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hNfLPU4luNee; Sun, 15 Dec 2019 23:00:27 -0800 (PST)
Received: from [10.30.62.156] (unknown [103.5.140.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D27A78EE0E2;
        Sun, 15 Dec 2019 22:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576479627;
        bh=A2Wr8ZBumwPTGC+iCR15HaQ2BGuod8PFDC0HEORQZ4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cm3LHlHw1zkoVRaYGSzzS4I2xxR8W9I9v1LMd4SipKLMJS81my9E3qAmDFLM2gmjL
         ddeAEQoPUCim8civWVL0042+wfhxl5AN1GalOmQUKoWJwkzLfJBmm1qrTVgU7g1aZn
         GnXCL6gv+F+eR3Y35dviLmUgC4j/zQixZZjnSVjo=
Message-ID: <1576479518.3784.5.camel@HansenPartnership.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle
 flush
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 16 Dec 2019 15:58:38 +0900
In-Reply-To: <CAFA6WYPd1=kAeOPgAdafp83-voXWv3eYi9E6Tu0csxBSKC896w@mail.gmail.com>
References: <1576173515.15886.7.camel@HansenPartnership.com>
         <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
         <1576240555.3382.5.camel@HansenPartnership.com>
         <1576244983.3382.9.camel@HansenPartnership.com>
         <CAFA6WYPd1=kAeOPgAdafp83-voXWv3eYi9E6Tu0csxBSKC896w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-16 at 11:47 +0530, Sumit Garg wrote:
> On Fri, 13 Dec 2019 at 19:19, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Fri, 2019-12-13 at 07:35 -0500, James Bottomley wrote:
> > > On Fri, 2019-12-13 at 11:10 +0530, Sumit Garg wrote:
> > 
> > [...]
> > > >  Also, I think we need "#else" part for this API as well.
> > > 
> > > No, we shouldn't ... the #else part is only for functions which
> > > are called when the TPM isn't compiled in.  That should never
> > > happen with tpm2_flush_context, so if it ever does we want the
> > > compile to break.
> > 
> > Just on this bit, it looks like we've given insufficient thought to
> > what it means to move TPM internals using code outside of the tpm
> > directory.  I think we really need two include/linux files, one
> > tpm.h for external code that going to do stuff which it would do
> > anyway even if a TPM weren't compiled in, like the PCR read and
> > extend.  The other tpm-internal.h for code that wants access to TPM
> > internal functions like flushing and session handling and will take
> > care itself of the case where the TPM isn't compiled in, like the
> > trusted key code does through Kconfig dependencies.  The test
> > should be easy: if it was originally in drivers/char/tpm/tpm.h it
> > belongs in include/linux/tpm-internals.h
> > 
> 
> Your approach sounds good to me. But how about just moving the APIs
> that needs to be used independently of TPM compilation to
> include/linux/tpm-externals.h from drivers/char/tpm/tpm.h. As the
> initial thoughts while I was moving contents to
> drivers/char/tpm/tpm.h was to keep a consolidated view of TPM header
> for a particular user.

If we do that, we have to change every current user of tpm.h, because
that file was originally only for the external users (mostly PCR
extends).  I'd rather avoid the churn and keep them using tpm.h, hence
the tpm-internal.h proposal.

> > > > +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> 
> I agree with you that the above API should remain as it is and should
> be moved out of the following check:
> 
> #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> ...
> #else
> ...
> #endif

That merely changes where the compile breaks.  If it's within it breaks
on the actual offending file.  If it's without, you don't find out
until kernel link time.  I'm reasonably ambivalent about this but my HA
days have given me a preference for failing fast, so in the file
itself.

James

