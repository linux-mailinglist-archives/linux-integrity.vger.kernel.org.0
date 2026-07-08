Return-Path: <linux-integrity+bounces-9899-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYaKJwGWTWo42gEAu9opvQ
	(envelope-from <linux-integrity+bounces-9899-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 02:12:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E7720944
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 02:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PUVlOCJr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9899-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9899-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B63303B4E5
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2026 00:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3539FD9;
	Wed,  8 Jul 2026 00:10:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DECA5A
	for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2026 00:10:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469403; cv=none; b=FwpWQ2xPNrrfQIvOKoXWGiDlo5xoHocC50I3CZM1cophySNHitbY+oZbrwUzCLdSG775lZsIobPuOgSBgnfS31edNPo8ZFmqM7evw3xnii02v5aOD7149d8j3UFYUuv4x5zwkhGhD35EuoyuKNceJKIvDz174td72mtlBTUSP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469403; c=relaxed/simple;
	bh=c58fnOiwEsN7lUj0DmXeQk2wWyvK7VT5Pt/ChD76cJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJLHpq2BJ2M9szy+/iJca5gWCEGrfxB41BuBT/mGk82tKd2QASIquZvMyOSeTQlZ04TfcmI0WMbbxlD8HJYZk+M61sXFMTlIJsNv4RtfpsP5w6bgCKhDWFoWFmfkUGKRKVKvB/NL1Bx2ukf8EpAuiU7PvExPJiKu7fLF4ugsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUVlOCJr; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9204711e831so4901585a.2
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469400; x=1784074200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=PUVlOCJrUkLuEsI+OMjFuJKsGa+l4JaMsu7vrh3aCQKgwbb6G2N1kmia8DPz4HVdQW
         CgRC71bA4obYOXHAljFXW1RsJygheVmQXgOH8GfoeQiCjiYwPH++jG1H2rhl4xkmgVq/
         AeLgvgRCUMyjM1il7xFIyGlUUkZJjllO41FTEEb3q9IebTucD21lXmIUojFRckwKQoiA
         QWDWqRcdEh9x8qJb+Qe5JJf8RXJSPMqJSEhj1tPFT0DYuT/RbEAeTxiMfhzIhZ0Cqb9K
         6x2A6ikZZnJTYl8pqUs+JsE5QVVWuhRDYn4D6WoQay6FzWEiKoKJE/Xx8sI/9Xu/jRCN
         2FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469400; x=1784074200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=dRo3PoOwAcuM+Kczxwd7ZBqh4PgAsTqH7G7+OmEqKTg041CFqFIXoQAqVbjwyD1lTc
         a884vW4FHJoEI+iL1BOjQCNMZXXC201HLDmbh91UT5FZGEJR97n6y1FtHUldechdL6w9
         j9UZszZNiHQnzTVEJOo0T43Ihu7mOyfRZ7yQj+3PzGernZktR7/P1+eOFIDtnTsiXk09
         W1jXs+uVLUTf2YWywV22f5oiTSpN6GnoaBxx+Ke5T2ejXHiRX7NV1yGcSqJ2KozRFrIl
         RropbGMn4V7B3fGuoGLchFZEN8MEYM1bMxgnN/o0yCrJgBICiHS/Nui6yBfR3Yoo8xgf
         p9mg==
X-Forwarded-Encrypted: i=1; AHgh+RrQhWnwjkCYSpb2jNnn2/aDF6n/AauLFKDPGUrrId+Em7pD/zrWzeSZIWtarGUg50b665197ctY45gAWtQ/gIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3PjpQNg4kerac+xtMYYCYx4RCk8a0Do4TA92C7Qp2ghq/5RZ
	8oz8pSJsECJHfB7F+xZRlvC0JIFq3LAZNIVpyJxhASpUg0z+uGzpzDKz
X-Gm-Gg: AfdE7clSPXmPU6WjyOiaOBbxdZv6jod5DpRtAe300+Xl8IdWw03I/JmPJbuUUAZrIYP
	X9i7jBz337/5DZpTCsRkORChsc7imNMEoUqhSTCrMzCGvD3oC1p0aC49cwfBT7gfuWUbikqV/2z
	l2yZviXfynsclitx1x+zRmX1XsBrfdkXuc9iZ20PIOs0P/DdK/O4PuwNG8TFts6i4SPvq9pmi+/
	llTiS1ce35t/pQyJLtYiGSlkw/794pnvtg4sIZy5J9Ft+kEyOLJxxrmFKnoevJMWmtOu8+Vtyw7
	zQtV1cjhTun1uSYQnTzkD1UaPImzh1TXGX1Hrep0jxefQdrHTjnrn7XCeQoUVMgmRXRu1lR2eDG
	SkZRwA7k4gRONrqDftQ86y8N4oz7NlFrjyWnZQgjk+vNMuBRSzDW83XALdr6aeVQNWFbzqIn51O
	vJqrT9HezL7QCNXX69GxOoX+Qhf55f1tu3/g2wd+r6xqwSD+xhNa2KVSmNVt/fHu8xHYC1dMO3A
	CQ9StEQ03kTXP0=
X-Received: by 2002:a05:620a:2b4d:b0:920:6061:816e with SMTP id af79cd13be357-92ecf629324mr5879185a.7.1783469400172;
        Tue, 07 Jul 2026 17:10:00 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:09:59 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue,  7 Jul 2026 20:09:53 -0400
Message-ID: <20260708000956.46138-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9899-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwindsor@gmail.com,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 043E7720944

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument and claims a
slot in it via the new security_lsmxattr_add() LSM helper.

v5:
  - make the kfunc non-sleepable to avoid an ext4 deadlock (sashiko)
  - move xattr creation logic to security_lsmxattr_add() (Paul)
  - use distinct xattr names in init_inode_xattr_slot_limit

v4:
  - introduce struct lsm_xattrs in separate patch (Alexei, Paul)
  - rename struct xattr_ctx to struct lsm_xattrs (Paul)
  - make lsm_xattrs.xattr_count unsigned int (Paul)
  - drop new_xattrs/xattr_count locals in
    security_inode_init_security() (Paul)
  - fold __bpf_init_inode_xattr() into bpf_init_inode_xattr() (Paul)
  - drop bpf_fs_kfuncs_filter() attach-point check; rely on verifier
    type enforcement (Alexei)
  - drop attach-time cap; enforce slot budget in the kfunc (Alexei)
  - allocate the combined xattr with GFP_NOFS (sashiko-bot)
  - replace init_inode_xattr_attach_cap selftest with runtime
    init_inode_xattr_slot_limit

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

David Windsor (3):
  security: rework inode_init_security xattr handling
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  36 +++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +--
 include/linux/security.h                      |  15 +++
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           | 108 +++++++++++++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 124 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 14 files changed, 344 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 602701718649936eb287bf6c7ecf870ec54c6f71
-- 
2.53.0


