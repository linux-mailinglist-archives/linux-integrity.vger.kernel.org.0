Return-Path: <linux-integrity+bounces-5940-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A655A941DE
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 07:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5479C7A27EC
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4FB14901B;
	Sat, 19 Apr 2025 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgHx4FY7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997E184F;
	Sat, 19 Apr 2025 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745042000; cv=none; b=Km2plVaE6prQu0KQwszWVNDbrIqXHkqa+p7nWPy6/JMzDAAezPXRHvPdLq8rfwT9mMcvw53aqBfGUKwLZhhJtThdTyPHKBJ8//EUl/Nwi48KbCDTSwHXtmct8J+JMQ68tHwHsOs8opZbaLAKdXDrWjuRJzJvCXOkE+dqTXf1tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745042000; c=relaxed/simple;
	bh=ZdTYrEJ0CdQH+h21BhOU3d17aXI4O1HqjMJirLqH63s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMATc0841Y6MGTTR1wS5MA5o52pVlj4U6nKDo2+PBuib4C1QJS+jiDBVjzi+ad5bIHgMA76S75lyiQKKDMZgTyeCulALhY5F7rbS36NpcPsrTksxhJ7e2ySElVSQ4lvZ7BMYkyZ+sgCnre9ug3QYu1jv9Ti9S1a8FEYbKnBezwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgHx4FY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F7C4CEE7;
	Sat, 19 Apr 2025 05:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745041999;
	bh=ZdTYrEJ0CdQH+h21BhOU3d17aXI4O1HqjMJirLqH63s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgHx4FY7AXJYlcUKG42T0fzOgqy/Jq/VE25XFjGwhZXcAshIYN8s4/N9VhgCuPhci
	 Nd0Fws3Tu5uHRAemhOZy+pZh3pmcPh+SNIaGdQpl4qPuYhSMt8abLjLYMTauIk4/Mb
	 L0ockSWLRBjepZ1a8KH7TEoypoaBLevbrcQZgaFyHlgCJFI66/DtDiRyZJc8hnA3Cx
	 ChbyrzhYx0HDW/7kWLIN7/7jSkOEXEaqHkU+iEYEPN9s7W1dYis/0xK+GKX8ufVPV9
	 ye+f51nWH/m5mX4So1Rmmn4+zyM/67mxTWoUJ4eUYSIMctinDtC74CmeASwAXaG3A5
	 BreVTGmTK5phQ==
Date: Fri, 18 Apr 2025 22:53:16 -0700
From: Kees Cook <kees@kernel.org>
To: Fan Wu <wufan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
Message-ID: <202504182252.64ED7AA4F@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-41-paul@paul-moore.com>
 <CAKtyLkEzie5dg2sVETdZ6NZwwN0Ni7SY4Za5mDCMWRJkUtYh=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKtyLkEzie5dg2sVETdZ6NZwwN0Ni7SY4Za5mDCMWRJkUtYh=w@mail.gmail.com>

On Fri, Apr 18, 2025 at 07:42:52PM -0700, Fan Wu wrote:
> On Wed, Apr 9, 2025 at 11:53 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Convert the lsm_blob_size fields to unsigned integers as there is no
> > current need for them to be negative, change "lsm_set_blob_size()" to
> > "lsm_blob_size_update()" to better reflect reality, and perform some
> > other minor cleanups to the associated code.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h | 28 +++++++++++-----------
> >  security/lsm_init.c       | 50 +++++++++++++++++++++++----------------
> >  2 files changed, 43 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index bc477fb20d02..a7ecb0791a0f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -102,20 +102,20 @@ struct security_hook_list {
> >   * Security blob size or offset data.
> >   */
> >  struct lsm_blob_sizes {
> > -       int lbs_cred;
> > -       int lbs_file;
> > -       int lbs_ib;
> > -       int lbs_inode;
> > -       int lbs_sock;
> > -       int lbs_superblock;
> > -       int lbs_ipc;
> > -       int lbs_key;
> > -       int lbs_msg_msg;
> > -       int lbs_perf_event;
> > -       int lbs_task;
> > -       int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> > -       int lbs_tun_dev;
> > -       int lbs_bdev;
> > +       unsigned int lbs_cred;
> > +       unsigned int lbs_file;
> > +       unsigned int lbs_ib;
> > +       unsigned int lbs_inode;
> > +       unsigned int lbs_sock;
> > +       unsigned int lbs_superblock;
> > +       unsigned int lbs_ipc;
> > +       unsigned int lbs_key;
> > +       unsigned int lbs_msg_msg;
> > +       unsigned int lbs_perf_event;
> > +       unsigned int lbs_task;
> > +       unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> > +       unsigned int lbs_tun_dev;
> > +       unsigned int lbs_bdev;
> >  };
> 
> Can we use size_t here?

These blobs are relatively small -- size_t would double the memory usage here.

-- 
Kees Cook

