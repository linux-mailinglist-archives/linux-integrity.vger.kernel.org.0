Return-Path: <linux-integrity+bounces-5014-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9CA49FD3
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416CA3A762F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2325DD1D;
	Fri, 28 Feb 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq9TzHPJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B531F09BE
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762454; cv=none; b=MKOb+i2ScGXY9FWqW8ELcD5yI8jtuGh6YO07I9vBkW5v6oEUZ+QGf6XOFw+EhjES3aa1eHpm2n10LTndXLQyKSBUQbfz/31+CoqJs0aXJKESqGqtjpUN3EFBsTJgTTUYzqsuc3NARF8soifdDsZ8TkVPoCI4bYgmM1p6KApj3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762454; c=relaxed/simple;
	bh=/RvA9r65QapsK4A1GAT1dVLM+H7F3owsWsN7y2Q2Trs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r08ParjxmHsNq2Bq/JquM8450zPVb6OQw3eLDmj4Kk4S/Y2sgrAh4ldturciLSC0F52JUKem7/MCF9gzoxs9Ncw9iY5UCjIrW423aIZg8bIicKnGvG/Dnejj34or1V/gvJxUew/UtgtZt5BPqhVUH/DSAOLIBsdOyHi2Q4jJ+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eq9TzHPJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rYSCAfZyuD0d3DxBU/ccZy8rRQiRa9ZEu27E2u5eVcs=;
	b=Eq9TzHPJfe5HCWajly9ZVKFFHZ0UxjeTu5I/Sya/G8amZxP9y9wv1VMbHaqNfRVN2VYKAp
	eqKZ2Lyylr3rc5g5Id+A5Z3a7+uHa9H9dvDpz24VwuGhlK8PAhpaoejR0n11C7vM15QXUN
	54Rwlg0pVf4jGNB0pfnwsypCdmEKNrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-a2XK9IAhOpadDNWjUTOjQw-1; Fri, 28 Feb 2025 12:07:29 -0500
X-MC-Unique: a2XK9IAhOpadDNWjUTOjQw-1
X-Mimecast-MFC-AGG-ID: a2XK9IAhOpadDNWjUTOjQw_1740762449
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390df5962e1so1368435f8f.0
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762448; x=1741367248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYSCAfZyuD0d3DxBU/ccZy8rRQiRa9ZEu27E2u5eVcs=;
        b=kOsj3SY2/CZtHJ0VqPW8q4KXp1X43Zn50vLTRzooxcoqCUPPuZVSNct6JrDyPnp/2O
         punlFPBRviEW+2FvDQf771kHwTyxk5YzwHCihGa30crq1n7vyFK0kJ9cVc3ef7lKHviS
         EsLr/QAmO6xtaj+Yx82SFx/OxWWw/CFPDOjvUuLenwuW9IQOU33ME6hCnTockfGsSCCK
         daPsRHi3kKo5Bse7+CwrrxKI1IzC5YGXIwQPx78PKLHei86OjOpuosrlO5iB3oHpHy+L
         Kkx2ooUsykuuPr1ePRs6S2Vhc8voiEqPMSqz2lRl98GCelRQvkpgkEQPTDkXxM4H0h7c
         C6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV88kMOSTZ9Jf9bEsCYoYC8+00Qce+W8R3q9MOB5Fp3Fv/4jqz6PN8UjwPjB8XC6W87fCjs/CKss9C87h7+3Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsl6Tgm2pOo4Gz+1ZVjaCodZAq/9VJeWkhf2+bnv3lrErGCOob
	/K5wxEuJUq5RGcl2Km3fT1UpEKRpOCh8rHFkoOVnHfwhS61TIFVA4CM2M751tt3481NtgTjfnBP
	W6pFev4dqYS/1HuzmHR1c1eFMaH0E2S1p9Ao1/45PkuFNRxbR4Ef+Oo5XOgXo9OfIBg==
