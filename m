Return-Path: <linux-integrity+bounces-5570-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FFA7A0AA
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE717311D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B42248862;
	Thu,  3 Apr 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7lgD6i+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32A3C0B
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674993; cv=none; b=joU30oTlgSIJCBdriVV4jq0baUlx5EiPJOpenK+hhDQhnsjaN3zGYAoLvuD1pYcSY575GIAWLbNV6fdut8KIaH6ZzAKTd/WEaq53pXW/hlJRKS3I4USsePLz6h5ZhnnPVvWXLmyIbZ3kyhD+fFhMey5N5cuoBMT6L9fDN18nYy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674993; c=relaxed/simple;
	bh=5FSteDrn5VYDqf1Btl0fx9pkTUztvXM/SHshbth5mbo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BiYhXF736n06u1daHXFB0cQiIbm3cTC44+DWNoWTKksA0bKGE5+DL67Zd92eIerrCldKpyU4JD58Za98kfkGg4rLuhjbFJlv+y312jZyZtE/JP2OHNib5cNlsri6cKMiMC1dRG0ux1aUU0PdwbYElHoaXT/FviiblAx1uaHmaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7lgD6i+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743674989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/bj//cdYUpP/vFX6jRs5Vr3jpomE9bg4nM3VVCeSMBY=;
	b=W7lgD6i+nKFvARqXrmhRgjC09uBD67FG6EMj30+OuVi8FAgqq5MDD+mJzWsKKn+eyxL+o9
	0rJQOn2D2/Nh6DcvOaEuSVL4igmSIeN0Czyv38X1/TjjRrXeTWG0v9Mzpqs4cBrkAjtHv6
	Bi45D2j2cDlkWVFQpKX0ZrWB0uzEvGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-6_ajfGcEMpyHHdZgt65x9w-1; Thu, 03 Apr 2025 06:09:48 -0400
X-MC-Unique: 6_ajfGcEMpyHHdZgt65x9w-1
X-Mimecast-MFC-AGG-ID: 6_ajfGcEMpyHHdZgt65x9w_1743674987
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf446681cso4495525e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 03 Apr 2025 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674987; x=1744279787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bj//cdYUpP/vFX6jRs5Vr3jpomE9bg4nM3VVCeSMBY=;
        b=SYsYA3RlDnogddW0aHtqvv9ticn2+LDMq0ilB/QrezshYFf/pS8lcLb7OgGuolX65E
         KoD6g3WjQATgZt/U9Q5dbvBB4TEdbXnqKzAXF4M7XPsStVRv38oSgADWZKv4viBj7O/e
         Y7wAq3jENvoGZr6U45tXH/rH3yE+xuVy/Mg8THlgGCJ/QXgl/Tm/hrb9NEQujX2ORg5Z
         Fn6N6dLIt1xIz94FwYciyw0LRVKM+yFBjwUUe8ipAcQOuh4GuOlsZOo97XUAV0sHwE7x
         a2fNVd4YoOTyxaMaumZkxpSxUGGIYebS9mwtH39of+1LmPaW+cyyThJQoakI/Fl544DG
         T0wA==
X-Forwarded-Encrypted: i=1; AJvYcCUxWDpK9sRL/4BM+O2zdvAM+Q6Y1rtNyQ6wgFDVnoElIbfQiMn10Jf1oh8ViDQoI64vrCBnOAaCEF1GtPGZ760=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iXS9wWURQZg09Zki+cY6bxxjdJ/jIz+AU0GMeAg+PddX7Pxn
	quepbElsjmgQ+i1BJuV8nRhlYewNs2TA3N5aQRbBpVbSuCCbEz9UPhmoNakxmda0QeCMnTOGhXI
	VA8Ljg9OTIhejQ8x25DGib7lllsMB2v6A4aAIW2W05lUKj2HlU3jZz5lIG7o6DgbhtA==
X-Gm-Gg: ASbGncvYjAOvsBg0xh2nnd6JF7rrFiNqTkxZkxuyMzbyQFACEtw1ntsLm/sOYOlVdik
	nCl7CLO1pT8pM60/Upwe8VKrk23Td40i2L6nOOaAu1pYeLlzUajYgLxFbKH9UQmcrMB96v3GYzI
	QJA2kArPn2gnv1iypSZ1APkmFkDTxbqU+9puolFKKJY0TJPrIe+FPOTnQEmD/MgbQshNEFCJu6t
	Qz+1t7JLfEjK3xHPgzILauRt8oxmZg8RvLJJe4u9t0dC1HdtfVU/1ymDU5Wd4pQMpPAnhin5/nR
	IhJtvCONFeeAsC9MY69znE7YwQLnttso70NhUoNOK3UPHPrXiHI5KNmajMa8
X-Received: by 2002:a05:600c:1c1c:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-43db62b5d7emr167023115e9.29.1743674987045;
        Thu, 03 Apr 2025 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4KSfYkS6sy6Vm+pZhzwGSLYiA9SzOfbtv+MaLxcJQ/HIMRRIRKx3we5xzDB6KifYrOAOlWg==
X-Received: by 2002:a05:600c:1c1c:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-43db62b5d7emr167022585e9.29.1743674986398;
        Thu, 03 Apr 2025 03:09:46 -0700 (PDT)
Received: from stex1.redhat.com (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea8d16049sm51244185e9.0.2025.04.03.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:09:45 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Date: Thu,  3 Apr 2025 12:09:38 +0200
Message-ID: <20250403100943.120738-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
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

v5 -> v6
- Removed the `locality` field (set to 0) and the FIXME comment [Jarkko]
- Added Tom's R-b on patch 4

v4 -> v5: https://lore.kernel.org/linux-integrity/20250331103900.92701-1-sgarzare@redhat.com/
- Added stubs when !CONFIG_AMD_MEM_ENCRYPT [Dionna]
- Added Jarkko's R-b on patches 1 and 2
- Removed cancel/status/req_* ops after rebase on master that cotains
  commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")

v3 -> v4: https://lore.kernel.org/linux-integrity/20250324104653.138663-1-sgarzare@redhat.com/
- Added more documentation around public API [Jarkko]
- Simplified TPM_SEND_COMMAND check [Tom/Jarkko]
- Renamed header in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
  section [Borislav, Jarkko]
- Fixed several comments to improve svsm_vtpm_ helpers and structures [Jarkko]
- Moved "asm" includes after the "linux" includes [Tom]
- Allocated buffer used in the driver separately [Tom/Jarkko/Jason]
- Explained better why we register tpm-svsm device anyway in the commit message

v2 RFC -> v3: https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
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

 arch/x86/include/asm/sev.h  |   9 +++
 include/linux/tpm_svsm.h    | 149 ++++++++++++++++++++++++++++++++++++
 arch/x86/coco/sev/core.c    |  67 ++++++++++++++++
 drivers/char/tpm/tpm_svsm.c | 128 +++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 6 files changed, 364 insertions(+)
 create mode 100644 include/linux/tpm_svsm.h
 create mode 100644 drivers/char/tpm/tpm_svsm.c

-- 
2.49.0


