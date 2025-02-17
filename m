Return-Path: <linux-integrity+bounces-4838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47991A37F4B
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC27C1898F1C
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EA215197;
	Mon, 17 Feb 2025 09:59:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C12163B7
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786351; cv=none; b=COfj2c3jNNAAqgfvtxmwAf38rdV8CUkvNx2Kg+Fg0Y35ltmxs8YXlkIfzb4gzeBoBKFkEJ+a9pMYTtgxGFABgMfeN91H1ktd0xiXWVaapCCNl4xHryYNoLrDnqldK5+O1EjlS3wNPIt46lAwqFtJnGGXlkeFxJlRnYntssZhC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786351; c=relaxed/simple;
	bh=kyvrv2U17INe4b6lSkUpltwHcLKqxONKQtWDij4ttQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p29G106C+mTdJ+6SseuwLcrAc4LWVPaWc6ITPJ+33gJkO8hdro9p+M069sCAi4RH2D1ou6Y6zi36+KI7jJNTcU2CenQZb1y7FrN6bZH5cMSmaU87cPvUPOtBXQ5zSDVkpIY4Nelhzxk0A4Dl8FBVEQvZlMMDyAc0tX5uDT1kooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YxHbJ3WSpz9v7JB
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 17:36:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A8EA4140B31
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 17:58:48 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnXeBRCLNnCrGkAg--.53884S2;
	Mon, 17 Feb 2025 10:58:48 +0100 (CET)
Message-ID: <9c5936be68bfbc4930a8e02e2ed99616626db187.camel@huaweicloud.com>
Subject: Re: [robertosassu:evm-iint-ptr-v1-devel-v3] [evm]  e38e699a42:
 will-it-scale.per_process_ops 160.4% improvement
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Roberto Sassu
 <roberto.sassu@huawei.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-integrity@vger.kernel.org
Date: Mon, 17 Feb 2025 10:58:38 +0100
In-Reply-To: <33ac5nnu2mte56mrrm62fqsyqozdifll63wdohjp2ywcnizwrd@2besd5mxagjg>
References: <202502171412.ec2e5b88-lkp@intel.com>
	 <33ac5nnu2mte56mrrm62fqsyqozdifll63wdohjp2ywcnizwrd@2besd5mxagjg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnXeBRCLNnCrGkAg--.53884S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF45ur43XF1DZw4Utw45trb_yoW5AryDpF
	WrGw15Jrs8A3s8Cw12va1jgFyFk3y0qFWYqwnYgry8Cr90gFyktF40gw4Y9FyvkrZaga12
	qayYva4YyF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBGey39YBrgAAs3

On Mon, 2025-02-17 at 08:58 +0100, Mateusz Guzik wrote:
> On Mon, Feb 17, 2025 at 02:45:23PM +0800, kernel test robot wrote:
> > kernel test robot noticed a 160.4% improvement of will-it-scale.per_pro=
cess_ops on:
> >=20
> >=20
> > commit: e38e699a42b4db5daf7dac453759fdc8ba0dab31 ("evm: Move metadata i=
n the inode security blob to a pointer")
> > https://github.com/robertosassu/linux evm-iint-ptr-v1-devel-v3
> >=20
> >      24.57           +72.2       96.76        perf-profile.children.cyc=
les-pp.__fput
> >      24.63           +72.4       97.02        perf-profile.children.cyc=
les-pp.__x64_sys_close
> >      24.67           +72.5       97.17        perf-profile.children.cyc=
les-pp.__close
> >       0.00           +95.2       95.17        perf-profile.children.cyc=
les-pp.osq_lock
> >       0.00           +95.5       95.53        perf-profile.children.cyc=
les-pp.__mutex_lock
> >       0.00           +95.7       95.71        perf-profile.children.cyc=
les-pp.evm_file_release
> >       0.00           +95.9       95.87        perf-profile.children.cyc=
les-pp.security_file_release
> >      98.69           -98.7        0.00        perf-profile.self.cycles-=
pp.native_queued_spin_lock_slowpath
>=20
> Contrary to what's indicated in the report, this change is in fact a
> significant slowdown (or rather, will be when other problems get fixed).
>=20
> The open3 microbenchmark issues open + close in a loop on the same file.
>=20
> On the stock kernel the some of the problem is false-sharing within
> struct inode.
>=20
> The biggest bottleneck is lockref manipulation:
> - there is lockref acquire and release happening *twice* instead of just
>   once
> - the lockref facility is prone to degrading to operation under a
>   spinlock and staying there when microbenchmarked. you can see on the
>   profile this does happen here
>=20
> evm also used to pop up, which I patched away in 699ae6241920b0fa ("evm:
> stop avoidably reading i_writecount in evm_file_release")
>=20
> Your patch adds a mutex which adds 2 atomics to the fast path (so slows
> down single-threaded operation) and more importantly adds a
> serialization point for multithreaded operation.
>=20
> In this case the resulting contention helps decrease the loss of
> performance in lockref and that's how there is an apparent win.

Hi Mateusz

thanks for the explanation!

> I have a WIP patch to move dentries away from using lockref, which will
> in turn avoid the degradation. Should it land, the mutex added here will
> be the new bottleneck.
>=20
> It needs to be avoided by default. Do you *need* to test the condition
> in evm_file_release() with the lock held? Perhaps initial test can be
> done without and redone after acquiring it?

This patch was more an explorative work to see what challenges we
encounter to move away from embedding the structure in the inode
security blob, and just use a pointer.

Currently, there is no gain in switching, since the requested blob size
remains 40 bytes (due to adding the mutex).

Certainly it is possible to do a test without a mutex and then redoing
it. If the EVM_NEW_FILE flag is not set, we can avoid to take the lock.

Thanks

Roberto


