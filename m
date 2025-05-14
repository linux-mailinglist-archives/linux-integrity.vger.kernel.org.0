Return-Path: <linux-integrity+bounces-6209-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76178AB6D25
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C91B61629
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8012797A4;
	Wed, 14 May 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7WUk6OP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DD15574E
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230404; cv=none; b=FxqpbXgfkRJw9vhQvLM3yNh8fDTKszhB0U5LJzheRCd30HmUwKJ1qX3OmknrpzT6sBGKuo5nr5ll/zyayiuUr1wJTn8tA27SIE9ichx7wQYWe46dUT7F8r1gvl6tTsnUp4FyssLSXQvCKYhVdPt0HhilYb/v36fYDAUO9fwwW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230404; c=relaxed/simple;
	bh=PSDzFJ6pwrZPT3XWZdI28VfZnrFAtzEea9+QlIcF/0s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NqA/Swtzyhzs34AGDC1Nw+MzziH0VFju5xMSbHwrhlEGEqrlpgClkRs76DAbvtv92CByhRU6jop2ExwOD5nekE49YT1FNipoGi74uqKlvO1BVeE+HWTwSDf1WzxoD/3o0idBbCWJi5B0m4hJ94cYu21keTGK3TYJ1MPmvnqYKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7WUk6OP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747230400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s6k9/GzU7jK7zlNovm76Gy0+NwNfyykNoxZQiNddalM=;
	b=f7WUk6OPTaxohewWw5gxTHFZdvkCSZyceI84kgDXAd3E9e1TERl327+MxD4HeaRblBcyTG
	75ZWX5kC//TL1OXPPsPZDnj6ZXSTf+BEbX0rDHieNIiUNNquBKpWbuej0K0GIaQUzh4TN5
	lcF+u62wreVX5tLVw4assxBQzvzy9zQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-RezocPDTOHayiLBPF-tsSA-1; Wed, 14 May 2025 09:46:39 -0400
X-MC-Unique: RezocPDTOHayiLBPF-tsSA-1
X-Mimecast-MFC-AGG-ID: RezocPDTOHayiLBPF-tsSA_1747230398
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-44059976a1fso23759385e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 06:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230398; x=1747835198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6k9/GzU7jK7zlNovm76Gy0+NwNfyykNoxZQiNddalM=;
        b=lHBZbOhV68c35rk9lxzOSKrqDmT/GyV8P19Smh3J3Di80fUx1+wHj9K8w6XougQKAi
         L97SW2TwM7yc+XX+oTa11mSPw39OBrBCSjwx6hbyFSZBgRYsumao5NRx10gAW8oIm2+S
         M4HSl6MWedTZzAr2kz//ZI/mtMnU8K+7sRIAE2pxglaXSscpqtd8ggN5mDelw+q0lavP
         OkrtDA2l7Rbamn2nr+zX9fVCkNihWIjPJoKGXA10IpTpyUUmhgmUeDhoFOQ4hrg6rmpN
         8HXMAFg+JjSwi0UuzUIdPxxZpckx3SeOTvThsPhphIthH24gYQk8cNdKRLIW1xxL8jpf
         8jBg==
X-Forwarded-Encrypted: i=1; AJvYcCVDcNgamZ7wVbFKG8Qa+06qzn7EHs8e7XO3sJeoLlMAa1PkbZFye67lewK2tYT4m/wvbWXyUlqF0UfP1XRd/Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8BUFl85quvfsyv1JKwd/OcALskA+glYLvgYiwcrojwvBD+5c
	elkYcvQDInFV24/uUgebFiNZygzQClEBOq+GDDBjbpPGjh/CCKUjIS7GdgaYlTQWs+j4Jgf1cTk
	5hjQl5oqk8FIElh7msKvd0PdCAwFG9eWk06Ew6AqTFvhLP9HFBgMAJoPTEUyhVsxHQg==
X-Gm-Gg: ASbGncuDJKIHHqQXj+3zJfp9wI3eYUlP8R/BDeV2m0ozOhMJDHBvnmsPZujynGeeRF2
	/mYsHW7HdMlMV0gFId8OFrMBGGiIzBw6pp9DVEgufo5ip6+L0NvrobX3lkOu3qmPu3SDbTyGQRv
	oKn0uq1vOfvNjjNner//vxr27otyFcry9yY0otSZfDz8jcBOqEKZlBJtlFvnA2MsI6nw88G/+lP
	iqFX7PG+xbbvynrvlGTeSAuGnViuRsRlFpL8kqVF72HJPzQDFOYm/crr/XkvCst/WrAs4xhqr+s
	ek1mJ0NdzEc9eNHKTJg=
