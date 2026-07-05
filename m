Return-Path: <linux-integrity+bounces-9884-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URmSOdHpSmqTJgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9884-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 01:33:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A970BB8D
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 01:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=A5azpq2h;
	dkim=pass header.d=redhat.com header.s=google header.b=FpnqmFNE;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9884-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9884-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB233008758
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jul 2026 23:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311936E46F;
	Sun,  5 Jul 2026 23:33:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D634F492
	for <linux-integrity@vger.kernel.org>; Sun,  5 Jul 2026 23:33:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294414; cv=none; b=iMSIatcTRLGdWYYkDkyeNpaDMWu4a8CKGj8AtC8ClSaN0qH8ml1kQLYswkHYiGSHJxK8RJ/zBKXi7uFphKE5Qf9EgEmJW4DCWULDhY+Zs0Ec5Iq7g7qigYQiB2sEn/ViiG+mPY3R/EdLk0cf2bQB/GpU6dvaGxTAQ6F9v0gHmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294414; c=relaxed/simple;
	bh=KKBCh644BzCDLwoBLFIkcmm2m/854E+YvviVeczjB8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRK5R+XjTKdJYVaPm13KJhjYakm0c6ekLgGJ+d63oT/hsnv2IPCA0u8/cLOK/sTpUGiBqr2XME9iLfDJXe7Xz+CF5hWdaAsk9om/a7mOaBhyreWo/ECeYSaIGppKW/7JaXJ27iohrCsnPAJ6lpn9CrlIcv/N+IjzzErAnHmQ7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5azpq2h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpnqmFNE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783294411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=;
	b=A5azpq2hMANT/BSqbO1dwauryo24U4lH0fAPpVhCOlNAVgBDTuToNBWyH9jXGjQyLqa91T
	dLUx8IsHQ9N/ko5Sq+z1qztqhKnfOeaHTjXUNDzD+hPhNIJyst8MpfO8v7gvgNfxZmlvbg
	qfN9E4e+i2ek8eBNj07NonXkd1IfS2E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Ls5zGTsrNSy97llm2qTgLQ-1; Sun, 05 Jul 2026 19:33:30 -0400
X-MC-Unique: Ls5zGTsrNSy97llm2qTgLQ-1
X-Mimecast-MFC-AGG-ID: Ls5zGTsrNSy97llm2qTgLQ_1783294409
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so15149005ad.1
        for <linux-integrity@vger.kernel.org>; Sun, 05 Jul 2026 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783294409; x=1783899209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=;
        b=FpnqmFNEuJ6nXLI34u38m7AWzOSKckRcd4Oil3p0vNBFyl4ZXQnLEtJZuZy4Zars2I
         rprGplV7Qd1TawcxJkLBRoyFeKTXMJSSVDtO5i9M7F4KFT7TUqU5/yNBUIV7btLL5Bnb
         B62Fq8rFrEh8k6KY0KVcTfaaAScnwlNZ4GvLRjdPEjVzhBJUmszrlGk1GFZXJKylVrc1
         8beS0JG052NRUSutnDhE7yte0M0eaOv/qyFZy3wTeHWyATJeGtJX+LxhR4q9GDgwj0RI
         hl24/Ocyw2LLKP/b0oUdOMqYhhH+8/9SfMM4ln3Moh9R4jcCuXBf7CamJVvZsWw09eb4
         VsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783294409; x=1783899209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWgX8hRK0wDWBZMkA2UqYafCnMgGjGfI+mUA5gi2rBg=;
        b=AaKI8Nsc3o4ud6ngVgpkey+Cuh3JS6BHutuXBLzZxgVzvt9PbN+y+MDDo3oKFwbIVY
         Nb7BKdz95w6Os+OhYnOhapC2yodtpJvCdS0IXACh1q/BBo4KPFEs6pkQtBbHJuKqBWTb
         0Orx0zOM8nvP6QNFmqq//e2NJ7w5Z30BkjwmlfrvEPjQJ8UX8rJcwyOewWEQLokihC2Y
         DdH7EImaep5e4ASNF7BlcWHrkBb7/X3Q337tspG5X64hL/HsqrbRk7K5jzjQbHOc79RW
         KjykOHyEQ2PC5dFkj/v6prX69gpp1cR1gBySdmmW9KQkJJqEqGv2111u8Xn+Mi0ugiRK
         U6Qw==
