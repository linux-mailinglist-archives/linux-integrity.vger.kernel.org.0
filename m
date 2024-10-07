Return-Path: <linux-integrity+bounces-3741-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998699343D
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504F31C23A63
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B31DC186;
	Mon,  7 Oct 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DYIIOMBw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2B1DC07F
	for <linux-integrity@vger.kernel.org>; Mon,  7 Oct 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320293; cv=none; b=hJ6++RVA609nwKya9BIuWJ9Ose2JUy2C06iOjSXQyTxhvqGn8bsV/guU1YCAKoGveiY7NpfH443ZldvzOImWpQoF6HqdzFxByWTFj86oUmAvpfSLo6xUvZvClpqVs5OGvxek8xvYAl0v4fcEtecoBJiJ7lO4eJvQwyDsPRM2v/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320293; c=relaxed/simple;
	bh=yzIwSmW9HtFRrrzylid8yhtEpl5lGIwiwFhhu3I22i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b59cf6qi+0NWpNL/KCBORtYWQ8VvWe6GDEZakeLtmoOIF/vHr/FMvkwG3K4e2MBka9eUBtVCet2pynyn4NmqMRdJla3yNLMF2OqWuclac4rdMAFrvqmMw6pU8svCAlUxIVypfstzGrXGS1mBBEHgUjhzyVo2dO81moPzj/Bk4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DYIIOMBw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e25f3748e0so45880327b3.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Oct 2024 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728320291; x=1728925091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FDLwYr0W0I2TyrqabkmE1dfXEL1zmhPVUq3NdPKOu8=;
        b=DYIIOMBwvC9WJ0Tvxs31qZewYS5/GAjvSOlaxhK4lp4PRLcPprJVbFpVKmYYYpURAe
         7P5uXGUt8OVhakz8wKUv4I2U+trUTvZIMbI7TiTEGsyxlU0q7EFpV8QxPZn3GeFEecPB
         L+vg5o5yfRcNcG6kud+XoltFYsFACAVUw8tGvR5yhZ2NGDA50li3UIbvI3KMGaDbDN6n
         S705jZmHpbEd3Q/dCzvGNWa377eGW3sIG7mwj2n2HObbZTFmPXBycuhEtRda16Z6aWyT
         TfKe9ujirtuVZ3cEeF2DAuNIhl3r2zPzZKJAy7qapZiefc91q61t+851oI+WMn7cNMX9
         MvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320291; x=1728925091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FDLwYr0W0I2TyrqabkmE1dfXEL1zmhPVUq3NdPKOu8=;
        b=C4q1Vmg2W1b0AjwXdQqLFSxmSuFPn6BGfLtuxxnpBbbopnTun5Er4XUnjFOkP1WKN/
         Prk4nu9jvnYdClo7vi9xAVklfkTfZG3bbaPd0Kr7CbK1AW1Zvs2eN/uYOmvjLdhahnHi
         LBSbJMhYpszT1RPvJ3+7nN1QKLCC2EeIIySpKvEtLJ2Mu57Og7h/1PHXcyKt4r7qL8tT
         eb0zH1ljUW4eKO8wXm2glo4h69Pa5MwbJEsW5EsBmyKinVlsN0cC03ShoUlqLvcTx18l
         IEPjm+MaXuC42wDB28feOo+5GSFCM5dAOMBJPBIslUX0JCFSQdv3VeEiUJIm/SJlRk4A
         UzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVqjEDgIxa0sRaP+S3OCJlANDKrU1jk/ACDfYYUnD7lUfWnh26BkqQaBGGgmCbviGkUl/wyjW2xIhZk2/nA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMe/PYT3OmvTTfyU/cyCjZkxy/i58ztqIM5bamHX0eC0R9SABN
	CF7CkpK86ifj8SPk3iaonYDW/fkIpDHtQ6Xv/7KMSlHLXCym8BqUDD/pGd7EdqcpGYQLvZvWkI0
	zOUTCoeHCBw7MjlL9901D+iO0Q6GLpnIoljA7
