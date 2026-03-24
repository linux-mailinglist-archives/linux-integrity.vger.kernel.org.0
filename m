Return-Path: <linux-integrity+bounces-9042-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gt3DIk+wmmCagQAu9opvQ
	(envelope-from <linux-integrity+bounces-9042-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:34:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70483040A1
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B7E317DCDC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784643CD8A2;
	Tue, 24 Mar 2026 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yhi2FHMh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNJhoOgz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDF3C945A
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336702; cv=none; b=IFNwC9g8nd1fVg97ljbWHx61hmndbxYKNhMD3AgHG5Tv1kV3qcYT4XniL2jCvxFvmtfj1Wzgw7pcDEN50wmfPKCInxoszolwPhEg3Y0k5KCkB1SaT6eJvL6BmnhJ/x0ovHhGGjfW/nYYu60gK3n7lTPR7s/Zi9+JFm8EyTffvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336702; c=relaxed/simple;
	bh=Jn7gNVg9GB7dWXhaE46VdMNVjktobpOIqL4TU91Jpx0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kwxrkW5NcpvjHtk9rxnZUMenIPj3dtm9SgxYhcXdfB+fWuuj/t7Og13AibNq/EDKcLyx8c1RGYJMPJ+xShT9nBu+wqp9lQj7OmEl7L91hPgiSFFdkDUsD9IVNv6/Hp4HJJAtFDcPolIRgr32Mndti7nZ1pp1M4yac2gVs5cV1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yhi2FHMh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNJhoOgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rxka58srL6y3c491qO5tkLvc0iWe4GgxBpI5GmdBla4=;
	b=Yhi2FHMhdxDfWT+cqk/+kOyOY5Xmb0403GcJg58J3XuFG/lcB+zMnpzhFSQRriI25wxCyv
	fnYOL5QqJ0s1AthfWgo1cy3PxzsOgYnbH3qD1IIth/YMsJOnoMXnb/YqfQC3v6B4is3Qd2
	U/xFni0UeUBXsesgk7PEjQBXA4tUSD4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-teAuxiV8P9qmDreiPTcxSA-1; Tue, 24 Mar 2026 03:18:10 -0400
X-MC-Unique: teAuxiV8P9qmDreiPTcxSA-1
X-Mimecast-MFC-AGG-ID: teAuxiV8P9qmDreiPTcxSA_1774336689
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a73ec7290so2158040b3a.1
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 00:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336689; x=1774941489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxka58srL6y3c491qO5tkLvc0iWe4GgxBpI5GmdBla4=;
        b=YNJhoOgzpJLLW7O9clDB7J92gNdYUE4HR2sYh4xdlZwehf5XkUQC4gBGXQgc101Jcc
         fD/e6vpOgS2iWlJ8BVjtt/5OYsIlX3c8PNZ1bHCZqCDAkpFaNvzxUDK55AMYizJug85h
         sUm8D2nMuYFj9hj+l3std9k+eouDptRSUC2IEATTlsWAwvwFFutcObVBUljuFDC/nasQ
         srt0VZtBJzix7eARfoW4LuxZRpsRIkGUBUKasI19EbqWsst5dvuYTpGVTZ7CT/NtY/5t
         xGlXj9Exdn4r/NA/tJ3NEUill6ddt+P6Rwo7ZKz7wmfXce4MTNdjSBsE8vfJh2J1vdUn
         kYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336689; x=1774941489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxka58srL6y3c491qO5tkLvc0iWe4GgxBpI5GmdBla4=;
        b=cweoDJRQuMd+X3pZ7EzZN78zebOeyLoZ75Np4sNX6aLPIkuZGVAIM5EAxYFNj8V4UH
         2PfuOvub6RF4EGkTimp71OMerdHCfiNcSarGTowR4Wyrsdnes7OKNmhoh35jl8CcL/jM
         JP0Zt+zrUEvgFjg7Z7/ygk3TbBcJXpxdhXKz96W8qnBSxWANJUH3mawiqyadsysFqavt
         i9SZuWYgjtW5CaM7QBFPT2siIL74a8qcUdmMnc+X6JNsTqV3SpxtRLmNlp0bXbHgS2xC
         fpvzQUDMMuRIZR7wZupuGBQIbWWFb2oJDojt/PaOf0u+3SBsXTSH3TKhQvkccZ6a5byD
         lMbA==
X-Gm-Message-State: AOJu0YwEWjaPM5S+1gP4/3Mlj9l6FpRJI4Np4AitiAlFSohgEOSh8s3p
	yp/lxBOTf+RrAV0k1m+fXSsrk4Q9EWWsZhPou1YX29IVkXwPgJgOLeD6z53quM0B/bjLmkxPMMC
	nzXOAafYgQSRdtoX4plEZJSU95xee2Vjkk7Wk3sMCKLuop7qOatTJA/1zU7oGwbni/xL+4g==
X-Gm-Gg: ATEYQzzA7IA4mluV1sMBqgPhv62FF7D4MGbnXfdDaYGYgdomzQhwyEdsvOjIw4yC6tJ
	Tjn+mbeXB1JzWbrBki5PcclI5crFosh1877aDOIbENC/V4gSUDY865rjSaXfaVGthkHv+JndRaT
	klSNr83Dq5XIilV3MmlVdUyIYzyMSLbsktQFrq9j6p52mO9JF0eOnFUl7eYXg5zcDB7CludZ20s
	Jw1K/czwbjsS32svC/0RPihuWF1RgxYQsucyn9Ju0JRRJfksMA1SCWkaQtuD/xq+DwO37EKX/yn
	w+AaxH7EOKW8uGL2Z+JzCfZfvbhTpg0MeIa9al00MSlNdMyTY05iweVuyDogjULZ5bFGO1UBaHr
	mmQERO15MwPgZndqwI5zRTrCkOnIE2WSwmWx2y7tdViBZgfONAlnQOB0jsiO9HQ==
X-Received: by 2002:a05:6a00:9505:b0:829:7fff:eb7b with SMTP id d2e1a72fcca58-82a8c397837mr13641024b3a.51.1774336689000;
        Tue, 24 Mar 2026 00:18:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:9505:b0:829:7fff:eb7b with SMTP id d2e1a72fcca58-82a8c397837mr13641004b3a.51.1774336688575;
        Tue, 24 Mar 2026 00:18:08 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm13597766b3a.37.2026.03.24.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:18:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC 0/4] tpm_crb: Add command and response buffer chunking support
Date: Tue, 24 Mar 2026 12:47:59 +0530
Message-ID: <20260324071803.324774-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,gmx.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-9042-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C70483040A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The new version of TCG TPM v185 (currently under review [1]) supports
sending data/commands in chunks for the CRB (Command Response Buffer)
interface. This is in line with the initiative to support PQC algorithms.

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

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
[2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/

Arun Menon (4):
  tpm_crb: Add definition of TPM CRB chunking fields
  tpm_crb: Add new wrapper function to invoke start method
  tpm_crb: Implement command and response chunking logic
  tpm: Increase TPM_BUFSIZE to 64kB for chunking support

 drivers/char/tpm/tpm.h     |   2 +-
 drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
 2 files changed, 137 insertions(+), 59 deletions(-)

-- 
2.53.0


