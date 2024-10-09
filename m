Return-Path: <linux-integrity+bounces-3768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D4997186
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971061F25749
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A301E32D7;
	Wed,  9 Oct 2024 16:24:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678981E32A2;
	Wed,  9 Oct 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491051; cv=none; b=H62Vevg5GweeulcHVkm1/q7Cb067115ovoVlhMlVDKjgKuD63qRYmmQqX21h5fPy/md8hKWaek2d0hTnoC7stoztpsxg7su3RoxlT3S5f/LaP0x4avbEFL/LJ4E1UBrUk4ALUSpr3YxaX8ZmOU1qIROYZ2P30u6yt3Eu2KrgLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491051; c=relaxed/simple;
	bh=ss1vuC8T7I/NVqyQ4h0vf7uA1GYauhLiZhKzzJMIc+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cehxZDPsFhh05zB669PK75fXAxtt19u4kOSW9M6t3dy+md0aQTWWdKOQTiBPwBScMa4q9RubVnqkSu46Vj1az1HAIbOHw7ANepLOkXsomRwu82lqbbeBA/0lT9sAgfjC4wz6Co0LmNJC2kxI41wuqJJ2WIapL/437Jr43FeBEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNyPF3GXDz9v7Hk;
	Thu, 10 Oct 2024 00:04:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 41D0E140413;
	Thu, 10 Oct 2024 00:23:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3mMgQrgZnDq6LAg--.65260S2;
	Wed, 09 Oct 2024 17:23:54 +0100 (CET)
Message-ID: <1a1d106ea8bba8abc1d3f3cd6fdd71d03edcf764.camel@huaweicloud.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Shu Han <ebpqwerty472123@gmail.com>, syzbot
 <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
 akpm@linux-foundation.org, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  hughd@google.com, jmorris@namei.org,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com,  serge@hallyn.com,
 stephen.smalley.work@gmail.com,  syzkaller-bugs@googlegroups.com,
 zohar@linux.ibm.com
Date: Wed, 09 Oct 2024 18:23:40 +0200
In-Reply-To: <CAHC9VhRt1BA_U2cEDFjHK_bmfW0ejx2AtbwZKgE5FFRDbUYNOg@mail.gmail.com>
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
	 <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
	 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
	 <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
	 <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com>
	 <70f55efdba0e682907c895ea8ba537ea435bc3aa.camel@huaweicloud.com>
	 <CAHC9VhRt1BA_U2cEDFjHK_bmfW0ejx2AtbwZKgE5FFRDbUYNOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA3mMgQrgZnDq6LAg--.65260S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Gw1kXr15Ar4UWr4kWFg_yoWrJw1fpF
	9aga4Ikr4DtFy7Arn2yr1UW3W0y34UKryUWr95Jr18JF90vF1ktr17Jr1furyUGr95C342
	qr4UWryfJw1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYkhLUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGcF5ngMVQACsp

On Mon, 2024-10-07 at 12:58 -0400, Paul Moore wrote:
> On Mon, Oct 7, 2024 at 12:49=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2024-10-07 at 12:35 -0400, Paul Moore wrote:
> > > On Mon, Oct 7, 2024 at 11:31=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> > > > > On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@=
gmail.com> wrote:
> > > > > >=20
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > WARNING: possible circular locking dependency detected
> > > > > > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > > > > > ------------------------------------------------------
> > > > > > > syz-executor369/5231 is trying to acquire lock:
> > > > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, a=
t: inode_lock include/linux/fs.h:815 [inline]
> > > > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, a=
t: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > > > > > >=20
> > > > > > > but task is already holding lock:
> > > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write=
_lock_killable include/linux/mmap_lock.h:122 [inline]
> > > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_r=
emap_file_pages mm/mmap.c:1649 [inline]
> > > > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_r=
emap_file_pages+0x22d/0xa50 mm/mmap.c:1624
> > > > > > >=20
> > > > > > > which lock already depends on the new lock.
> > > > > >=20
> > > > > > This issue (if not a false positive?) is due to the possible `p=
rot`
> > > > > > change caused by the processing logic for READ_IMPLIES_EXEC in =
do_mmap(),
> > > > > > so the remap_file_pages() must perform LSM check before calling=
 do_mmap(),
> > > > > > this is what the previous commit want to do.
> > > > >=20
> > > > > My apologies for the delay on this, I was traveling for a bit and
> > > > > missed this issue while away.
> > > > >=20
> > > > > Looking quickly at the report, I don't believe this is a false po=
sitive.
> > > > >=20
> > > > > > The LSM check is required to know what the `prot` is, but `prot=
` must be
> > > > > > obtained after holding the `mmap_write_lock`.
> > > > > >=20
> > > > > > If the `mmap_write_lock` is released after getting the `prot` a=
nd before
> > > > > > the LSM call in remap_file_pages(), it may cause TOCTOU.
> > > > >=20
> > > > > Looking at the IMA code, specifically the process_measurement()
> > > > > function which is called from the security_mmap_file() LSM hook, =
I'm
> > > > > not sure why there is the inode_lock() protected region.  Mimi?
> > > > > Roberto?  My best guess is that locking the inode may have been
> > > > > necessary before we moved the IMA inode state into the inode's LS=
M
> > > > > security blob, but I'm not certain.
> > > > >=20
> > > > > Mimi and Roberto, can we safely remove the inode locking in
> > > > > process_measurement()?
> > > >=20
> > > > I discussed a bit with Mimi. Her concern was the duplicate iint
> > > > structure creation during concurrent file accesses. Now that inode
> > > > integrity metadata have been moved to the inode security blob, we c=
an
> > > > take the iint->mutex out of the ima_iint_cache structure, and store=
 it
> > > > directly in the security blob. In this way, we can remove the inode
> > > > lock.
> > > >=20
> > > > Will write a patch and see if it passes our tests.
> > >=20
> > > That's great, thanks Roberto.  Assuming all goes well we'll want to
> > > backport this everywhere we merged the remap_file_pages() patch.
> >=20
> > Welcome. Probably it can go down only until the kernel where IMA and
> > EVM are LSMs.
>=20
> Yes, we'll need to look at that once we solve this in Linus' tree.

#syz test: https://github.com/robertosassu/linux.git ima-remove-inode-lock-=
v1


