Return-Path: <linux-integrity+bounces-9592-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJWSLAIuC2plEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9592-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:19:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D956FC8B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B893009CC4
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBF3750CB;
	Mon, 18 May 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZWgpQ1U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zol8llln"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B931B80D
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117457; cv=none; b=lmBVavDZ0vCtARu8RaxyGlzLkfziehbF/cvGi0F/ut2MWbDkYKXn3vMWSrENgqtUNtoRF0LgBmS/tnpSyzmNVIi3JWem5XK8rsdx8lWLzMvyoArKwJlqpaeZUaV6OpcRTLddP8zB8Y9wA3Cge5sMVtkOpkajvkGQg35V6EsXeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117457; c=relaxed/simple;
	bh=XmotWqTzaBwjT4mG51oc8AMNQBgqW8+YP3N76ZYRhs0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tfdSVOf5FOR697akRLpEk6UumUmY1uiqfCyuI5UubSaKPgiioFCymw+jUIZSYd+ar0Mb/M3dfQKxvJRrc7lOAQQ8vNB282eesFdDjiQzbbkjP/bhxh3Z6bEylmbJ5caKuRxy4oJDGuhfjx0f/3vsxFvCZqO9IszQW5ruj28zkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZWgpQ1U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zol8llln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EUOqhEXYSCFrJQVtrLFbBts5i90fpDqStr0HkixbP94=;
	b=AZWgpQ1Ugi7uznVdQzotJsLOBsTh4QsH2ugI/mwJIlb9FqNUl5mYfNUq5GosL2XLF3RfRu
	eeduwxg6iBo1p4ibjKgx2yYG13IVEXZaVZT/1L2duBoO+EaPwQZrJoCDauMyYXQ/WVPsGg
	8lJfs1GkkWtaEL9KYgziKgVmAvJtoOA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-x09UVfxSOBiryXLfYn-oaw-1; Mon, 18 May 2026 11:17:33 -0400
X-MC-Unique: x09UVfxSOBiryXLfYn-oaw-1
X-Mimecast-MFC-AGG-ID: x09UVfxSOBiryXLfYn-oaw_1779117452
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so3365618b3a.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117452; x=1779722252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUOqhEXYSCFrJQVtrLFbBts5i90fpDqStr0HkixbP94=;
        b=Zol8lllnOQz8DGhbEC5d6NptEFwEIs1UCfbmRIlRNEWz1JGVopE6VidyrQIpV500T3
         IrBZdRG8WswoMLO8wwRn//GHKq7vhK/3+v9aFAjql8NUm6Ipv0AelEVpRX3Id+x8XPca
         paf5M+mL835wL9s2FZ7JSRowx2drR43rAMPQOzi/SPDCE+6Qjs9Qyo0In33df/I4l2lG
         YWnfDiq2krttrr2qPNZVXxi8F+7IsduQ2smsP4ihGcMOxhgHvhZSbfE48dOeK8zQNeO/
         JqCHI/rGMZRiC0v2Mm8OTYysI+eh4KnCi/bATRW9eAMaP+bhFMbctwo/VcB5SLaCdscc
         ZUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117452; x=1779722252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUOqhEXYSCFrJQVtrLFbBts5i90fpDqStr0HkixbP94=;
        b=f1HwD03zuEJYtr7ZgCErC/TrNMKW49j1woIDOEhcY/sOOLA/HNuM/iIjIChn0iApiG
         T8Y9VFZx6gx9h/nVzyOI5XOPVDBcq5phuf2POXbtuuGyTK4AA+93664XEc8hwZnob16x
         un5NpE7r7iigpK6ems9WPFB5/nhfbV6Fwel8zChG9Thi72/aNBzXupg9tbVFliWRIL+l
         gJoH83gtL7MlVliZrlOSMQRgZDFonHt1sZNIrT17ouayPQ/Ow2oH83bRUD2/aSKiN/rK
         ndQcwWRpL0LHPyovejcdgRuGv+7rqVgv6jd4RI8Ur8N2Lo8YYhUZo0g+HdTbpaD6Xajg
         dUfA==
X-Forwarded-Encrypted: i=1; AFNElJ+iXbHFy8GblYLMhUYGxxzh91aHa6ZwwfPSf0AD5QH/BIoeY+wn5ItPgkWX6If1Lopw7Db7D4w0Vl+DiyX4Y0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjeiqsVqjEVPaEw9WB3/5jjDuUTNLRSNk6nKVNSS58DmoKnYCi
	VEd6Dcd1kOSTWmPgqZjbYR49eShySbJuz3lrSsVbvLN8Dwc+dCA5Y+7kEFTV0hsQK60IpvOt/Uq
	2hGMfaViJUcnEiirgXehAwQGNind/tn+jNdIAH+VnI28RzEEf6pLh5J4iDh7UAWRav322pg==
