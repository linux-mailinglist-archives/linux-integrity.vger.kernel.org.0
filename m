Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD87C4788B7
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhLQKZV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 05:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhLQKZV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 05:25:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B9C061574;
        Fri, 17 Dec 2021 02:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE28AB82788;
        Fri, 17 Dec 2021 10:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8067C36AE5;
        Fri, 17 Dec 2021 10:25:13 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:25:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20211217102511.br4phodpz5brkuoq@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216125027.fte6625wu5vxkjpi@wittgenstein>
 <20211216133148.aw3xs4sxuebkampb@wittgenstein>
 <daccd334-7f8a-41a1-fedd-05c39c504b5b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daccd334-7f8a-41a1-fedd-05c39c504b5b@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 04:27:24PM -0500, Stefan Berger wrote:
> 
> On 12/16/21 08:31, Christian Brauner wrote:
> > On Thu, Dec 16, 2021 at 01:50:27PM +0100, Christian Brauner wrote:
> > > On Thu, Dec 16, 2021 at 12:43:09AM -0500, Stefan Berger wrote:
> > > 
> > > > This patch also introduces usage of CAP_MAC_ADMIN to allow access to the
> > > > IMA policy via reduced capabilities. We would again later on use this
> > > > capability to allow users to set file extended attributes for IMA appraisal
> > > > support.
> > > > 
> > > > My tree with these patches is here:
> > > > 
> > > > git fetch https://github.com/stefanberger/linux-ima-namespaces v5.15+imans.v7.posted
> > > > 
> > > > Regards,
> > > >     Stefan
> > > > 
> > > > v7:
> > > >   - Dropped 2 patches related to key queues; using &init_ima_ns for all calls
> > > >     from functions related to key queues where calls need ima_namespace
> > > >   - Moved ima_namespace to security/integrity/ima/ima.h
> > > >   - Extended API descriptions with ns parameter where needed
> > > >   - Using init_ima_ns in functions related to appraisal and xattrs
> > > >   - SecurityFS: Using ima_ns_from_file() to get ns pointer
> > > >   - Reformatted to 80 columns per line
> > > Since we're starting to be fairly along I would ask you to please write
> > > detailed commit messages for the next revision.
> > > 
> > > I would also like to see all links for prior versions of this patchset
> > > in the commit message since the discussion has been fairly extensive so
> > > for this series it makes a lot of sense. So something like:
> > > 
> > > Link: https://lore.kernel.org/r/$MSGID (v1)
> > > Link: https://lore.kernel.org/r/$MSGID (v2)
> > > Link: https://lore.kernel.org/r/$MSGID (v3)
> > > Link: https://lore.kernel.org/r/$MSGID (v4)
> > > Link: https://lore.kernel.org/r/$MSGID (v5)
> > > Link: https://lore.kernel.org/r/$MSGID (v6)
> > > Link: https://lore.kernel.org/r/$MSGID (v7)
> > > Signed-off-by: meh
> > > Signed-off-by: mih
> > > Signed-off-by: muh
> > > 
> > > I find that extremely pleasant in case we need to revisit things later.
> > > (Technically you can get the same by searching lore via the final link
> > > but I find it be pretty pleasing to just copy+paste directly from the
> > > commit message to the discussion for the earlier patch.)
> > So I looked through the series from a high-level view for once and I
> > would like to change how it is currently structured.
> > 
> > Currently, it looks a lot like you end up with a half-namespaced ima if
> > you compile and run a kernel in the middle of this patch series. Not
> > just is this asking for semantic chaos if we need to debug something it
> > also makes bisection a giant pain later.
> > 
> > In addition, the fact that you need a hack like
> > 
> > > +struct ima_namespace {
> > > +	int avoid_zero_size;
> > in the first patch is another good sign that this should be restructured.
> > 
> > Here's how I would prefer to see this done. I think we should organize
> > this in three big chunks (bullet points are not meant to signify
> > individual patches):
> > 
> > 1. namespace securityfs
> >     This patch is thematically standalone and should move to the
> >     beginning of the series.
> >     I would strongly recommend to fold patch 9 and 10 into a single patch
> >     and add a lengthy explanation. You should be able to recycle a lof of
> >     stuff I wrote in earlier reviews.
> > 
> > 2. Introduce struct ima_namespace and pass it through to all callers:
> >     - introduce struct ima_namespace
> >     - move all the relevant things into this structure (this also avoids
> >       the "avoid_zero_size" hack).
> 
> Before I start any move and don't get it right:
> 
> Is this to be done like in the current set of patches in those steps where
> one thing is moved after another?

Yeah, I think that's perfectly fine and I liked that part of your
series.
I would introduce struct ima_namespace together with a first or
multiple easy member(s) to move into as one patch. And then individual
patches for other, larger members as you did.

> 
> 
> >     - define, setup, and expose init_ima_ns
> 
> 
> We do this alongside the move of the individual pieces into ima_namesapce as
> is done across the patches now? Most of those 'move' patches haven't

- One patch to introduce struct ima_namespace including init_ima_ns and
  a single member that can be moved into it converting all accesses to
  that member to access it via struct ima_namespace.
- Individual patches for other members as you did now.

> received much feedback so far.
> 
> 
> >     - introduce get_current_ns() and always have it return &init_ima_ns for now
> >     - replace all accesses to global variables to go through &init_ima_ns
> 
> And not pass get_current_ns() down from the top level and access the right
> away via ns->foobar but use init_ima_ns.foobar instead?

I would recommend starting to pass down the ima_namespace down right
away so you don't need to do it later when you actually introduce the
ima namespace proper. This could probably be done as part of the first
patch that introduces struct ima_namespace.

If I'm right this will make the actual semantic changes to enable ima
namespaces proper easier to review as they don't contain the jitter that
comes with introducing a new argument into functions.

> 
> 
> >     - add new infrastructure you'll need later on
> >     Bonus is that you can extend all the functions that later need access
> >     to a specific ima namespace to take a struct ima_namespace * argument
> >     and pass down &init_ima_ns down (retrieved via get_current_ns()). This
> >     will make the actual namespace patch very easy to follow.
> 
> 
> I am wondering how this new series is going to relate to the existing series
> and the links you suggest be added on a per patch basis? How much of the
> existing patches can be preserved?

I answered that in the other mail. Just put them in the cover letter. :)

> 
> 
> > 
> > 3. namespace ima
> >     - add a new entry for struct ima_namespace to struct user_namespace
> >     - add creation helpers, kmem cache etc.
> >     - create files in securityfs per ns
> > 
> > This way at all points in the series we have clearly defined semantics
> > where ima namespacing is either fully working or fully not working and
> > the switch is atomic in the patch(es) part of 3.
> 
> 
> The existing series tried this by enabling IMA namespacing support when
> SecurityFS is enabled... Is that also the last step then in what you

It did enable ima namespace support before that. It only wasn't
reachable from userspace since securityfs couldn't be mounted and a
custom policy applied.
But from a pure implementation/development perspective namespacing had
already taken place in the first patch.
Say, if I wanted to debug something in the patch series and compiled in
the middle of the previous patch series then I would have already had to
deal with per-userns ima namespaces before userspace could do anything
with them. So the regression and bug potential that comes with that had
already been fully realized so to speak.

What I want is to have this be one step: namespacing is fully
implemented and turned on at the same time.

> suggest?

No, securityfs can be mounted and just stay empty until ima starts
creating files in there in the last patch. I see no harm in that at all.
