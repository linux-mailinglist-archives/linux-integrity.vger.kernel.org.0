Return-Path: <linux-integrity+bounces-5214-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030DA5BC7F
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950561897AC6
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B6225A50;
	Tue, 11 Mar 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1lbl9gX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445A22B5A8
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686159; cv=none; b=NcTPTcvH8UAoc09QZZ1UG2aZ3e9MJd48DbtoOM0wjLCYuP7jDOwyC64/12X/oCJXRr0AAl3RCaNxShPZuFmAeKk3xoc7RNqeklpwC9QgEOSLM5GHP/qEqxculyC6ccaB59ktGRfu5pIyVVSkYoNZRAhWtqIDo1l4bibIy3yXoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686159; c=relaxed/simple;
	bh=bk1utCoL0jpm+fE7QxhWVPAm20ULaoWKvqvMoOSo3r0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cB+begHJ4sS4UoJDxqqBfiqV+w66psHVoy7jS2OT2c5rO4dPHbTzY+6oqmhaRPr5RA9ducyEPaXX/spoAGpUxptp4UOBm1Ztc/yN90e1MTlmyItDOKyjm666ETg1X3NJp6tm3+MwKilRSN/3x26duTOoDuIKlRNX8WO1cpKjAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1lbl9gX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtUeSeWcd1CI3feUKO1y+/FGn6aMUK50DGWtG1Q+97U=;
	b=F1lbl9gXpaAWGtv0GCqBAaDfD4MEshsoomQKn8EmZIJ3suypsKy2BU5Ps6tlL3KT4TAUQG
	MCZtULkkKpYl+sk8tHRGa4x5rGUfyN8n+jz/yCY/pjAv5D/QU58Tcsep0YEeOqYMWv0O3o
	r5dYP4czpgbDlcJvTp3xGN6p5EVyydU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-0A_ZgH57M3mWjTBNXTdocg-1; Tue, 11 Mar 2025 05:42:35 -0400
X-MC-Unique: 0A_ZgH57M3mWjTBNXTdocg-1
X-Mimecast-MFC-AGG-ID: 0A_ZgH57M3mWjTBNXTdocg_1741686154
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac254e4b515so454690566b.0
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 02:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686154; x=1742290954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtUeSeWcd1CI3feUKO1y+/FGn6aMUK50DGWtG1Q+97U=;
        b=S8+DpzcLhk3VzIJtLZNsUU+d79C3skxLQZOxTpFSaWV6bxxu/604/71wahDJNzuqhC
         WVGGWNNcnwaqDO8iZasOilWqOQnO2y8scRTKD8l+PBa5y1TyZZ27ZTCKSHVir2f9bjks
         mpUwMKUARtmxUnfwhcJECLHu2ZOleHn0pNdKXiV/4JcatFoBIP8wiPLhaJYqbxmwSaca
         TQE8EBSRvoc9darhhFxo1UBbcukALpTpwTUgOKu2yKqj/xXQjvHDR86KdrwcRXIU7a/l
         Xtai5Ym/W5fXgbRYIeYW6rH5sH7WXyH4pLARrc4pkn7ZScKfvoMu3BUFKoQY2Th+qH7M
         mPqA==
X-Forwarded-Encrypted: i=1; AJvYcCWMwbWUuG4SXvaNc8vdpTnYTtcpVlUUiGlGl7xLmODtPmHCkhuQPiVdsAIloqxGExOsR3juLKYJjN/4kRAl1DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKU/cCeo+XfsOmqfOewXodbCXdPYrPuUAzCVrUR4pJh5emLE4
	RVZlF9CaC4zZBSOxu7QYxH01jvMJbisEF6yKJJaiXf38Yfpv23DJr5RjwE1c6yxZmpYevCuydQO
	OMmM10I2YdWXwkDUWvr1N8E9z/D3y1hCQ7Ymat/D4TT6NFPP3z2BBWVMQAhgBe8du5Q==
X-Gm-Gg: ASbGncv9zc4gEa/6FIeHbfHLlx7/FJUEU5XedPtMFrjoGIbAsMe0zKcSvkoXiy5u5D1
	d5eRpE1PRPDnm50s81pwYyFvNFp0/ttA6nmEUZzKhUgtS+wmY+zI86s9qy7MOBN7llQJO44SI2B
	RiNPQNELvFWU9nqgTfLzK14HPVgKfrv944qxUl+YR7FvGxyI4jTW9R3TM5F7/aKM/wb92NXTNgD
	fZe7HuJlnzVhhlQ7U6GTZRdq8c+0Dh5uwXB3Q7VDDz+mEFcpLxgG6sD1+6CBdIb30iGQGrG1/T2
	ti6E0TQL7eoqJIcffp9jinf4tJmRq7ONKQZDx44Ig3IsFlcUKBh6pWk7J/2z1TPzXq0SZ+kN
X-Received: by 2002:a05:6402:40d5:b0:5e7:87ea:b18c with SMTP id 4fb4d7f45d1cf-5e787eacf57mr872948a12.15.1741686153796;
        Tue, 11 Mar 2025 02:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY2OSneC4cl7aSD4PE0BPNJTrwCmoiCQ+JTyO3tvYbex45WTvoHfGFh8SwSjQWrtNpqraj+A==
