Return-Path: <linux-integrity+bounces-9892-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K/ADJKkgTWoyvgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9892-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:52:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0371D854
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=S3j3PEJH;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9892-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9892-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C5031D9F96
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A75430301;
	Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520841F7C6
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438730; cv=none; b=i+C5vRUJptLqOLK/pvbIgq35tfmWkzjOg9BOiloUZWypP+lIczMkuMkyaUxeLWnDtf9DbRz7tHPAklQIxiIde7lLAAJ2A95P6Wl2tXDD9/0FEO3ZvDj8yyIA3cQOB4i3+njs8cEPy3XfHUg2euNHEmqUkNwceE9uTLrkyvwbmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438730; c=relaxed/simple;
	bh=iDSVx05XJpQ187yLL+vngdmnzjWQdJOINiVqfnmbIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaw2dQ9KrolfhrWeyDEu3yLcpPLv4OYCw9gVMCJOsoN0ouzvMbVP/dLJ2uQkAibb4QwX9RAMo/TZtDnkrVnYX8IAfg55cp5+1UL56ZjnOJrkG0EW1b1M4zC02jSk9Mkvto9drEMJhB6ApXdECzy3v8asYvfX74OUg3xrxT7iPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S3j3PEJH; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so30442025e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438727; x=1784043527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEQ8hvtSLcTmZmrsjKtJkrVXdZFggd5Aezo0pgyYhCk=;
        b=S3j3PEJHWmxK+12hA8/u+iTeDUx3LEdYnH/vEwvG5gPHUsVnhJiimj52xHPYRo37wP
         ToOTwF3WqX3ceUOUmKLBZnSn6wtJ+QJKtT+7//I4xAYRyrNA7UDGH7c81d90S1Gf94ds
         8x8TY3+mz4LXeiUMN7taxmuDaTviWYd8GdwCJo9pbVnwFhgapwgvHXD+TFG6pJsTGYjR
         SKjSLQT7MMKWHdsC2h7XReMlDp+44zKBmhuJ5f8+NmkBOOVY2Y/9Xb1Oyy8tVzwxtI3n
         tGGsKHGSav3dFFeP8LpKXaPBb6tFJoCcb+/mPIylF2nnVOGHnq3nIOn0nwFDYag4VdZ8
         URiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438727; x=1784043527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEQ8hvtSLcTmZmrsjKtJkrVXdZFggd5Aezo0pgyYhCk=;
        b=TFyVwgrZ99xxxkoABQFG/w2QVTxR6CrUB69/Sv3y/1i3VNZ1nzC9GszMHBwPMFLePQ
         ZJSu602hKzxUdvVD2EIvBPldcWADckidlqKY9119/mhHqzOKSYGj7xW62PwDwXchjQAP
         fOeFM6LhjUSP9Fq8YU6wge+urU2AjUYCj9Xmk+HLoHzbwc3qWcDjeNY1I/CsDY51pjxs
         wDNGyM1HMokURf0gc6eYSq+hOSmMWxC/spYFJ3Yf0ryAc/Sgch/lUdtTvDXuy/rlM+Xo
         6NOhfYoVk0Y7EitZVsCGHty2mfuOAUHwWbGOcef2nD3oaI6A3cjY3VSxdBxkGI7W6CRz
         oMHA==
X-Forwarded-Encrypted: i=1; AHgh+RoTESzehizcviHC6BBttf7hXrvUnKlgRyRUM5TPoopKw8HJUQuYnKHB/GaUSE/9ODhz/A6dYajP5CBJICWQ1Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoiczdFnwKXSbxRWQJjayGSt8IjzvcZgsi1tFcNxOrEwX8zjd
	pRKkZvVJFem6p90GhEjQ3kr9uS84noh+yNZ3hFzAZpB4PuaRS5LlsH0xzaJ+autR3hc=
X-Gm-Gg: AfdE7cmntqiELg22xyjWcUOnd8kMLIJ0CDHunZiSPX5v7owVcKVWJNoA8fFTKb6NVG/
	M+FJedvpucfwJUAZCXbWRX+WNWWRKpZAH0R+Qt/hhyJe9FDK/aN2MlzGaCKT7OdLFTM2zxQOyxh
	bLgYrVjtrlFayf35aSf8Mxcwc+z+xQ+WDYAfXdlm+EvBz0j1oVb37dq5We1UGnoQJuN9/dvCZoG
	PwCi2kc2tH9ZgyRoVheXdtyZYzPehMCdnQ1JITqDIZ3buxSkwhRlbFJ/OcVZdaDHEQkZJqghneU
	4m7H+0zt8lukinJtLdIqOFvE8RdsSBijY+cW46luPTQDYHsClxLCenSPKGZ++idF0CrREUUC3kB
	w3HcNVlOPddpawi2JiJwCl0O6XWgPA7Se2Rq/ajL+ytkNEa4NjOEYI4va9ViKlYD/i53Jpvci7f
	feMC0xX76kN87TCCeXoE7GMeGCfEcfawopwDLkTL85iDt9AlM26j1hMaM0T+8uxNxwuqWDOJIwj
	zHzur0pxe9/4elUBuYTWgzf
X-Received: by 2002:a05:600c:3b08:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-493df0410d7mr67190395e9.14.1783438725537;
        Tue, 07 Jul 2026 08:38:45 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:03 +0200
Message-ID: <20260707153819.4172541-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-9892-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:atomlin@atomlin.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,suse.com,google.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6F0371D854

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

The first three patches are cleanups to avoid relying on declarations being
indirectly provided through linux/module.h -> linux/elf.h. These patches
are all independent and can go through their respective trees. The final
patch depends on these changes.

It is hard to identify all files that indirectly reference something only
through linux/module.h -> linux/elf.h. The changes were build-tested with
allmodconfig on arm, arm64, m68k, mips, powerpc64, riscv, s390, x86_64.

Petr Pavlu (4):
  x86: Avoid indirect includes through linux/module.h -> linux/elf.h
  s390: Avoid indirect includes through linux/module.h -> linux/elf.h
  tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
  module: Limit ELF includes in linux/module.h to uapi/linux/elf.h

 arch/s390/kernel/nospec-branch.c | 1 +
 arch/x86/entry/entry_fred.c      | 1 +
 arch/x86/entry/syscall_32.c      | 1 +
 arch/x86/kernel/cpu/intel.c      | 1 +
 arch/x86/kernel/fpu/xstate.c     | 2 +-
 arch/x86/kernel/process.c        | 1 +
 arch/x86/kernel/signal.c         | 1 +
 drivers/char/tpm/tpm_crb_ffa.c   | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 include/linux/module.h           | 4 ++--
 10 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.54.0


