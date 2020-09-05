Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1125E7D7
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Sep 2020 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgIENVN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Sep 2020 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgIENVC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Sep 2020 09:21:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D4C061245
        for <linux-integrity@vger.kernel.org>; Sat,  5 Sep 2020 06:21:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so12076789ejo.9
        for <linux-integrity@vger.kernel.org>; Sat, 05 Sep 2020 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cf70RVIxoNSgahE+uIsH3+C73R0A8ae+hS6CMm9ibGo=;
        b=WlyHOhgSqWfBqdLy0WSRBGuNOED84GtNTNQ+Tg3130NwVM5JG66IDt773ASOPFQiPw
         5+7VMCMoYs3lP1tjpecM1xXsUXneiT7LsRj3A+6tz4YJM5D1UY+62QbaRqSCOjLmTvx7
         DnGxz5F6JBwQnOKsFColkQ3ywiTBuQ0HARw6LUFPPdjxC0T8X2m+iePG0Jzxc/NAWrM1
         Zz/H/XBM+ysTYXqaunRGZ66M2XIVMGdTG5HwXewvoet5cDJB1luGhBqyIzUZbgSieFkt
         wwd0mzTkkutAqrqqVXEGQsvSbPjyhnkA2OWQ6icP4Ew12rViKWRdCNR+E4dNaB+rS826
         WiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf70RVIxoNSgahE+uIsH3+C73R0A8ae+hS6CMm9ibGo=;
        b=QcJIp9uV9iQkEiqMITJooTQsaWWy7bARwsLqKwLjtg6UBBDERYSQ6plV3Ko96JuYaj
         eFrJw8P3DwwadOCOdZniaABbWuv3LM66BiPmiGk5Qk8WH7vRGYLCTibxL7QjnL8+Zuqr
         wJLtt9e0PlywhGu5UG3BUACDJWsJXDvLb8hzBOwaawL9aI2cAR/Ea/d8PqPHz9gnqMjW
         I0cU41Q+Ty9d5fSfOyy8nponFIxaV7+M4Pvvv/h7AHJB9OlXLGLpIltCEdUrpSHNRRtn
         nFXvvEqXlmlTNyaus4140gczLwJvttYU2tyi91snbs6x6oVE2HypgdPqyork8stxjOeZ
         6yOA==
X-Gm-Message-State: AOAM532pkW9R3F9oi4XbgmYdeEZ6fuf5Er2QdyEuOudPb5pd3i4KVJSp
        70hZpzIkQfELnvcYrcOHlGbQaQvFLaSFhP1QrsHw
X-Google-Smtp-Source: ABdhPJzK5OBvPjv4UCM6lUpsfkAvko4dfcrSwtYROIrJJ1NOd9VUANU2TzN94R2eyORzcQb0ryRH67pSUK0SpPp44Sg=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr12357873ejn.542.1599312060415;
 Sat, 05 Sep 2020 06:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-11-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-11-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:20:49 -0400
Message-ID: <CAHC9VhQDmx5tSJ4NrEGat-iXjONL0Rfn1O2OqqW7ZbJ43tH6gA@mail.gmail.com>
Subject: Re: [PATCH v20 10/23] LSM: Use lsmblob in security_inode_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 26, 2020 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-integrity@vger.kernel.org
> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditsc.c                    |  6 +++++-
>  security/integrity/ima/ima_policy.c |  4 +---
>  security/security.c                 | 11 +++++++++--
>  4 files changed, 19 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
