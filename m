Return-Path: <linux-integrity+bounces-9909-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iUNINM5oUmrFPQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9909-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:01:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD0742112
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h1sn6KvL;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9909-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9909-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A733300CCAF
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2E2C21FF;
	Sat, 11 Jul 2026 16:01:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9627874F
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785675; cv=none; b=aUEoQC6VoKoz3mpWAAHlX+Az2arkUd6rREaddsYFoA0BkFdNtUZe8zgAg0+ysZrS6ADJd5cG2SHwqVMLJzlNVL0W9eYwEBR/4KjW2IcRbrdcdPi6U5ooQb+4Jv24UqLdekLg54j+T1TOtQ0MW+x+G+iK2F3PJoVsja1OV8tjRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785675; c=relaxed/simple;
	bh=N7RC+uZRrlKgQQELyWXcXycrqlZe8qncc17h5i528c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGhkt4le38UlhZvUDmMHDMT9TmkqLR4yggeuClg+z3D8tI4Nfo2env530RvsIuQ4eFhL0uyPY+mIdOYAeg/QVFtqhvHUDPRoBwqAkDo2JFh1t2FalJt4glmVglrGR7S6k7VobZJZlluOt020bjG36EtEV3DdWIZ8p4V8o10qeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1sn6KvL; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381ed661712so2307875a91.2
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785673; x=1784390473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JayLLvpAgBylhvulp5IdQiUHgZ6NsRSyedzXc8seza8=;
        b=h1sn6KvLpn5hppyIM0tn+DMR6xwsCKmcQlqpWfWpIrnmj1ZoT02vejWpDz22WVCOgM
         xecWQn80Jpuqqdvd/0UmtgFx1fDnub+Swf7i9Vmp9OquronEK3D61xZC/4hYtWbBPO1J
         zdoILp+W+eqEt4TQ5Q8Cdw/p2DtSY/gQbeujFfbq86dYBbrvmR1+p0lSlDCdBT15uYXm
         lOauePim5VCd4EouaPCasFzZnkVNHfUlUTUnPiwoUpNt7u177W9ObjulC3xZhdRSyQ2y
         84NHn3JKFIvElaZDAnolY/reDNPHCpyVPajsYVTEwJE4pLxlkOAMGOvvnV3z4ighe2+K
         aMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785673; x=1784390473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JayLLvpAgBylhvulp5IdQiUHgZ6NsRSyedzXc8seza8=;
        b=LPs1cV8Tk+I8yP7n7ecZsbkKyWVH9+aKzAO7xfO87ubc/dXq9xIW5pjUdXmC6bzxUU
         kd/KLEQEJ1BG9Uyl2r+2agPDEHgLGOpRe23WQmZUj9Kd5Ca1Om3mAA8XIYHsRXod/BPv
         0Q3uD7v5e6gItVrOQXCDNVTABcXRsiAlQ8tbyCltTifj6afWT6B4vePM1Be770FaC1Ol
         yz+0udIkvHl8MvLAUOThp3i4TcKyAIrUNPB2Z/gDhpy+wRhwYHgDKtvNqVa+bbk0xUir
         Duiv5VKzAVZxljZPPgS+0cC9BCUMAGmNjaO1buYp+MkCBgVLbapFLhUksKx6YKnWDVe6
         OABQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIoqHcc9jS4CTdvqswh2yhk347zx8gOzd6tuCaRGKrdVB48BdX1o/70UPGeTUZG74XkPDhVZDD9LtIxgo8Cec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMR4+Fm7d6tn3tzBQLJ7/gKSECj6s8GpmmIPOuYcltRAK0zY0
	tm0NaMe6hpfAzrFlBIbAAxb/xXKjDZ8cQjS4XmYGvwVWQMC+OPYqhhat
X-Gm-Gg: AfdE7cmMWld5wUI0b9vd2m5ct7H5Yg1GHu/NV2j9QLVaE5L/3s2NHKuL393PFPz2x7X
	6QF7eQ9k9tcivRt+rgwyddRUJPID/9RnchOP1tOIcIUIrTgL7OlnG0+WgwIqwOd9aKaqXxWrJCP
	FrMmu7QZIbWX+8nu38f39YYO5QDLNJc9mBBlBl51MOThg1pyMsObdmn3dI/bM0g578rtl+WZAC+
	NG1Z6zL/zoYtXQxtgfo7ePOBSnQSi8sQcc1A5U3U8ym0+eoCRj4OGdz5SCPVKc0OugLqDWrFpb0
	RXTM2U7XFOQ4B2D26abLE0VyYmlQPJPdaVGL0a3QCFBmSPY3hoHJ6hxPH81XDKM8ytyunexRKTP
	LftqYZ+ej13LFSDesi43QMs3j2k07VBwM+/jSdb0ZqhJmFIvy8WsNZR8JNpLAd7jwXCdnuZnpe5
	9x/fMe2Og+yM1rKBS1kiXo
X-Received: by 2002:a17:90b:4c49:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-38dc774d270mr3079721a91.20.1783785673221;
        Sat, 11 Jul 2026 09:01:13 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm20951952eec.15.2026.07.11.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:12 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 00/10] tpm: Reorganize public headers and extract tpm-buf for standalone reuse
Date: Sat, 11 Jul 2026 09:01:00 -0700
Message-ID: <20260711160110.267780-1-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9909-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:ross.philipson@gmail.com,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DBD0742112

