Return-Path: <linux-integrity+bounces-4326-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D59EB370
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B27282466
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA71B415C;
	Tue, 10 Dec 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJEOmf1J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63081B4F04
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841274; cv=none; b=OYkiR5esD+bz4qzNmVF66/bKiDa1b1S9ppm/np/I4frOxMO46KKuv/FyyZs/huscJjf7kI6Hs204q3g3pguf33EBmGDwfy0V/jUSj6SYgLhEzv/gbgOCHRUyK3GL9xtWMefkHrSXmXdk8ucpaXmWByaFCvR39UZ/llvG66rpSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841274; c=relaxed/simple;
	bh=uMKjV+y0vw0lI/s9eg40DkNqUYxDUxLa948BBQpRy9k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DFeeIH3YNDAIn1ed8bLu3DZ1kSY3WnqYuon1VOYMvRClqXZz8UZrG3mKH8ZV7Rs3gyTP5COJGX4ruhDsHb5GNUspv2J+WjtWK7jyWdJi+veYEx2bPTq6fkYW0pEmFZBYogqROHN9cCiuJKd82kMiGUBRWzIdNMXG8VQszNZ4Za0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJEOmf1J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6y4zB+gmVHiAjEsX9Z/aEV1q2suQ7sOPckycItFYtA=;
	b=eJEOmf1JLY5AQLCPv/3Z1FIL3K3kaFnAIWmhXgAILVvc46udjBgnLptO/8mKp3uhUGV1Wp
	R9dZ7TXPIh0UIPE0VSlzA6BnkKQMB+cH755TGTZLy5FTj52x2vxfwRIUwUgx/Cux96W9Co
	mjsmVGohzL3esIfG6RezP344dVf9p1M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-K3wiNKdsMk6EHXBUGgR36A-1; Tue, 10 Dec 2024 09:34:30 -0500
X-MC-Unique: K3wiNKdsMk6EHXBUGgR36A-1
X-Mimecast-MFC-AGG-ID: K3wiNKdsMk6EHXBUGgR36A
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d88d56beb7so68636126d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 06:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841270; x=1734446070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6y4zB+gmVHiAjEsX9Z/aEV1q2suQ7sOPckycItFYtA=;
        b=EFC7r8UaevtATqkFx6de8FjV4OPpSXVa+eoyldXjq8P8LxKBGfDHnpz1ur/Pb5SiIt
         agmH87X+b8163iJTzAQkVPcXRe3vqSsnP2mZQwstHOK/31nsioAlhh86zRW0cZt94r4W
         smWN2b05eR67vU/s8zhq50utJ5M7uOS95EKcTyqr2Uy9bHlH+vTWsAYOVF5BUad6rG2p
         bZbNAqr+/AbAASvGe+dXDEwQ8ybEjYG+tnrjMg7ISb8Is3YkDvImie28DgY+Rkm4diAu
         IqxHEH/IQrIEuxjDOkEJvGG9ywQrGuuK1i1ImYM/neibKnf/2hIYtByR1/asWJfr4DFB
         ntjg==
X-Forwarded-Encrypted: i=1; AJvYcCX23zcLst3cCf12sHjLDIkAGjF15Dq4CU5hkH3IM6JZJ5/ZEocnrj/gssSXKL0+NXaLMKIoPwpihYAOevch0GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmnqart6xbIYbeXl5mPTpqter59q9kpEhcmF0vVZOPWoqEoXN
	mxH9WFMbFUfaZ2XlBWQx5H8J7eCT1YUO9cSiOHSAHsaSgUIMcVn2ApFn+ngIdoHbL9FToFHRK4N
	+M480u0FR4lH2ZoK+Wp33ZA3OD2IiTxYEFUPSTpzoTE6ReRpabCVXPBZMS9WinlcwDg==
X-Gm-Gg: ASbGncuHy7S38eQyjtVQZNuTOC1NyQsvqIc7sXJDqUhGfRfS+uX8wLyf1WQ6dob2jj8
	0g9XHaI3osZTIeRUoOsgOKyb4MTUL3GetU4ZWQGltbT/vOWwcBuHQSLDEXDlhl8ZRss4ioR4CCA
	KY8VK3B3Lc6Hr8RIe7qr7RijwDbmKWnajqn02iwgfnT5xwU5Q8Ux+Mh5UKEr0w+RNbg7c8CwIzX
	Kkma3dHcDjFSfwZBoTuU1paeV23WJU7DA7rGgMALWFEgj5ti1kit88Ea3dGI1M2EZbaDIOvSeQb
	EKLSRSkhpqbTfJPYBUpkil2wd+WbwdA=