X-Forwarded-Encrypted: i=1; AHgh+RoUOqH0eqBSG9SzPgqTZKCXFqQsmPtB00woCvVUsHiPIsWffrnuc00nMdKgmuBIn2wAQCYiWq/FIaUlFZmteSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjaEzFq/FhUUQt42k0k2aZ+sNa7G/BCGHfYSe36fmgbmybwME
	byla11BdbW6bxEEFLDhBTGdNv+g1XvvR+XYMbmUzSRCldHnx64L9jjnJ6ZVM/4Dj8L6L+NpI55m
	IQqvERAIvkO0E0o0R+FJVZhGXza0NUq4umuCAQp8AlayKatJ3tT8K2i61q0EjFVlr0MqSA63U0o
	3UC3ZI
X-Gm-Gg: AfdE7cm/EQWQ9nN4dKWUAL/1cJloOUd0uR+f15osrehAzzl+hl43kVD2RpdsphsIhq3
	1oyWEcdbcy9Z9H09PwbRC8SOmoGgdh+nwhMzAdHUhSUnRAZpnvS60z5hwnC0w6tsGHay78t6BCj
	a44At9cQBVACpifv8bHADdKYFpHMZ7MTIt14c43lqpEHYYRyK8/pOOLLMX8xhwCasMmdpavw7oU
	X9HPyJ0O9StDU8eHFoR/WhyvSWZ9bNNAsnVZjiYScsk4OJtqJxbKe+bnTs7SRgRuWsu6HG8JVVi
	bjcKG19ka399p6G312XCtTC+adgbOsd6w3feOqzmghITD1uxY0UQtk8EMYA4t3J074qNVOGaLMd
	BId9eZNwkiB3FqPTTDlI0Z3lTs0XiSwhQVzbdEhXnOk6bw30JZhe9B5HrhA==
X-Received: by 2002:a17:902:fa84:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2cbb9eb434bmr53329065ad.27.1783294409459;
        Sun, 05 Jul 2026 16:33:29 -0700 (PDT)
X-Received: by 2002:a17:902:fa84:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2cbb9eb434bmr53328835ad.27.1783294409024;
        Sun, 05 Jul 2026 16:33:29 -0700 (PDT)
Received: from localhost.localdomain.com (122-63-66-137.mobile.spark.co.nz. [122.63.66.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789237bsm38168945ad.71.2026.07.05.16.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 16:33:28 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	pratyush@kernel.org,
	Markus.Elfring@web.de,
	kernel-janitors@vger.kernel.org,
	jarkko@kernel.org,
	Tao Liu <ltao@redhat.com>,
	stable@vger.kernel.org,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v5] riscv: Prevent NULL pointer dereference in machine_kexec_prepare()
Date: Mon,  6 Jul 2026 11:27:07 +1200
Message-ID: <20260705232706.30265-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,web.de,hotmail.com];
	TAGGED_FROM(0.00)[bounces-9884-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:jarkko@kernel.org,m:ltao@redhat.com,m:stable@vger.kernel.org,m:nutty.liu@hotmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 353A970BB8D

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
a check in machine_kexec_prepare():

  kexec_file_load
    -> kimage_file_alloc_init()
       -> kimage_file_prepare_segments()
          -> ima_add_kexec_buffer()
             -> kexec_add_buffer()
    -> machine_kexec_prepare()
       -> memcpy()

Address this by adding a check before the data copy attempt.

Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/kexec/CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com/
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---

v5 -> v4: 1) Add parentheses to function name in patch subject

link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v3: https://lore.kernel.org/linux-riscv/20260701025732.66330-2-ltao@redhat.com/
link to v4: https://lore.kernel.org/linux-riscv/20260703111530.91285-2-ltao@redhat.com/

---
 arch/riscv/kernel/machine_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..738df176ff6f 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
+		if (!image->segment[i].buf)
+			continue;
+
 		if (image->file_mode)
 			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
 		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-- 
2.54.0