This series reorganizes the TPM subsystem's public headers for better
modularity and maintainability while extracting the `tpm_buf`
abstraction into a new standalone header (`include/linux/tpm_buf.h`).
The goal is to allow other kernel components to construct, parse, and
manipulate TPM commands, responses, and TPM2B-sized buffers without
pulling in the full set of TPM driver headers and implementation details
from `<linux/tpm.h>`.

Key elements of the series:
- Split version-specific (TPM1/TPM2), common, and platform-specific
  (PTP) definitions out of the main headers into dedicated files
  (tpm_command.h updates and the new include/linux/tpm_ptp.h).
- Clean up include dependencies (e.g., remove the main TPM header from
  the TPM event log header).
- Refine the tpm_buf implementation for improved memory safety and a
  cleaner API suitable for standalone use.
- Introduce include/linux/tpm_buf.h (with helpers for
  init/reset/append/read operations) so the buffer logic can be reused
  more broadly (e.g., by security subsystems, measurement architectures,
  or early-boot components).

This work originated in the TrenchBoot/Secure Launch development tree
but provides general benefits to the upstream kernel by reducing header
coupling and enabling safer, more reusable TPM buffer handling. It
builds on prior refactoring efforts and incorporates improvements for
robustness.

Note on this version: This is a breakout of the TPM driver related
changes from the Secure Launch v16 series. As it includes Sashiko review
changes, it is being considered v2. Another noteworthy change is the
replacement of patch #9, "tpm-buf: Implement managed allocations", with
the recently posted variation titled "tpm-buf: Memory-safe allocations".
Additional API cleanups were made to the tpm-buf code to better support
standalone reuse.

Version note: This series extracts the TPM driver-related changes from
the Secure Launch v16 series as a standalone patchset. Because it
incorporates the Sashiko review changes, it is now designated v2. A
notable update is the replacement of patch #9 ("tpm-buf: Implement
managed allocations") with the recently posted variant titled "tpm-buf:
Memory-safe allocations." Additional API cleanups were also made to the
tpm-buf code to improve its suitability for standalone reuse.

Series based off: torvalds/master
dc59e4fea9d83f03bad6bddf3fa2e52491777482

Thanks,
Ross Philipson and Daniel P. Smith

Changelog:

- Replaced "tpm-buf: Implement managed allocations" with "tpm-buf:
  Memory-safe allocations": New implementation uses fixed-size
  kzalloc(TPM_BUFSIZE) (or stack-backed) buffers with explicit capacity
  tracking, strict __tpm_buf_size_invariant checks, improved TPM2B
  handling, and validation during init/reset/append to prevent overflows,
  size mismatches, and potential memory corruption issues associated with
  the prior __get_free_page based approach.

- Updated "tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW":
  Simplifies the error flag handling in the buffer abstraction by
  combining related overflow/boundary conditions into a single, clearer
  error state.

- Updated "tpm-buf: Remove chip parameter from tpm_buf_append_handle()":
  Makes the handle-append helper more generic and independent of struct
  tpm_chip, improving its suitability for standalone reuse outside the
  core TPM driver.

- Updated "tpm-buf: Add TPM buffer support header for standalone reuse":
  Refreshed to build on top of the new memory-safe implementation, the
  merged error codes, and the chip-parameter removal for a cleaner, more
  reusable public API and header.

- Header reorganization patches ("tpm: Initial step to reorganize TPM
  public headers", moves of TPM1/TPM2/common/platform definitions to
  command/ptp headers, and removal of main TPM header from event log
  header) are retained with the same overall structure and intent; they
  benefit from the refined tpm-buf code and minor consistency adjustments.

Alec Brown (1):
  tpm: Remove main TPM header from TPM event log header

Jarkko Sakkinen (3):
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle()
  tpm-buf: Memory-safe allocations

Ross Philipson (6):
  tpm: Initial step to reorganize TPM public headers
  tpm: Move TPM1 specific definitions to the command header
  tpm: Move TPM2 specific definitions to the command header
  tpm: Move TPM common base definitions to the command header
  tpm: Move platform specific definitions to the new PTP header
  tpm-buf: Add TPM buffer support header for standalone reuse

 drivers/char/tpm/tpm-buf.c                | 145 +++---
 drivers/char/tpm/tpm-sysfs.c              |  26 +-
 drivers/char/tpm/tpm.h                    | 180 --------
 drivers/char/tpm/tpm1-cmd.c               | 180 ++++----
 drivers/char/tpm/tpm2-cmd.c               | 321 ++++++--------
 drivers/char/tpm/tpm2-sessions.c          | 164 ++++---
 drivers/char/tpm/tpm2-space.c             |  57 +--
 drivers/char/tpm/tpm_tis_core.h           |  64 +--
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/keys/trusted_tpm.h                |   1 -
 include/linux/tpm.h                       | 230 +---------
 include/linux/tpm_buf.h                   |  60 +++
 include/linux/tpm_command.h               | 518 +++++++++++++++++++++-
 include/linux/tpm_eventlog.h              |   2 +-
 include/linux/tpm_ptp.h                   | 133 ++++++
 security/keys/trusted-keys/trusted_tpm1.c |  45 +-
 security/keys/trusted-keys/trusted_tpm2.c | 166 +++----
 17 files changed, 1237 insertions(+), 1085 deletions(-)
 create mode 100644 include/linux/tpm_buf.h
 create mode 100644 include/linux/tpm_ptp.h

--
2.54.0