X-Received: by 2002:a05:600c:c07:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-442f21690d0mr31437745e9.26.1747230397916;
        Wed, 14 May 2025 06:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY9vh+bpQG79sp/6DI8di3RxLNOV35Az0tewqTY/ffxwzq3/IqQ2Ik1HsPTwPjASd5o1gbLA==
X-Received: by 2002:a05:600c:c07:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-442f21690d0mr31437185e9.26.1747230397293;
        Wed, 14 May 2025 06:46:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.148.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951b62sm32993785e9.22.2025.05.14.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:46:35 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 0/4] tpm: add support for sync send() and use it in ftpm and svsm drivers
Date: Wed, 14 May 2025 15:46:26 +0200
Message-ID: <20250514134630.137621-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up to the discussion we had about whether or not
to add send_recv() op in tpm_class_ops[1]. Much boilerplate code has
already been removed by Jarkko with commit 980a573621ea ("tpm: Make
chip->{status,cancel,req_canceled} opt"). With this series we try to
avoid also the temporary buffers needed between send() and recv() for
devices that do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer like
tpm_ftpm_tee.

The biggest advantage for this approach is with tpm_ftpm_tee where we
remove the local buffer and extra memory copies. For tpm_svsm it does
not change much since we continue to use the pre-allocated buffer,
to avoid making an allocation for each command.

Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
If that flag is set by the driver, tpm_try_transmit() will use the send()
callback to send the command and receive the response on the same buffer
synchronously. In that case send() return the number of bytes of the
response on success, or -errno on failure.

This series is based on "[PATCH v7 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" [2], which is currently merged in the tip tree and available
in linux-next.

Thanks,
Stefano

Changelog
- v4 -> v5
  - changed order and parameter names to match tpm_try_transmit() [Jarkko]
  - rebased on next-20250514
- v3 -> v4: https://lore.kernel.org/linux-integrity/20250509085713.76851-1-sgarzare@redhat.com/
  - reworked commit descriptions [Jarkko]
  - added Jarkko's R-b on patch 2
  - added Sumit's R-b on patch 3
  - rebased on next-20250508
- v2 -> v3: https://lore.kernel.org/linux-integrity/20250414145653.239081-1-sgarzare@redhat.com/
  - fixed comment style [Jarkko]
  - renamend `out_send_sync` label to `out_sync` [Jarkko]
- v1 -> v2: https://lore.kernel.org/linux-integrity/20250408083208.43512-1-sgarzare@redhat.com/
  - changed title since we removed send_recv() op
  - implemented TPM_CHIP_FLAG_SYNC idea [Jarkko]
  - removed Jens' T-b
- RFC -> v1: https://lore.kernel.org/linux-integrity/20250320152433.144083-1-sgarzare@redhat.com/
  - added Jens' T-b on ftpm driver
  - removed last patch since [2] is not yet merged and will require a new version
- RFC: https://lore.kernel.org/linux-integrity/20250311100130.42169-1-sgarzare@redhat.com/

[1] https://lore.kernel.org/linux-integrity/Z8sfiDEhsG6RATiQ@kernel.org/
[2] https://lore.kernel.org/linux-integrity/20250410135118.133240-1-sgarzare@redhat.com/

Stefano Garzarella (4):
  tpm: add bufsiz parameter in the .send callback
  tpm: support devices with synchronous send()
  tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
  tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC

 drivers/char/tpm/tpm_ftpm_tee.h      |  4 --
 include/linux/tpm.h                  |  4 +-
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-interface.c     | 22 ++++++++--
 drivers/char/tpm/tpm_atmel.c         |  3 +-
 drivers/char/tpm/tpm_crb.c           |  2 +-
 drivers/char/tpm/tpm_ftpm_tee.c      | 66 +++++++++-------------------
 drivers/char/tpm/tpm_i2c_atmel.c     |  3 +-
 drivers/char/tpm/tpm_i2c_infineon.c  |  3 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  3 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |  6 ++-
 drivers/char/tpm/tpm_infineon.c      |  3 +-
 drivers/char/tpm/tpm_nsc.c           |  3 +-
 drivers/char/tpm/tpm_svsm.c          | 28 +++++-------
 drivers/char/tpm/tpm_tis_core.c      |  3 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c  |  6 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c    |  4 +-
 drivers/char/tpm/xen-tpmfront.c      |  3 +-
 18 files changed, 83 insertions(+), 85 deletions(-)

-- 
2.49.0


