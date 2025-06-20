Return-Path: <linux-integrity+bounces-6481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3CAE1B88
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAA33B89A8
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CC28D839;
	Fri, 20 Jun 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhOrnrZe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE528CF75
	for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424908; cv=none; b=OaGa18lQiLUTUQhmWo9paCKQglxB+NFrDwM49Db1wmQensiG48QAFcPzl917vexhrcefbSgLZXFmZEAll4OzdSgCdlhw5bxDdHMaBgq1f5znVRfhtfMltSfN5OsOFtZU/OiFoWJbTdl+LG3pkhFMNikXwhpRooyb1qp/dq7lG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424908; c=relaxed/simple;
	bh=/eRyrPSfVH4pb56171VjO8PcLakHMAQoKvhNZP2d87A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dLbMJI5iCZ2ksrLclSkVy4wbCtvcIZCMhQkP4a74d8AVtTO+l+AP4a82rCrHFBaumYIVSoMtRoxAqP0jsl97lh2XgtBIEDQ5rHEoxci5oag2oaKn8sIDRAlLDLBYKh2BHN2Inzdns9lgRZy69CtXc4fMtHxqXaKZs3wQEsjdYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhOrnrZe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750424906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=efezj3LnMENDrFh/B5S35gvfWn7TvlAanxYCoetZO3w=;
	b=BhOrnrZeqFQT/RphKQgy1jZE58cRPgjN5Kxtrru7d7do2NIWl7gO73iL3bftk+Za961Vfd
	NuRlfBRG5GN/LMbFsjngz3MxjTnqvfLFAYkdyF73gQSKmM62XlYoQXJm+sQZ0+wzlkG98W
	gIoMVWHNVLN8eYJ2P3a9lQAnR+Y2Ayg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-UXiOEqGoMtWxDhhW1bn9gg-1; Fri, 20 Jun 2025 09:08:25 -0400
X-MC-Unique: UXiOEqGoMtWxDhhW1bn9gg-1
X-Mimecast-MFC-AGG-ID: UXiOEqGoMtWxDhhW1bn9gg_1750424904
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1055979f8f.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Jun 2025 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424904; x=1751029704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efezj3LnMENDrFh/B5S35gvfWn7TvlAanxYCoetZO3w=;
        b=qiKY5q/QFQx5qUTyrwdW5hVP9ztabHnRGkO3vtGs/2oAgcQGJ/mk5yjOxVyRhqrEP2
         tUZvvrj0B5rZMO9oclg59wzkgTjM7ucgGyZIsm3Xl8MAzTFXGXwVHF7s3eez22mVQ+3N
         Old8yTIdJxVtjUi+1JfZ8EZGvNP98WuvrCwflNxN2tmOhVZyHb7el5AwCfuOqxX1sMc7
         xcmsKKHyKqIO6DEjFD8EPsH/2Z1mnPorbIQtIrXhZfoDNq2/H2ptnpVSnPpnhp8VjiSk
         0bXa2Cgyo6RqJM4M82ya0F+Nk/yJ1W7Q7v7NO8QL1jtsBKEJtfXn3icsCZIPRcR/EwSF
         /whw==
X-Forwarded-Encrypted: i=1; AJvYcCX82aOCcW0epqGuhlx2M+zxhzF5J0DkXsEQ+7KOntaLZMcFO/0zAqhCi6WWe8/d5Czz3nuJ7TnjaFPTts5n7sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNRTptv1x+9SnRwMok2svZXXq6mlA8rAfM31TQvf6XYOc1x3C
	aHXr6GrOqUfaCEPYHLZuno/Msw6RIirBonHoX0+8hiKymdv+8HGwuv1kJEo85pvPPj3967me8rS
	ThA8O3Udmho1BfBYLpMq2xZyanDvBKZGQYXJhPN9ZiYSlKSNzFhL6RGpXewaiw6vPe1Hd9A==
X-Gm-Gg: ASbGncsfsIen5Nc4P3a2yItPEzs5pAJ+auQeJzfnls5iu/zV5P6GCbl7Wwo4tkBq7Ps
	GuiMWb7QjYNueA7GDmrHRmk7YhCwuVnPxzAf2DWFwZnKpB4aq1kgazSp3Junm2kAqVuop7ey5qW
	Bx7clVdMVfgSQxYFHiGq3suLlPJVSARyHEDQF/JFQpxAevLVTfUwBy7P/hRq0tdbqPco0+39Kbi
	9zSF6YtVd6tJvx9szWI2GN4Ji4VU8hUQU6ofwsAy/8fzghWsGw5+w3Z9yAbLcjswPFwqHQU714W
	nbJjhZnw9CxpGiHPQ8N0ihJwgTDAnEoWl1I=
X-Received: by 2002:a05:6000:70d:b0:3a4:ec32:e4f3 with SMTP id ffacd0b85a97d-3a6d12e8d73mr1963680f8f.17.1750424903402;
        Fri, 20 Jun 2025 06:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQvIvRiOMOwY6vcPGATBD4+Ygw2boYIIBCDTjikBg4YIpBv3nF1VGt1H//5h9pdOChc4ssw==
X-Received: by 2002:a05:6000:70d:b0:3a4:ec32:e4f3 with SMTP id ffacd0b85a97d-3a6d12e8d73mr1963604f8f.17.1750424902439;
        Fri, 20 Jun 2025 06:08:22 -0700 (PDT)
Received: from localhost.localdomain ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19f9esm2059296f8f.39.2025.06.20.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:08:21 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Naveen N Rao <naveen@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 0/4] tpm: add support for sync send() and use it in ftpm and svsm drivers
Date: Fri, 20 Jun 2025 15:08:06 +0200
Message-ID: <20250620130810.99069-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The content of this version is the same of v5, but rebased on current
linux-tpmdd/next (`git range-diff` on v5 is empty) after the merge
window since tpm-svsm patches were merged with another tree, so we
agreed on postpone this series, see
  https://lore.kernel.org/linux-integrity/aDCb-wkHGoLQ-IGg@kernel.org/

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

Thanks,
Stefano

Changelog
- v5 -> v6
  - rebased on linux-tpmdd/next - commit e271ed52b344 ("Merge tag
    'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")
- v4 -> v5: https://lore.kernel.org/linux-integrity/20250514134630.137621-1-sgarzare@redhat.com/
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