X-Gm-Gg: ASbGncth+wNHYBejgFuVQCiA94+OzuOxRUBmBqGDYsNWnwWrL3PLbcpVYuTj+0qh9oD
	EBLZrZHBYz2uvGAE8v7YARwW8m3qKZYQosEwQjAeikIAGNo7YrecZb1CQYPZoM5mla7UX0UMlvg
	9WnBKxxr80r3JUefEC8ZpmIyikhKxTOzo2TDJeRJERLUBHoxjwUr0LSb890kNFelzNKCVP0Urx4
	NSFaIBVknnP7heysksmHBV75q8rX6RsYAGYQFeJIiDCZkHq4XKr3J4poTifgQ+2ex/MQsGvckuM
	TnnU7aRDE7yryfuuRnuU
X-Received: by 2002:a5d:47ad:0:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-390ec1658f3mr4919652f8f.21.1740762446979;
        Fri, 28 Feb 2025 09:07:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtVYlKKW8a4KALXus8eZuA/K3Vl0LzZxrwI6Pap0hcUB9luMzYgXS5z5tRoXmaqfZdOyLkrw==
X-Received: by 2002:a5d:47ad:0:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-390ec1658f3mr4919346f8f.21.1740762444740;
        Fri, 28 Feb 2025 09:07:24 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7473sm5847296f8f.38.2025.02.28.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:23 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 0/6] Enlightened vTPM support for SVSM on SEV-SNP
Date: Fri, 28 Feb 2025 18:07:14 +0100
Message-ID: <20250228170720.144739-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I put RFC back in because we haven't yet decided if this is the best
approach to support SVSM vTPM, but I really like to receive feedbacks
especially from the maintainer/reviewers of the TPM subsystem, to see if
this approach is acceptable.

Also James, Claudio, I left some questions for you in patches 2 and 4,
since I reused your code, but I changed the context quite a bit, so for
now I reset the author and added C-o-b, but I'm not sure it's okay for you.

As requested, I try to add more context:

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

The first two patches add public APIs to use AMD SVSM vTPM.
They use SVSM_VTPM_QUERY call to probe for the vTPM device and
SVSM_VTPM_CMD call to execute vTPM operations as defined in the
AMD SVSM spec [3].

The third patch add a new send_recv() tpm_class_ops callback as suggested
by Jason to be used with devices that do not support interrupts and provide
a single operation to send the command and receive the response on the same
buffer.

The fourth patch adds an interface to talk to emulated devices via the TCG
reference implementation and then used by the fifth patch to implement the
SVSM vTPM driver. The sixth patch simply registers the platform device.

Since all SEV-SNP dependencies are now upstream, this series can be
applied directly to the Linus' tree.

These patches were tested in an AMD SEV-SNP guest running:
- a recent version of Coconut SVSM [4] containing an ephemeral vTPM
- a PoC [5] containing a stateful vTPM used for sealing/unsealing a LUKS key

Changelog:

v1 -> v2 RFC
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

Stefano Garzarella (6):
  x86/sev: add SVSM call macros for the vTPM protocol
  x86/sev: add SVSM vTPM probe/send_command functions
  tpm: add send_recv() ops in tpm_class_ops
  tpm: add interface to interact with devices based on TCG Simulator
  tpm: add SNP SVSM vTPM driver
  x86/sev: register tpm-svsm platform device

 arch/x86/include/asm/sev.h       |   7 ++
 include/linux/tpm.h              |   2 +
 include/linux/tpm_tcgsim.h       | 136 +++++++++++++++++++++++++++++++
 arch/x86/coco/sev/core.c         |  55 +++++++++++++
 drivers/char/tpm/tpm-interface.c |   8 +-
 drivers/char/tpm/tpm_svsm.c      | 120 +++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig         |  10 +++
 drivers/char/tpm/Makefile        |   1 +
 8 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/tpm_tcgsim.h
 create mode 100644 drivers/char/tpm/tpm_svsm.c


