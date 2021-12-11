Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD894712ED
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhLKIqa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 03:46:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45630 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhLKIqa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 03:46:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4ECC3CE2F2A;
        Sat, 11 Dec 2021 08:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5EC004DD;
        Sat, 11 Dec 2021 08:46:20 +0000 (UTC)
Date:   Sat, 11 Dec 2021 09:46:17 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20211211084617.axfv5fkhc5eycmac@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
 <20211210113244.odv2ibrifz2jzft5@wittgenstein>
 <8b5eaf38-2e7b-1c82-a715-50f0ffd4d1ff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b5eaf38-2e7b-1c82-a715-50f0ffd4d1ff@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 10, 2021 at 03:08:27PM -0500, Stefan Berger wrote:
> 
> On 12/10/21 06:32, Christian Brauner wrote:
> >  From ecf25d6b2b5895005d4103169bdb55d970e7a865 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner<christian.brauner@ubuntu.com>
> > Date: Fri, 10 Dec 2021 11:56:25 +0100
> > Subject: [PATCH 2/2] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
> > 
> > securityfs: don't allow mounting from outside the filesystem's userns
> > 
> > If we ever need to allow that we should revisit the semantics.
> > ---
> >   security/inode.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/inode.c b/security/inode.c
> > index eaccba7017d9..71f9634228f3 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -43,7 +43,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >   {
> >   	static const struct tree_descr files[] = {{""}};
> >   	struct user_namespace *ns = fc->user_ns;
> > -	int error;
> > +	int error = -EINVAL;
> > +
> > +	if (WARN_ON(ns != current_user_ns()))
> > +		return error;
> >   	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> >   	if (error)
> 
> 
> Oops, I hadn't seen this patch. How can one 'mount from outside the
> filesystem's userns'?

The new mount api is generic enough that this could be possible and it
might gain that ability explicitly at some point in the future for the
sake of delegated mounting. So that's just a good hardening measure.
