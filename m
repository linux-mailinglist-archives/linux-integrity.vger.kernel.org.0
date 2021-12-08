Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA246D667
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhLHPIb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 10:08:31 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:54518 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235600AbhLHPIb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 10:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638975899;
        bh=Sm5R1vWRpvxmDKdGbI9FHr+/9qJwamYHqEif5HCeedw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JkAoHh3KOCw1+eU+2EYFgAlqkIhg53U/RY4CnUYgYDyrg+f/kAHRrjfkNp2vUOEM7
         1e/5Y35Vm0/3F25ECoLF+nsu9IFMyAx9GsJeS4jK8xIQaok7A5QV+rhH8WUmQLugwn
         Or6zK3NhE6zn6SNGAgd0bOF/NYacOgG79CzpFr7s=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CE861280D7A;
        Wed,  8 Dec 2021 10:04:59 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ue35qeCBpGnq; Wed,  8 Dec 2021 10:04:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638975899;
        bh=Sm5R1vWRpvxmDKdGbI9FHr+/9qJwamYHqEif5HCeedw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JkAoHh3KOCw1+eU+2EYFgAlqkIhg53U/RY4CnUYgYDyrg+f/kAHRrjfkNp2vUOEM7
         1e/5Y35Vm0/3F25ECoLF+nsu9IFMyAx9GsJeS4jK8xIQaok7A5QV+rhH8WUmQLugwn
         Or6zK3NhE6zn6SNGAgd0bOF/NYacOgG79CzpFr7s=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F30041280D78;
        Wed,  8 Dec 2021 10:04:56 -0500 (EST)
Message-ID: <0654f5befe3daa4915ed70be82c512b958a25c9a.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 08 Dec 2021 10:04:55 -0500
In-Reply-To: <20211208144634.rqwn3ccizrbzdq52@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
         <20211207202127.1508689-17-stefanb@linux.ibm.com>
         <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
         <dd43783ae76ad3238d99f75d8aaf95e20ad28b79.camel@HansenPartnership.com>
         <20211208144634.rqwn3ccizrbzdq52@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-08 at 15:46 +0100, Christian Brauner wrote:
> On Wed, Dec 08, 2021 at 09:11:09AM -0500, James Bottomley wrote:
> > On Wed, 2021-12-08 at 13:58 +0100, Christian Brauner wrote:
> > > On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
> > [...]
> > > > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct
> > > > fs_context *fc)
> > > >  
> > > >  static void securityfs_kill_super(struct super_block *sb)
> > > >  {
> > > > +	struct user_namespace *ns = sb->s_fs_info;
> > > > +
> > > > +	if (ns != &init_user_ns)
> > > > +		ima_fs_ns_free_dentries(ns);
> > > 
> > > Say securityfs is unmounted. Then all the inodes and dentries
> > > become invalid. It's not allowed to hold on to any dentries or
> > > inodes after the super_block is shut down. So I just want to be
> > > sure that nothing in ima can access these dentries after
> > > securityfs is unmounted.
> > > 
> > > To put it another way: why are they stored in struct
> > > ima_namespace in the first place? If you don't pin a filesystem
> > > when creating files or directories like you do for securityfs in
> > > init_ima_ns then you don't need to hold on to them as they will
> > > be automatically be wiped during umount.
> > 
> > For IMA this is true because IMA can't be a module.  However, a
> > modular
> 
> This thread is about ima and its stashing of dentries in struct
> ima_namespace. That things might be different for other consumers is
> uninteresting for this specific case, I think.

Well, yes, but the patch series also includes namespacing securityfs. 
We have to get that right for all consumers, including the modular
ones.  So I think the way it works is we don't need a remove callback
in kill_sb() if we don't raise the dentry refcount in create.  However,
we still need to return the dentry to allow for stashing and we still
need to be able to cope with remove being called for the namespaced
entries ... for teardown on error in the IMA case and module
removal+teardown on error in other cases.

> > consumer, like the TPM, must be able to remove its entries from a
> > mounted securityfs because the code that serves the operations is
> > going away.  In order to do this removal, it needs the dentries
> > somewhere. 
> 
> That still doesn't require you to take an additional reference on the
> dentry per se.

No, I don't believe it does ... however it does require a stash
somewhere.

> Aside from this brings in a whole different and way bigger issue as
> that requires way more fundamental work since this is about a (pseudo
> or proper) device. It's not even clear that this should have entries
> outside of init_user_ns-securityfs.

adding vTPMs is a use case that people want to support, so I don't want
to get to that bit and find it all doesn't work.

> > The current convention seems to be everything has a directory in
> > the top level, so we could call d_genocide() on this directory and
> > not have to worry about storing the dentries underneath, but I
> > think we can't avoid storing the dentry for the top level
> > directory.
> 
> I have not heard an argument why ima needs to stash these dentries as
> it doesn't remove them once created until umount.

I'm not saying IMA does, I'm just saying we still need the dentry
returned by the API in case a consumer does need to stash.

James



