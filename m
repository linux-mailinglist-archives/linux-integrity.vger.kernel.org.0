Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA5424969
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbhJFWFO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Oct 2021 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhJFWFO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Oct 2021 18:05:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0FC061753
        for <linux-integrity@vger.kernel.org>; Wed,  6 Oct 2021 15:03:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so3674957pgu.13
        for <linux-integrity@vger.kernel.org>; Wed, 06 Oct 2021 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S8r+rc6bFIU7cXArQnf6Qtpwv2FoCGPsccPj2q+K1zk=;
        b=BlcpB5NSeXXefPepERXjr0jUHlucP3qusHB3fY//2ntWT4PaA2nle9ET0X3AI1HmEH
         feGtjzF6zI0ZgP3SazGlzI7XQsy/joCst2lDK+wX83vnR+9++PDS05+ZQtLJy+cp0Zww
         49ZwkdVQHaEFSC8vTVzcnAqC2r7EwFKG1KnMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S8r+rc6bFIU7cXArQnf6Qtpwv2FoCGPsccPj2q+K1zk=;
        b=JCQ1XmmK3kFzku2k+Lms2EtefyPmQNTLy2krsJCORY9scVUlMGtMUBPGsJZRB3OHO8
         W3Rt+SbAa2orMyoTYP1u6Yu2er3EGv8+xDEi7VoFMxa3L452uS0V7+UQqokb05aXr2Dk
         OFQHdFICAxcFnC3zf/PfvhsGG9To1XvXSHGbuyiqNS+Y7fkpORL5ZjuuRA+ZptZY5Zgc
         41cWV0Z6MaSla1BIU0y5OXhCsgj84H4Ce64ulIj+Z+Oyt+ciitZI14a/q1pVZ7yamvPv
         gBeNoJ0rWZKIbO55k3gzL1jHjcY733//UQVgPC+5gm7pGAkD9am3aRttn5uPA7wm8n5l
         m9DQ==
X-Gm-Message-State: AOAM531QUiZHHV57tFduxPPbdNfEsQyE4Tu5wnAqmoGCl2qfO7yoZGPs
        L1CU+YBu4EwHSB8LyKf0Vq/aeg==
X-Google-Smtp-Source: ABdhPJzouFSoNpCm18n4Iwn3EUMcJjerfXPUN9YpUneFa6F70rdyCB8CBylaxKHlD/YEVHoOYPZFMQ==
X-Received: by 2002:a63:e651:: with SMTP id p17mr420929pgj.66.1633557801181;
        Wed, 06 Oct 2021 15:03:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm2947437pff.214.2021.10.06.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:03:20 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:03:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     bauen1 <j2468h@googlemail.com>, akpm@linux-foundation.org,
        arnd@arndb.de, casey@schaufler-ca.com,
        christian.brauner@ubuntu.com, christian@python.org, corbet@lwn.net,
        cyphar@cyphar.com, deven.desai@linux.microsoft.com,
        dvyukov@google.com, ebiggers@kernel.org, ericchiang@google.com,
        fweimer@redhat.com, geert@linux-m68k.org, jack@suse.cz,
        jannh@google.com, jmorris@namei.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        madvenka@linux.microsoft.com, mjg59@google.com,
        mszeredi@redhat.com, mtk.manpages@gmail.com,
        nramas@linux.microsoft.com, philippe.trebuchet@ssi.gouv.fr,
        scottsh@microsoft.com, sean.j.christopherson@intel.com,
        sgrubb@redhat.com, shuah@kernel.org, steve.dower@python.org,
        thibaut.sautereau@clip-os.org, vincent.strubel@ssi.gouv.fr,
        viro@zeniv.linux.org.uk, willy@infradead.org, zohar@linux.ibm.com
Subject: Re: [PATCH v12 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202110061500.B8F821C@keescook>
References: <20201203173118.379271-1-mic@digikod.net>
 <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
 <2a4cf50c-7e79-75d1-7907-8218e669f7fa@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4cf50c-7e79-75d1-7907-8218e669f7fa@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 09, 2021 at 07:15:42PM +0200, Mickaël Salaün wrote:
> There was no new reviews, probably because the FS maintainers were busy,
> and I was focused on Landlock (which is now in -next), but I plan to
> send a new patch series for trusted_for(2) soon.

Hi!

Did this ever happen? It looks like it's in good shape, and I think it's
a nice building block for userspace to have. Are you able to rebase and
re-send this?

I've tended to aim these things at akpm if Al gets busy. (And since
you've had past review from Al, that should be hopefully sufficient.)

Thanks for chasing this!

-Kees

-- 
Kees Cook
