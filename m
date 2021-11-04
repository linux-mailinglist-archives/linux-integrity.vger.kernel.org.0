Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C726445A12
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Nov 2021 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhKDTAU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhKDTAT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 15:00:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715FC061203
        for <linux-integrity@vger.kernel.org>; Thu,  4 Nov 2021 11:57:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c8so8163549ede.13
        for <linux-integrity@vger.kernel.org>; Thu, 04 Nov 2021 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UumUZrJhlq3hNY8ny+XSNEmoAHaJP3vhujdIKzTzhk=;
        b=RBPzTVMstrJU0x+mE/LR78sV6eL9yARAVMySYiGYKDyULq/TaxK//6OgwmJabROneV
         4cjTt+fpfPuhGlbR7CBuu/wP0hBgyAVTiggVWaSOgzBmh+L3O5b0ieHXaiVBjg1gavag
         HpZJvZHenlXAlU6Dt/g/v5LDjlETXVjmZyaqAySmfDZVRjtq6VL6m7ZBaQaS8S0GXH1Y
         JMn+/mdRbRsMTPGcTDI/HNO9ei0Kg40cI7FpZG1Iefpu20f9fgC/b3fBwGHIt9qRF2fl
         7eGNyfoSmpIIigyOyjKNY3RCdXavEU626puU8l8hfBJHMLzwH/re4Kq9hqPeC1YdAkGg
         s5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UumUZrJhlq3hNY8ny+XSNEmoAHaJP3vhujdIKzTzhk=;
        b=oJg4+ZBb0WCGuPKnhCrqNZuS/SWTkejfjOuTmbKlMSjbUSkRfssqrYi5zxoJ0IrEOL
         poLIIFKRjjwaX83CUY+vUW9yf2lObzzCEPtq5bvobnieiXmpKPtJRbfyTDK/YR9TUbcw
         bxsQafERgz1QepUBpGRjvB22w0PdevFWmoBdCs1Slq1AmU+4GdFJ3sZkjFzST9yUUl8L
         h76vPlfuNLLrm55V0UDWxtMbIvQBvoh/2Xuq9xw25yiiTg0LAja05T/i9GGybqhtFfaE
         52jMoj/exaRTqfwN3IME/9wjJp5VOvmmi5NTL18yB4alx59eyeQEK6bD89YvyJG0M5FC
         cw1w==
X-Gm-Message-State: AOAM533yNGrhK3mo2srHvla2dfMRy6sLJjygG9yM0S0ZtHCjwAIeQ7yB
        TzejaE5VV9KQD+nbgS5kq9iOghrxkug8hsPMy70g
X-Google-Smtp-Source: ABdhPJzKbh1HxkeGG8jqQ1nxmOwVv7ypNcEY3A+oZUPe64DOdz92+S2wSssWLSRI9pHEVnEJiooAeJpIhoa/6A4VNlE=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr45974304ejc.126.1636052259578;
 Thu, 04 Nov 2021 11:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <ef82b8f5-082c-d2c5-2781-8a6bd90306cd.ref@schaufler-ca.com> <ef82b8f5-082c-d2c5-2781-8a6bd90306cd@schaufler-ca.com>
In-Reply-To: <ef82b8f5-082c-d2c5-2781-8a6bd90306cd@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Nov 2021 14:57:28 -0400
Message-ID: <CAHC9VhSDXYfd3uZoFM=+onQcz=oM+3ZUr875SYvkDqhJA-QkWA@mail.gmail.com>
Subject: Re: Disassociating ima_filter_rule* from security_audit_rule*
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 4, 2021 at 1:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> After the last round of comments on the LSM stacking patches
> Dmitry Mastykin <dmastykin@astralinux.ru> pointed out a
> conundrum with reuse of the security_audit_rule functions
> in integrity rule processing. The audit system wants to
> match rules for any security module that as one. The
> integrity system wants to match rules for a single, explicitly
> defined LSM. The two sub-systems use common code in security.c
> which needs to be changed to support multiple LSMs, but needs
> to be changed differently for each of these cases. While it
> would be possible to create frankensteinish versions of the
> security_audit_rule functions that would handle both cases
> it seems that creating "real" versions of the ima_filter_rule
> functions would be considerably cleaner and easier to maintain
> going forward.
>
> I'm suggesting this now, while I'm still working on the patches,
> in case there's a solid reason that frankencode is absolutely
> everybody's favored approach. I plan to propose the disassociation
> as a patch separate from and in advance of the stacking series.

I'm not 100% clear on what you are talking about, but since you are
currently working on the next revision to the LSM stacking patchset
perhaps it's best to just wait and see what the code looks like.

-- 
paul moore
www.paul-moore.com