base-commit: ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
prerequisite-patch-id: 46b3bb004bd044863a404b15d704b0ab5cb3adf3
prerequisite-patch-id: 6448736bc6cd561e6ddc10d21f43952a585c5657
prerequisite-patch-id: 9dd308a4f5a115129c6c1b403083651ade63a3de
prerequisite-patch-id: 0a97c8378dbe85c3547a39ecb008190b84c7e797
prerequisite-patch-id: 776de0155dee63ac4ad062e30c97ba09c2d3da83
prerequisite-patch-id: e0f8dda234962608edc6226074c8f1b177a9e8eb
prerequisite-patch-id: 9d957abb4542e6d5968b638b8e593e287a3018db
prerequisite-patch-id: 8e8a0d9828e2b76a80a749b99f88da395c831877
prerequisite-patch-id: 2549a12c40bca1c4f984abf247a1223348676c62
prerequisite-patch-id: 4f16ae35dae2290ebe784c8bb173922d85e3d1bb
prerequisite-patch-id: 12c769f55c189894f9e4a81978e8c3cbb0cf344b
prerequisite-patch-id: 4dae8c09727f2d9ba2eb49c274d04621b9651410
prerequisite-patch-id: e96507d220ebb1e6f32c6d8551eb5bc10d9b2d6f
prerequisite-patch-id: 3bc6b3c406f5ce6ca862ef62e8483fafc4b4ec88
prerequisite-patch-id: 57a35b09322e2cb4cffa6612b7c3384523c6235d
prerequisite-patch-id: db039fb5a3137ef06c3483840ded33f144f94acf
prerequisite-patch-id: 23b6c2faacb3d81ad087c569ea959b5862b0bb87
prerequisite-patch-id: 8e5d5fa9bc52f32532ca9723db5bcab0386e850d
prerequisite-patch-id: 7a6a804bc82fb058ee67392e6e468ae27023ae29
prerequisite-patch-id: ff86959f0d768eae5336288912823035f77609f9
prerequisite-patch-id: c3ebb29e9b269792ce0a7b46b657422777106d34
prerequisite-patch-id: f5e3de6141e5637587010201301d9d72cd97890a
prerequisite-patch-id: aded4f4affa33b2b9cf3247196280dd1d293a058
prerequisite-patch-id: 9b2acb5e0e86ebb7c4a61499e5f429393692e370
prerequisite-patch-id: cb08f24e1fd645370f6bb82ba0886aa0aff83bbf
prerequisite-patch-id: 2f41ac08e7779c81fd8f101c8796e1613a81739c
prerequisite-patch-id: cf8b634831df57eb9db1a68642934844d28d528c
prerequisite-patch-id: 914c0f3b919369a63759101879ea37728706cca7
prerequisite-patch-id: 8d3e72411f2a3bd3c8ba3b5551b92ab177689d62
prerequisite-patch-id: 26b64e4869e65950cb4760a37fa2ba991d771c28
prerequisite-patch-id: 1859575bea729b23e4936e8ef875a9de0bfc70ea
prerequisite-patch-id: f494c8149085ecbc106fa7335aed94d31c02d7c0
prerequisite-patch-id: 40b847f228570992cfbbba8f23b15172df9ab52e
prerequisite-patch-id: f78efee71866139b424e27b803bee565742f8a59
prerequisite-patch-id: cda7b586a4ddbbe74bb4c4fc009d8abad8d4d8c8
prerequisite-patch-id: 6862c1fea0d7449595527d981e9b5b7b02869a14
prerequisite-patch-id: f5fb751bf87f37baef653ed4b377c5921eee01fc
prerequisite-patch-id: 8cf70f391bea57332e1213c6e886763f2bc041b0
prerequisite-patch-id: 384a60f2f5ddff6455dd7a0855583acc941b3f34
prerequisite-patch-id: 40db4cf493393f9144098482eade1fa86af02d4d
prerequisite-patch-id: 9cedf11607dc4cfca44ab5309444889bd4659b23
prerequisite-patch-id: 93d8536a3f2c81978b73d322b3e479aafadcb672
prerequisite-patch-id: 5f9c2f1b1e7d896c49b1b45a148f19b40b887248
prerequisite-patch-id: 86a2350095820314ff778c848669419975886370
prerequisite-patch-id: eabfaf40df547e88d3afe7cf5aa644fd23baa611
prerequisite-patch-id: 60aaecfd948b2cd54cbf1db649789170f9883002
prerequisite-patch-id: 161a1c31a55741b14613fcea7818746482bc7633
prerequisite-patch-id: 4be263ce33796df2b89b11a4bba1f1505840b970
prerequisite-patch-id: 85a0fc5a0963f2794ad148d33b23e8a6a7bf4209
prerequisite-patch-id: df6f925e58999583d8f26f4c6956c7e68d1a3ac5
prerequisite-patch-id: 7a817e7b23e1583e23dee2235be954cbdce6ef52
prerequisite-patch-id: 580827936003011c14917c4c2ebf302d1aaac3cb
prerequisite-patch-id: b4730418ea0df499c0bbebcf4d891bd32dbbcadb
prerequisite-patch-id: dc8277acf8a53927ef1ef35cc5e00753f2aa403f
prerequisite-patch-id: 9e3a142dee392a0ecbcc12784ccd83a709393085
prerequisite-patch-id: ccfb87f2935ec4d801f77def75803cfb8fdc3284
prerequisite-patch-id: c84ff30a6f578b641b7d9fc2c1a4a04925046c07
prerequisite-patch-id: 5bcce2542b9969633e0629f81be10dbb8bd692f6
prerequisite-patch-id: b0410e17e89b77719d801f6a86e367f9cda6524d
prerequisite-patch-id: 6809f0f4f5a657b6c6c69d548f8e5585b4aa3bd8
prerequisite-patch-id: f347001242aa07e52b27b4aac3bd51e2a9ccd969
prerequisite-patch-id: 2604b8e195ad9ad8cfa896e09d7d87c7114ad050
prerequisite-patch-id: 82625989e67c3c0a42f37f6148f108955330a3c8
prerequisite-patch-id: d7a34ae135becb97eeacaf6039295ed9c394cb26
prerequisite-patch-id: 3afe6b2a2fde5e713601b0df5d50435d40a3bb37
prerequisite-patch-id: 09aa6359e40fc4658db4581301a782e53c174d4d
prerequisite-patch-id: 3f833b1be3fb9890617802e28fa19e7383bb0d2f
prerequisite-patch-id: 509339bee2ca8da4bc851e29079a15ff81ec0c7b
prerequisite-patch-id: aa00b8e789f29936d2006cbdb14ba221a355d8ee
prerequisite-patch-id: 520064842ff26fb20a47399602ad2c1dab5895dc
prerequisite-patch-id: ffc71ff6ba4ff6aa165613420c94c2fb502083b4
prerequisite-patch-id: f53ec70257559bbd20d3d70426ebf32be55ee1fc
prerequisite-patch-id: 63f833233f2f563950f62e3ae0e738420e41e6bf
prerequisite-patch-id: a497894b0fe12ec4c52ecc6d1403c08d014f138b
prerequisite-patch-id: 0d38ff6d0fdb057d83749721c06d7e04156d53ce
prerequisite-patch-id: 2388b49b66051dc3120eca75d663dce059ce5eca
prerequisite-patch-id: 520f30d4408e1878d798cb4189c2496f63898147
prerequisite-patch-id: e675f425948372b45c2edc04fd050be960a551e9
prerequisite-patch-id: 0aa98f774107e4591a2afc12ba6be883c1a34e73
prerequisite-patch-id: b00b1f4a4213f6a58fc074088f414198d2eeabaf
prerequisite-patch-id: 17098f00d571080ebce81e0720ad4d9fb9aac64e
prerequisite-patch-id: dc2c08a314fc2bd9ffe05c9ff0bc8442079062fb
prerequisite-patch-id: d87f4aeeb50fffb2458018e8280e70d7bbaad859
prerequisite-patch-id: 6b5e2e247b92dbb307b67e2bdbc6558328119755
prerequisite-patch-id: 11889a6cee65fc3a250381045c120b39060158fb
prerequisite-patch-id: 6f3013bb99b7747c54488395d0ac815e5beec7f3
prerequisite-patch-id: 8fb5d94c890967f11c626e5a26aa50a7e87a0689
prerequisite-patch-id: f753b6aa34bbe6675a810aa7e9f5a46bd6f8f3f8
prerequisite-patch-id: 23e13c044f53fddead4c4e7906d1fd3d36f4a38b
prerequisite-patch-id: 671f9588d17aebb0cc3dd824df196dc5b11ddc82
prerequisite-patch-id: 820a1403805a5892a8cc524960a28c64f9c9141d
prerequisite-patch-id: 92c96e640574d9351f22854a926f3252047e2366
prerequisite-patch-id: 0842ca6be6e6f1516797be8445eef3db6da9191b
prerequisite-patch-id: 5e713ef45b4467792deed932f3c88cc28c65a87f
prerequisite-patch-id: 018699af6673b5e68f91b15f851085febe645de6
prerequisite-patch-id: 5a2726fd0f676d19f9acea73521ba303fa9097ad
prerequisite-patch-id: c9a993ef4a6ba2f497aff0c790fe68b6da1ff53b
prerequisite-patch-id: 536149fa9ba99fc70926409b736c6c5383f7896b
prerequisite-patch-id: 0c9a37733251c55d7e12cdf68403b5e5e0f424ef
prerequisite-patch-id: 2df5ee9c2ccd3a87f0dcd1b8b6c0e31899b8c095
prerequisite-patch-id: e6d17eea6658913932b1fc7bd4860a86d670b360
prerequisite-patch-id: 96ae72d3ad07fbc884a733d39e7f67b2f26be24a
prerequisite-patch-id: d6165a80a726f18e2d807b935e3a9778aaf39b69
prerequisite-patch-id: dd32309c586ea3322992a866b5b53aff74111dd5
prerequisite-patch-id: 3a98988c76cc915f621135bf0835951dc33022af
prerequisite-patch-id: ea9d299351cf85a2705ac042cd9a73a90f3bef86
prerequisite-patch-id: ee8f1635bb0961f027355d23bf28bf14bf945cf8
prerequisite-patch-id: c4619dd03f29f1b52694dbffb2d474c519a8cc71
prerequisite-patch-id: 1f6e4e43695fc8a9ba08962e8f6eb4113b24a6c0
prerequisite-patch-id: e01e23c6bcc7d5441aa58f3b7b92324d0dd261f3
prerequisite-patch-id: bede20cdd06b49f7f597feafaffec54f78bd545a
prerequisite-patch-id: acefd770d66151a76d2d9a0c24acfd8298cbf01c
prerequisite-patch-id: 25deaeae53c6ccde2dab5992032e0b0076e8ff75
prerequisite-patch-id: 3fb34ce6400e2ad5c181c8d74d8a868cef98f642
prerequisite-patch-id: ce7b927531beaaf400f212f4ea9278793e0e02be
prerequisite-patch-id: 4974f215f056d8c69066ed7dafc53c665f773bd8
prerequisite-patch-id: fd2d88bdc268b146f4c1c8b77f22f1306735365d
prerequisite-patch-id: 5410bd3eaa7b3cbf851cca45739e4f90563611ee
prerequisite-patch-id: 51602abbab6a2f787672464a0dc675a7a3a479ce
prerequisite-patch-id: 51b3769fcd6e6f646434e0892880d706ec51db8c
prerequisite-patch-id: 99586bd8c136330bae2cf184cadd6825ab9f30b6
prerequisite-patch-id: c1d59f2a4e0d37ac6d1a03fcf3754dd142df0a30
-- 
2.48.1


