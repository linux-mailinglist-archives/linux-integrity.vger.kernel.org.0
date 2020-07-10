Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5AC21C00F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2020 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGJWoK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGJWoK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 18:44:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2247C08E6DC
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 15:44:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so3214816pjg.3
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TjEJpib1IL5htaIPNtgXZReDUQ6slE49xFUwHakVlH0=;
        b=SO1xAbaPN5JafN9toT/S+WneSLZasNKIViJUdCc3GKTm5RREBz48J7iN1ANJD4rGJC
         oLJy5cqcDy+SDN0nvcAXoX0qVGw0sHTomDkxRemFAupDhPw+xCwT01Lz1nYiaZNCU99V
         rJrNVo6yLJNpmhg0DMRwUu5W0ig+vMBotm3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TjEJpib1IL5htaIPNtgXZReDUQ6slE49xFUwHakVlH0=;
        b=IGs701ee6WWBlj44IJKUg4PzRvmyNUKNKyz16cuAjL/VUOYNGtXbYT9GpLvHe02ulx
         6YIDqkIH8NP0pVl4hVGtfyYZ1kmOX+MaRMg94403UOYZ84nICj3lj4UqCTDnJSD3jSu5
         2TRrTgpPzRQALzzJJNbVMwJxFgNrLtQE5muTc7Iym9gMNF48Rc0Xfe5aAWIGNrxZvAqD
         kgPHEYnfnoM6Kw0KFRwIlewLjDdtJ8cuKIlsXjCjo6mw177J6faBMDB1TClzYO2uAcDB
         9ZSOP0hdnpnmSYwnKvXG+sAcReVsy0YxIvllyY+4owd8wFeeDkxWKV/7TpTj5FGdvJje
         IGAw==
X-Gm-Message-State: AOAM533e8IfBp6IzzNjsOQ4Eky9DVM+FMPQiGIroaoE7iPwcQ2hTzrGV
        CY+LIu1UFYSZAwzADHw+x+VMBg==
X-Google-Smtp-Source: ABdhPJxQKXZOntIHVtBHw75TX+0uQyvL4Fgsc3zGCY0FUh3ifMwWHpCyP6LF7aHmjDXcutvHnmqdtg==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr7916117pjb.60.1594421049223;
        Fri, 10 Jul 2020 15:44:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b128sm6195291pfg.114.2020.07.10.15.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:44:08 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:44:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
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
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
Message-ID: <202007101543.912633AA73@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
 <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 10, 2020 at 03:10:25PM -0700, Scott Branden wrote:
> 
> 
> On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
> > On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
> > > > @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > >    		goto out;
> > > >    	}
> > > > -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> > > > -		*buf = vmalloc(i_size);
> > > > +	if (!*buf)
> > > The assumption that *buf is always NULL when id !=
> > > READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
> > > I get unhandled page faults due to this change on boot.
> > Did it give you a stack backtrace?
> Yes, but there's no requirement that *buf need to be NULL when calling this
> function.
> To fix my particular crash I added the following locally:
> 
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
> __user *, uargs, int, flags)
>  {
>      struct load_info info = { };
>      loff_t size;
> -    void *hdr;
> +    void *hdr = NULL;
>      int err;
> 
>      err = may_init_module();
> > 
> 

Thanks for the diagnosis and fix! I haven't had time to cycle back
around to this series yet. Hopefully soon. :)

-- 
Kees Cook
