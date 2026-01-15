Return-Path: <linux-integrity+bounces-8241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E19D21E26
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 01:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F59300E3FB
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5221A2630;
	Thu, 15 Jan 2026 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVUYvSdL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmZbf6IK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC805533D6
	for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437818; cv=none; b=jYGhdWNjE5q00ewt/ptdNGgt1NE7QeAaY7KGmOD1gimG3BnU90NL69ZOGeCzMUqqpJ+LQ5TjIA7x/X68gK1bfWwUmtkBjCh9emrmfyZoW0wq5wPi/lMZ0TcmyzW3XzJqaz2EHf+rPie+7SnvJcTNevM2eJOXf0MftgAsSI81oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437818; c=relaxed/simple;
	bh=Kb5q8aUeq7GVGIsCQlQn4N/qm19FJT+FjvKp8v5sDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAu7T56d6su9ONya4yQtu/pfXU9gHR/KXtTIjhCXDgyRZBfUu7nu3R5Us3w1xYo0jm2I4Hi5Nr2TfVoP0fVaFOMToCf0zXJO1MxdaTnnwdIwD2FpRhDZdMieHnMo0C2Y3evN7Kgz8HRrlS77bUV2WcP03BZIM2zVe/Z2Wsiom5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVUYvSdL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmZbf6IK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768437815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ec6x8/FVpvY/DiC6562FtGhoFmeN9phav99UKp3puAI=;
	b=SVUYvSdLOSapIFRrxv3GXPSyqfhEqACTFU5Kf+DH/6YsTSidZXKEvz51kOXD92tJ3LZn/+
	hGnYQtDEpwpsBlD+f9FgwRdH5SFi3rpu/Q2EIoU4eY2PWraQUbucESs1u1THo75zzUyCe3
	Z30XJfZLp70WFvjbrkVHaI/MQ3I2zac=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-R6OKqdQkNnCoQPG4i_Wr0w-1; Wed, 14 Jan 2026 19:43:34 -0500
X-MC-Unique: R6OKqdQkNnCoQPG4i_Wr0w-1
X-Mimecast-MFC-AGG-ID: R6OKqdQkNnCoQPG4i_Wr0w_1768437814
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so329075a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 16:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768437813; x=1769042613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ec6x8/FVpvY/DiC6562FtGhoFmeN9phav99UKp3puAI=;
        b=KmZbf6IKByFhdfHcYz/lb+O5z/QLy69ZWM2DlKSbTDVYwzzzAumsSc14w5ELCXqNZ1
         PW+5h8oI1Mm9dds92mk1Rl9O9u7/YiFH1leQ75p8yTWPfTi2m4uaOlkDnrz9hzKMq1+D
         rJjJ32XyVqZO3EgiE+5uWcp6U8TxJiG/Q7SwZyARns6VlBMp4nJHwouK7tIfpbNFsgOj
         Y+KzemfzLyUp+4gVRKIh7wJHEwzatmdFYMKcjSVVRuepAnkGgrM04jjSg0UNG/GD/Fq6
         KaNGoXm9Si+ADawkG6Jd8pinMmEhSEShoHCQp9E0fkBGwhick7pEVG7Y7/LKz6AqjlQb
         kVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437813; x=1769042613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec6x8/FVpvY/DiC6562FtGhoFmeN9phav99UKp3puAI=;
        b=cUBUDpY97VEokja7C1lahz7ogVrHxEE1X6RedPuZj3MbbxZ0XYdO3KQeTaMh34uo7S
         GBZspXG3oWc5BuVmhBNrd7Hez0ibl8kjand37yWBs56/UZBVYYFmkCltqMRPwETPcbGg
         qoDmYL1NFrYaKgMg8or84S0th20kfdFeCrIsrn13gxhLKVgYmDkpTqMgxsPCTxz2Exem
         jnxrcaoj7MEb9j6u3Og7ouY7cc4N8YsEtWk9p9Jz3WoJF2BQTkUvLjnrxRWlPTXVgQAH
         jUlZbONMLZB2OXCwayNFcOQihiYjI0yDRtwwCVh5gnoEUNYW9rgE086hGggiJs6ashy9
         qRwQ==
