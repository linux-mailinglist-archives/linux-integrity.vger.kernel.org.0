Return-Path: <linux-integrity+bounces-8497-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xgG3Fl9+jmnJCgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8497-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:29:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8E13243D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380123029AE7
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1221B9F5;
	Fri, 13 Feb 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emMxNysb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOErmyFC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9B1A2389
	for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770946140; cv=none; b=a9U+6oZJ6gP+K2sJ8a4VY8NKDwusuOG/7BumFs+UP24BR4neL7W7FiaT0Ny6U1IyCkdQ9j0s+Sj/sgJv5c3eof3+fX/cpabD5MvYINcssRCyLZZoWPAIbGRdy+ASN0RtrdulbyNSCBSquVphLb40U1qxSWio7l0TUMSJgqbPjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770946140; c=relaxed/simple;
	bh=LkGFc6Olt1ALvC/w7V4FJpUWTISWyEKJsQMoGVdY2gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X00AWH+QB0qnOdUEKXRazL5Yh5MrEVkkgkN58q4UjVwlo1CRx/Lctcxi8K4Mi6+53W6onPiVWS2ce/GyZshVCReyqBjf1Lm3EzKolcILjji5Nn6E7LtgWwSH6mvEJewJdqMobgR+J5kLLkdq972mcZ5t7EWXXODwmeajCDLdBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emMxNysb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOErmyFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770946138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JjZlXD02NpdsukwwFOdN8/Veo/G6Fq+Y2yVD223pJW8=;
	b=emMxNysbgxCOAjTY/E+KWLfsHCmWN/X4NfG0b8yfeDBkdrydi2jbQy/k4rSlWcJXSdLV5i
	vDR6Q7f5Qr3WoAnXniTCCDJoGPVj7KFhsDZrgu3O3Orujw76gYt8M4FblewJpSgHUZxY09
	WQIBqcOYIPPUY/oV/nDnCEhpIzWN4IY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Bw94dKtVPAmBYTpofy0yRQ-1; Thu, 12 Feb 2026 20:28:57 -0500
X-MC-Unique: Bw94dKtVPAmBYTpofy0yRQ-1
X-Mimecast-MFC-AGG-ID: Bw94dKtVPAmBYTpofy0yRQ_1770946136
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so1182408a12.1
        for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770946136; x=1771550936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjZlXD02NpdsukwwFOdN8/Veo/G6Fq+Y2yVD223pJW8=;
        b=YOErmyFCRYC4RpxaUhgPP/qUgXPf4hLqaIDm5OFHsDr5kcwlOq2ubw04A15sduAKBV
         2XRqTBbX6UIbd5HKr+m/wR8feOtBNENud4PwIj3eAdW7kWOn2aix7iMsrXyFJ2Zktclj
         MRKkVngIT0dthxE/7FlaYgvnhgQfKlFLMrOMuOR6VC4RkvHevp49NEZHFHtaxrfk8mHy
         sCk1V86hEP8I1aUCA8BDUjwz3lq01F0wxYYJrw/ob6eU+g30zmX0jIAOQ1OwPz3bD2WM
         1Bj8sUtie2sDbE1OpLxAInTdmUTbHMkws6RYX67a3VQwUXOvMzOrs49l9vqdcLhqrG/u
         kTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770946136; x=1771550936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjZlXD02NpdsukwwFOdN8/Veo/G6Fq+Y2yVD223pJW8=;
        b=QfT+HBIKOj68trov73BGdEyq3/ZgBvVCirKeeI2FhT7n6v0XX2nMW1VAhcdkOoKF7w
         1SzruYXvK2aWvF48xb1hfkAaXpfx6tx0Tv6CM1Mv5y4WA07rIk+UYeY7LlN2R7xgk33V
         e0k4TVb9lLfJop2Qj/vc7ZSM2onxdICuAcN/XF1b+We+1eKo175mY9eWOMoffFv1+uIg
         53Z6iYKuuuNj7aC+KWk3sWmRy2gOxtMfmaylBZ8rm07kJ7hBTcaMAPmX8WXu/w3WjW5g
         LkK7utMkHHt8tenee9H4boGQgK90YecBhz6ZK1CWERiDqIqaLTM/bihqXpwGPZgfVa0H
         Ae1g==
