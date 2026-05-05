Return-Path: <linux-integrity+bounces-9424-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNe6ITaz+Wly/QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9424-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:07:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BBB4C9266
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E8D43016CE0
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545803F167B;
	Tue,  5 May 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LMrZa8UP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596D3D3308;
	Tue,  5 May 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971936; cv=none; b=QerRRHvlAOyxlpi+A04ESj2K9SjHea3jOnf4H0lN2uWfK2ZAUtXFxWiSEArKNdnqOVeQcc+iMPKjcLkx2/9wiFr0Xv4ic7VQj7MespKSHKXalVis0UlEcfFhnSFy4xwfYNmlyDoqXF3TuDExxiYNxecK8tucPaKwIvQAUfopyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971936; c=relaxed/simple;
	bh=3+TfV+G2pdtyPon4UoiayN0MzOd9dLRawRkDkEmqgQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BPCKfLAz+esc+DZhlojQI78MlT6Sv28hNfnxBrCS01R8GRtjLx9qEsFULPIQJt5mQjYMVVtXVT30rrdl6JbjS7hFtjdp+X6wLpePDU5Q6RXR0noFjAi09/BGcn7hog8RbC2aS1LxE07BLVLfZh1I+eSVqMWHVg3UdzVpUvoX80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LMrZa8UP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971922;
	bh=3+TfV+G2pdtyPon4UoiayN0MzOd9dLRawRkDkEmqgQk=;
	h=From:Subject:Date:To:Cc:From;
	b=LMrZa8UPBgDJoGIsTna8H4ZvARP53soQigqMBW1IArgIR1gf6B9u0afV70UvF1Uin
	 jY7hg4rJog4rDzYGOXybUL/fOAPQdxnme7eKMB1xSTM2jyWQ7Rglh8OxRK5megVbEz
	 wRQOU4R0TgMW8eukf1MmwueT3G6MQvi+aspNjLe8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Date: Tue, 05 May 2026 11:05:04 +0200
Message-Id: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMy2rDMBCF4VcJWldlZiRFUVZ5j9KFLuNIkNrBS
 tyW4HevHAgFN13+B853E5XHwlXsNzcx8lRqGfoW5mUjYvb9kWVJrQUBaSQy8mNI1xPL7GvmKq0
 34G2M5BWI9jmP3JWvu/f23jqXehnG7zs/4bL+J00oQSaLENl61SU8fHKptcZ8za89X8TCTfQgD
 CDBmqBGBI+400w22O4poX4JTW5NqEYAsCOzS9w5fkroB7EFRLUm9EIEpygFF8w2/CHmef4BycC
 Oj3gBAAA=
X-Change-ID: 20241225-module-hashes-7a50a7cc2a30
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 debian-kernel@lists.debian.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=7338;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3+TfV+G2pdtyPon4UoiayN0MzOd9dLRawRkDkEmqgQk=;
 b=B5jNaK8nrebPKZ5DQeOkk+hpzui5ffCiBEg6BGEicy81yoV1XDItYSp0mFpver92Pe1Oxtti+
 zOglNe9yqCQDsVc1y3PKkLJ8f0E9od2X+pmDKCsBbWMM9LZJWIQtHXw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 25BBB4C9266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9424-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,gmail.com,linutronix.de,lists.ozlabs.org,lists.debian.org,weissschuh.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds. Either the module signing key
is generated at build time, which makes the build unreproducible, or a
static signing key is used, which precludes rebuilds by third parties
and makes the whole build and packaging process much more complicated.

The goal is to reach bit-for-bit reproducibility. Excluding certain
parts of the build output from the reproducibility analysis would be
error-prone and force each downstream consumer to introduce new tooling.

Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a merkle tree root of all modules built as part of the full
kernel build into vmlinux.

Interest has been proclaimed by Arch Linux, Debian, Proxmox, SUSE, NixOS
and the general reproducible builds community.

Compatibility with IMA modsig is not provided yet. It is still unclear
to me if it should be hooked up transparently without any changes to the
policy or it should require new policy options.

BPF/BTF folks, please take a look at patch 1.

Further improvements:
* Use MODULE_SIG_HASH for configuration
* UAPI for discovery?

