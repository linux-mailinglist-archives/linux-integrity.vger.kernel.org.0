Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0D4273DC
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Oct 2021 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhJHWqs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhJHWqs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 18:46:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFBC061755
        for <linux-integrity@vger.kernel.org>; Fri,  8 Oct 2021 15:44:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h3so4435184pgb.7
        for <linux-integrity@vger.kernel.org>; Fri, 08 Oct 2021 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tZEn/oAYWz3OcPJexi2kL6PvuHBhh8RYYUTzGNKbmSU=;
        b=DhKhOYtI0pBL6NCNFhLl35WOj9Pbn0YptqtJC1eqqOh1krXIhDiyulLRdDnN09WxhN
         4ODUUIY2goSTSm/XDlA9aerxN9TrWKJwe4C0uO6BXyJUc/M0Rb4Qo34q+wo1Cs6Kdbrx
         wM6E7zu705f4gxd7Ly+0oFdjD/mjV9w3i9uaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tZEn/oAYWz3OcPJexi2kL6PvuHBhh8RYYUTzGNKbmSU=;
        b=kOdKTrmFmkV0xTo3qpMdZ0iExOfKa15rxQ9WFUMpHzjQyU5OyLppXv1W3SZYcQvNBr
         fMNVJzOWe384FkEjzIMaVm5yYjD5e4LS6Thp7fhYhrhH1InHS0TmBuryC+GGu8w2gmuQ
         y31Lq3KbNKMtUZk39IeeY26nOTxHGIgNxa1ReMkDapoBRI0zjCukRiKLeOmQkz2GFCaF
         R7Il2wm6xtdxvaVdjy1BVbPW+ak74PoYcH0jOCS1/4tFEeOhnhbmaM2QjCRnS2JldSeg
         qj4d0joOBLg3uM3kyWj9Usc1Y7LgfIeM2HMjQGRqG1fqv3Namp8nkA27dKmHgTVsH0C8
         3S1g==
X-Gm-Message-State: AOAM530Z7DSygbk12MnhB4gGxkPlOcjS3t9T3o8i/paZH703nP5/AEFS
        tf0qhXxylT+jTvUMNrObcAUChg==
X-Google-Smtp-Source: ABdhPJzc82UFKnEHL2nXeW/1+UZrI2+VOZcKuFOfe0n0xCQmI8hpLGTGT0H7X/rjlFKvQ2WBHiiUwA==
X-Received: by 2002:a63:cc48:: with SMTP id q8mr6758353pgi.171.1633733091937;
        Fri, 08 Oct 2021 15:44:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k190sm350501pgc.11.2021.10.08.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:44:51 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:44:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v14 3/3] selftest/interpreter: Add tests for
 trusted_for(2) policies
Message-ID: <202110081544.85B7DA3@keescook>
References: <20211008104840.1733385-1-mic@digikod.net>
 <20211008104840.1733385-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008104840.1733385-4-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 08, 2021 at 12:48:40PM +0200, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Test that checks performed by trusted_for(2) on file descriptors are
> consistent with noexec mount points and file execute permissions,
> according to the policy configured with the fs.trust_policy sysctl.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Thanks for the adjustments!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
