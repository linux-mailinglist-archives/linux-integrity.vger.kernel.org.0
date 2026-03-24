Return-Path: <linux-integrity+bounces-9061-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLnFCS/UwmllmgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9061-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:13:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369231A8D7
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9102D3047A73
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6138911A;
	Tue, 24 Mar 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdP7bUuO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o/fUXNCu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D23932EA
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375977; cv=none; b=dbL3cCHOcgLplNmVhDfAtFtUugHC6vNYzzFKxbFyAezei7JlMoGjd9FidKjV8yzqcxt/EO49pT8WtOEQzveoHhppb945OS3ByfvGStsE+lbPq6ISA+GgI12p0tHYCoLPWmpoBkU0VPRUhMH1gf/17BXAcqQ5GX5VlkkAmt7VQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375977; c=relaxed/simple;
	bh=WeNCUoEkhbHBR1L+eUPV0IJb754Qql/HDyY7uARnIF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWRr1QgDsF4fqcUAqF6D7Ehic03UJFZN9u9o0Acfu3pvo8oXx4qvVDqr/Ktu3pMFY8oA4MalGLs60hUd5wdcOqZotJtgauZs9DLiTmXblNDKDLV5yPSgek5eQ+tGisQorHTqb1brS0gr0j/1NrpRLRQWC+iudaZJKCGgoM3L7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdP7bUuO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o/fUXNCu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax2GNDsKFff6oK1rOIrS956WsnSbTzO+ePG1MDmG/EM=;
	b=HdP7bUuOmObMfdEhsLAT434RjDqD8uqjSqORrHJIP2/N0iTUHXNOsH1mOlYyDwP1+zsfEV
	D7jXpiBLiTJfjTWrKabmWgXx+CTXgSbw7Ih35VcfIkOuksMtueaB+3jNg6h12KB4fXBU13
	IXmDtn65yIzp8FwmCqlgbSN2GASeowM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-bC6_HjtTPtWhbXjPXq8yPA-1; Tue, 24 Mar 2026 14:12:53 -0400
X-MC-Unique: bC6_HjtTPtWhbXjPXq8yPA-1
X-Mimecast-MFC-AGG-ID: bC6_HjtTPtWhbXjPXq8yPA_1774375972
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829b7ed8964so4267745b3a.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375972; x=1774980772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax2GNDsKFff6oK1rOIrS956WsnSbTzO+ePG1MDmG/EM=;
        b=o/fUXNCukz0oq2pcfG7O5/H9EIYK5EMLPnqfPdR7vLKX3nV6BvG/2L2/AQkMkl3thH
         K0AksKgY9nUN+NnuPd8L1FiaYztvZlNYaHCPSj7kF7DC5AMK9qiord/vM1ftGr6OBMFc
         yeIbC5ZxoWn28I02pzwwjRxoZ+P4cIshoLPXFjxqxLoxUW/0zR3jbkCs3Ac/hlOd8wrI
         bYRvfI2BHCVDI8VVKKbqQWD20xYfM+Ij25j83NlzJu+iomTTWhK8uHi3C/fQP8LX0IQ4
         1N1bM0EQvTCZ7wNGMR+HrgJ98jCHs8d583jMmYHFSkVU4qZNfWZeSwlvME8iRxMSBeUU
         SV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375972; x=1774980772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ax2GNDsKFff6oK1rOIrS956WsnSbTzO+ePG1MDmG/EM=;
        b=DJKXo9q/+nxFEJcRma/t9x9KDwSoQXyuu0IKeBiV/lcnTOo5GPaOqXdcoE1Ky5FXHj
         lrta+kEfB/lyEMMPUoo+A0YaMkS81Vfu0iPQ7WrZ0ann6W7T54dkU+gong6YqGfySm5x
         1CzVfsOZYC74OkG4rEspLMNcsQXGztw5W80FbP0AOwulSOvLZW9PUTjFQpFg30HkGq6C
         jPKeonsCdufE/tX4yId5Q0pfzFWTx776aiL1WvkUX3YDaBGzH/XO84GIKQCpLEdp9vuh
         Cs/SuTCZ7kutexOiHiTbc/Evxbhc4T3kc0SJz7SxAxCjZWbnjJthRxLRC8N58lymKbg0
         pCKw==
