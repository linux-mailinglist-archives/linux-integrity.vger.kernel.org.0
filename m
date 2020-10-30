Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E042E2A0FA1
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 21:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgJ3UiH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgJ3UiG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 16:38:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF44C0613D2
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2020 13:38:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p93so7967921edd.7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2020 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtPauSqKwJG5D5tXCeCcRBhlhHsdB0HpiFXLoo+fML0=;
        b=GxBUFZvgq5bsOLRF3G84VhjEqHDdIhTwWOPjIIqoJZG63kQ/W7QPdx2MmUo1rfOXXS
         d4kQ8dDsbb6aXEkjCPTusrfNQOhA0GDB5cswx0HzCXNCIbMrStkYM9f3Kj5rMsXNLH6F
         ULsJnFrfRvCcWMZZysIxVyM9ILQwquXjNCURhRZ/92wLdM1EA5brfeyh0U4jdEPIw0WX
         1mwqjOqiw4OvZ9nTXXd79KyaaM/PM3svHnh7E2YIrxyoWdlPF7XRNV6o9DAlkknUnXLn
         9SILO/cWefxXXFKV+JYj+aVRex+Lf2jeXOTdyaWTibZxTkFfOYtWv9WWSkACftv4XTsS
         oANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtPauSqKwJG5D5tXCeCcRBhlhHsdB0HpiFXLoo+fML0=;
        b=WE47zo6v2xA9AfYpTg0neHLs3S6cANFvbqgAvw0quHgy2QgNchHzcG9UjcP4y0XWkh
         x5CcCy0LrR2l2bQ/vKjlmGyhXUnOc5TAqyd+LBCGR7f15oxTB/H+G+c7jPyrzBmDfbZ1
         wM6f2pcKhrXS49hxoNURHPS3l3Ct6H1VtCX4DXEmpDQN+J+LVryzwCZiHOxARQbp+M8G
         i4LritXIT3zF1UJw/yFa5fI0TX2DzVfQLCvfc1coksv9srdNXn40yKeGfcMEopFMThsY
         3iaGp7RIPhpnxfUeGEvLkYW4NHw40hAzf4+mgZPZMTBEv6p5MN9FNK7PDJz8v4ydGWSr
         WT+g==
X-Gm-Message-State: AOAM532bCV+3UuUn6JGGqC46fU6+4ZaJDiHcJF7V77Mu2LA+bZFWxelz
        ekkfF6gYFE66g7CNAmBClIyyOiZ5QETzLg2GigUf
X-Google-Smtp-Source: ABdhPJwCTC9hqhAPRcAXeSRxUNIhXXZ6FqpWVMydk28cE7eJAdL1lcm2vdJwxicSEgr+1VaVQ+gK8Ng2Mz7izW1PxJY=
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr4271625edc.135.1604090285122;
 Fri, 30 Oct 2020 13:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com> <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
In-Reply-To: <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Oct 2020 16:37:53 -0400
Message-ID: <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 30, 2020 at 12:43 PM Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
> > Unless this patch set is specifically dependent on the two patches in
> > the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
>
> Thanks Mimi. We don't have dependencies on those two patches in SELinux
> tree.
>
> We'll base our changes on v5.10.0-rc1 in SELinux tree.
>
> Thanks for the quick response.

I'm not as fast as Mimi, but I thought it might be worthwhile to
provide a bit more detail as to what I expect from SELinux kernel
submissions.  I believe most other maintainers operate in a similar
manner, but I obviously can't speak for them.

Unless there is an exception due to a previous discussion, I ask that
all SELinux kernel patches be based on either the selinux/next branch
or Linus' current tree.  If your patch(set) applies cleanly to either
of those branches, and passes review, I'll merge it into the
selinux/next branch taking care of any merge conflicts that may arise.
If the merge is particularly tricky I may ask you to double check the
merge afterwards, but in my experience that is rare, most merge
conflicts are trivially resolved.

In the case where a patch(set) being proposed for inclusion in the
SELinux tree has significant changes to another subsystem, I will ask
the affected subsystem's maintainer to review the patch(set).  If the
other maintainers do not provide an ACK for the patch(set) I will not
merge the patches.  If the other maintainers do not respond at all for
a few weeks, I may go ahead and merge the patch(set) anyway; that is a
decision made on a case-by-base basis.

If the patch(set) introduces new functionality I will ask you to add
or update an existing test in the selinux-testsuite.
* https://github.com/SELinuxProject/selinux-testsuite

If the patch(set) introduces new, or changed, functionality I may ask
you to update The SELinux Notebook.
* https://github.com/SELinuxProject/selinux-notebook

Beyond the above, the general SELinux kernel tree process is
documented in the README.md found in selinux/main:
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md

-- 
paul moore
www.paul-moore.com
