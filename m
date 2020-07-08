Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DABE217D68
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 05:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGHDKi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgGHDKh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 23:10:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB10C08C5DC
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2020 20:10:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so20162441pgg.10
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2020 20:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=edyXrUUXlucnGHdJkzAqctBsLVZmrijKH7zA9JnE9Qs=;
        b=hlwBMhGsm2KgPGyCtgedo+zMtJVTl9SEIwqwMo7UolN4lX2fwyUQ7Vbv1FEj92NcM3
         NGNdx6NXMsjTYmNytJtOZ3gWi7rmCWK8D0Jexm3+W/nDCAPphHj3nPmq/F9roB3r9uBb
         7FRRPNjqv1E2famw0cCafEHyl0POEhMcEsmn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=edyXrUUXlucnGHdJkzAqctBsLVZmrijKH7zA9JnE9Qs=;
        b=EiBz9k+LXqfhhkrixCCYWckH7UGufajafxcqTR9cBnz7EKxQgiIOVeFITU8Gya7atg
         pR8HA34kXekabx5KLDLLE7v9toBM+bBqS9+55l/YSiXAbX1CsdPJtKSK0bDK+YR+Bt96
         dA+vjfCrrZ5bqSVtKtUGe7qg7SHRMXb/W3HFc9NE1K6DxvF2cxjzdaqNdzjRFnlppa2Z
         uWb75B7l2XA+br5meLSpflijLaHjhfpl4NPl1TDSBh7aqTYqVlpXNYAPLMOpPDrZhFLr
         2ykOCPhrXWovEHObmEzUn5jVEKuFzPIOHLUqe9CINWtMPsgdtBuLbw+vkor8o4+sY4yi
         1PlQ==
X-Gm-Message-State: AOAM530KfCvGUnLctvaclHBIP3pPnJlBD2wCtOoHz/cLUF8qXrIlXqYT
        fCGpV3J5crCsBk3xjjtVDxY5pw==
X-Google-Smtp-Source: ABdhPJz2SITuOpLsf2fKbfCPMhLdYgaGbKpZy5ZObf2Y0s34KANDBCI0SwEXpDtq9tudsC3KYnRTXw==
X-Received: by 2002:a63:6cd:: with SMTP id 196mr47424478pgg.169.1594177837244;
        Tue, 07 Jul 2020 20:10:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r17sm23362049pfg.62.2020.07.07.20.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 20:10:36 -0700 (PDT)
Date:   Tue, 7 Jul 2020 20:10:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/4] module: Add hook for security_kernel_post_read_file()
Message-ID: <202007071951.605F38D43@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-5-keescook@chromium.org>
 <1594169240.23056.143.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594169240.23056.143.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 07, 2020 at 08:47:20PM -0400, Mimi Zohar wrote:
> On Tue, 2020-07-07 at 01:19 -0700, Kees Cook wrote:
> > Calls to security_kernel_load_data() should be paired with a call to
> > security_kernel_post_read_file() with a NULL file argument. Add the
> > missing call so the module contents are visible to the LSMs interested
> > in measuring the module content. (This also paves the way for moving
> > module signature checking out of the module core and into an LSM.)
> > 
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Fixes: c77b8cdf745d ("module: replace the existing LSM hook in init_module")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/module.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 0c6573b98c36..af9679f8e5c6 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2980,7 +2980,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
> >  		return -EFAULT;
> >  	}
> >  
> > -	return 0;
> > +	err = security_kernel_post_read_file(NULL, (char *)info->hdr,
> > +					     info->len, READING_MODULE);
> 
> There was a lot of push back on calling security_kernel_read_file()
> with a NULL file descriptor here.[1]  The result was defining a new
> security hook - security_kernel_load_data - and enumeration -
> LOADING_MODULE.  I would prefer calling the same pre and post security
> hook.
> 
> Mimi
> 
> [1] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/007110.html

Ah yes, thanks for the pointer to the discussion.

I think we have four cases then, for differing LSM hooks:

- no "file", no contents
	e.g. init_module() before copying user buffer
	security_kernel_load_data()
- only a "file" available, no contents
	e.g. kernel_read_file() before actually reading anything
	security_kernel_read_file()
- "file" and contents
	e.g. kernel_read_file() after reading
	security_kernel_post_read_file()
- no "file" available, just the contents
	e.g. firmware platform fallback from EFI space (no "file")
	unimplemented!

If an LSM wants to be able to examine the contents of firmware, modules,
kexec, etc, it needs either a "file" or the full contents.

The "file" methods all pass through the kernel_read_file()-family. The
others happen via blobs coming from userspace or (more recently) the EFI
universe.

So, if a NULL file is unreasonable, we need, perhaps,
security_kernel_post_load_data()

?

-- 
Kees Cook
