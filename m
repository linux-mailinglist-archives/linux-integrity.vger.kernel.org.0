Return-Path: <linux-integrity+bounces-5658-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE1A7F7E6
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039D616C36A
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A6263C77;
	Tue,  8 Apr 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKXtyMia"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE22331F
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101139; cv=none; b=oBjNL8LMZZ6cT036vBlXEB+RYPZob+JAJsc5nNyuxynWtxibLoKA+bCew1+O1LnQigkP6ji771SlBcmesZjxc45vT7yFdkPyghanrcsr5h3s8/ojfYHNBFYyRt5CAw9pHjg6PsrA0wjAt4zWN1W50TYY2TVWcudm0LtVf+ZEoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101139; c=relaxed/simple;
	bh=2Y87TIxXN/XvT2IURIuS2iDT3aQt1SdJi1elLOjKyXU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HWQuq/D3YkiL3JfqpIY8iZw1L24hIn8NfS4Agrc/MYrO24zJ21LNfw+HOmRxtjGgnbnSkdA2G4WEHH+aZe3CD4OYPJnt/I2AfRr+5a3c/QLuncuGGxZGxJGJjtd70TKnbQWAHml0LGjXis2gybVykBUfrUa3AS4puKWl4ZzqPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKXtyMia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EIgGazPnpY83MOYPFrpriS6Ll9aCnAeY2hjvoYNgsGQ=;
	b=WKXtyMiai5K4vzbls3grfRFXwTBB7mtcbplya3DX81QMLNZ8PCHrbbiYl0JuZlJ8P8PfF1
	sG/a7dsac9tYnouEi2t2uSaR8VmOt9tDAU/+C/TjTDx3kEvn5b5OOZA947s47du1cyTnXD
	kzKbOzpEMPdidWc0unSI3+FZIUYT7Co=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-PDtzhCIoMrqy_afGvQBOOg-1; Tue, 08 Apr 2025 04:32:13 -0400
X-MC-Unique: PDtzhCIoMrqy_afGvQBOOg-1
X-Mimecast-MFC-AGG-ID: PDtzhCIoMrqy_afGvQBOOg_1744101132
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso66374845e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 08 Apr 2025 01:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744101132; x=1744705932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIgGazPnpY83MOYPFrpriS6Ll9aCnAeY2hjvoYNgsGQ=;
        b=wup8aSY2Bq+idN+eFn8BJ1O5Dtm1YUFz0IMFJ2HjX6mb50UPpDTp63nF6Vqi6VFKjC
         DSoSt7NYGZn6MhYTqMzVopLhY/m5xSrpoC49pVUweikner4kCsZgDb0xF239JDKIUxd4
         kN6/VU3ikMDMp1aLLtpEa1IZv28mPA9Gd5HJewNIXKmsD3jsiyLodIVtSFM6RkTMRdHK
         sOeOvFUat/D0MmSKOGvhDVvSAvzMoLmyCV1wlKdWzrLxfY57EVj4TTj5KKaDg/FFmwuj
         vTLEIL6MCmpT459apqxmypMjoYU576JPQq7wd368eqmdFKqXSRELKihMC2tP3iwY6daP
         JiLA==
X-Forwarded-Encrypted: i=1; AJvYcCVnsUSu1vqGrGjX4fGq3iWqPPzl/+kmN/OCor4DFzB2B2WeE8HXHXxWRatqVVVVOi1b9m9hsj/WJGiYa+0n030=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7SYAC2Iv65T8PuNXbJdnqcZy+WlrnBlOGftC07ajGMgO4OxG
	Jg65/TiGipeRHOQ0p2Y+kwfjpZTMCQQT5ZNmg57bzY7VhAi//GSbgUA3Qc3W799pMWBhv6I9zyD
	Kokse2k02JC0A0pZbuR7xQmPZYlwqwaQfA3j/B15gpv/ngqxRS3kTx8YotayzTWJxTQ==
X-Gm-Gg: ASbGnctxEDQrpiqS3cdJSsg+HFp4Mu6KhYiq9z6j7vgdG1ecPXhjvaasGspX4St3DVw
	MbgFzdQrhCpLBgugCF+X3AJjNHMU29NXJ9eZt/dDK4wdseysIMejEwEH1OCT/NftBKRnby58DRW
	g1Kurfu4CqAd19C/4evAee+c4zJrcYmfMQE3pZDQUhYc4IsArzIc7N1PbKaE7n0pyjjx3Fb2vO9
	ENg6XBRYFI36GXHGv1RFUS6qc90CwCRMHhl5OSnklYs3F2KRP5FW8S9inUvw2U/VaYRaW8mfB/q
	SmtHSHNT57APnOAd7/Fg1jtRnHrY14+yE86c6+gnqtnm2Yg5NAFCIkPjr8GmhlyLxw==
X-Received: by 2002:a05:600c:b90:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43ed0d6aba5mr130770525e9.25.1744101132334;
        Tue, 08 Apr 2025 01:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgPkhOboJZ733S4u0DItGfgIvyrdGzL+Nsa1iDulpOSNfq/oW82+ZuG+Ms69bzenXSEUjucg==
X-Received: by 2002:a05:600c:b90:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43ed0d6aba5mr130770015e9.25.1744101131821;
        Tue, 08 Apr 2025 01:32:11 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d6b1sm14361605f8f.62.2025.04.08.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:32:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sumit Garg <sumit.garg@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/4] tpm: add support for sync send() and use it in ftpm and svsm drivers
Date: Tue,  8 Apr 2025 10:32:04 +0200
Message-ID: <20250408083208.43512-1-sgarzare@redhat.com>
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

This series is based on "[PATCH v6 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" [2], so if we want to apply this series first, we just have to
remove a hunk in the first patch and the whole last patch.

I removed Jens' T-b and Sumit R-b from RFC/v1 since we changed the code a
bit, so I kindly ask if you can test/review again.
I left some questions on patch 1.

Thanks,
Stefano

Changelog
- v1 -> v2
  - changed title since we removed send_recv() op
  - implemented TPM_CHIP_FLAG_SYNC idea [Jarkko]
  - removed Jens' T-b

- RFC -> v1: https://lore.kernel.org/linux-integrity/20250320152433.144083-1-sgarzare@redhat.com/
  - added Jens' T-b on ftpm driver
  - removed last patch since [2] is not yet merged and will require a new version

- RFC: https://lore.kernel.org/linux-integrity/20250311100130.42169-1-sgarzare@redhat.com/

[1] https://lore.kernel.org/linux-integrity/Z8sfiDEhsG6RATiQ@kernel.org/
[2] https://lore.kernel.org/linux-integrity/20250403100943.120738-1-sgarzare@redhat.com/

Stefano Garzarella (4):
  tpm: add buf_size parameter in the .send callback
  tpm: support devices with synchronous send()
  tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
  tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC

 drivers/char/tpm/tpm_ftpm_tee.h      |  4 --
 include/linux/tpm.h                  |  4 +-
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-interface.c     | 20 +++++++--
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
 18 files changed, 81 insertions(+), 85 deletions(-)


base-commit: 92d2673cb03c16e47d7308dedad6ff3bc3d117ca
-- 
2.49.0


