Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF12F6667
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhANQvz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhANQvz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 11:51:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF294C061575
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 08:51:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b6so5956393edx.5
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3k27iIjxC7sh/PZO3qnIJ/sRNHZDFHKlX0RIApltSw=;
        b=ZgyRh/yU2M1e+J10UbjQxSUSlEd1XLOVgu1/lr5YUK1UzzPdMEaMqpQbLlmBzu9XBK
         V04Guk2sRd0aCET6WUAxwLX2ZUNIOC/Y/CTQUzYWd1HeEQmdJqt27gbrcy8iZJHnrujQ
         Bi3BR0vhJBtgQw86Xh1Jb5JdeWYxjRnIUdJABnuhQ/7PyiVVx9VLk16mlluO9f3m6twP
         SAc2VypVxfSNrA9A5K25M+PCVLcAfnBzI1fMFzWQgs+klUhR8L6YzcmFEWUsDNVRwMku
         p23/mulW55bGoHjesHn339vKbZLy7b5Lsegd5H1CZ+gvAizb0+1lQx7E9vvbqVOduB7s
         x5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3k27iIjxC7sh/PZO3qnIJ/sRNHZDFHKlX0RIApltSw=;
        b=NZqFgFLiSScf/+Ti1x7ID0BTuN53GXpGegmhT3ZBAN757Iu64mpeslwFFYO3XEFfHX
         xBNi4fpV4m6XWu+SHsHsOlKyonItY5cH0Fo4g804rTbyS4A4nVZeoEjPiC+vAAwHjRWT
         J5VzYVyDlhRaNQIQ7Slz9Y+BQNLxHL6m34VpLCgm6JIWO92zFnMJIF4qEH5wnZAx2GZj
         mBYARg94+8hfBA77vFiq6+D3ti3Fox87FGeyQCVm9CwdcI1g5ZDvbHY0Aqpsc+pXppZB
         9Vg98Sy72ibm4vVHGx9Ybdxcl4BNgtEWjswsNWlU9m899suJUc2PFYG0ADbuksbI0xXm
         rocQ==
X-Gm-Message-State: AOAM530ZI7GhMZ6VIlPrHpp1QnaNv1kiX5C6/+kCPIx+bUQQ/J8oKlZJ
        najkZo3VbLQf9GABGDxhF4OvhJrQykLewrFqV49D
X-Google-Smtp-Source: ABdhPJxVa0+vM3ja4ugH1NHGsj5G/TvBdvxpArXXBfbbVXq6GgudnkGd4EwXJ3xfYUrJh1qmQ92BanBPsrs11HCj/Pk=
X-Received: by 2002:aa7:d7d8:: with SMTP id e24mr6250325eds.135.1610643073181;
 Thu, 14 Jan 2021 08:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com> <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
 <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
 <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
 <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
 <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com>
 <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
 <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
 <3746bc7673df25354411151442a7772b867be396.camel@linux.ibm.com>
 <fc80b1a1-ff4d-3bf2-59bd-2cb56135bf0f@linux.microsoft.com> <99be76345f375bb2f485f08a53dcb8ed806dc538.camel@linux.ibm.com>
In-Reply-To: <99be76345f375bb2f485f08a53dcb8ed806dc538.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Jan 2021 11:51:02 -0500
Message-ID: <CAHC9VhTrxCi=H0ezR6eXjXnHH+atU9ieSZWy6pybOE9eAKnrMQ@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 11:44 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [Cc'ing Sasha]
>
> Hi Lakshmi,
>
> On Thu, 2021-01-14 at 08:22 -0800, Lakshmi Ramasubramanian wrote:
> > On 1/13/21 6:49 PM, Mimi Zohar wrote:
>
> > >>> Lakshmi is trying to address the situation where an event changes a
> > >>> value, but then is restored to the original value.  The original and
> > >>> subsequent events are measured, but restoring to the original value
> > >>> isn't re-measured.  This isn't any different than when a file is
> > >>> modified and then reverted.
> > >>>
> > >>> Instead of changing the name like this, which doesn't work for files,
> > >>> allowing duplicate measurements should be generic, based on policy.
> > >>
> > >> Perhaps it is just the end of the day and I'm a bit tired, but I just
> > >> read all of the above and I have no idea what your current thoughts
> > >> are regarding this patch.
> > >
> > > Other than appending the timestamp, which is a hack, the patch is fine.
> > > Support for re-measuring an event can be upstreamed independently.
> > >
> >
> > Thanks for clarifying the details related to duplicate measurement
> > detection and re-measuring.
> >
> > I will keep the timestamp for the time being, even though its a hack, as
> > it helps with re-measuring state changes in SELinux. We will add support
> > for "policy driven" re-measurement as a subsequent patch series.
>
> Once including the timestamp is upstreamed, removing it will be
> difficult, especially if different userspace applications are dependent
> on it.  Unless everyone is on board that removing the timestamp
> wouldn't be considered a regression, it cannot be upstreamed.

I'm not a fan of merging things which are known to be broken only with
the promise of fixing it later.  That goes double when the proper fix
will result in a user visible breaking change.

-- 
paul moore
www.paul-moore.com
