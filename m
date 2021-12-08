Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1846D607
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhLHOuU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhLHOuU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 09:50:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684AC061746;
        Wed,  8 Dec 2021 06:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25483CE21C3;
        Wed,  8 Dec 2021 14:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47442C00446;
        Wed,  8 Dec 2021 14:46:37 +0000 (UTC)
Date:   Wed, 8 Dec 2021 15:46:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Message-ID: <20211208144634.rqwn3ccizrbzdq52@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
 <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
 <dd43783ae76ad3238d99f75d8aaf95e20ad28b79.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd43783ae76ad3238d99f75d8aaf95e20ad28b79.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 09:11:09AM -0500, James Bottomley wrote:
> On Wed, 2021-12-08 at 13:58 +0100, Christian Brauner wrote:
> > On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
> [...]
> > > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct
> > > fs_context *fc)
> > >  
> > >  static void securityfs_kill_super(struct super_block *sb)
> > >  {
> > > +	struct user_namespace *ns = sb->s_fs_info;
> > > +
> > > +	if (ns != &init_user_ns)
> > > +		ima_fs_ns_free_dentries(ns);
> > 
> > Say securityfs is unmounted. Then all the inodes and dentries become
> > invalid. It's not allowed to hold on to any dentries or inodes after
> > the super_block is shut down. So I just want to be sure that nothing
> > in ima can access these dentries after securityfs is unmounted.
> > 
> > To put it another way: why are they stored in struct ima_namespace in
> > the first place? If you don't pin a filesystem when creating files or
> > directories like you do for securityfs in init_ima_ns then you don't
> > need to hold on to them as they will be automatically be wiped during
> > umount.
> 
> For IMA this is true because IMA can't be a module.  However, a modular

This thread is about ima and its stashing of dentries in struct
ima_namespace. That things might be different for other consumers is
uninteresting for this specific case, I think.

> consumer, like the TPM, must be able to remove its entries from a
> mounted securityfs because the code that serves the operations is going
> away.  In order to do this removal, it needs the dentries somewhere. 

That still doesn't require you to take an additional reference on the
dentry per se.
Aside from this brings in a whole different and way bigger issue as that
requires way more fundamental work since this is about a (pseudo or
proper) device. It's not even clear that this should have entries
outside of init_user_ns-securityfs.

> The current convention seems to be everything has a directory in the
> top level, so we could call d_genocide() on this directory and not have
> to worry about storing the dentries underneath, but I think we can't
> avoid storing the dentry for the top level directory.

I have not heard an argument why ima needs to stash these dentries as it
doesn't remove them once created until umount.
