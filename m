Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4294652F3
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 17:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbhLAQnl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 11:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbhLAQnk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 11:43:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F037C06174A
        for <linux-integrity@vger.kernel.org>; Wed,  1 Dec 2021 08:40:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u17so18121455plg.9
        for <linux-integrity@vger.kernel.org>; Wed, 01 Dec 2021 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y8cmWY4Zar66oxROb9aCaWg+WHCdO5TorclDxazoih0=;
        b=KMrgAdmxIQ8K3dFwdZP0KgMke/VWmOiwmkpwK8XtO5jg0bv+IwT6kwy5QeCS8cVmkG
         iXva0YNAfh0jDs3F2vVeVDeeSEVNtLaDMU2jGFO9dRGbP5aXdL3iPH4S0TdEOsAPotsb
         vAd3VHhwy3mFo4QwZrOfawXcT16vzNk/wWXh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y8cmWY4Zar66oxROb9aCaWg+WHCdO5TorclDxazoih0=;
        b=gCNbpLP5N9gspN3IMHR6j+JHU6GxoCvdcO9Qy3xoCRMWj/h+ASII2TQKnA/Y7vHMgx
         jL0zOUKxjebU4gC+qGuMNmqtSkq1t87BjmjgDThdUCPz7yxuqEc1TScn2N0Wpnm/iIan
         Hrn4iDatnsdiakehSv1KrqtqtStEpSLeMFsgFCrQSYq0v2Coo15ZpU/mYHt5sFk1PWbm
         zlcjadoCCJeC1vsWtX7Cv8dFmI5dPBeHpnoQ0l8+jSjCnAZIMj46QpuTno4Lo0FAdQUM
         5pqxylsFd9l3JuhR/u/RK3Dez3sa8Wq6fkjJkyTXPJYmMMx+OKIGLNogJDvf9dvsQDx0
         4X+g==
X-Gm-Message-State: AOAM531ITGV4tQ+EZtUB94gWQf9d2yxaN9DOgfm4UucDJSChb+G3vrYb
        zNcOnqMa2g+gmREOCk+nd4/HXg==
X-Google-Smtp-Source: ABdhPJwJfw+rygwnhuiEpbRB+v+vZNeROz8C/SXUcdZBzJqV6OaozK2TnS2SEtEqIW0r9VUrX4HDWg==
X-Received: by 2002:a17:90b:3ec2:: with SMTP id rm2mr9031549pjb.1.1638376818926;
        Wed, 01 Dec 2021 08:40:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm322535pfl.98.2021.12.01.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:40:18 -0800 (PST)
Date:   Wed, 1 Dec 2021 08:40:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
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
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v17 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202112010839.4362C7A70@keescook>
References: <20211115185304.198460-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115185304.198460-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 15, 2021 at 07:53:01PM +0100, Mickaël Salaün wrote:
> Andrew, can you please consider to merge this into your tree?

Friendly ping to akpm. :)

Can this start living in -mm, or would a different tree be better?

Thanks!

-Kees

-- 
Kees Cook