To: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
To: Sami Tolvanen <samitolvanen@google.com>
To: Daniel Gomez <da.gomez@samsung.com>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: Serge E. Hallyn <serge@hallyn.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Naveen N Rao <naveen@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
To: Nicolas Schier <nicolas.schier@linux.dev>
To: Daniel Gomez <da.gomez@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Cc: Arnout Engelen <arnout@bzzt.net>
Cc: Mattia Rizzolo <mattia@mapreri.org>
Cc: kpcyrd <kpcyrd@archlinux.org>
Cc: Christian Heusel <christian@heusel.eu>
Cc: Câju Mihai-Drosi <mcaju95@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-integrity@vger.kernel.org
Cc: debian-kernel@lists.debian.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Changes in v5:
- Document tree layout.
- Make scripts/module-merkle-tree more robust.
- Remove all changes to link-vmlinux.sh, use vmlinux.unstripped instead.
- Clean up types and logic in modules-merkle-tree.c.
- Use "auth" over "integrity" naming scheme.
- Reduce the changes to the existing authentication flow.
- Explicitly send the series to BTF folks for review of BTF changes.
- Link to v4: https://patch.msgid.link/20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net

Changes in v4:
- Use as Merkle tree over a linera list of hashes.
- Provide compatibilith with INSTALL_MOD_STRIP
- Rework commit messages.
- Use vmlinux.unstripped over plain "vmlinux".
- Link to v3: https://lore.kernel.org/r/20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net

Changes in v3:
- Rebase on v6.15-rc1
- Use openssl to calculate hash
- Avoid warning if no modules are built
- Simplify module_integrity_check() a bit
- Make incompatibility with INSTALL_MOD_STRIP explicit
- Update docs
- Add IMA cleanups
- Link to v2: https://lore.kernel.org/r/20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net

Changes in v2:
- Drop RFC state
- Mention interested parties in cover letter
- Expand Kconfig description
- Add compatibility with CONFIG_MODULE_SIG
- Parallelize module-hashes.sh
- Update Documentation/kbuild/reproducible-builds.rst
- Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net

---
Thomas Weißschuh (14):
      kbuild: generate module BTF based on vmlinux.unstripped
      lockdown: Make the relationship to MODULE_SIG a dependency
      kbuild: rename the strip_relocs command
      module: Drop pointless debugging message
      module: Make mod_verify_sig() static
      module: Switch load_info::len to size_t
      module: Make module authentication usable without MODULE_SIG
      module: Move authentication logic into dedicated new file
      module: Move signature type check out of mod_check_sig()
      module: Prepare for additional module authentication mechanisms
      module: update timestamp of modules.order after modules are built
      module: Introduce hash-based integrity checking
      kbuild: move handling of module stripping to Makefile.lib
      kbuild: make CONFIG_MODULE_HASHES compatible with module stripping

 .gitignore                                   |   2 +
 Documentation/kbuild/reproducible-builds.rst |   5 +-
 Makefile                                     |   7 +-
 crypto/algapi.c                              |   4 +-
 include/asm-generic/vmlinux.lds.h            |  11 +
 include/linux/module.h                       |  18 +-
 include/linux/module_hashes.h                |  29 ++
 include/uapi/linux/module_signature.h        |   1 +
 kernel/module/Kconfig                        |  29 +-
 kernel/module/Makefile                       |   2 +
 kernel/module/auth.c                         | 139 +++++++++
 kernel/module/hashes.c                       |  95 ++++++
 kernel/module/hashes_root.c                  |   6 +
 kernel/module/internal.h                     |  18 +-
 kernel/module/main.c                         |  16 +-
 kernel/module/signing.c                      | 113 +-------
 kernel/module_signature.c                    |   8 +-
 scripts/.gitignore                           |   1 +
 scripts/Makefile                             |   4 +
 scripts/Makefile.lib                         |  32 +++
 scripts/Makefile.modfinal                    |  28 +-
 scripts/Makefile.modinst                     |  44 +--
 scripts/Makefile.vmlinux                     |  40 ++-
 scripts/include/xalloc.h                     |  29 ++
 scripts/link-vmlinux.sh                      |   3 +-
 scripts/modules-merkle-tree.c                | 416 +++++++++++++++++++++++++++
 security/integrity/ima/ima_modsig.c          |   5 +
 security/lockdown/Kconfig                    |   2 +-
 tools/include/uapi/linux/module_signature.h  |   1 +
 29 files changed, 919 insertions(+), 189 deletions(-)
---
base-commit: 585c2e775b12ef45bdf9cef5f679dcb1220e0d65
change-id: 20241225-module-hashes-7a50a7cc2a30

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


