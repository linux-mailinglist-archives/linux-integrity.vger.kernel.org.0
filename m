Return-Path: <linux-integrity+bounces-8414-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GHPAFV2gWkYGgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8414-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:15:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95CD45BB
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE973035D49
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBC31D735;
	Tue,  3 Feb 2026 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhA8x6X4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="axx/kBkY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0D313E2C
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092097; cv=none; b=WmFg/TzKrE00pgh2w/UfJxsyWZBzAmnq1PXdiUBSrgC8bNAHkVJ+yRxDvSxJj36WYBzfPUymPN2OK55RmbrQr7VP9MLRoYZsUspKTO9oasN2rUaaYJ6hUthBSqJjZtpyQqGKDtUzszhYu0A8ljruWZO/qEH/nam3eK1TvyG43g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092097; c=relaxed/simple;
	bh=sJHfecm+9PgAuBM+q5zub2xzR1ygcAgU4V485eo94bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl+VYj46OxkSRfIK4GQwGmiKrvsXogUU4aZSPPYHXUHNJpimVvIUF7ShMfh8oDRB/387UwNEm15Ed9PzlLm4INU7C5fZacqodjTmQOAJq7WU3Gtif0T+d8wzk/JzlE7DKQJ5vxgn43MOBtT3yaEfA1C+5DT9VZCIJ0e2ErTPa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhA8x6X4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=axx/kBkY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/dgoz1907GpWsw9tjXtaDcvG7jiC8B/ivCp+i6DkyU=;
	b=WhA8x6X4mgZzugHBzGKqO94MEwtrST3MES/4yeJpt3pkO15pxMNx8dhQKcfaSyxsWnAFWM
	FWgWRaol7ElpLXeYwxo7ziIVq3GmYe1H4sAlzGUJ1IAalAvYBEWQ56hA8L/XYgey56PmFK
	6s8WsPZ9u1Q+OIZG1mg2TltJj3+z4Jo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-gwblLFBJO4a4Pag53GVuVQ-1; Mon, 02 Feb 2026 23:14:54 -0500
X-MC-Unique: gwblLFBJO4a4Pag53GVuVQ-1
X-Mimecast-MFC-AGG-ID: gwblLFBJO4a4Pag53GVuVQ_1770092093
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a77040ede0so51401875ad.2
        for <linux-integrity@vger.kernel.org>; Mon, 02 Feb 2026 20:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770092093; x=1770696893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/dgoz1907GpWsw9tjXtaDcvG7jiC8B/ivCp+i6DkyU=;
        b=axx/kBkYL1CPFtKWI5IIZ+8AQt2xA1T8NtULKnIuCBZj7LQ4LUgb3hF4H8JYcrWli2
         2Jk4W8EE76KTlQwQh3kcgSudYIjx0aDhJt7vGuHqbomnN4Fi1/2ecH3Roy34/B00YH/v
         oz5wxvtTs2mAnVbls5nQNVP2ktEhSznODOU51HfUzh4Ku7vidZ78GIEk0SzKyaAyNIIH
         ycreb5/iYZGmHDGx9qaTTkBi3YGPW0wdZvZ0n2qFKRnOsYvAOCdxmP6i2D1p+PkeF7aS
         KYyf7J5X3ogKwpFlUsB7lLl2/q7rhcoSvIXJvaTm7cdUxFHJxhXB/QwGtrfdns1rE7C/
         0/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092093; x=1770696893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/dgoz1907GpWsw9tjXtaDcvG7jiC8B/ivCp+i6DkyU=;
        b=oXnMNNuY6MaVkYVpZHrKnpuLov/VFiTfp6NbsiFWvNOdFjuY6T0c4FkHtGT/EdVZb9
         /uzLK/Q6932OtKwtEZnK7S/GEjhnrtDsAselpB1HxoYRWbazlVul9sT7uuLzyBSK7yHG
         IfBwZytGvaB3laBkAo8WOjwJsx3RQx/4olOszT5QOL4kfE06P+RAjufsoxIi2j0KCyHo
         QRgswyUL7n8DQTveyKZjuNdbzUJQfCs/S2C0HUNf0cpNLeDnbjN/DVCc4MZYTQdBzpET
         2q94f87ySwf/FOhHcTZHumuxIZUoXZuIaIRBYkRkSBIsOpPU0k47M3tBTnYOffgXJHiB
         6sGA==
