Return-Path: <linux-integrity+bounces-6340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4CAAC81C8
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68097A4120A
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9173230277;
	Thu, 29 May 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=welho.tech header.i=@welho.tech header.b="Z5O74jSs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66E22F772
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540729; cv=none; b=mhWuZpnkxW158mgRNC2PKDUX4FzrBXuIlXhByJYaMm3Sl+Ma8nVx1HW71pXv99kze1zhbSEfkZs3VQEDZvJGS7EBf8fl/qU2CDh5xlX/80i92H2EaTGRsyZ5wN2xNGP3I5sf1ZGj4yFG1lRfLYiWc20W9GQaLgbjvrMZ2baTrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540729; c=relaxed/simple;
	bh=+xabQibrftJkVUwZN7dmngN81xgMxDTrpiypIR+Bleg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GJGBL8AW5uYrbtddTAWu19BFbCZFHnMUvvdIMhKhW/Qmj8mS+qVo8xDObLiQQhslOHD+JS0qtR1cLaiEp1qmIbwFOYmrw98+95HS8KtbJah/GHaWU1/xhF+yjAy8xaBNbQzFSDs/tK3qVO+l1j+0JDNmjfquLT7oZFMM8xchMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=welho.tech; spf=pass smtp.mailfrom=welho.tech; dkim=pass (2048-bit key) header.d=welho.tech header.i=@welho.tech header.b=Z5O74jSs; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=welho.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=welho.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=welho.tech;
	s=protonmail2; t=1748540719; x=1748799919;
	bh=8gzq8wYrUWwUGXftu5OuGK0/Efmw6ikuz+/C0p0BuvQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Z5O74jSs80lfy0YVkKk9CCLGp2po24Y4czyXtsLRWAsYgCK5EKCVejsv/qTmbmz5H
	 LDgyjPbJhfzhf9PoJ21UGqtqGsk34kP1JVDK+jb0xicjHlc+tm5E604nntR/dageeg
	 LpdbUfrOMrNaEQLhHfnZrACG/ERi+G/J5OQOUFsjb8eypgxN6mGqGUft6vz6f3LR33
	 ojPLA6wfC8g2NnB+1/VZBj6M0AbYGFcFYmo4wGaspZppIsOU8DLyiPC7NBKU0sUxO3
	 x6wRNzewkM01MWJYlvhrKYnUDvvmXRTOl13NHL4dzWNU0I5y3BLm5b0HeSR2OX1/al
	 aa93IdNCv5NpA==
Date: Thu, 29 May 2025 17:45:12 +0000
To: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Dennis Marttinen <twelho@welho.tech>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Dennis Marttinen <twelho@welho.tech>
Subject: [PATCH] fs/ceph: set superblock s_magic for IMA fsmagic matching: up to 60x speedup
Message-ID: <20250529174453.293618-1-twelho@welho.tech>
Feedback-ID: 63214926:user:proton
X-Pm-Message-ID: 294c9fb9a57bf9a61f0c822a773aa432f7737b89
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The CephFS kernel driver forgets to set the filesystem magic signature in
its superblock. As a result, IMA policy rules based on fsmagic matching do
not apply as intended. This causes a major performance regression in Talos
Linux [1] when mounting CephFS volumes, such as when deploying Rook Ceph
[2]. Talos Linux ships a hardened kernel with the following IMA policy
(irrelevant lines omitted):

# cat /sys/kernel/security/integrity/ima/policy
[...]
dont_measure fsmagic=3D0xc36400 # CEPH_SUPER_MAGIC
[...]
measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
[...]

Currently, IMA compares 0xc36400 =3D=3D 0x0 for CephFS files, resulting in =
all
files opened with O_RDONLY or O_RDWR getting measured with SHA512 on every
open(2):

# cat /data/cephfs/test-file
# tail -1 /sys/kernel/security/integrity/ima/ascii_runtime_measurements
10 69990c87e8af323d47e2d6ae4... ima-ng sha512:<hash> /data/cephfs/test-file

Since O_WRONLY is rare, this results in an order of magnitude lower
performance than expected for practically all file operations. Properly
setting CEPH_SUPER_MAGIC in the CephFS superblock resolves the regression.

Tests performed on a 3x replicated Ceph v19.3.0 cluster across three
i5-7200U nodes each equipped with one Micron 7400 MAX M.2 disk (BlueStore)
and Gigabit ethernet, on Talos Linux v1.10.2:

FS-Mark 3.3
Test: 500 Files, Empty
Files/s > Higher Is Better
6.12.27-talos . 16.6  |=3D=3D=3D=3D
+twelho patch . 208.4 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FS-Mark 3.3
Test: 500 Files, 1KB Size
Files/s > Higher Is Better
6.12.27-talos . 15.6  |=3D=3D=3D=3D=3D=3D=3D
+twelho patch . 118.6 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FS-Mark 3.3
Test: 500 Files, 32 Sub Dirs, 1MB Size
Files/s > Higher Is Better
6.12.27-talos . 12.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+twelho patch . 44.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

IO500 [3] 2fcd6d6 results (benchmarks within variance omitted):

| IO500 benchmark   | 6.12.27-talos  | +twelho patch  | Speedup   |
|-------------------|----------------|----------------|-----------|
| mdtest-easy-write | 0.018524 kIOPS | 1.135027 kIOPS | 6027.33 % |
| mdtest-hard-write | 0.018498 kIOPS | 0.973312 kIOPS | 5161.71 % |
| ior-easy-read     | 0.064727 GiB/s | 0.155324 GiB/s | 139.97 %  |
| mdtest-hard-read  | 0.018246 kIOPS | 0.780800 kIOPS | 4179.29 % |

This applies outside of synthetic benchmarks as well, for example, the time
to rsync a 55 MiB directory with ~12k of mostly small files drops from an
unusable 10m5s to a reasonable 26s (23x the throughput).

[1]: https://www.talos.dev/
[2]: https://www.talos.dev/v1.10/kubernetes-guides/configuration/ceph-with-=
rook/
[3]: https://github.com/IO500/io500

Signed-off-by: Dennis Marttinen <twelho@welho.tech>
---
It took me a year to hunt this down: profiling distributed filesystems is
non-trivial. Since the regression is associated with IMA use, I received a
hint to CC the folks associated with IMA code. The patch targets the 6.12
kernel series currently used by Talos Linux, but should apply on top of
master as well. Please note that this is an independent contribution -
I am not affiliated with any company or organization.

 fs/ceph/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 73f321b52895e..9549f97233a9e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1217,6 +1217,7 @@ static int ceph_set_super(struct super_block *s, stru=
ct fs_context *fc)
 =09s->s_time_min =3D 0;
 =09s->s_time_max =3D U32_MAX;
 =09s->s_flags |=3D SB_NODIRATIME | SB_NOATIME;
+=09s->s_magic =3D CEPH_SUPER_MAGIC;
=20
 =09ceph_fscrypt_set_ops(s);
=20

base-commit: adc218676eef25575469234709c2d87185ca223a
--=20
2.49.0