X-Gm-Message-State: AOJu0YxNkXTCRU9sZ0QzBJMo5michW190ZnfAX4bGlLnA2kTzH5zIu13
	cNlktEJiaFLGKjehGLgySUkpZEjwSmXdM1YAYThFYL6JA7ZVdKNPxGoWjSH59lVKl/eRPI49xO/
	sIFndUWX6TK5fKvyDMW97vAyLTzhPuNu+AhDXryfP6sjf12rheGySp8Im1dzkhY0bG7gD4CxuPD
	nZktnITo5L+2YtActa80d13nYpcH7jwrAWK4APmdyzFfJY8bztZUk=
X-Gm-Gg: AZuq6aJkDJmUUOiQ+0Sbjui3HlWbUlsPWQ8OILf1irNYbrmSTDwc+9H+4ze/4k+/B0t
	lrShgdtgYVGHa5NckY+Tgs4be5QlQkMsFAqTphCWrTI0z2FBmYighxdx7w0F9PDy/G4nEQmlUbf
	1flfA8ILkGKXORjBOtUp/caW83t2wVRZR35/rTN5z9zoY6y17S+MFsB5uSUmrpN2x7SP6EqOrHd
	/fm2+hXMoJE/hWV0btWtEf6dbRzuTz+fvFwLNE5UpOkRxZL3Xq/uDorzZS9IWBE5P+Zzy88QLvN
	NfWCAxDx1zhtxlpouqYXHR/NAm6LlnFhjcgk32+uD6xaIUt5CR6maKLjMf2HzfOFNQvgnWlfJJP
	SD35FYdtagN3U
X-Received: by 2002:a05:6a21:35c7:b0:393:7575:a8d5 with SMTP id adf61e73a8af0-394671c1cb0mr539065637.22.1770946135619;
        Thu, 12 Feb 2026 17:28:55 -0800 (PST)
X-Received: by 2002:a05:6a21:35c7:b0:393:7575:a8d5 with SMTP id adf61e73a8af0-394671c1cb0mr539045637.22.1770946134927;
        Thu, 12 Feb 2026 17:28:54 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197f7e0bsm6162488a12.27.2026.02.12.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:28:54 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3 0/3] Make detecting the secure boot status integrity-wide
Date: Fri, 13 Feb 2026 09:28:45 +0800
Message-ID: <20260213012851.2532722-1-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8497-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E8E13243D
X-Rspamd-Action: no action

EVM and other LSMs need the ability to query the secure boot status of
the system, without directly calling the IMA arch_ima_get_secureboot
function. Make arch_ima_get_secureboot integrity-wide.

v3
 - remove unnecessary line splittings [Mimi]

v2
 - drop CONFIG_INTEGRITY_SECURE_BOOT Kconfig option since it 
   "imply INTEGRITY_SECURE_BOOT" is anti-pattern as pointed out by
   Ard Biesheuvel

Coiby Xu (3):
  integrity: Make arch_ima_get_secureboot integrity-wide
  evm: Don't enable fix mode when secure boot is enabled
  s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT

 MAINTAINERS                                   |  1 +
 arch/powerpc/kernel/ima_arch.c                |  5 --
 arch/powerpc/kernel/secure_boot.c             |  6 ++
 arch/s390/Kconfig                             |  1 -
 arch/s390/kernel/Makefile                     |  1 -
 arch/s390/kernel/ima_arch.c                   | 14 -----
 arch/s390/kernel/ipl.c                        |  5 ++
 arch/x86/include/asm/efi.h                    |  4 +-
 arch/x86/platform/efi/efi.c                   |  2 +-
 include/linux/ima.h                           |  7 +--
 include/linux/secure_boot.h                   | 19 +++++++
 security/integrity/Makefile                   |  3 +-
 security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
 security/integrity/evm/evm_main.c             | 24 +++++---
 security/integrity/ima/ima_appraise.c         |  2 +-
 security/integrity/ima/ima_efi.c              | 47 +---------------
 security/integrity/ima/ima_main.c             |  3 +-
 security/integrity/integrity.h                |  1 +
 security/integrity/platform_certs/load_uefi.c |  2 +-
 security/integrity/secure_boot.c              | 16 ++++++
 20 files changed, 132 insertions(+), 87 deletions(-)
 delete mode 100644 arch/s390/kernel/ima_arch.c
 create mode 100644 include/linux/secure_boot.h
 create mode 100644 security/integrity/efi_secureboot.c
 create mode 100644 security/integrity/secure_boot.c


base-commit: 2619c62b7ef2f463bcbbb34af122689c09855c23
-- 
2.53.0


