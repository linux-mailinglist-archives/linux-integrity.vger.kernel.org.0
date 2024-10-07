Return-Path: <linux-integrity+bounces-3738-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6D9931F2
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3307F282089
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DC1D9597;
	Mon,  7 Oct 2024 15:48:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A31D4344;
	Mon,  7 Oct 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316082; cv=none; b=pTkhIWs/MdQx6OQi2poEpztX+OYDFB289QPZOPrAF8fhvTV8C7Ozn/2EouP5gZ/rY0iigu+5ydcTw/dBHF9jBI3Tu8y4N/POsPDH/FBi1XfTd3oNulNrA81qRC0noXK4UlSoDghwffiEi6Z/om+MGGHjHL/Z/4LnuU9dZYUforM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316082; c=relaxed/simple;
	bh=QbIFB83CPWNA2xWgzSI925rkM1meSV5IgKMJZZ1tlu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/wNmW6gFZXr9jE/+PXyKYSzO1tbeK1+8p44sRU5kwQ1MSLbQUKu26CnXaLiFhU/ua1GKWH3apJrWmW2qXltZigzypCImpg+bYM5WxlmBjHuggkCuxasOXjL0e6Pgnf83/mfOktciDOcGntWKLSGK6Z5hCpmMkVqDn1l+IFFYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XMjL42fBsz9v7JS;
	Mon,  7 Oct 2024 23:11:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 52010140360;
	Mon,  7 Oct 2024 23:31:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHt8fb_gNno7hpAg--.56876S2;
	Mon, 07 Oct 2024 16:31:49 +0100 (CET)
Message-ID: <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Shu Han <ebpqwerty472123@gmail.com>
Cc: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
 akpm@linux-foundation.org, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  hughd@google.com, jmorris@namei.org,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com,  serge@hallyn.com,
 stephen.smalley.work@gmail.com,  syzkaller-bugs@googlegroups.com,
 zohar@linux.ibm.com
Date: Mon, 07 Oct 2024 17:31:35 +0200
In-Reply-To: <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
	 <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
	 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAHt8fb_gNno7hpAg--.56876S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4DAF15ZF47Xw1DAr1fJFb_yoW5Wr45pF
	9agayxCr4ktFy7Ar92yr1jg3W0k34jkrWUCrZ5Jr18J3Z0vF1vqr13Jr1furyUGrZ5uw1S
	qr4DCr93A3WqyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGcDQ-4NXwABsF

On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmail.co=
m> wrote:
> >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > WARNING: possible circular locking dependency detected
> > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > ------------------------------------------------------
> > > syz-executor369/5231 is trying to acquire lock:
> > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode=
_lock include/linux/fs.h:815 [inline]
> > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: proce=
ss_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > >=20
> > > but task is already holding lock:
> > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_ki=
llable include/linux/mmap_lock.h:122 [inline]
> > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_fil=
e_pages mm/mmap.c:1649 [inline]
> > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_fil=
e_pages+0x22d/0xa50 mm/mmap.c:1624
> > >=20
> > > which lock already depends on the new lock.
> >=20
> > This issue (if not a false positive?) is due to the possible `prot`
> > change caused by the processing logic for READ_IMPLIES_EXEC in do_mmap(=
),
> > so the remap_file_pages() must perform LSM check before calling do_mmap=
(),
> > this is what the previous commit want to do.
>=20
> My apologies for the delay on this, I was traveling for a bit and
> missed this issue while away.
>=20
> Looking quickly at the report, I don't believe this is a false positive.
>=20
> > The LSM check is required to know what the `prot` is, but `prot` must b=
e
> > obtained after holding the `mmap_write_lock`.
> >=20
> > If the `mmap_write_lock` is released after getting the `prot` and befor=
e
> > the LSM call in remap_file_pages(), it may cause TOCTOU.
>=20
> Looking at the IMA code, specifically the process_measurement()
> function which is called from the security_mmap_file() LSM hook, I'm
> not sure why there is the inode_lock() protected region.  Mimi?
> Roberto?  My best guess is that locking the inode may have been
> necessary before we moved the IMA inode state into the inode's LSM
> security blob, but I'm not certain.
>=20
> Mimi and Roberto, can we safely remove the inode locking in
> process_measurement()?

I discussed a bit with Mimi. Her concern was the duplicate iint
structure creation during concurrent file accesses. Now that inode
integrity metadata have been moved to the inode security blob, we can
take the iint->mutex out of the ima_iint_cache structure, and store it
directly in the security blob. In this way, we can remove the inode
lock.

Will write a patch and see if it passes our tests.

Roberto


