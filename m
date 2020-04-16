Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7681AD00E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgDPTCy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgDPTCw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 15:02:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298FC061A0C
        for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2020 12:02:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so2075857pfp.8
        for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2020 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8K7Uij5FR/y53ufQlRLlkErb4h6Rc+s+0cEs8RvIfrk=;
        b=YdnE/OwI5bjyGE4wBYZvX7wq8Xafz8j9lyiEzp+yCLgf9hsU76SfnuKI6bwWigWoqa
         5w03p2YoJ/fJgkQIXHBqPdjEzwKysZLMI85pQxODOydyXec6umrPKv7GQ/NOJJqf4tzk
         WQJ63Nk4Uj0og43o75YRZhTZOvPOvEsWYEbmh7L67Jfe+Mj4tF1AdTutTCmZn18UZBkj
         4TtQk0Ms592l5wvcKYwxdP8nzwpJIXBtvYtUJ9Ryd5dwMI4V1LUKeEZm52/AG4peb6Gb
         F8W94zk8HgvIo2dCgCX15GAgIOvpS0pyi6Vzx7C0R2nG19QVVcVg92QSdUufFzosKCQU
         Y3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8K7Uij5FR/y53ufQlRLlkErb4h6Rc+s+0cEs8RvIfrk=;
        b=dXQpEf1EBVBLWyu0rV2wPiup842vBYUMdpxuqJ1vHwaEQ2F4aD7TQ0tYkQG37Ci9qu
         xLrSi/Ng4sO/u/5JMcP3AiDMEGD6c8fzz5HoOMAc0idSJE6vHs6ifJi0yUYaDmZqf6F4
         2dhNA4V/jlFr7Vs6zh7rN6Ejw2khe4SF/CRt36gEISxXBMKyM5ZUprLTfH4vXgewpMZl
         TgVA4jb8VbsUkbrtoHnprKDl1iZ1eQ4AmmsBUNB018/DOybwdUUp0EKehxDHU79k3MYn
         bMjtCXQUXWVux1DaDz/UN3sDzFUxv6Tj7fedVDpTa7ocviZipFihSYL4dQwSQMUt9hYY
         qm0A==
X-Gm-Message-State: AGi0PuZbcdJYsPTDUTW7PaNIT9vm0VEkn04O1ntGsz6ahh460VLL3/Vt
        nm8pwVolj/bEvPPhf2bAd/Lv9g==
X-Google-Smtp-Source: APiQypKast0h9t87WbQLCLiTUV4SKx75+YVIAeBS0qbkX7sazFiBKGb0HnxseY8TwC1k7SubyJuayw==
X-Received: by 2002:a63:7309:: with SMTP id o9mr2982038pgc.406.1587063771417;
        Thu, 16 Apr 2020 12:02:51 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id y26sm12291377pfq.107.2020.04.16.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:02:50 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:02:49 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416190249.GC701157@vader>
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
 <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 16, 2020 at 08:22:10AM +0200, Paul Menzel wrote:
> Dear Omar,
> 
> 
> Am 16.04.20 um 02:23 schrieb Omar Sandoval:
> > From: Omar Sandoval <osandov@fb.com>
> 
> Thank you for the patch.
> 
> > We've encountered a particular model of STMicroelectronics TPM that
> 
> Please add models you are encountering this with to the commit message.
> 
> > transiently returns a bad value in the status register. This causes the
> 
> Have you contacted STMMicroelectronics?
> 
> > kernel to believe that the TPM is ready to receive a command when it
> > actually isn't, which in turn causes the send to time out in
> > get_burstcount(). In testing, reading the status register one extra time
> > convinces the TPM to return a valid value.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 27c6ca031e23..5a2f6acaf768 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -238,6 +238,25 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> >   	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> >   	if (rc < 0)
> >   		return 0;
> > +	/*
> > +	 * Some STMicroelectronics TPMs have a bug where the status register is
> > +	 * sometimes bogus (all 1s) if read immediately after the access
> > +	 * register is written to. Bits 0, 1, and 5 are always supposed to read
> > +	 * as 0, so this is clearly invalid. Reading the register a second time
> > +	 * returns a valid value.
> > +	 */
> > +	if (unlikely(status == 0xff)) {
> 
> I’d like to see a debug message here, saying the TPM is buggy. Maybe the
> model can be printed to, and that the TPM manufacturer should be contacted.

How can I get the model information? (Sorry, I'm not very familiar with
TPMs, I'm just the guy on the team that ended up tracking this down.)

Thanks!
