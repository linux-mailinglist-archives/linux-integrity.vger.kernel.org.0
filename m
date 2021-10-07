Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907F3425B82
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbhJGT2P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbhJGT2O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 15:28:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E02C061755
        for <linux-integrity@vger.kernel.org>; Thu,  7 Oct 2021 12:26:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j15so4587126plh.7
        for <linux-integrity@vger.kernel.org>; Thu, 07 Oct 2021 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NZdCC7CS4dz4WubheIViknJtIIkaL8xCwtFH+zR8MvM=;
        b=eHzzunjEiw0c49/WWP7ttbNMcB3anVXl2I3BhWlHxCkAgfUZJaQlEQ4yj49eW+O5Qd
         V/tr9/w7+oeASdwfi2gPR+2A9dR5TzHngo0qjndDetXgsqoAB1QXDYqUefhEG8akLtkm
         NXtn7bxmsTq3rNyvns/y2bVgOPK39DmHni93s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NZdCC7CS4dz4WubheIViknJtIIkaL8xCwtFH+zR8MvM=;
        b=dG8SgqXyct7UGztIRWk3sVoUqvJBHR36xxJ1Zv3EWqKtY66JYpyPUgrH1OR5YJwqdO
         TroJBWb6XyEo26iKbwWbg1ukZxIOMI3/taolaRNgpMnzLtJAz5gKyOVB/+kbp2seHE7g
         BYfEyvw71iZa0bxAQw+S67dykxs4O4SRgPNPF9fLivNmDgYDTzup25LlyyZ5F8qoZte2
         +eW2oKQYpnq4bR6228w9F3D00ibevd1kEWDF0lqbRr0HOk2F9IeHo/ch4CsFcP2csSlq
         kKzyeTHlAhQ91T9vLYEwrsCvpMEi5Sd/AJKKsliYi2XDPUnn3VqGlU/wh3fz82hp8+UC
         DKDQ==
X-Gm-Message-State: AOAM530UBWTkbEdMI3y3fPBEVxXemyiVhzM8ePXFlnIQ+IdAg6C3ybw3
        Xu+CVpk8hOiV/gwF8MBtiNMQRg==
X-Google-Smtp-Source: ABdhPJx4Tw35x1xl9BQYB1be7fBA/xGCyy08poTnjhSNtRNoa/m8AG/GdRnhqGS7ZQ1VLaYiOhqwvw==
X-Received: by 2002:a17:90a:6b4d:: with SMTP id x13mr2840636pjl.208.1633634780607;
        Thu, 07 Oct 2021 12:26:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y24sm210615pfo.69.2021.10.07.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:26:20 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:26:19 -0700
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Subject: Re: [PATCH v13 2/3] arch: Wire up trusted_for(2)
Message-ID: <202110071226.750297A@keescook>
References: <20211007182321.872075-1-mic@digikod.net>
 <20211007182321.872075-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007182321.872075-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 07, 2021 at 08:23:19PM +0200, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Wire up trusted_for(2) for all architectures.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
