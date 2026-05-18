Return-Path: <linux-integrity+bounces-9593-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCWZHhIuC2plEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9593-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:19:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2B56FCA3
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0694304D25F
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D367375ADE;
	Mon, 18 May 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnbh+kV8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oJ/toitM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201C36DA14
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117461; cv=none; b=SWwhkMdjztcbsyL+oSQmAPnoUwflH+fViAvxag8/AaPDMKilO9Afe0ZL3PFq0VccnrfK1RBB0gNFo6ATWhWuXxQtq7/KjOLOYOvlanWWaArvJnYoRvs6wPLwsdzdOakAXhavWHvaPoVRgmQtPLepnKN8zOMPYyEJdfEs9baGsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117461; c=relaxed/simple;
	bh=X6H9YMI/G5UD7SgY0WhWwEquiNvZiLCynZ0Ng09icf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8xqEJgFyQI3tDUcBYNE0/Eqo0MtTZG03FztuzspK4AYhxAj7AK0+HVUVOtd1ePBsYC6k4pBmYyyCcnFN+hyN0ZkN8kMP0e2m3RWeRicXkpR/nneRwtowmXqvYMJIOYz4FrxKR+G+ZcvBTlf0u5ogzwsCGTT+d88QcnSYDOOSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xnbh+kV8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oJ/toitM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
	b=Xnbh+kV8IpLdPr8QStOHpyllC8mAfj5ZOLYWBnfvBudPgxMe7kbougBeYXkO5HxXTLjOGz
	VeW/2uzI3TCfc9VQZeU6B6rz9pgysdFHtHeUuWpwxeHdIKEspcRQfvY2+7CijtOt/EHQb2
	LJcPNY3p3m5gdR56xxZW0GoX7s9cQR0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-OXvIoQk6PTC7CCNXk1CyQQ-1; Mon, 18 May 2026 11:17:37 -0400
X-MC-Unique: OXvIoQk6PTC7CCNXk1CyQQ-1
X-Mimecast-MFC-AGG-ID: OXvIoQk6PTC7CCNXk1CyQQ_1779117456
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-83544d05c5aso1164200b3a.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117456; x=1779722256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
        b=oJ/toitMClugy/eelXYgGKrBfPskR2J5S08VH4f4H75GaH2w0eiwDreTSSsHn6XK7F
         rt2kIo05CUlhu0j0MF4xFdyW+O3Wq4uxkf5YMgvuISOl7zVvnlIhXqUbXsGgXcZbM6vy
         EgJkx8dk0DnpZgFnnorWAlHJA6TNgE2PLrkfvCyiqri7lhdmwLE9jgiNST6gl5uR87gv
         ulozZ3oOBD+gIU9VVfpJXBByXOkPYafbZTVV9o8sHv2nV9QqIdSFT9oPBplD9O8Om2MK
         AGxvvEou2B43fal7Opu11B47egANWPa2nKwz84PHm309NLUo5L4Dd0stX3B1XdPWI4vb
         bQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117456; x=1779722256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jtzC8GOmAvHT3XfNpHE4tG+IxT92XswAdGYofHiX++Q=;
        b=hkxODzkSu0cZq2cmMXhs47uqdFjO2cnIbVDSmc51Z3AtEei0imEKXsJZh2hFpp161Q
         5LiO196/tOOEZqQgruE/PDJQTeZhj9S83Z14u1SXsDYRnzztKXHKNhNHaQVSssjHJWDE
         kHwQXaKUYFalbG0QNYhiqGaJEvfRb9f0AiEi6l06AwLlAjkZvh3RU1Kc8FCsS+UnqHVR
         +ddCAdYePuyGR191+GX8D7dqMVeUnQmKPStVZjI+5nFPb0mhXJ7pm37MK7Y4bSCGqPSJ
         fSN5D3KBLlqSfsRz1gzQXX4dTQqrT8xl4CP+OptUsaKYWAfANfYl9Ans6H8upiayXgdB
         scvw==
X-Forwarded-Encrypted: i=1; AFNElJ94qYN67ae56zxrMQMrpKS8wsEhNETShwLka/k3RRe+ZdRKudlWbuaaNGklf0+Sqd+9jX2QFOTECyUQjdkzVHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCZOC0yXR+2JyJceAQ1AjbkhaUCdJlJLuJAq87K78j79v9Qlv
	7hEDQxgQMvMsxNbxtj7tuRjW3C4zc0bytSaqmPLBpcMyr52+8us/mXF/lVZyU9PPDVFjZhLnH6x
	WFexRyNo9xoinXMWLpHIq999lPFbbmYV7wQaVPnq0tmOjg8TOeciRmVWJqSD77NU2sHG/MQ==
X-Gm-Gg: Acq92OGBj/I1X/yiMdMoL3pi0ulaMZr94ykLuLkvY4uUU7e8FCBz0frdg/00HooRTjQ
	ncXQSiR2LYCZN+Dc3+1I5ONUxS2EXpqwIpP76TORzNqN/D8uQuOC9oGoHo1DizTJb8anJKvCbG/
	1tOO1oETMoWfub8CArqlWLQU4elWSrfNgjIXIJwfK3WHXH1LPT7gHSB4EzdyG046tUGADxG1Whk
	ZdLBupgDWgpP7R7xL09yn6mKdQ7iA2jCpKqQUbUOwpTN3acKeKFTwBJH3NrL+4yoAzKrw/SnaKU
	gu+fsKSXHR53++Ri/xs/TdbocZKnhFAmi2OinH5k4j4dSsW9EXyNX/MRaaRxPe3LFXMChycJ0pn
	HuP3RnwmEEMB6H7I2HNXyVyJcupFCaNW9kgOYzBNxpCg8T9SuP3mo+7ahSFouolIkxsMivoRQeQ
	==
X-Received: by 2002:a05:6a00:3907:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83f33c25b5bmr16219899b3a.16.1779117456318;
        Mon, 18 May 2026 08:17:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:3907:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83f33c25b5bmr16219874b3a.16.1779117455840;
        Mon, 18 May 2026 08:17:35 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:35 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 1/6] tpm_crb: Add register definitions of TPM CRB chunking fields
Date: Mon, 18 May 2026 20:47:19 +0530
Message-ID: <20260518151724.730443-2-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518151724.730443-1-armenon@redhat.com>
References: <20260518151724.730443-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9593-lists,linux-integrity=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	HAS_WP_URI(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DFA2B56FCA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..d76f9e30f036 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -57,12 +57,18 @@ enum crb_ctrl_sts {
 
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
2.54.0


