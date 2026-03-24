Return-Path: <linux-integrity+bounces-9043-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEQzIUo+wmmZawQAu9opvQ
	(envelope-from <linux-integrity+bounces-9043-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0371304051
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1579E316B5E3
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE53CE4A9;
	Tue, 24 Mar 2026 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgudRQ2T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5T4iL5r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6329BDBB
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336703; cv=none; b=fLlUaky5fbe79YiQt1nyWSsGeOLBVbHRkD5w57CpDC0atl58IDCif6OQr4zShWumFJ0jo1QGSfu715PdTitbm4/xqWgJMLEfcqX8iyupe+xNg8iwkxrbZm6ecO2NWJID3PqlcZuicjQ3i4FpiNJevK/xVIKgZLRvuiycFKkUZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336703; c=relaxed/simple;
	bh=r7eFDFzjkCYc1eM+PcUUcoobdllEhQ+bRB6p/EM6B5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCSKvP5utwiLYLX+oK2JWjUOE5FPgiJ4WhZJGNdusDF3oL9dzARZT7oQUBxp8zxJnmVZDyQ3FGBdHWjbtGSnBqMznLxjVGxHLQZAE+LVVsToNvtg5U5rGGPOd6vcP+GQaYdhO6TavJQFidq9xsh0BeTjD08r+FaxG/rd2Ujjy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgudRQ2T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5T4iL5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vB7aLaiUDuy/zNum2h8/EvqzLzhAF+RMHtPW9CGDRoQ=;
	b=CgudRQ2TgaFRtrr7mHo+NkdR8r8f8d0HyRxOeQGv+kp2UJJLhcfWTuQ6V/4SQKHLY1aoKD
	JRg7U8mQbXDoErIu54gOIP0CHeeJaC6l5+OkZc/hG84tnNCPYaVHrtigGj3vnKqqmCsfTb
	cLVeJ8/WZQAEEoxFsYQoaKlq2Om8zvQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-hehFaCrlOvSaBRIvlW9CFw-1; Tue, 24 Mar 2026 03:18:12 -0400
X-MC-Unique: hehFaCrlOvSaBRIvlW9CFw-1
X-Mimecast-MFC-AGG-ID: hehFaCrlOvSaBRIvlW9CFw_1774336692
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c741a9ef5f0so3572806a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336691; x=1774941491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB7aLaiUDuy/zNum2h8/EvqzLzhAF+RMHtPW9CGDRoQ=;
        b=W5T4iL5r+3NVlwikMos3BsnjNDimSctOWmYi7IP3M7f/haIZc/ybGFgRsGAHvZGTNb
         4P79bhxqYN+5QpistKGqv7QwNnr3lgE31MaXet5BWTgTU4cJuGuIf0cDn44rawof/b0D
         AMmBoTFWYg/ocKvtQ7jZFUAn3sOkRRsZawPKDgTxDfvyftgzhGWKcY1iwa/MFZbG1tYD
         gmq1geStVsgTi2OI6fCyJf4EUwjjbqKYw2SzAvvoMxKdZr+5BRKB2DG2yzKubKRSmfff
         0+y+s8MqTyLvn9yCcxz/xs52tJbJnc4ksNYYI36oZGly9SLkO23aaF8jT7/imKNKfbsN
         qSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336691; x=1774941491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vB7aLaiUDuy/zNum2h8/EvqzLzhAF+RMHtPW9CGDRoQ=;
        b=aBaTXstPcipTa4oTK3oWjhqs1t8Pt03FWiVY/9c2LEY4w/3Ip6zMXjgv04mSw8ZRKa
         AManzdorY50C4sBPJlQeaXkmFTUYlaaxtfhMRYIUyhDQ0nBzhRNcqmS73mZ2bGD/vmII
         l05dzFoNOuKZq17P4PXopH1wzrzgEklOCZPHJIAQMBk2zhxSKSW1iKY6joqASeLqV+Zs
         Bf/g/u883w+qEt5+0l65dOqQwWpyb3OjeIR8qJHjTnv85By/C/TCZCERpQNLNQx/Vf8N
         NNTydibgbU+QkQG3JclZK8C1SCL7FKqY+E0SgRvTFWV9JA03N+csFAeAVHPhtz5TsvxS
         /ATw==
X-Gm-Message-State: AOJu0YwsfnWWkQQdPd3FXRMGLkpXsKXRDqhS0/hUWCo+FllV8485L/PZ
	rSXu37vUNmYtJykxjKi+AxFXknFJQtm5KDs4ErXukAROl7meVA2SVmGDfwJgR71Aj/kdTAkfRJV
	FEpp/MzKqCCMDbEifPZ3Vhm2qeMOuj1l/h/sZUqwG1SSKJbgCfBBxWFBh1J7J2knQazuU39/sfm
	J9PA==
X-Gm-Gg: ATEYQzxcAFtMypzxBqFHWBbVH/muW2srSedeUefqbIl1b4KQOZcHmQ2ziJqBlZxrgh0
	/pmOwGSkmmSdaLpFKyxz74prhiR+4uqN519FczF4UWTVMSICD9y1dI6WfuhSw88VTYtZBpFPzIK
	/LzN97/PFDOi0E+nbv5MUoNCvNY57GRvugoZHh0ak1jPWW2aBgpYkBiAcCBjvIzoRXL3DaBVaCi
	3PZDWpETgc88HuHd1bW88Wy6RPKurkjz5g+HLhsDA5rqsN03Ws3iCFv+skkwUBWkxn0HYqfrzEt
	Si9RiTt5/lb9kX8uoG82HDVSxodhx1v1j3lq7czHAhqeklQ8urc3LVhPFcEHgkHVkC4xY0XRECT
	F7yJC1+HttsfCTxSur4QP40gUh+EDgCJBZBXpN0KM04HUg8lVZ7QHXbhFdO5Uxw==
X-Received: by 2002:a05:6a00:8d3:b0:81e:f280:f341 with SMTP id d2e1a72fcca58-82c5bd62425mr2173671b3a.6.1774336691539;
        Tue, 24 Mar 2026 00:18:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d3:b0:81e:f280:f341 with SMTP id d2e1a72fcca58-82c5bd62425mr2173651b3a.6.1774336691167;
        Tue, 24 Mar 2026 00:18:11 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm13597766b3a.37.2026.03.24.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:18:10 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC 1/4] tpm_crb: Add definition of TPM CRB chunking fields
Date: Tue, 24 Mar 2026 12:48:00 +0530
Message-ID: <20260324071803.324774-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324071803.324774-1-armenon@redhat.com>
References: <20260324071803.324774-1-armenon@redhat.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,gmx.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-9043-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: F0371304051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- Add 2 new registers for invoking the start method
  and add CRB_INTF_CAP_CRB_CHUNK as the new TCG TPM
  specifies this CRB Interface Identifier that decides
  if chunking is allowed.
- Refer section 6.4.2.2 of the specification document [1]

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