X-Received: by 2002:a0c:f68e:0:b0:6d8:963e:b4d1 with SMTP id 6a1803df08f44-6d8e712938bmr286517576d6.18.1733841269593;
        Tue, 10 Dec 2024 06:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb1UuAaUO1dNhz6MIRT9Wbox0HH0LaoGa0cAYrefMbWoSKlNIt4gnd75IiJHTIIYA0QEBmcQ==
X-Received: by 2002:a0c:f68e:0:b0:6d8:963e:b4d1 with SMTP id 6a1803df08f44-6d8e712938bmr286517086d6.18.1733841269102;
        Tue, 10 Dec 2024 06:34:29 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d91e1080bbsm12723146d6.55.2024.12.10.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:28 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/3] Enlightened vTPM support for SVSM on SEV-SNP
Date: Tue, 10 Dec 2024 15:34:20 +0100
Message-ID: <20241210143423.101774-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on the RFC sent by James last year [1].
In the meantime, the patches have been maintained and tested in the
Coconut Linux fork [2] along with the work to support the vTPM
emulation in Coconut SVSM.

The main changes Claudio and I made from the RFC are the following:
- Used SVSM_VTPM_QUERY to probe the TPM as Tom Lendacky suggested
- Changed references/links to TCG TPM repo since in the last year MS
  donated the reference TPM implementation to the TCG.
- Addressed Dov Murik's comments:
  https://lore.kernel.org/all/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
- Added a new patch with SVSM call macros for the vTPM protocol, following
  what we already have for SVSM_CORE and SVSM_ATTEST
- Rebased on v6.13-rc2

Since all sev-snp dependencies are now upstream, this series can be
applied directly to the Linus' tree.

The first patch is primarily designed to support an enlightened driver
for the AMD svsm based vTPM, but it could be used by any platform which
communicates with a TPM device.
The second and third patches, on the other hand, are specific to AMD SVSM.
They use SVSM_VTPM_QUERY call to probe for the vTPM device and
SVSM_VTPM_CMD call to execute vTPM operations as defined in the
"Secure VM Service Module for SEV-SNP Guests" [3] Publication # 58019
Revision: 1.00

These patches were tested in an AMD SEV-SNP guest running:
- a recent version of Coconut SVSM [4] containing an ephemeral vTPM
- a PoC [5] containing a stateful vTPM used for sealing/unsealing a LUKS key

Thanks,
Stefano

[1] https://lore.kernel.org/all/acb06bc7f329dfee21afa1b2ff080fe29b799021.camel@linux.ibm.com/
[2] https://github.com/coconut-svsm/linux/tree/svsm
[3] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[4] https://github.com/coconut-svsm/svsm/commit/6522c67e1e414f192a6f014b122ca8a1066e3bf5
[5] https://github.com/stefano-garzarella/snp-svsm-vtpm

James Bottomley (2):
  tpm: add generic platform device
  x86/sev: add a SVSM vTPM platform device

Stefano Garzarella (1):
  x86/sev: add SVSM call macros for the vTPM protocol

 arch/x86/include/asm/sev.h      |   4 +
 include/linux/tpm_platform.h    |  90 ++++++++++++++++++++
 arch/x86/coco/sev/core.c        |  64 +++++++++++++++
 drivers/char/tpm/tpm_platform.c | 141 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig        |   7 ++
 drivers/char/tpm/Makefile       |   1 +
 6 files changed, 307 insertions(+)
 create mode 100644 include/linux/tpm_platform.h
 create mode 100644 drivers/char/tpm/tpm_platform.c