X-Gm-Message-State: AOJu0Yxi9NwKVwvOr3SM814odyR9ylKYSxAQZxGB+P+uQqdu29S7mtjJ
	BV7s7qLYJrPzKojadO1v63Q+ilMY9wRR8ghubu9+5LsoBFs4CUB24fqnlfClwoCU/1GocRmamVc
	CMzDGF0QaeKwSllD2McYjYxPm0jypEHkV+MQl6M59E3m8wdvfGY6rOABpySXnF+qlXVyYoWzo3J
	oRzwT47BWyh109dLdOejQq9VvoG212iNiB/6e7SqPfk2qD/0CQPF4=
X-Gm-Gg: AZuq6aIfu73iFsshhFGVJqJPBuAhFlkO0LZm68+V3bagheE+WbLzHj28M83kJTJcMj7
	pJEWPhxeTxD/ay5ZWJQSYiX8ozvLYrV6ZyOzM7hetXUxew9SpLQOsce32GrswZyr3+guv8QaLpR
	oP1g4RLdY7eLkvrpDeaYO8k9i0Exb3tVlzoV6RQwLVhBf27D05f2czBZjBjNM4RuXS4mW/YuC0b
	0Pc8gIQrYVspy8KgGMWOHSOc32X1HSSYobj6SdDOpJDNcdU1njWdtar+kf+EPNhjgOs+mHqqpWX
	EhCAtt1VWaaSnua1U0lQtQIFIM5nKYbhqPzGO2IvdrZ/ZKPCB6BcPox9GD0i6XCPSMXwnAUK1cG
	K
X-Received: by 2002:a17:903:46cb:b0:297:d764:9874 with SMTP id d9443c01a7336-2a8d96a7688mr136630085ad.21.1770092093189;
        Mon, 02 Feb 2026 20:14:53 -0800 (PST)
X-Received: by 2002:a17:903:46cb:b0:297:d764:9874 with SMTP id d9443c01a7336-2a8d96a7688mr136629755ad.21.1770092092472;
        Mon, 02 Feb 2026 20:14:52 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d93cdsm157121635ad.70.2026.02.02.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:52 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Tue,  3 Feb 2026 12:14:30 +0800
Message-ID: <20260203041434.872784-3-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203041434.872784-1-coxu@redhat.com>
References: <20260203041434.872784-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,intel.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8414-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7E95CD45BB
X-Rspamd-Action: no action

Similar to IMA fix mode, forbid EVM fix mode when secure boot is
enabled.

Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/evm/evm_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb..a54cb73b51ee 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -72,17 +72,25 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
+static char *evm_cmdline __initdata;
+core_param(evm, evm_cmdline, charp, 0);
+
 static int evm_fixmode __ro_after_init;
-static int __init evm_set_fixmode(char *str)
+static void __init evm_set_fixmode(void)
 {
-	if (strncmp(str, "fix", 3) == 0)
-		evm_fixmode = 1;
-	else
-		pr_err("invalid \"%s\" mode", str);
+	if (!evm_cmdline)
+		return;
 
-	return 1;
+	if (strncmp(evm_cmdline, "fix", 3) == 0) {
+		if (arch_get_secureboot()) {
+			pr_info("Secure boot enabled: ignoring evm=fix");
+			return;
+		}
+		evm_fixmode = 1;
+	} else {
+		pr_err("invalid \"%s\" mode", evm_cmdline);
+	}
 }
-__setup("evm=", evm_set_fixmode);
 
 static void __init evm_init_config(void)
 {
@@ -1119,6 +1127,8 @@ static int __init init_evm(void)
 
 	evm_init_config();
 
+	evm_set_fixmode();
+
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
 		goto error;
-- 
2.52.0


