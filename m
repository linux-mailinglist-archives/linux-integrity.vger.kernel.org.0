Return-Path: <linux-integrity+bounces-8412-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKHLMjp2gWn3GQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8412-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:14:50 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB40D4573
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 271BB302FE91
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAD2D130C;
	Tue,  3 Feb 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViuDCpdg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kqa3Xgzf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C962DECC6
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092088; cv=none; b=R4H7SJBsJzuWgnwGX5uLmDA3R8iSmZ82XoFb0AD5YVh5mfhlh1fBo6uC7ve/8mK+oJNd18uDoC2c39NFkunkmGIEFWoLNaGL/Dlt3tpngzQIAv9WbXv3BhrgJgQmkV4BGxRdNnxf7y3bOcmmd0EB3xfYwHsKVQ2jsLIqbWxvVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092088; c=relaxed/simple;
	bh=mD+SQDguFIrw/HVHEEnxiUhMBimvBbhZGbinC1aiizU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/FiA/DHpdX6zjJ8pkQnf6vcsXdZcw5ydGosWBVyKaF94zzm+8H3vbLO0+MfeFT2w25Z5lSDB70gsNIWVX+0kwG5f0AOGjXssvXBptqA0TeUhyy4iMmxl9PkU9uTa99My7GFQgZRXz5SPIy5G3xPW1xuqPHYdpUd9e9uSoS6ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViuDCpdg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kqa3Xgzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kcrfy68PurYgasTlI6o/MKp0a5gRh6fPendF941EsIg=;
	b=ViuDCpdgap0i/FwdkPv2qIXhhRebCYycKMgjPrc2HOUAgQjYzQhtJNLJ9h4b1c/irbt16g
	PTbazVxwR9jj1w9WiCEXfXn+m3nNVDwLvGwiCkz5gLHs0Aw1Z6hIL05KESL4EQ/3VKBVm8
	T/9vNTAoMUeOs5A2AJgy0PEvM94qq3A=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-KRuj9LMLNDqCgY4bPXVnnw-1; Mon, 02 Feb 2026 23:14:44 -0500
X-MC-Unique: KRuj9LMLNDqCgY4bPXVnnw-1
X-Mimecast-MFC-AGG-ID: KRuj9LMLNDqCgY4bPXVnnw_1770092084
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c61dee98720so3107167a12.0
        for <linux-integrity@vger.kernel.org>; Mon, 02 Feb 2026 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770092083; x=1770696883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcrfy68PurYgasTlI6o/MKp0a5gRh6fPendF941EsIg=;
        b=kqa3XgzfqZRDiSdH2tdc9rthdG6Y2oh+izWFnizAncCEjHGgMgfvud5tJgcWctxaWI
         RItUGSvoohUfSp0KKyvjvUQocQtZ8vKl3X4XK3tLVZYxnJKE6RK6k9tl8SNNacKJW/kg
         VjcUhzjPAU4m/GYTCdlSSP9yKHVk2j4nX01fOpxhIaZ2LBqX/Jpge8nVjyZ5mtgkp087
         4hb1teASO77/xMCDxoIgQYMBeaJXnqXlaBWpur32fOCB/4OOo7NnsQWTtwehKwoNb0Va
         PIO9Sg+HA6gNj8dyvEQEwbMVsrKCcRqveXAQEvovL7CNpNebyUDviOqK/SQT2KIWRbwE
         LtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092083; x=1770696883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcrfy68PurYgasTlI6o/MKp0a5gRh6fPendF941EsIg=;
        b=j7UM6US1TRCUKfAywB7mRUepv0/y4knwpWqdZnIOcEiSqTa5yVc9TSBCrulZikvTrG
         sMGG0oX/dq1RADe8/egHfPzJWSqhgkINynjokAesWv8fhiTI9GhoTpUZ92aJargnRNwD
         JTMZvlewfZXsQQ1ZlmR8lIpg5O/m1XZOtI+yuKp5zm5gjbZyeunpEAvMXeJGe9HHqcNB
         QaTuP0jyynpJl9XqYruTL9tNZ70w6Sr+XkGx/+k3v2RXSD47Jngq6KI8EOPPUq6QUU4V
         m9RRoaCo5sRXSwizfDACRxx711s8Tv5FTOs1t7jm+FJbzxga4bjoG3ciR7U40XsBH6+o
         mpCQ==
X-Gm-Message-State: AOJu0Ywa0jGn/O4Kxk6wS1vBS9zB0p6EcvT/Mw3uS+VU6XI4VAbNjkVn
	XQyl1QqhJ3uR26BGDDibm91m0xY0wXRXFbP5hH0K06J4Nh762MoMMD6V/ckBkfl0FpeSjUiKIik
	T64wSzMbuDLQ2QX1eFfTgLJgm6iFNSqK804U1vzTECk4+7/FBgkN4WDEpmDvO5XGb433wHEPpB7
	2joBmB7N7RzEzHItCL7/ysS521zvnUlh9YOT+rG14sUb5EQvVlQ68=
X-Gm-Gg: AZuq6aJ+vdkxvNX1VbLKshKXm8j7qr7c3mAbdnqtaDdidh1pwhjBYmjvY1zhSCRTdyz
	ZwVQHLCvbBV9cfMaxN4Orz0sHDfWENT/coq4CYBXU1tiiY5sBbc9u78U/lnAmWFLmpkEHRhiTjY
	zcv+66mErcG51utXk53yhZ5EToI8HapNvrseu0TvhDAuWV9oY5J9I2en4X+sfRvaHNU3L20jI7S
	kqMyuOaabM92sThfu0cqo2Vd/yw2ymtcHwoY6pmqoAO+2Mgn7y55RDRhHC39EMyVDKke/Nx0ztz
	abjWUY7xj2sSF3lvsVkwprPArnV0zO/XX+UGWqymDJ8+biCUM8ms+r6Zv0LauFEXtKpE17Nmiai
	w
X-Received: by 2002:a05:6a21:9d91:b0:38d:ed39:35a0 with SMTP id adf61e73a8af0-392e016eccbmr13830693637.61.1770092083293;
        Mon, 02 Feb 2026 20:14:43 -0800 (PST)
X-Received: by 2002:a05:6a21:9d91:b0:38d:ed39:35a0 with SMTP id adf61e73a8af0-392e016eccbmr13830659637.61.1770092082648;
        Mon, 02 Feb 2026 20:14:42 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642afbeaf3sm15636535a12.33.2026.02.02.20.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:42 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2 0/3] Make detecting the secure boot status integrity-wide
Date: Tue,  3 Feb 2026 12:14:28 +0800
Message-ID: <20260203041434.872784-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8412-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4BB40D4573
X-Rspamd-Action: no action

EVM and other LSMs need the ability to query the secure boot status of
the system, without directly calling the IMA arch_ima_get_secureboot
function. Make arch_ima_get_secureboot integrity-wide.

v2:
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
 security/integrity/ima/ima_efi.c              | 48 +---------------
 security/integrity/ima/ima_main.c             |  4 +-
 security/integrity/integrity.h                |  1 +
 security/integrity/platform_certs/load_uefi.c |  2 +-
 security/integrity/secure_boot.c              | 16 ++++++
 20 files changed, 134 insertions(+), 87 deletions(-)
 delete mode 100644 arch/s390/kernel/ima_arch.c
 create mode 100644 include/linux/secure_boot.h
 create mode 100644 security/integrity/efi_secureboot.c
 create mode 100644 security/integrity/secure_boot.c


base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
-- 
2.52.0