X-Received: by 2002:a05:6402:40d5:b0:5e7:87ea:b18c with SMTP id 4fb4d7f45d1cf-5e787eacf57mr872899a12.15.1741686153165;
        Tue, 11 Mar 2025 02:42:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7473c17sm8118639a12.28.2025.03.11.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Date: Tue, 11 Mar 2025 10:42:21 +0100
Message-ID: <20250311094225.35129-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD SEV-SNP defined a new mechanism for adding privileged levels (VMPLs)
in the context of a Confidential VM. These levels can be used to run the
guest OS at a lower privilege level than a Secure VM Service Module (SVSM).
In this way SVSM can be used to emulate those devices (such as TPM) that
cannot be delegated to an untrusted host.

The guest OS can talk to SVSM using a specific calling convention and
instructions (a kind of system call/hyper call) and request services such
as TPM emulation.

The main goal of this series is to add a driver for the vTPM defined by
the AMD SVSM spec [3]. The specification defines a protocol that a
SEV-SNP guest OS (running on VMPL >= 1) can use to discover and talk to
a vTPM emulated by the SVSM in the guest context, but at a more
privileged level (VMPL0).

This series is based on the RFC sent by James last year [1].
In the meantime, the patches have been maintained and tested in the
Coconut Linux fork [2] along with the work to support the vTPM
emulation in Coconut SVSM.

The first patch adds public APIs to use AMD SVSM vTPM. They use
SVSM_VTPM_QUERY call to probe for the vTPM device and SVSM_VTPM_CMD call
to execute vTPM operations as defined in the AMD SVSM spec [3].
The second patch adds an interface with helpers for the SVSM_VTPM_CMD calls
used by the vTPM protocol defined by the AMD SVSM spec and then used by the
third patch to implement the SVSM vTPM driver. The fourth patch simply
registers the platform device.

Since all SEV-SNP dependencies are now upstream, this series can be
applied directly to the Linus' tree.

These patches were tested in an AMD SEV-SNP guest running:
- a recent version of Coconut SVSM [4] containing an ephemeral vTPM
- a PoC [5] containing a stateful vTPM used for sealing/unsealing a LUKS key

Changelog:

v2 RFC -> v3
- Removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
  As we agreed, I will send another series with that patch to continue the
  discussion along with the changes in this driver and ftpm driver.
- Renamed fill/parse functions [Tom]
- Renamed helpers header and prefix to make clear it's related to the
  SVSM vTPM protocol and not to the TCG TPM Simulator
- Slimmed down snp_svsm_vtpm_probe() [Borislav]
- Removed link to the spec because those URLs are unstable [Borislav]
- Removed features check and any print related [Tom]
- Squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  with the next one [Borislav]

v1 -> v2 RFC: https://lore.kernel.org/linux-integrity/20250228170720.144739-1-sgarzare@redhat.com/
- Added send_recv() tpm_class_ops callback
- Removed the intermediate tpm_platform.ko driver
- Renamed tpm_platform.h to tpm_tcgsim.h and included some API to fill
  TPM_SEND_COMMAND requests and parse responses from a device emulated using
  the TCG Simulatore reference implementation
- Added public API in x86/sev usable to discover and talk with the SVSM vTPM
- Added the tpm-svsm platform driver in driver/char/tpm/
- Fixed some SVSM TPM related issues (resp_size as u32, don't fail on
  features !=0, s/VTPM/vTPM)

v0 RFC -> v1: https://lore.kernel.org/linux-integrity/20241210143423.101774-1-sgarzare@redhat.com/
- Used SVSM_VTPM_QUERY to probe the TPM as Tom Lendacky suggested
- Changed references/links to TCG TPM repo since in the last year MS
  donated the reference TPM implementation to the TCG.
- Addressed Dov Murik's comments:
  https://lore.kernel.org/all/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
- Added a new patch with SVSM call macros for the vTPM protocol, following
  what we already have for SVSM_CORE and SVSM_ATTEST
- Rebased on v6.13-rc2

Thanks,
Stefano

[1] https://lore.kernel.org/all/acb06bc7f329dfee21afa1b2ff080fe29b799021.camel@linux.ibm.com/
[2] https://github.com/coconut-svsm/linux/tree/svsm
[3] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00
    https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[4] https://github.com/coconut-svsm/svsm/commit/6522c67e1e414f192a6f014b122ca8a1066e3bf5
[5] https://github.com/stefano-garzarella/snp-svsm-vtpm

Stefano Garzarella (4):
  x86/sev: add SVSM vTPM probe/send_command functions
  svsm: add header with SVSM_VTPM_CMD helpers
  tpm: add SNP SVSM vTPM driver
  x86/sev: register tpm-svsm platform device

 arch/x86/include/asm/sev.h  |   7 ++
 include/linux/svsm_vtpm.h   | 141 ++++++++++++++++++++++++++++++++++
 arch/x86/coco/sev/core.c    |  39 ++++++++++
 drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 6 files changed, 346 insertions(+)
 create mode 100644 include/linux/svsm_vtpm.h
 create mode 100644 drivers/char/tpm/tpm_svsm.c

-- 
2.48.1