X-Forwarded-Encrypted: i=1; AJvYcCXtNGcXPSmKpj07KcQquh2Tp2PTn2zG+lwSEUFEWbRJU2pqyxIWALjTWrSBYC4khRZxK8rLfVUjMUlzuX++sY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5FJbnpBy1eVtW7PpO5gGPURkEdKxW3nq0CCky62yQUfTOOFC
	dE764YPdxRUJMsaR1yFJZn6CkTdECV6vPHqjioiKQSi/hoiZsBHv8+/O2orhbpVWQCRP4CSO+4c
	OITilirFX6dl5L6BcsQsTITkKm/n0GF9xAQqMLTthBBL6g6CqiWJQSBtmXAZGzsNHdoQyIuriur
	CJnQ==
X-Gm-Gg: ATEYQzw0QNUTxgieoBEO2smDVGbimHtYZSvWjjgAU9kpgXjHqrsPS/1FtjBik4QgOzk
	pkD56M9FbO9IIaQlUD6guTCn5jNGeUIy0TL/U+poYquFQG7908JIkJGbnGlpbRCcO4CwDfqWFAR
	hSW8BvsXVFwa5H8154VLqew3+NCHh0MrFeDFo+cu9+1JahT3XlcboYmuhzyTgI3QfL/sSD3p1p0
	CaS6SFOZ/sPwuKno+YAhwoTuSy5czJbaQVBR9r3WIUbqihM8sXw87T4q9cTFqc8Naxg6sKijaNg
	H+IIo8UbwpjVv8X3UpIhTvWHwOrGUuj8t+g9HyHHG760t1GXe+iAp981Ztjs4LVL+UxjINOtXdF
	CjXvOgnUHtfAGBcqjOZz9bF8FWadBiB9AzcELbZeSHQ8iZQus2G0A5kllsgzWmQ==
X-Received: by 2002:a05:6a00:2185:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-82c6e0eaf1fmr501988b3a.39.1774375972164;
        Tue, 24 Mar 2026 11:12:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:2185:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-82c6e0eaf1fmr501965b3a.39.1774375971745;
        Tue, 24 Mar 2026 11:12:51 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:12:51 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 1/5] tpm_crb: Add register definitions of TPM CRB chunking fields
Date: Tue, 24 Mar 2026 23:42:40 +0530
Message-ID: <20260324181244.17741-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324181244.17741-1-armenon@redhat.com>
References: <20260324181244.17741-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.de,ziepe.ca,redhat.com];
	TAGGED_FROM(0.00)[bounces-9061-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	HAS_WP_URI(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9369231A8D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Post-quantum cryptographic (PQC) algorithms can require buffer sizes that
exceed the physical capacity of the TPM's Command/Response Buffer (CRB).
To support these larger payloads, the TPM 2.0 CRB specification [1]
allows for data chunking when the physical MMIO window is smaller than
the required buffer size.

To support this protocol, the TPM driver must be able to detect the
chunking capability, and signal the backend using specific start
method flags, also known as the control area start register bits.

As per sections 6.4.2.2 and 6.5.3.9 of the specification document [1]
Add 2 new bit flags to the existing enum crb_start and add the
capability bit.
- CRB_INTF_CAP_CRB_CHUNK: A capability bit used to detect if the backend
  supports chunking.
- CRB_START_NEXT_CHUNK: A control bit to signal the TPM to consume the
  current command buffer, or to get the next chunk from the response
  buffer.
- CRB_START_RESP_RETRY: A control bit to signal retransmission of a
  response buffer.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 6c25305c256ef..67c0061d4cab7 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -56,12 +56,18 @@ enum crb_ctrl_sts {
 
 enum crb_start {
 	CRB_START_INVOKE	= BIT(0),
+	CRB_START_RESP_RETRY = BIT(1),
+	CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
 	CRB_CANCEL_INVOKE	= BIT(0),
 };
 
+enum crb_intf {
+	CRB_INTF_CAP_CRB_CHUNK = BIT(10),
+};
+
 struct crb_regs_head {
 	u32 loc_state;
 	u32 reserved1;
-- 
2.53.0


