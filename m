Return-Path: <linux-integrity+bounces-2338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD208BCE05
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2024 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039711F2385E
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2024 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D31DA5F;
	Mon,  6 May 2024 12:34:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162281DA58;
	Mon,  6 May 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998870; cv=none; b=ikSxHvDc0BfEsKEvK13Qz4PGi2mAXARLAxPL2paHtB40zTxxFUqmYKyjaZY/Ww07Ka+lwWQfmfIIzQU23w/NEINS4FwWO2nV1hJ/K6OGAvOOrtyIVhhRUS7fKF6RMk53P/n3Kx3u9P7HRUKRy/NuRbT7G+T5MfuLQJntlBh2/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998870; c=relaxed/simple;
	bh=B98TXEFSbhOQ1H3pUCnsrzCSALIGq+HzyitCBr1f82Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adAqCB6lH15/QvmuPhK+9GwqvQty/2jqQqtTlEaqL6QJzV2+zWuZJ8J2IE6/mP86OgEHmT2L/iCbrSBkhXvdBG4JMs81BV9o69rbT8daXKVgAgwAr5zyNhuPF6HPyW7cgSKZBYVMMrb25WDzM9xUdsSy4JVB9dKqwU73Qdh0PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VY0fb2rH8z9xGXR;
	Mon,  6 May 2024 20:12:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 892BC1404A6;
	Mon,  6 May 2024 20:34:19 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBH8Rk_zjhm+GelBw--.19992S2;
	Mon, 06 May 2024 13:34:18 +0100 (CET)
Message-ID: <15d129d8e601a98d5b447da6a6032c8f984d2638.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations
 on stacked filesystems
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zohar@linux.ibm.com,  roberto.sassu@huawei.com, miklos@szeredi.hu,
 brauner@kernel.org, Vivek Goyal <vgoyal@redhat.com>
Date: Mon, 06 May 2024 14:34:03 +0200
In-Reply-To: <CAOQ4uxjd3e2M4_dF4_jVhghMCmtuZT01hWCMeiuA_=1HFfrS1w@mail.gmail.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
	 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
	 <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
	 <CAOQ4uxjODtbaWPHS3bQvnEKuYAWTJa6kqsXCSzcsF1hJdThcsw@mail.gmail.com>
	 <2b28414a7c7e4c53057ef8e527f85c05eb225d85.camel@huaweicloud.com>
	 <CAOQ4uxjd3e2M4_dF4_jVhghMCmtuZT01hWCMeiuA_=1HFfrS1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBH8Rk_zjhm+GelBw--.19992S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyDtF4DGrW3CF1rXw4Utwb_yoWDGryxpF
	W3Za12kw1DJF17Ar1IyF18XF1Fy3yrJFWUX34Fgry5Aa4qqrn3trWrJr1Y9F9rArn5Jw4j
	qayUtrZxZr1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5kMxAACsr

On Sat, 2024-04-27 at 12:03 +0300, Amir Goldstein wrote:
> On Fri, Apr 26, 2024 at 10:34=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > On Thu, 2024-04-25 at 15:37 +0300, Amir Goldstein wrote:
> > > > On Thu, Apr 25, 2024 at 2:30=E2=80=AFPM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > >=20
> > > > > > On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > > > > > > > On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stef=
anb@linux.ibm.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > This series fixes the detection of read/write violation=
s on stacked
> > > > > > > > > > filesystems. To be able to access the relevant dentries=
 necessary to
> > > > > > > > > > detect files opened for writing on a stacked filesystem=
 a new d_real_type
> > > > > > > > > > D_REAL_FILEDATA is introduced that allows callers to ac=
cess all relevant
> > > > > > > > > > files involved in a stacked filesystem while traversing=
 the layers.
> > > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Stefan,
> > > > > > > >=20
> > > > > > > > Both Miklos and myself objected to this solution:
> > > > > > > > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcA=
sJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> > > > > > > >=20
> > > > > > > > Not sure what you are hoping to achieve from re-posting the=
 same solution.
