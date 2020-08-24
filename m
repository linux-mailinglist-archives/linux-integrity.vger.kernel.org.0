Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176B42509B9
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHXUBf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 16:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgHXUBd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 16:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598299291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=aW1gbBVcqVCzvpcGarXB2wzf8AKhuqvkFcHVXgh1TlkEXhVWUCt4jBa8izb0etDlQBm5Qw
        CS5v+tzjnzDszkdSwLTtn5c3pbrWAYgBtMHg4pptJanvmdiXgagJIAyImT0QJ7EM8pGcwI
        Ti3eWQNT4gIQmPw9ezRLOl7lOuLWRjE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-n2uTcLIoPbCtuMaYLzdGrQ-1; Mon, 24 Aug 2020 16:01:29 -0400
X-MC-Unique: n2uTcLIoPbCtuMaYLzdGrQ-1
Received: by mail-lj1-f197.google.com with SMTP id a20so3118399lji.17
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=ESRBkkg5+sXDCfbWWooWrGEIAAMguvYUdCdYiyD1vjvEqWhAtI+S+EQeoCOkzPLdCN
         LTFUw5t7jAxhdoRo6AqcRjHXrKfYZVlVRJlsvjWto90byeVgfrr9qv2/KHzWxuph5nGm
         4kPt+e0HmreG+xO27nGPWx2lT+h3AG46UOXlQmz/wg5FFiPkadgzG2Sgn1H0PW+URu14
         hWEBZ4+O+LkTvVJY9t5HRwXkt5ATDpY4ugSXGAJ0gVrw2bBxEyYwu3k26VlOGVjsud/J
         FUJIs7TPPMaxUKzU53NiHwTJNoQKGRCUljkr5TYvv1M+29XeehIiwAEPzj8c552ZOkbR
         JOvQ==
X-Gm-Message-State: AOAM533KQzHhXn317yfDYcjWNAxJIGOfv6630BY6d5G5lX8kXAZChojm
        NiX9oka3uqSSXVOckDspPgM/OaTm8he42h1PJZQU4l9yVv3+fdHWRNTyX8Rd9X37u6viju6DsZn
        Vf62P0HggZddt+dUiVak9H9K8zbDJ3u9lwN8CzlrcvjmC
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180382ljc.38.1598299288296;
        Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlH+auARhq7SWPbHEI59342ZMN+shTt3ocQ8lwjHmShhNGjby6clQhLnKc2Mg8F5+NM25k106HjhZgrKaoXJ0=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180369ljc.38.1598299288036;
 Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com> <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 22:01:17 +0200
Message-ID: <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 8/24/20 7:00 AM, Stephen Smalley wrote:
> >
> > >> +int security_read_policy_kernel(struct selinux_state *state,
> > >> +                               void **data, size_t *len)
> > >> +{
> > >> +       int rc;
> > >> +
> > >> +       rc = security_read_policy_len(state, len);
> > >> +       if (rc)
> > >> +               return rc;
> > >> +
> > >> +       *data = vmalloc(*len);
> > >> +       if (!*data)
> > >> +               return -ENOMEM;
> > >>
> > >> +       return security_read_selinux_policy(state, data, len);
> > >>   }
> > >
> > > See the discussion here:
> > > https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
> > >
> > > In order for this to be safe, you need to ensure that all callers of
> > > security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
> > > any use of security_read_policy_len() occurs while holding the mutex.
> > > Otherwise, the length can change between security_read_policy_len()
> > > and security_read_selinux_policy() if policy is reloaded.
> > >
> >
> > "struct selinux_fs_info" is available when calling
> > security_read_policy_kernel() - currently in measure.c.
> > Only "struct selinux_state" is.
> >
> > Is Ondrej's re-try approach I need to use to workaround policy reload issue?
>
> No, I think perhaps we should move the mutex to selinux_state instead
> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> it can then use it indirectly.  Note that your patches are going to
> conflict with other ongoing work in the selinux next branch that is
> refactoring policy load and converting the policy rwlock to RCU.

Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
that would allow you to do this in a straightforward way without even
messing with the fsi->mutex. My patch may or may not be eventually
committed, but either way I'd recommend holding off on this for a
while until the dust settles around the RCU conversion.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