base-commit: b8f52214c61a5b99a54168145378e91b40d10c90
prerequisite-patch-id: 95e8dd63b084c02fdfe348efa34781a0b74afb8d
prerequisite-patch-id: 562e39c3b9f951d505dbc05b37648b9bbd4386f3
prerequisite-patch-id: cc5511b814bbfe8eac62ee4461819874fe78063b
prerequisite-patch-id: 0bff1adbadf180086405120a5985a4cd67c1b7f5
prerequisite-patch-id: 1ec0a087ab0490c6e80a2f230b987a84f9eed524
prerequisite-patch-id: c22127c6217174c2164a00ec24294d6a5212f45c
prerequisite-patch-id: 43debb2c202f464334fdfe10e48b2c45b140126c
prerequisite-patch-id: c07e855fa49924cb1e027b216318f73da8d6c411
prerequisite-patch-id: a8f4c0894f898a6bc377b1c8a37754f958c84fc0
prerequisite-patch-id: a5511799158a1b1910d8afdedfb9e7edf728c0a8
prerequisite-patch-id: da66073f285179d73c5c2f08eb1eecfdd4807658
prerequisite-patch-id: 9f03269789347a15a67e15dd8c08e2607a91ddcf
prerequisite-patch-id: 7419dd222300dc3aa48d0c81f512474787f579d0
prerequisite-patch-id: 603aa385aef8e442726f3b732a3f9a0b63bfc5f7
prerequisite-patch-id: 9b15d1f577671f0e4d75d69565ea0691b38f471c
prerequisite-patch-id: fb3191af6783ede5bbcad3d868aeaf3cc90ff7ff
prerequisite-patch-id: 5fda5ee841e48b5f7ac9c1d6e4828c10455eced6
prerequisite-patch-id: e1cde7169faef9c4129f1f9ad8bccf9eaf6f211e
prerequisite-patch-id: 6f3f0bb50eb15bf615964727a6dffad68f4cead6
prerequisite-patch-id: 52fa9e1afe9914b81dda5214abc240a3248f48a1
prerequisite-patch-id: 1b728e64eb425a11f73f87d2fa1368d7d36d8657
prerequisite-patch-id: 366b0263fe31fa11db9791eee64ef97d843af80a
prerequisite-patch-id: 54104cd96f2891870a61335109dd2206d402c27f
prerequisite-patch-id: 24ee2965a654d36f03449ee3ce421b8927d043e7
prerequisite-patch-id: 037d0567ae81177ed282f3037a6bb8e833dfdf3d
prerequisite-patch-id: 9d79c95b05f4c611d8461965ca941ca960475b70
prerequisite-patch-id: e176bdfce858effcb79ff1b11e7a20a57ec4cc18
prerequisite-patch-id: 8ecd889a3ad8f5c737a69ae6e216a3e2eb3a114a
prerequisite-patch-id: a4fef48beab5d5ab1858bf40dc542bb1fbb42017
prerequisite-patch-id: 9b101918d6bdb3d8680022171f1ee25a28c3248d
prerequisite-patch-id: a512c92723cde3519e6c26c2816fbb4b708bf0b6
prerequisite-patch-id: 2dde60edf98a200d67bd8df69b46b21019be2ed2
prerequisite-patch-id: 02b11ff2886ed3b1a55661b90efbe47041c21ea1
prerequisite-patch-id: d3391b7c5a1af0ecd2bdbd051981707b3faa32f4
prerequisite-patch-id: 90813b319fb95b6c72a089d2e74da54782a24a27
prerequisite-patch-id: 518f728b831d855b5abc0a10c5985a5ee8a9c83e
prerequisite-patch-id: 07ce94fb0696a02befc5a092721303ce00873ef8
prerequisite-patch-id: 66b8f73f619cb74ddd682e32d57e7750b85febdd
prerequisite-patch-id: e70aa4172ef472645ca9960b3695e9f001a53fce
prerequisite-patch-id: c2c2c26506b2fff6c3d0d8b2b450a685ce03fb18
prerequisite-patch-id: aa16c93dadb90dc631432590983358bb75ba27aa
prerequisite-patch-id: b19cdd775175474fbf7a01140c18657db05c2407
prerequisite-patch-id: f59231fc95a6d92499fa560075f6f24e47277121
prerequisite-patch-id: 7fc55ba6258280eeb4ab42521be980428b57719d
prerequisite-patch-id: 787688510b08b12c9bd8b467a1b49e1ca0ab3f5e
prerequisite-patch-id: 6a2af85c68d66b3472a6debd2ef3191b68287e4b
prerequisite-patch-id: 9bebc718a3132f595e69e9714ae8d2023016756d
prerequisite-patch-id: db3c12a2f165e8a4724f4b0f7faab14f45528ae1
prerequisite-patch-id: 1ea04c3d13d9ca162ace68654b39186f30165947
prerequisite-patch-id: b83a79a4d039039c81a11d00c0549f6bfe56d78d
prerequisite-patch-id: 1ffc404864a007fcec9fee62e2ab1999a876382e
prerequisite-patch-id: fed3707bef1e516735946416a416ee50bbfa3d0e
prerequisite-patch-id: 626f4a7756165f2abcd88d5315d9a3348b68c361
prerequisite-patch-id: 07fcc622f2d8eb1040a8bf2a1d9b864413814925
prerequisite-patch-id: 06666eba9fe30d8adaaec27e38fa7342f68f8078
prerequisite-patch-id: e933816edb8b44c920bc512fae109543841e4a3c
prerequisite-patch-id: 16326503fba86075d6c8db4e88bff1fef260a59f
prerequisite-patch-id: bd6f14b6526ea1fb568856cb2c4a495e0de1a3b0
prerequisite-patch-id: b007f3e58a7cc9d86fb7625bc5af24320bf57d72
prerequisite-patch-id: 07ef994dacff3a872115f13308eea89ddf868860
prerequisite-patch-id: 03afd3daf1dbc523f4702db797924c7fce9b5363
prerequisite-patch-id: 3936f6ae3277276ec038a4f1ddac4efe0e68792f
prerequisite-patch-id: d89f512dc22e5ba119d7eef9dcce0029445b3553
prerequisite-patch-id: 0efd291fb6f06ba8721def39ccec3760d5a8b7b9
prerequisite-patch-id: 4324d1f2e902883a2bdcaec5bade163d51a5645e
prerequisite-patch-id: bc80a1e0bb8526e28311435ab8da4a0827aa7b85
prerequisite-patch-id: 4a619aa2c30b7cd0054eb3e6727bf321fb83d0a7
prerequisite-patch-id: f8365d4d92060912a7f10dc9bba3d92794cdc059
prerequisite-patch-id: 0251bf1dd83fd8cd13e6d32e41b6b0afeefe80f3
prerequisite-patch-id: 1def8af563a357166b3d101e280c4f158773b7c5
prerequisite-patch-id: 97ed9a2a5a07e3f55054296fc7f45699b48b53e1
prerequisite-patch-id: 7b227e22eff7112028576165ba5534de3cc3f112
prerequisite-patch-id: 767ae9a3ce4e94bff6b09c9645ac1c4ee9dfb8c4
prerequisite-patch-id: 6909d6b811bc73010b9cd651af2e9ba41865415a
prerequisite-patch-id: fed3b79d588528cd03babdcf24acf84b6f5c39e0
prerequisite-patch-id: 1358f9c39dd8bcd819b690373d121117072539ca
prerequisite-patch-id: ba6012740c1b0d3cefd6160efb973bc5f96eec35
prerequisite-patch-id: 63d1a4e72653ccce46f0eda00761d685b34226bd
prerequisite-patch-id: ebbc1aac33dbe217c8db6ccbaf04f18741e4162e
prerequisite-patch-id: 796081c09da24f9d0e76c07f08311eb81892f2fc
prerequisite-patch-id: 5d68aa911dba90fd44b5919a6c4f815b09784cba
prerequisite-patch-id: 0ace7958b54780e0da340d8b636fae8e3531328d
prerequisite-patch-id: f74d7c7e628eede4aaf6517043c6a671000b1fbf
prerequisite-patch-id: b8952585ec51ae807458c9077eb4400a25ad7b27
prerequisite-patch-id: fcc7c93f37b7722acbfb19695b3a8fb30b6e5a84
prerequisite-patch-id: 3bf566ccc9ee3bee26181ed7a9ed53b78bf8f5d1
prerequisite-patch-id: 35c7cf2a1e58e988913637639da07e11a87bc9d2
prerequisite-patch-id: e814feb8f90263b42881abfa3c9a0c8a95378ea2
prerequisite-patch-id: 55b92c661518843311f11ae401c279273dee8d75
prerequisite-patch-id: 3c11637e9bed75b01f2e4dc776c7bc6bcc999680
prerequisite-patch-id: ab2359fb36a6ece5bf847db74fc62e25305d9336
prerequisite-patch-id: fbd2586e1874389ca532c48ed652e52055f35bf4
prerequisite-patch-id: 25527bc2da2f368af37f0f3591d7ca2c0101c51d
prerequisite-patch-id: 33340f985b2775fad48b17188d63d253199e1acf
prerequisite-patch-id: b26b23b56d84661c342696bebcb4e46cebeb675a
prerequisite-patch-id: 1d5f3291b3d42b56bc8def073e24563974d5af15
prerequisite-patch-id: e60792810dff7795fd2cf4afb6b12d57139503a1
prerequisite-patch-id: 6dde39817ee40af91670c738691e2fa7c9f57139
prerequisite-patch-id: 4a3929c853e35761885311bf636217bbf14014e6
prerequisite-patch-id: 938cc488c9c45d841b6c1bd48581419001f559f2
prerequisite-patch-id: 4497a1cee56b2a42b117cbf84beab4cd33c33634
prerequisite-patch-id: c6bb659b17af9a96afdcd0e547cac98cb01f7a8f
prerequisite-patch-id: 5a3d249d134f68bdbf8c2cbf38aca3a3a9d8c56f
prerequisite-patch-id: a0cc6e292b1d7f490e1ea0b8d429c3404d9b1602
prerequisite-patch-id: 0811566ede59aaa224d36da0881eb1ea133a3a10
prerequisite-patch-id: 6e63b48bba6f9809770a3803f9384239c0ae1b76
prerequisite-patch-id: d3706dfe8a7c084b7b58f78546c604954dc8338c
prerequisite-patch-id: 4f4f0c2c0bb2ba9aae3bbb29cd65b9fd5c5aa699
prerequisite-patch-id: ff9915259f492458914d1a99f4cef0017caef306
prerequisite-patch-id: 74add493070b81d97259876ae39ab1cfb3ebb3a0
prerequisite-patch-id: f25bec82d9f1a3cc37bf63e2c3b342eb03d87d46
prerequisite-patch-id: 1d64819c65073070c01b34745cf635f9eee34a1d
prerequisite-patch-id: 9cc5f2449ba87827bbaace7107fe1bea5b159313
prerequisite-patch-id: 49f2e76cde57d8d5810c5b9d9ec0692e3655433a
prerequisite-patch-id: 75b729cdcfa6609476bedcf1c4e40bfe9f56dba5
prerequisite-patch-id: ed6b718a2f239ee3ef791ef12ce78f97ded9a291
prerequisite-patch-id: 9862b013b14d0b54ab5fee7bf4f06b8bfd0214e0
prerequisite-patch-id: 575ab5dceb5c42fa0d12fe79d50cfb9efbfbbf8b
prerequisite-patch-id: 604df1b88328faada4ee0b6b6c7563ed6dce469e
prerequisite-patch-id: 7975710aeefd128836b498f0ac4dedbe6b4068d8
prerequisite-patch-id: be0a697a84c0d9842ddee1f1e1560f1590ba915a
prerequisite-patch-id: 4e7ff453616c4168e907575998b086d38ecb407c
prerequisite-patch-id: acb038051122bc4fd2e4ab0be9450bc0c9d035a3
prerequisite-patch-id: b7bd97ddba2b4d83196a1cb7f2ab827c8c50aecb
prerequisite-patch-id: a7ec68be2db89de9a39aaff64792141c6d1529bf
prerequisite-patch-id: a11f4165f6e1445b74cf94a0125b4d2034e6290e
prerequisite-patch-id: 80eec4eec888f758003c5c3d6858fd5f0aa00727
prerequisite-patch-id: f725d08d6e95b600f2b0f9e965e70c5788f7a183
prerequisite-patch-id: 4704d9888723321256d511d3ac770e1e63e08775
prerequisite-patch-id: 1ef170065dc72a7576f95a9b45818fb5bcba6731
prerequisite-patch-id: 3dfea2a4fe6140102396f9dc4857d62d71ecbdb5
prerequisite-patch-id: d2aa746113ab7eb28ae4d596c5a72f35080bb2eb
prerequisite-patch-id: 73d2193911720abc83a6215ff554e60237bdf73f
prerequisite-patch-id: 97c1478023bb75a8e8bff20e0c15703a0195fd9d
prerequisite-patch-id: 67d1ea61a1ae24239654ad99d78601b0414c9ba1
prerequisite-patch-id: bce377617c5374ee599c1e0ae415da4902b76f3d
prerequisite-patch-id: 3c296327d4be4314a7853f6789c2e5454e4e1c14
prerequisite-patch-id: b825ac875ce36195e288ecbb0b5f5aa34aef3c5f
prerequisite-patch-id: fe5f451479f651e320c0d8d2d6a08dab5cbed948
prerequisite-patch-id: 2863bf682276e1a4590b3349242f27a6582664b6
prerequisite-patch-id: 3d62c79bd49338f16309e4f04247f4bbcfa2b6a4
prerequisite-patch-id: 30ca1ba984b9788fb1b525e0594f195d456eb00d
prerequisite-patch-id: 849083eed82ef0197a4be3ff7d75ef60ea7eda7c
prerequisite-patch-id: d88c4b834c27cec63123f322adc3b7585ae19af2
prerequisite-patch-id: c1cd04a0a220c50ac211eb521626a3ae08d06385
prerequisite-patch-id: adebf8b7f71339c1242b0071e5fc72646b497ec0
prerequisite-patch-id: 902d971b351a83a8693c87e5d931e51f3df69563
prerequisite-patch-id: c61fdd1ee7c9013140579b1eadba66b9c3618f49
prerequisite-patch-id: 6679facaf9992e375df36a4487efb1873cdcafaa
prerequisite-patch-id: ab8153866360e973d8624617f05627ef3cefd581
prerequisite-patch-id: a0fdb008db2fccc7d1b9093ab2f7d4601d9da561
prerequisite-patch-id: f35d881003fd88bbc86c76ce9d0f3d64c51495fa
prerequisite-patch-id: 6ac4400b52cbaba598c3d1f9d3b705d9ffc0662e
prerequisite-patch-id: 099943631e047356e42a83272345b764db64f079
prerequisite-patch-id: 557c46c50cf74807b4d03020eb10012c602140e6
prerequisite-patch-id: 4eb7632c1b95bef720115ccc06663d55d32f6cb7
prerequisite-patch-id: a57bb65f01478f97359a622275744dbe6947fb39
prerequisite-patch-id: 243c94721a58f28322ef00ae78135b3157f32bf8
prerequisite-patch-id: 31d75258e4a6364b2db5c331a2519c4c20d4383b
prerequisite-patch-id: c8f42d5280a92825df331d21d4da828f10f03865
prerequisite-patch-id: 716cbcceaa606b2d785d5face527c506be324047
prerequisite-patch-id: 86b83051c8ad033e1ebcf874e4a486158954f9e5
prerequisite-patch-id: cb8a8f87ae6796e88e66c6c25e88f85a139c0d43
prerequisite-patch-id: d31827f6bef0bbfdec40a63630f4c1aa6876ed34
prerequisite-patch-id: 3728677ea70297b5af4e175340f97c4238294c1c
prerequisite-patch-id: ffd916a933d55fb312ad03d3e50aff7364babe61
prerequisite-patch-id: f1dc2dd48bbaf7fb6ca93f69353180b733e0f0d5
prerequisite-patch-id: 2ddf5627a98373eaf096dbcb7759ba1b8182de5d
prerequisite-patch-id: 386cc5fd09a8a21d7e4d4499446b96de7d267c0b
prerequisite-patch-id: d119afbdf8659e7b30fefb256850b86f29ebbaee
prerequisite-patch-id: b0b9241e57cba965cf53b3aea73dd73b317d8c21
prerequisite-patch-id: 320e5aaa176fee06a08de42c76ee9d7362e13470
prerequisite-patch-id: f65814a8f6b81868f8bdb4c619741bd9ac5e900a
prerequisite-patch-id: 0b5bd4f23803ca71a3e01c57b99b1a64cb6e8ca1
prerequisite-patch-id: 13bb5b6ce2435f2f61f5532b4c93807df9d872f9
prerequisite-patch-id: f70cbdf6b574a127248ec13206e395f2ba964606
prerequisite-patch-id: 2b8208f48a83e5e3733ed1c3aaa53958b1c7de22
prerequisite-patch-id: 24f3d42a71addc4d035982fe836508a62d814b5b
prerequisite-patch-id: c8906a2a653dd3d4c34da9a8ab068591baeda197
prerequisite-patch-id: b462ddcee3dc93e308dc40a07a8fb2bd396316fe
prerequisite-patch-id: a884c0dffa1e91a3e652fbb25c45fb7c54c71fbd
prerequisite-patch-id: 871191529f426ccbcb577968f5418b43a8dbec43
prerequisite-patch-id: 6ed20db6f1bd13ac5bf8b938333417cae84fe9eb
prerequisite-patch-id: 2a1bd712eb2c8d0d489c168738088ce1ee9c6017
prerequisite-patch-id: c669eb214136b7b310bffb8355e75b35d67ed544
prerequisite-patch-id: d943a15e9ff80498367695110ca969c7c3dc1dde
prerequisite-patch-id: 22a82ca73b17f65dcb89366e79d749a708ecd8af
prerequisite-patch-id: 22b49704f98c14a8750bb257af45523e0397b8ab
prerequisite-patch-id: 0933e66f19f9799825d5223fecddd5cc58496207
prerequisite-patch-id: c4aee9495f9e91b89e3a2626e1d71c0b71de721e
prerequisite-patch-id: 3cffe3c9401acc7ba9d249d66d48ab6287bb8a8f
prerequisite-patch-id: 76b834a2b8274d3b8e712087545a69b6884cf083
prerequisite-patch-id: 317c79d67b7b1a8c314752599d7501499301b3d1
prerequisite-patch-id: d08cc0ecc791dc9ac3a07154a65c8f80f9483d34
prerequisite-patch-id: 23d1374614207c22ea72cfe3073e548165acb8e1
prerequisite-patch-id: 04ed94f8c62a7524db009938d564e5b2620fbb54
prerequisite-patch-id: 6e1b84c631d2b86514ead675d0f2bd7d8a26e09c
prerequisite-patch-id: 1b801583e4de13fc82d072371d6786abbcded031
prerequisite-patch-id: b15cfb413c6a9ba85cde93135eac4edb0121d8a5
prerequisite-patch-id: 3512538974e969c5c0b841477fc09ea4541c80d1
prerequisite-patch-id: cb3eb091ea423781ea3d77132763a57831c44dd5
prerequisite-patch-id: fcf4e8688158857c753a685fe050c1612e3d780c
prerequisite-patch-id: 0df4aac304c2909c76bb5cc4d90444fdfea0b4c8
prerequisite-patch-id: e4680a6b2e91ea77e4581e21f931f34641c502e9
prerequisite-patch-id: 5d7c0e895f765c59aff9ccff526544cab30b0b9e
prerequisite-patch-id: a5d104d14ba9a460133674971c6ef3db7dd75a56
prerequisite-patch-id: 048c6780830d7c4a7e163ecb72da94ae0316e4b5
prerequisite-patch-id: b6b9a08762c5c03a4e61afacfa741f7e429ddff1
prerequisite-patch-id: d295e56d1961147cf09bbb13b90ff1563624eaa7
prerequisite-patch-id: 02786bdbf29873049429973ae6a723662ae44d26
prerequisite-patch-id: 244b54ea6cf0dcc14923b4a62c6f8cc0067eb14b
prerequisite-patch-id: 96cde472042eae9ae97d86fca584c9a8e815eeec
prerequisite-patch-id: 9408551071c33d7cef53bd3b90e0046a5e6b0f97
prerequisite-patch-id: f59b552ac61999553987dc764d2c0c2329250e6d
prerequisite-patch-id: 2399623a1903e6dfca6966806f35206396c482d8
prerequisite-patch-id: 0cc9f7181d936daacdf021a56a53cec9b645e71e
prerequisite-patch-id: 889c36737da30c718f45da4028b72c1ab85082a2
prerequisite-patch-id: 515a939952707f2bc213bd570c13f7f291d2287e
prerequisite-patch-id: 30e597ccc6b2296c8342ed6e3260a01493959f12
prerequisite-patch-id: f85115c6506ed8ec3fe724c9814e7aea5d5e6f12
prerequisite-patch-id: e6ffcf08e2e62669d6579cf7b423014975d8d111
prerequisite-patch-id: dc151e6fb1e9a425aa4f5fcf1cc7e938fc47f0d3
prerequisite-patch-id: b6a5c08e376cc8d18994e5b3cde2d1a5ef90cea1
-- 
2.47.1


