Return-Path: <linux-integrity+bounces-6237-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FFAB8D01
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 18:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857671BC0259
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FB0253F16;
	Thu, 15 May 2025 16:58:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239719D07E;
	Thu, 15 May 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328339; cv=none; b=t9NPouoxBnruAKBMSVLeNlE8ZzUrLBd4PKbWcPUGP/2wjbvw4DRkMRxtRrUr0Yao5kMV5hzT/9hvbklTVnehFSNiEUq8KY3iDCR+hNdnU4NKQ1196B5fxjuJBwl1n4qIelo1aO5yd6TQAf63i/gCFin1dcRWJUD/VwqfUt5D86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328339; c=relaxed/simple;
	bh=iAtQvWTdSGZneEP+K3adQdKa73rxxVoUasNSZAfZMFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlAhte4kDOGdmBg70RqVuff0mDvLUhTmzirVseXjodaKBPIsQdr8cDZ5+AzCdtzNHqHWeZEgOLhue+x8xqKpd7fLkkdB9E7BEoOFnoEPGNQRwoDsLchmnSe2DmkIx95fMxww9+YYoo3euk4YjRNucd1uqehv4kpQQrYLT85ir9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZywsR1kfBz1HCN7;
	Fri, 16 May 2025 00:39:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5796F1402E0;
	Fri, 16 May 2025 00:40:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3_kzYGCZoyALvBw--.63654S2;
	Thu, 15 May 2025 17:40:01 +0100 (CET)
Message-ID: <2993afd1b2b1553a75d1016ec2d06b6fb8e78e57.camel@huaweicloud.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, paul@paul-moore.com, 
 roberto.sassu@huawei.com, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com,  zohar@linux.ibm.com,
 linux-bcachefs@vger.kernel.org
Date: Thu, 15 May 2025 18:39:48 +0200
In-Reply-To: <l7xs6ea7takb5yvyvobxoce3mudbgen5d7s47onksm4ujpdkib@tvstwbdpvm4o>
References: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
	 <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
	 <rbab6axciiuomrann3uwvpks2zogx3xfntk7w4p2betq3morlf@5xnl5guhnaxj>
	 <576e10238d83f725fbe23c4af63be6e83de9ce48.camel@huaweicloud.com>
	 <l7xs6ea7takb5yvyvobxoce3mudbgen5d7s47onksm4ujpdkib@tvstwbdpvm4o>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3_kzYGCZoyALvBw--.63654S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DKF45tw1kuw13WF4xXrb_yoW8tFW3pa
	42gF1UK3yvgFy7CrW2y3WYyFyFkrW8ta43W3yrXr92kF98XFn09FySkr4YgrnxWr1Fyw12
	kr1vq343A3WDtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGglkmQHswAAsD

On Thu, 2025-05-15 at 12:37 -0400, Kent Overstreet wrote:
> On Thu, May 15, 2025 at 04:30:09PM +0200, Roberto Sassu wrote:
> > On Thu, 2025-05-15 at 10:18 -0400, Kent Overstreet wrote:
> > > On Thu, May 15, 2025 at 04:06:02PM +0200, Roberto Sassu wrote:
> > > > On Wed, 2025-05-14 at 07:54 -0700, syzbot wrote:
> > > > > Hello,
> > > >=20
> > > > + Kent, bcachefs mailing list
> > > >=20
> > > > I have the feeling that this was recently fixed in one of the lates=
t
> > > > pull requests in bcachefs. I don't see it occurring anymore, and th=
ere
> > > > are more commits after the one reported by syzbot.
> > >=20
> > > I have no idea how any of the ima stuff works or even what it does, I=
'm
> > > not even sure where I'd start...
> >=20
> > Basically, I got a clue that bcachefs would be the cause from the
> > bottom of the report:
> >=20
> >  page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
> >  filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
> >  filemap_read+0x5c6/0x2190 mm/filemap.c:2702
> >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> >=20
> > This means that IMA is reading a file and calculating a digest over it:
> >=20
> >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline=
]
> >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> >  ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:5=
68
> >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:2=
93
> >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:38=
5
> >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> >=20
> > syzbot is complaining that the data the digest was calculated from was
> > not initialized (e.g. zeroed).
> >=20
> > There is a reproducer, we would be probably able to do a bisection and
> > find the commit that caused it (and maybe the one that fixed it).
>=20
> Ok, that would be fixed by the - multiple - KMSAN fixes, most of those
> were spurious but code was lacking annotations. Probably this one:
>=20
> 9c3a2c9b471a bcachefs: Disable asm memcpys when kmsan enabled

Perfect, thanks a lot!

Will check it and mark this report as fixed.

Roberto