X-Gm-Message-State: AOJu0YwEXu0CMjpA8RxLNi6kpGaLDQnXESmyROn756U1FQKq5T4bjSpv
	8Gc+qOVkJSwTUYXpc/sVjgYlIhnqKF+CqBbo1shTvnVenOroX+OSxtYzDGkWQTnZr30Fq+jETG6
	SDmYwVj1Rxcm3/0TvnxCS+xJO8ILOslcQLk3966Pot4Nf50y7HITVp/JDGL25Z3zgT/k0MMAxXg
	EDGDyV/JH2wB5aiGx98jvpbSntl5plyypbz/LqPo2RF+q0tOoUIYI=
X-Gm-Gg: AY/fxX6RSQhz6aN8UHeTv2LttIrMxAmZ8DMHQXzYTkcJu7vy7g4w5UXnoOZ5GV6z3cE
	hLlsCmrgjug+nUpt250+mwRmr4MABm28PRfyTsek9/2I8RZEFgyy/aS1i2G3QdRMxl6k0Ijez8n
	L8xbSbdxrrzxirpH/NI5lcg/hIac8gstr+Ax1pfVu7HQxDTEDV6K4G6XIXtxTkYhSxDpO8wPDhZ
	YERo0z7nb3djb6+GdBBBmM7cE1DmNVWD6uEHwcUJPeqc89eo82xsYorjRMbKb2hP+p/Qi11c3D5
	zscGEX2nxKNPZO5232zH+p3ygExfO16PT7uZgF3r1dpK+4jZlFCV5ql5pAzBwD30fBZumqDXChA
	7
X-Received: by 2002:a17:903:11c3:b0:2a0:c884:7f03 with SMTP id d9443c01a7336-2a59bc12d90mr40657945ad.44.1768437813195;
        Wed, 14 Jan 2026 16:43:33 -0800 (PST)
X-Received: by 2002:a17:903:11c3:b0:2a0:c884:7f03 with SMTP id d9443c01a7336-2a59bc12d90mr40657645ad.44.1768437812489;
        Wed, 14 Jan 2026 16:43:32 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2b4dsm241973605ad.54.2026.01.14.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:43:32 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/3] Make detecting the secure boot status integrity-wide
Date: Thu, 15 Jan 2026 08:43:22 +0800
Message-ID: <20260115004328.194142-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EVM and other LSMs need the ability to query the secure boot status of
the system, without directly calling the IMA arch_ima_get_secureboot
function. Make arch_ima_get_secureboot integrity-wide.

Coiby Xu (3):
  integrity: Make arch_ima_get_secureboot integrity-wide
  evm: Don't enable fix mode when secure boot is enabled
  s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT

 arch/arm64/Kconfig                            |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/kernel/Makefile                  |  2 +-
 arch/powerpc/kernel/ima_arch.c                |  5 --
 arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
 arch/s390/Kconfig                             |  2 +-
 arch/s390/kernel/Makefile                     |  2 +-
 arch/s390/kernel/ima_arch.c                   | 14 -----
 arch/s390/kernel/integrity_sb_arch.c          |  9 +++
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/efi.h                    |  4 +-
 arch/x86/platform/efi/efi.c                   |  2 +-
 include/linux/ima.h                           |  7 +--
 include/linux/integrity.h                     |  8 +++
 security/integrity/Kconfig                    |  6 ++
 security/integrity/Makefile                   |  3 +
 security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
 security/integrity/evm/evm_main.c             | 24 +++++---
 security/integrity/ima/ima_appraise.c         |  2 +-
 security/integrity/ima/ima_efi.c              | 47 +---------------
 security/integrity/ima/ima_main.c             |  4 +-
 security/integrity/platform_certs/load_uefi.c |  2 +-
 22 files changed, 128 insertions(+), 87 deletions(-)
 create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
 delete mode 100644 arch/s390/kernel/ima_arch.c
 create mode 100644 arch/s390/kernel/integrity_sb_arch.c
 create mode 100644 security/integrity/efi_secureboot.c


base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
-- 
2.52.0


