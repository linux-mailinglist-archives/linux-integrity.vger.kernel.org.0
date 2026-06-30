Return-Path: <linux-integrity+bounces-9852-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8I9kDpcORGomnwoAu9opvQ
	(envelope-from <linux-integrity+bounces-9852-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:44:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B276E6E744D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aEQ12RMX;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9852-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9852-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB10A305F19F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F1413D82;
	Tue, 30 Jun 2026 18:40:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB33E121A
	for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 18:39:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844801; cv=none; b=ghhi9MSMQ3vgaeccKM/Hngt8WVwc5mC5LgDJCkpycftVJsAzhWb2KVSd0gNc4QDLfT2NvBTGBHHE4bquHu68nBLjtl7VO45xue0y6gBoNlRiUCCBWRx0oIr3nyu+5BzPRbsobEft/DHIGj9fTldsG2CW7RlqFzooJ8LFYpppp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844801; c=relaxed/simple;
	bh=S6k+uQwLsBLqS78QaiWexapMR9GFIKsV5VVSUcaj7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6ocSsowaqGUmLpkUWVGosM1PuL8hbxoDW4Nb9ViLTRI1IXd539OySq/41X+Yn1GNaHn3kcaBAUJ8JOJEaVD6wpyoGJQ9+RWi4H5E15wsdzpp80+Y8SKWqnXlFuWWBY8UZYcnnqIoGDdWPJCB3pvY97/LnSIIXHGk2MeUakkZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEQ12RMX; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f18d92172aso20465306d6.2
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844799; x=1783449599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmgV8nCn9sbfqM1ezwxzcVc9Q6Oo1QwQHw5Oa3kbYoo=;
        b=aEQ12RMXQ+9Hh3F8u82u1VGab0TICtc/2lK+zxraZIDrae+S3v/JtWuYFKJsnzbp3/
         rTUg5SEbJgZN6xVgrxhrVKZQj4Ogp9uPEb6JZvnnRtpuj2opyz5ULVe6H8+J/JnmjONs
         /WYbwijD17n+1B77a+eIL4kTFmd2LydZ0hs6TLYwYjcSWFi9k6XXwVYqknEioWyTkfrN
         eHEbtCkZwVBmFDjIQMKLNDQCFzVck68Uc0xuvcCFtwEObTvpvFRvOekTQswV6P+Ci4Tn
         l9mhkVkmpB1uIdKzzdMMpKAlmnCMKW0x9Rp/bjthR/8mOFihJiTVI5El7+6ALF3nDnb1
         5gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844799; x=1783449599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmgV8nCn9sbfqM1ezwxzcVc9Q6Oo1QwQHw5Oa3kbYoo=;
        b=cPXOYnI3/lET0Hx8Gqm8Lcs+AR/we77X03CxIOCVY/dlObcWW5WgBS7AkJU2g5hqkE
         rkFk8Krjp65M0qI9kz5Cgl5UNiHEvLffbdGjZCsIicUZe5isBbf7SasAXAj2n1UVImIH
         /9MD5bQr8rpgM8ZuitvxXIj0qJO9LD2/YtvPWl19Gp2BlbaJGvdQ2u2N55vD4cZmwmZJ
         hYs2Okq1FS97JnT7LajY5YKQfA1knX48FOQEP3PuyQMrx+pc2VMFEj1bYt/ZalHX3aFj
         RANqNCIqj4rltyeDqgnVaQh+0FPICSpa16+Jc99jaduSPQttLBfKwNVoRBJzX9SWee9B
         f9fA==
X-Forwarded-Encrypted: i=1; AFNElJ/3GkgtaJfwxzOX7MkC5LoRAt9yEQiZKr91Uc9MvA6ptYY49deFbHjE1bMGWHW84ed6gMhAReUgm2kfgHBJ4Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHelJFutG8qEATUCxPr9qvTsAdTvuxZ5WHjOw8F6CoHqA1foxU
	r/BzvYHsVe9fAKU+FCJzDVwEYfHgJp5N9M4o5EPBiFrEpi1N81gyK9wk
X-Gm-Gg: AfdE7cl1AKS7CUAblsAPYTyrf1n52xqxcMmYcErAvl7gqkFJvkfwttYbDTClizUg8Eu
	h5mzHkQfSlTOqPyiPbDb2mBOJyb64DXv+SQUoiRL7ZutK7HZClYZ1pf+Eyv/Cd7XDlt3lF/wZjD
	GzLGc2uM/EArOEg6y230UulRGgj2ZVRoR5HhUws0tkA/lpRXc8Uz4sK+cdf8EcUC90+a58Ma8Oh
	LO/umC2KfwAYzmGUzfbml5HjhmBt/Sb52wRQF78RxNHCTOrvpYK5vim/Tayvts5Vip4z1mv1LmD
	Ut66CpbI0/zpCxpuotlaViMmQcN3I697PRt6uYNw1MP/ilvh8aJZ4SDWh+cjnJ5X3q8JW67orNC
	ItZ+b7lxF2FHmCvI4fKhsm0jI5wbmNwufJD04L//HZewKqqoTx5E6M0ytX1fsFEsAs59bTviaL+
	VA2Gzz6HF5C3hWJbFH+VbUGbB24Xar4n0++LFqgmwj5OcsNH+Ehi/+KgVGGidEJ5OxXcuXxak5Z
	5tAixLbALhduR0=
X-Received: by 2002:a05:620a:7088:b0:92e:4773:5a05 with SMTP id af79cd13be357-92e624aa5a7mr812235885a.4.1782844798653;
        Tue, 30 Jun 2026 11:39:58 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62191b18sm326961285a.18.2026.06.30.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:39:58 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue, 30 Jun 2026 14:39:52 -0400
Message-ID: <20260630183956.281293-1-dwindsor@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9852-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B276E6E744D

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
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

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
  security: pass inode_init_security xattrs via struct lsm_xattrs
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  79 +++++++++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +--
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |   1 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |  24 ++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 129 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 15 files changed, 299 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0