> > > > > > > >=20
> > > > > > > > I stopped counting how many times I already argued that *al=
l* IMA/EVM
> > > > > > > > assertions,
> > > > > > > > including rw-ro violations should be enforced only on the r=
eal inode.
> > > > > > > > I know this does not work - so you should find out why it d=
oes not work and fix
> > > > > > > > the problem.
> > > > > > > >=20
> > > > > > > > Enforcing IMA/EVM on the overlayfs inode layer is just the =
wrong way IMO.
> > > > > > > > Not once have I heard an argument from IMA/EVM developers w=
hy it is really
> > > > > > > > needed to enforce IMA/EVM on the overlayfs inode layer and =
not on the
> > > > > > > > real inode.
> > > > > >=20
> > > > > > Ok, I try to provide an example regarding this, and we see if i=
t makes
> > > > > > sense.
> > > > > >=20
> > > > > > # echo test > test-file
> > > > > > # chown 2000 d/test-file
> > > > > > # ls -l a/test-file
> > > > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > > > >=20
> > > > > > Initially there is a file in the lower layer with UID 2000.
> > > > > >=20
> > > > > >=20
> > > > > > # mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc,meta=
copy=3Don overlay d
> > > > > > # chown 3000 d/test-file
> > > > > > # ls -l d/test-file
> > > > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 d/test-file
> > > > > > # ls -l a/test-file
> > > > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > > > > # ls -l b/test-file
> > > > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 b/test-file
> > > > > >=20
> > > > > > If I have a policy like this:
> > > > > >=20
> > > > > > # echo "measure fsname=3Doverlay fowner=3D3000" > /sys/kernel/s=
ecurity/ima/policy
> > > > > >=20
> > > > > > there won't be any match on the real file which still has UID 2=
000. But
> > > > > > what is observable by the processes through overlayfs is UID 30=
00.
> > > > > >=20
> > > >=20
> > > > ok, it is simple to write an ima policy that is not respected by ov=
erlayfs.
> > > >=20
> > > > My question is: under what circumstances is a policy like the above
> > > > useful in the real world?
> > > >=20
> > > > Correct me if I am wrong, but AFAIK, the purpose of IMA/EVM is to
> > > > mitigate attack vectors of tampering with files offline or after th=
e
> > > > file's data/metadata were measured. Is that a correct description?
> >=20
> > (For now I would talk about IMA, EVM can be considered separately).
> >=20
> > The main purpose of IMA is to evaluate files being accessed, and record
> > the access together with a file digest in a measurement list,
> > allow/deny access to the file (appraisal), or add a new event to audit
> > logs.
> >=20
> > How files are selected depends on the IMA policy. A rule can be
> > subject-based or object-based, depending on whether respectively
> > process or file attributes are matched. It can also be both.
> >=20
> > A subject-based rule means that you identify a process/set of
> > processes, and you evaluate everything it/they read.
> >=20
> > An object-based rule means that you identify a file/set of files, and
> > you evaluate any process accessing them.
> >=20
> > Since processes normally would access the top most layer (overlayfs),
> > the IMA policy should be written in terms of metadata seen in that
> > layer (but not necessarily).
> >=20
> > This is just for identifying the set of files to
> > measure/appraise/audit, not which file is going to be evaluated, which
> > will be always the persistent one.
> >=20
> > I have to admit, things are not very clear also to me.
> >=20
> > Suppose you have a file in the lower filesystem with SELinux label
> > user_t, and then on overlayfs with metadata copy, you change the label
> > of this file to unconfined_t.
> >=20
> > What will happen exactly? On the overlayfs layer, you will have a
> > permission request with the new label unconfined_t, but when overlayfs
> > calls vfs_open(), there will be another permission request with the old
> > label.
>=20
> CC Vivek who was involved with ovl+selinux, but I think the answer is
> that ovl sepolicy is expected to be associated with the mount ctx and
> not the objects and there was a need to implement the security hook
> security_inode_copy_up() to be able to compose a safe sepolicy for
> overlayfs.
>=20
> >=20
> > It is kind of the same challenge we are facing with IMA, we can observe
> > the file operations at different layers. That is why I think having
> > stacked IMA calls is a good idea (other than really fixing the
> > violations).
> >=20
> > The current problem, that is very difficult to solve, is that the
> > policy should cover all layers, or some events will be missed. Now we
> > have overlayfs-specific code to detect changes in the backing inode,
> > while with stacked IMA calls, we can detect the change at the layer
> > where it happened (and we can remove the overlayfs-specific code).
> >=20
> > Ideally, what I would do to cover all layers is that if there is a
> > match at one layer, the lower layers should automatically match too,
> > but it is not that easy since after the vfs_open() recursive calls we
> > start calling IMA in the botton most layer first.
> >=20
> > (What I did with the stacked IMA calls is just an experiment to see how
> > far we can go, but still we didn't make any decision with Mimi).
> >=20
> > > > AFAIK, IMA/EVM policy is system-wide and not namespace aware
> > > > so the policy has to be set on the container's host and not inside
> > > > containers. Is that correct?
> >=20
> > I know that overlayfs is primarily aiming at containers, but I would
> > suggest to not add that complexity yet and just consider the host.
> >=20
> > > > If those statements are true then please try to explain to me what =
is
> > > > the thread model for tampering with overlayfs files, without tamper=
ing
> > > > with the real upper and/or lower files.
> >=20
> > I hope at this point is clear that what we care about is that, or the
> > process is reading the content of the file whose digest is recorded in
> > the measurement list, or we must signal to remote verifiers concurrent
> > accesses that make the statement above false.
> >=20
> > > > My thesis is that if an IMA/EVM policy is good enough to prevent
> > > > tampering with the real lower/upper files, then no extra measures
> > > > are needed to protect the virtual overlayfs files against tampering=
.
> >=20
> > What you say is correct, but the way you identify files to
> > measure/appraise/audit can be different.
> >=20
>=20
> IIUC, the problem as you described it, is similar to the problem
> of how to display the overlayfs path of mmaped files in /proc/self/maps
> when the actual inode mapped to memory is the real inode.
>=20
> The solution for this problem was the somewhat awkward
> "file with fake path" - it was recently changed to use the new
> file_user_path() helper.
>=20
> I'm not sure how this can help IMA, but in theory, you could
> always attach iint state to the real inode and only the the real inode
> but the rules that filter by path/object in the IMA hooks that take a fil=
e
> argument could take file_user_path() into account.

Sorry, it took some time to elaborate this proposal, but I think it is
mostly correct. I even tried it (as an experiment, we didn't make any
decision yet).

So, the basic idea is to use the stacked IMA calls I proposed (by
adding security_file_post_open() in backing-file.c, and evaluate each
layer independently.

The policy match on each IMA call will be on the overlayfs inode, so
that we see the same metadata as the process opening the file, but we
attach the state to the real inode (regardless of the layer).

Violations are going to work because there is no layer mismatch (write
on one layer, read on a different layer), they are checked always on
the real inode. Since overlayfs has to always open the real inode,
i_write/readcount will be always incremented.

If there is a match at one layer, IMA is not going to process the file
again, since the result is cached from the previous IMA call.

i_version comparison will also be on the real inode, no need to provide
one on overlayfs.

Invalidation (like by setting security.ima) will happen on the real
inode.

I went even further, to think that when we check the authenticity of
security.ima with EVM we can pass the real inode, but we are not sure
yet.

We will continue to validate this proposal.

Thanks

Roberto

> For example, if you have security_file_post_open(f) in
> backing_file_open(), then you can use d_real_inode()
> in process_measurement to get to the IMA state and check the
> rules referring to the real inode and you can use file_user_path(file)
> to check the rules referring to "front object".
>=20
> In case of a nested overlayfs, you should get two post_open
> hook, both will refer to the same IMA state on the real inode, but
> each hook with have a different file_user_path(), so you will have
> an opportunity to apply the path/object based rules on every layer
> in the nested overlayfs.
>=20
> I hope what I tried to explain is clear and I hope there are not
> many traps down this road, but you won't know unless you try...
>=20
> Thanks,
> Amir.