X-Gm-Gg: Acq92OFyiIOcyQxsgdA/pZGqH8XseCY50rn8NHEX7uZ6c2i+vP/LE0kPDk9/7utQBBP
	VkW6wOFUeYO/X0eKjxN21J4QU5XPs7jGriG5daQrBi3sNUPaatK/SnnMenByVoD2TwQvfMlK4s3
	gNk+1OnV+fsBjf85aCJJtrTATNYIgiIksJ0ZFPAJSdji89UVazFGsAqFlNdlPIVYWDHAKsoj4Ot
	SpgdPJwqHOmzoM/HRX4U1O7qacJCL+tRpe1RJXpJLDI+4xuUX/B3KXc7xli1u9MMVWFk/Cc28r1
	CXHX0w/Gs2XadfDT1BHhYa3OdcTXS4ZjkHQdUxBL7S/xVOH6nLhzYT+xpdE6CO1Qh8Ppy/AOTPi
	4r++c5oXa/2oWsDCjg8lv50ekAvKvbax56afblPWtnKby5WJL9ufRsxzZgz0G+TyyONoj8iusYg
	==
X-Received: by 2002:a05:6a00:1406:b0:837:42a6:58a2 with SMTP id d2e1a72fcca58-83f18ef9d1fmr16583389b3a.35.1779117451960;
        Mon, 18 May 2026 08:17:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1406:b0:837:42a6:58a2 with SMTP id d2e1a72fcca58-83f18ef9d1fmr16583337b3a.35.1779117451185;
        Mon, 18 May 2026 08:17:31 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 0/6] tpm_crb: Add command and response buffer chunking support
Date: Mon, 18 May 2026 20:47:18 +0530
Message-ID: <20260518151724.730443-1-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9592-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 259D956FC8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The new version of TCG TPM v185 [1] supports sending data/commands in
chunks for the CRB (Command Response Buffer) interface. This is in line
with the initiative to support PQC algorithms.

This series implements the logic to send and receive larger TPM
cmd/rsp between the linux guest and the TPM backend in chunks.
Currently, the TPM CRB driver is limited by the physical size of the
MMIO window. When userspace attempts to send a payload that exceeds this
size, the driver rejects it.

This series introduces chunking support. The driver now checks the CRB
interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
backend, the driver will slice oversized commands into MMIO-sized
chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
with CRB_START_INVOKE. Responses are also read back in a similar chunked
manner.

If the backend does not support chunking, the driver retains its legacy
behaviour and enforces the standard size limits.

This feature also requires the QEMU to interpret the data in chunks and
forward it to the TPM backend and subsequently dispatch the TPM response
in chunks back to the linux guest. This is implemented in [2]

This series depends on Jarkko's unmerged patch from the mailing list:
[PATCH v9 11/11] tpm-buf: Implement managed allocations.

Depends-on: <http://lore.kernel.org/20260125192526.782202-12-jarkko@kernel.org>

The whole series applied on top of for-next-tpm branch (with prerequisite)
can be found here:
https://github.com/armenon-rh/linux/tree/tpm-crb-linux

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
[2] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/

v3
--
- Split patch 2, so that the code is cleaner.
- Re-order the buffer size adjustment patch.
- Rename crb_trigger_tpm to tpm_crb_start.
- Add dispatching logic in send and recv functions. Chunking is
  separated from no-chunking for clarity.
- Increase TPM_BUFSIZE in the common file include/linux/tpm.h following,
  [PATCH v9 11/11] tpm-buf: Implement managed allocations
  https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/

v2
--
- Add size checks before copying memory.
- Update TPM_BUFSIZE to 8KB.
- Commit messages updated to indicate motivation and logic of the change.

Arun Menon (6):
  tpm_crb: Add register definitions of TPM CRB chunking fields
  tpm_crb: Split start method into a separate header
  tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
  tpm: tis_i2c: Use local 4KB buffer to limit memory usage
  tpm: Increase TPM_BUFSIZE to 8kB for chunking support
  tpm_crb: Implement command and response chunking logic

 drivers/char/tpm/tpm_crb.c     | 257 +++++++++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_i2c.c |   6 +-
 include/linux/tpm.h            |   2 +-
 3 files changed, 204 insertions(+), 61 deletions(-)

-- 
2.54.0


