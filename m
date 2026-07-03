Return-Path: <linux-integrity+bounces-9881-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Y/iIISfR2rXcQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9881-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:39:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75097701EDD
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:39:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="eIdm/gXm";
	dkim=pass header.d=redhat.com header.s=google header.b=tRCoxWYP;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9881-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9881-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A942D3004C9F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E853A0E8A;
	Fri,  3 Jul 2026 11:27:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F71B4F1F
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jul 2026 11:27:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078031; cv=none; b=c/02QvHlo6YppDGl/IHjWphceL9bN5tP3MHvMA1ramlOqzMJQ/HqpPMcFeEs0Iy2Vm2fdrWJSZ18x536BBa4zgDVF8f6etjfjvVlx/pIKurEIBsnwLBOpkknlrLn9krhXXet5OI9zmXPGtYlmPX4CZR8P+iIHBy3WhkyymqpMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078031; c=relaxed/simple;
	bh=7TZzsqMFbtcgc+w5SoueN6NnlsZVcur7+/g0tDCWPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQfWnpBl/tZa7a22LIg38KRqU4HmHVIDyLCJXwVOguW2vkn+aNoJebuMlF1baMccrYHOo7w30tN/Rw5LPxQL5qHearANx7/DPQY9VE1f82S/yT17LXyqs1HnyAqQ1hQrtN4AZRcjFk2tSLFN1/lsrZf5drOiY3ciFES5J8aqmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIdm/gXm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tRCoxWYP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783078025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
	b=eIdm/gXm3iY8BdEaZYDgpNxQclAT2ltsGoRQFeYmSUaqUWVxnlkrO2MdHlUy/59iVxtHlm
	84KMqmN52bIVaDQphHqjbusUrAQNa5xpwh2LzmTCwqMEEn3r/E8VEWPl3s3nkf0Sk8go8h
	/VhBm8mQ8W9FShnd6E5gh1SOleYo6JU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-UQV1zpCkNRyNkIdCwloyZA-1; Fri, 03 Jul 2026 07:27:02 -0400
X-MC-Unique: UQV1zpCkNRyNkIdCwloyZA-1
X-Mimecast-MFC-AGG-ID: UQV1zpCkNRyNkIdCwloyZA_1783078021
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c825562f8bso9448775ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jul 2026 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783078021; x=1783682821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
        b=tRCoxWYPlE5d5t3BHjAFklAIa8tfB02OGSjJy/GcnowcQCE1Yj3e0O0H5+94VCtnGs
         LjPjJmykCdLRVJdztYqyylo2Gm1fME5qX1PECnp1G3HQjVs33E/2KmRlNAgl3xuka/YU
         FWuHE6tZxZh5MaKQ3PUMTSfqxmRGytqZRdmojqAIhKlB2Cn+tPmIElSi+yxeEqVFBTth
         vJ8gLSKe/7wtOlbgbPNItmqB1rYk4p6aIRXPsM5PUfMWhWgw0lhJgt2jHSrCl6g0FiGb
         O+MrWqlROYXrndBc1OYzOsbqj94DoMw2XKljRBxDzPBd4IBjbjjkgk2z2QEQCtwwYWkO
         jQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078021; x=1783682821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
        b=DuzeXX/VapZg9kyKfnSCbh+2uohSz//U4hsQOXirh0NTcFeRZoFvL2AVV8gHlMhNVG
         9bEC0kbGNdAdul+B4lAtm9q1KyLVcrUw9atBhzUXh7zSrbm35uP1Lv83KzvgJ1+v9Wyq
         N1VNQuusL33SMLvJy+QOGzj4ANw8+BUg7XcuineQmCXduqVq95uCQG5rDkTSBKun1SHa
         yqdSCHlh8gWzWZ/1HteI5OkmAqc2ngFks/CJfENfwLAiinR7OvjnWZirnZrlkOnoh8KW
         zop680rsXHmK3VL/IZ1V8RWzVEM9feSZ6ez9epz7Fp3LiWRRe/Tkq4vhwxHlXdeCarI+
         iKnA==
X-Forwarded-Encrypted: i=1; AHgh+Rpk3EJh+wrx8Fl693SPdSLKiOh8D0jggzmiZgWIug4SlVnmtGDHDXuteOjMyw89r9QTscrwb/ikebG9O4vEwhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgujPhWK/EBbwYAekV5GVHcbmvJsKV7QngSxE0nhkTrdohvMVe
	AWlTD+8Csgsf5pDltVhp4DpgErA4CXlJt6iJSr7Unr3jc49HrYEW6HHp+tNk0U+ipE4q7Or3ARn
	bjLqSzzghMYGipX6vWfRwB+A99uYlgkjtamzXe5TTPzYgQuM65clcA0I5IjjBEZYzROYslw==
X-Gm-Gg: AfdE7ck4SyJ+JkK03XKgwLEPxEoIo0eIYWkwq05kiPQq/S5cL+LlHnAO283UTFuo67z
	zd2ziKfLHDSztw4jAUsoYaKJsWEL8wW8Fdh4cRApwnYmJSyYVbUKNqjtg9urv+XRTlnrGnpRod7
	Za1OTCeDZ13u4T5Fx1d+XrUJsIRghGyqF914xinJqaYIGwUeLGaSOXkrbfpmYCu5XIuQBivY/uL
	1jTN/EuPGqAvLgKgdjleqb3m04PijchybxmpkDR7P3vQT7l2ie9KK9NZMse7dZOsy9NNJY6s8vT
	3owWLZZiAj3fqAY6VWpyOVGJX2EECWJLUVi5cIlBGJZgdOZ9HF23MHr/k2Jjx8TAmLajbWlmue+
	kDPBhVt41Q4EuSV9G2Xj7vyer7vyxsWKQ6Zd4IjzLMVOWovqWXA==
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173485ad.45.1783078021229;
        Fri, 03 Jul 2026 04:27:01 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173215ad.45.1783078020656;
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
Received: from localhost.localdomain (122-63-67-56.mobile.spark.co.nz. [122.63.67.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260acsm8227305ad.6.2026.07.03.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
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
Subject: [PATCH v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
Date: Fri,  3 Jul 2026 23:15:31 +1200
Message-ID: <20260703111530.91285-2-ltao@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,web.de,hotmail.com];
	TAGGED_FROM(0.00)[bounces-9881-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75097701EDD

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
a check in machine_kexec_prepare().

Relevant path:

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
v4 -> v3: 1) Remove code comment.
          2) Replace (buf == NULL) to (!buf).
          3) Reword commit message.

link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v3: https://lore.kernel.org/linux-riscv/20260701025732.66330-2-ltao@redhat.com/
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


