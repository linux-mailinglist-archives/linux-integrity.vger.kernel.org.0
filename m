Return-Path: <linux-integrity+bounces-3740-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4489933DA
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A864B1C230F2
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBF1DB352;
	Mon,  7 Oct 2024 16:49:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC661DB342;
	Mon,  7 Oct 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319786; cv=none; b=cNvavw+TaDk2BlSWxDgF/TINCQqGBRxlxvJVDj04i0mqoswMhGDyl3CMkcOdJili1JveqCHHsa+Ggr2a823v7uoA/0yYjSmwHFrV8VLKaNZYh+eR1lHFRisA/mxnZqeWH/pi7+OMkQ3gkG1+qPOHwTE5D8QaW1c1Hp3t2z8kVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319786; c=relaxed/simple;
	bh=e6oL7ZRUZC32HjR14NFb3QSMDDEUolhQktq5ahOdaFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWrHM+rt7Wy9uDaT9/41gXbq/XCZ2eLdZqm/dzxvn9ZtmUzzlEqbYYDXqj96iNsmf7PicIEzuo4b3+G24ivhQBarq30gF7b32S+u/Pa8czXwC0lmMOPYX+M57YtqlxZg7bZddv8VwmsI2yyKw6d+4DUlOlBuaYP2/PLMG1UDS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XMl3m3dKzz9v7NS;
	Tue,  8 Oct 2024 00:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DBD1A140516;
	Tue,  8 Oct 2024 00:49:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXOMkOEQRnSZ5qAg--.56494S2;
	Mon, 07 Oct 2024 17:49:29 +0100 (CET)
Message-ID: <70f55efdba0e682907c895ea8ba537ea435bc3aa.camel@huaweicloud.com>
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
Date: Mon, 07 Oct 2024 18:49:15 +0200
In-Reply-To: <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com>
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
	 <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
	 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
	 <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
	 <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXOMkOEQRnSZ5qAg--.56494S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Xw1xtryrCF4xZryfCrg_yoW5ury8pF
	9agayIkr4ktFy7Arn2yr1UW3W0y34UKrWUWrZ5Jr18t3Z0vF1ktr17Jr1fuFyUGrZ5u34I
	qr4UWryfJ3WDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGcDQ-4OAAAEsc

On Mon, 2024-10-07 at 12:35 -0400, Paul Moore wrote:
> On Mon, Oct 7, 2024 at 11:31=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> > > On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmai=
l.com> wrote:
> > > >=20
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > WARNING: possible circular locking dependency detected
> > > > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > > > ------------------------------------------------------
> > > > > syz-executor369/5231 is trying to acquire lock:
> > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: i=
node_lock include/linux/fs.h:815 [inline]
> > > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: p=
rocess_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > > > >=20
> > > > > but task is already holding lock:
> > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_loc=
k_killable include/linux/mmap_lock.h:122 [inline]
> > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap=
_file_pages mm/mmap.c:1649 [inline]
> > > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap=
_file_pages+0x22d/0xa50 mm/mmap.c:1624
> > > > >=20
> > > > > which lock already depends on the new lock.
> > > >=20
> > > > This issue (if not a false positive?) is due to the possible `prot`
> > > > change caused by the processing logic for READ_IMPLIES_EXEC in do_m=
map(),
> > > > so the remap_file_pages() must perform LSM check before calling do_=
mmap(),
> > > > this is what the previous commit want to do.
> > >=20
> > > My apologies for the delay on this, I was traveling for a bit and
> > > missed this issue while away.
> > >=20
> > > Looking quickly at the report, I don't believe this is a false positi=
ve.
> > >=20
> > > > The LSM check is required to know what the `prot` is, but `prot` mu=
st be
> > > > obtained after holding the `mmap_write_lock`.
> > > >=20
> > > > If the `mmap_write_lock` is released after getting the `prot` and b=
efore
> > > > the LSM call in remap_file_pages(), it may cause TOCTOU.
> > >=20
> > > Looking at the IMA code, specifically the process_measurement()
> > > function which is called from the security_mmap_file() LSM hook, I'm
> > > not sure why there is the inode_lock() protected region.  Mimi?
> > > Roberto?  My best guess is that locking the inode may have been
> > > necessary before we moved the IMA inode state into the inode's LSM
> > > security blob, but I'm not certain.
> > >=20
> > > Mimi and Roberto, can we safely remove the inode locking in
> > > process_measurement()?
> >=20
> > I discussed a bit with Mimi. Her concern was the duplicate iint
> > structure creation during concurrent file accesses. Now that inode
> > integrity metadata have been moved to the inode security blob, we can
> > take the iint->mutex out of the ima_iint_cache structure, and store it
> > directly in the security blob. In this way, we can remove the inode
> > lock.
> >=20
> > Will write a patch and see if it passes our tests.
>=20
> That's great, thanks Roberto.  Assuming all goes well we'll want to
> backport this everywhere we merged the remap_file_pages() patch.

Welcome. Probably it can go down only until the kernel where IMA and
EVM are LSMs.


Roberto