X-Google-Smtp-Source: AGHT+IFNRdRw5/QfeWn+YZcg6EYhNUDISm5RwXNFrmhrBCU4JilAZjxQqSfb9m9kQ/pHzm2oJ8T1BPTDLI27V/5AAXQ=
X-Received: by 2002:a05:6902:2408:b0:e25:c0b4:f364 with SMTP id
 3f1490d57ef6-e28936dc8f5mr7574805276.17.1728320291200; Mon, 07 Oct 2024
 09:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
 <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
 <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com> <70f55efdba0e682907c895ea8ba537ea435bc3aa.camel@huaweicloud.com>
In-Reply-To: <70f55efdba0e682907c895ea8ba537ea435bc3aa.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 12:58:05 -0400
Message-ID: <CAHC9VhRt1BA_U2cEDFjHK_bmfW0ejx2AtbwZKgE5FFRDbUYNOg@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Shu Han <ebpqwerty472123@gmail.com>, 
	syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:49=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2024-10-07 at 12:35 -0400, Paul Moore wrote:
> > On Mon, Oct 7, 2024 at 11:31=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> > > > On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gm=
ail.com> wrote:
> > > > >
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > WARNING: possible circular locking dependency detected
> > > > > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > > > > ------------------------------------------------------
> > > > > > syz-executor369/5231 is trying to acquire lock:
> > > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:=
 inode_lock include/linux/fs.h:815 [inline]
> > > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:=
 process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > > > > >
> > > > > > but task is already holding lock:
> > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_l=
ock_killable include/linux/mmap_lock.h:122 [inline]
> > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_rem=
ap_file_pages mm/mmap.c:1649 [inline]
> > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_rem=
ap_file_pages+0x22d/0xa50 mm/mmap.c:1624
> > > > > >
> > > > > > which lock already depends on the new lock.
> > > > >
> > > > > This issue (if not a false positive?) is due to the possible `pro=
t`
> > > > > change caused by the processing logic for READ_IMPLIES_EXEC in do=
_mmap(),
> > > > > so the remap_file_pages() must perform LSM check before calling d=
o_mmap(),
> > > > > this is what the previous commit want to do.
> > > >
> > > > My apologies for the delay on this, I was traveling for a bit and
> > > > missed this issue while away.
> > > >
> > > > Looking quickly at the report, I don't believe this is a false posi=
tive.
> > > >
> > > > > The LSM check is required to know what the `prot` is, but `prot` =
must be
> > > > > obtained after holding the `mmap_write_lock`.
> > > > >
> > > > > If the `mmap_write_lock` is released after getting the `prot` and=
 before
> > > > > the LSM call in remap_file_pages(), it may cause TOCTOU.
> > > >
> > > > Looking at the IMA code, specifically the process_measurement()
> > > > function which is called from the security_mmap_file() LSM hook, I'=
m
> > > > not sure why there is the inode_lock() protected region.  Mimi?
> > > > Roberto?  My best guess is that locking the inode may have been
> > > > necessary before we moved the IMA inode state into the inode's LSM
> > > > security blob, but I'm not certain.
> > > >
> > > > Mimi and Roberto, can we safely remove the inode locking in
> > > > process_measurement()?
> > >
> > > I discussed a bit with Mimi. Her concern was the duplicate iint
> > > structure creation during concurrent file accesses. Now that inode
> > > integrity metadata have been moved to the inode security blob, we can
> > > take the iint->mutex out of the ima_iint_cache structure, and store i=
t
> > > directly in the security blob. In this way, we can remove the inode
> > > lock.
> > >
> > > Will write a patch and see if it passes our tests.
> >
> > That's great, thanks Roberto.  Assuming all goes well we'll want to
> > backport this everywhere we merged the remap_file_pages() patch.
>
> Welcome. Probably it can go down only until the kernel where IMA and
> EVM are LSMs.

Yes, we'll need to look at that once we solve this in Linus' tree.

--=20
paul-moore.com

