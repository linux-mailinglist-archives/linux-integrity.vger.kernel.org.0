Return-Path: <linux-integrity+bounces-6235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0ACAB8CD0
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2744F1BC51D6
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68A253939;
	Thu, 15 May 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jr+vQqo+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281472638
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327711; cv=none; b=lW4tS8vDBcEqxaPe+k4UyXIANXmqcQYu7cNNRY9dLtTdVSYfoYljuIKv6QDZ2JDE4+nA9+x2mZLOr0GyPXXhwteIzm8NjpHGvHZ8pvcbVgYKR+B/B85E7HrRWjuyEHhAXG3jqzJN9BT/ZhKk4pXBruRH0DNAGyES3yL3U6oDnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327711; c=relaxed/simple;
	bh=e7sLRz/Ngexj8R7WF81VpHeIb8mhEtxycl0RQ4IyKzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7I9pAS32q6+s2/PqXKBxs7IuJ2alBDEU2VtMfRJHDmKn0urmcZEoE4bnzlw+CMvvGWrUvI9WzJkB8kgr+UJpAsdlX0LaTTVdoBhSpT39zj6aFvtuk+Z6/B54pl6tvX5qSDrbSfTQCZPlko3e5jdOAEW3l8N0L+oSPsqHrKPIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jr+vQqo+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 May 2025 12:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747327705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANKimStGiUGQOc3uP+LxjVRcW73HM8BreHOddAxJSDk=;
	b=jr+vQqo+av+AC45bxpBf4MrrMGToarKcorsY0sn7xB2PvT6vHc4UZLRitpUGOMSQGorx6U
	fIukGjhLo673D8y6U9SZgEBxZ/GfQwg8C/pjKVGXOlAlkUE4hszD9YLbgRAuY7AT+oj0zz
	6++wmGp7XLvz3fNn3Tq9ZeY9mlBkmvo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: syzbot <syzbot+3f0b3970f154dfc95e6e@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com, linux-bcachefs@vger.kernel.org
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (3)
Message-ID: <er7lw7xo3qfu67sdjdghcurgar3q2iwcy6lr4jlunsmev5c4qq@b7mue2oh6ort>
References: <6824aea8.a00a0220.104b28.0011.GAE@google.com>
 <38c28bd4dc40b2e992c13a6fdba820a667861d8c.camel@huaweicloud.com>
 <rbab6axciiuomrann3uwvpks2zogx3xfntk7w4p2betq3morlf@5xnl5guhnaxj>
 <576e10238d83f725fbe23c4af63be6e83de9ce48.camel@huaweicloud.com>
 <l7xs6ea7takb5yvyvobxoce3mudbgen5d7s47onksm4ujpdkib@tvstwbdpvm4o>
 <2993afd1b2b1553a75d1016ec2d06b6fb8e78e57.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2993afd1b2b1553a75d1016ec2d06b6fb8e78e57.camel@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 15, 2025 at 06:39:48PM +0200, Roberto Sassu wrote:
> On Thu, 2025-05-15 at 12:37 -0400, Kent Overstreet wrote:
> > On Thu, May 15, 2025 at 04:30:09PM +0200, Roberto Sassu wrote:
> > > On Thu, 2025-05-15 at 10:18 -0400, Kent Overstreet wrote:
> > > > On Thu, May 15, 2025 at 04:06:02PM +0200, Roberto Sassu wrote:
> > > > > On Wed, 2025-05-14 at 07:54 -0700, syzbot wrote:
> > > > > > Hello,
> > > > > 
> > > > > + Kent, bcachefs mailing list
> > > > > 
> > > > > I have the feeling that this was recently fixed in one of the latest
> > > > > pull requests in bcachefs. I don't see it occurring anymore, and there
> > > > > are more commits after the one reported by syzbot.
> > > > 
> > > > I have no idea how any of the ima stuff works or even what it does, I'm
> > > > not even sure where I'd start...
> > > 
> > > Basically, I got a clue that bcachefs would be the cause from the
> > > bottom of the report:
> > > 
> > >  page_cache_sync_ra+0x108a/0x13e0 mm/readahead.c:621
> > >  filemap_get_pages+0xfb3/0x3a70 mm/filemap.c:2591
> > >  filemap_read+0x5c6/0x2190 mm/filemap.c:2702
> > >  bch2_read_iter+0x559/0x21c0 fs/bcachefs/fs-io-direct.c:221
> > >  __kernel_read+0x750/0xda0 fs/read_write.c:528
> > >  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
> > > 
> > > This means that IMA is reading a file and calculating a digest over it:
> > > 
> > >  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:498 [inline]
> > >  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
> > >  ima_calc_file_hash+0x240a/0x3fd0 security/integrity/ima/ima_crypto.c:568
> > >  ima_collect_measurement+0x45d/0xe60 security/integrity/ima/ima_api.c:293
> > >  process_measurement+0x2d1a/0x40e0 security/integrity/ima/ima_main.c:385
> > >  ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:613
> > > 
> > > syzbot is complaining that the data the digest was calculated from was
> > > not initialized (e.g. zeroed).
> > > 
> > > There is a reproducer, we would be probably able to do a bisection and
> > > find the commit that caused it (and maybe the one that fixed it).
> > 
> > Ok, that would be fixed by the - multiple - KMSAN fixes, most of those
> > were spurious but code was lacking annotations. Probably this one:
> > 
> > 9c3a2c9b471a bcachefs: Disable asm memcpys when kmsan enabled
> 
> Perfect, thanks a lot!
> 
> Will check it and mark this report as fixed.

Btw, since you mentioned syzbot reproducers, I have a tool for running
those locally, with a single command. It's one of the "tests" in ktest:

https://evilpiepirate.org/git/ktest.git/

With that, you can do

build-test-kernel run -IP ~/ktest/tests/syzbot-repro.ktest <syz id>

in your kernel tree, and it'll build a kernel, launch a vm, and run the
reproducer, all in a single command :)

