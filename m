Return-Path: <linux-integrity+bounces-9060-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODbAJkXUwmmwmgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9060-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:13:25 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3031A903
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FEA302A062
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F7388E7A;
	Tue, 24 Mar 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKiYMrww";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2PcCWuz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF55369208
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375974; cv=none; b=O6HUjV7ltSEDTHt8A7o679N+DhVoO+WabRPdztIDHl2ZEg5eoeOuadXF7R3sXsiUTccj3gM45iMnJI9tEgcnduXhDtg7nAWDBEoqrNbcLF7CKKcNA8MZIeLElpcqD7fkBruQ+0mH6rSyjTj47EU5snocnuw+XBlfRcxeBHOml+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375974; c=relaxed/simple;
	bh=SkM5Z+ibeJ0gQPAb2f2ncFaeN0nEKhbjvcwVJ4xHY40=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SgmyEi+oyA6vgKrrLP1nzgIHHl1G6z2MdujLay/12JPWgngdAgXp6RTmS5Np26219y3IPYjyg7/+sBq1LS2+YuzMiCI4vBN9PxHNAqsWI/BUBy1g+uam/1TquTpt/M5peM6DERaDagZ4W7/BWmyRufp6IumrSkFfnFvPpGcoC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKiYMrww; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2PcCWuz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6QiCo41ZZKkd2paUvlUkZeENhSAez4wAM8HZfA4NceY=;
	b=gKiYMrwwnbEpkdaLjfgbknRACeneOj6x62GQE9X4zoQAgjUVwNLbIv76Pmg54p5W67bEA5
	zFef5ru9vz6ybgLsD5m93QGU4yfRspqIX57U87e/IjEnmULUT5tFEcnoKF55zQPDqFzw4+
	rI3ARqx+dW5Y3cUMesHRyuBJytVdfAI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-MwEBH6EPMTGHgjDUFUigrA-1; Tue, 24 Mar 2026 14:12:51 -0400
X-MC-Unique: MwEBH6EPMTGHgjDUFUigrA-1
X-Mimecast-MFC-AGG-ID: MwEBH6EPMTGHgjDUFUigrA_1774375970
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c738b1f630eso22902934a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375970; x=1774980770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QiCo41ZZKkd2paUvlUkZeENhSAez4wAM8HZfA4NceY=;
        b=A2PcCWuzYFsBjZQzYrKHDUSksRQ17vJU4/D4bSikNwt083gSFSpZ10OsQOgZllsbnD
         miMEd3j83/esu+qJC9nvyaKcTIxFBzXa9OU8YbE/QjLBtsvVR04XcRjbBcnu/7m91466
         dBz7jTkklkqadg0PZek3WHg2jFq76MhwMKptGOJofC5bV5o6vBRhIZ/JRHmYoAAeu90i
         R1AHmrXa2qoolNV90fGRRhywgKH7d+Szq0j39mX5Avl/O3gM+tZGePCvFycR5/ieuAPj
         HXIMw+V7L+vIEJqCvs6n081LENorVIq1en7TBMRiDtt3OOzr87n3wChBfwWy29cP8f4I
         I3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375970; x=1774980770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QiCo41ZZKkd2paUvlUkZeENhSAez4wAM8HZfA4NceY=;
        b=gfdSLNs0YGTlksoYwYLRaoWjqkV7aAhTfzEZlsTvgDywq6/sr2KBISq6o2ZdVVU4rh
         nP6PjSqIubIgT5gK9Pvbluyba7dlHG8FWgTx+0HQr2DRA8VRwI3TaqKEhzZTcABXSaja
         sSyT1NrQUUkoGjPQPwcFC1aA9BDgxqBmI7Rs44spEwQQR360movL9GPQEfm8VnhBeF7j
         uL0UZOX2Hc5z3d3ku86aCyx2cm7HtoxvShVM9qAlTIwfJQ0+sFlgm/aYqRUtQ/QwX9Ay
         2tKeoKTP6SweI8T6CKHevpMkYNEkU/8YBU8PscIRaAlC8kP7gn+UyFa5V8ZmyF3ycI95
         8wTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRuksyAILELaRRLEkffXegsxMhL79oDBCQ5e9YQ2/ehJ+Xxx3Q58mockhKGgOdlMRabSjqmRZ/nvy6/FEoQps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EDlySr23MVNRStPFsAT4fss1g+HLWY0OCk74AjI2aStM9XQK
	JnH8k89CCBDYjMaDLj4mPR48qJtR5C7PTqrEkr1U8DiQ+FKFVE0YsgpOOs8KhAlGoQs3asDgIK2
	2env+pz+a4NRDa1T6htltt45MxKmlEjOaDiz/v4N/DNr4tBP0cgePdE6VN3RwlUvwpJvKNMH9aj
	hG+w==
X-Gm-Gg: ATEYQzyvFRsPB5cLfrKNblmwMBJFZXySHMVWQRCDpNrYlMnlmAMTUWqt4fj5HmMw554
	7Ta0jIPn9XzKihhf5alUJvCC57ezR7mkxdn/hTXKdHQWDWckStVYGBwc7UMlapFIir9LQQVHmW9
	A1310ciBJsSoFNJ9u33Dr1ydzdT2T9D03WjZSg03PZn1AWGoKkHAEoI21xi2uT8zydOrHT0YqR2
	lBKguJb8QJcVa0qO5hAYP8tDIZsoRivrw4C5CeBgyktz0F5V0vzYcSRdMbMgKAedpz/JZVp3fV3
	sdcvJdZc/d7IkeL6AQ93KjhKPlw8WSiLkAKXBJIhipjx6HP4It0oNnUM0+Wc7mBScBKUwe/fqk/
	dQ/IW67WZsRbS9rr7w5zBU+5c2LoNC06HZtpqBZ477PBNgAgRHBaAdXbLMH+pPA==
X-Received: by 2002:a05:6a00:2185:b0:82a:768c:9a2c with SMTP id d2e1a72fcca58-82c6df39307mr514078b3a.22.1774375969658;
        Tue, 24 Mar 2026 11:12:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:2185:b0:82a:768c:9a2c with SMTP id d2e1a72fcca58-82c6df39307mr514053b3a.22.1774375969179;
        Tue, 24 Mar 2026 11:12:49 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:12:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 0/5] tpm_crb: Add command and response buffer chunking support
Date: Tue, 24 Mar 2026 23:42:39 +0530
Message-ID: <20260324181244.17741-1-armenon@redhat.com>
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.de,ziepe.ca,redhat.com];
	TAGGED_FROM(0.00)[bounces-9060-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 20D3031A903
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

v2
--
- Add size checks before copying memory.
- Update TPM_BUFSIZE to 8KB.
- Commit messages updated to indicate motivation and logic of the change.

Arun Menon (5):
  tpm_crb: Add register definitions of TPM CRB chunking fields
  tpm_crb: Add new wrapper function to invoke start method
  tpm_crb: Implement command and response chunking logic
  tpm: Increase TPM_BUFSIZE to 8kB for chunking support
  tpm: tis_i2c: Use local 4KB buffer to limit memory usage

 drivers/char/tpm/tpm.h         |   2 +-
 drivers/char/tpm/tpm_crb.c     | 199 +++++++++++++++++++++++----------
 drivers/char/tpm/tpm_tis_i2c.c |   6 +-
 3 files changed, 146 insertions(+), 61 deletions(-)

-- 
2.53.0


