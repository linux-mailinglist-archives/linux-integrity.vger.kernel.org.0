Return-Path: <linux-integrity+bounces-8499-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MegBYF+jmnJCgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8499-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:29:37 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE97132496
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B05F13094A50
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D0226D00;
	Fri, 13 Feb 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWFT2Qnl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sJsF+QUe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F4221D96
	for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770946151; cv=none; b=FaNRvS+kInOd+KAEpl7EzZ6jsyYHfjllah2gbHVn97exo2e7vHkRuIDzDn2tS0GqnATtQz+tutBa6ExBwc9R+7mdNIrBjaLjagZs6akhYjFJVCrt7SvtTa826GgxNCqAJqyh/MMCxpirqztH4KXlNtLxBqNMYj8AgaTLKznQ1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770946151; c=relaxed/simple;
	bh=+1Q2uF6WKVSZBZvU8j4Tlp8gBEODqavEONgkrktkcB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J74mApjFD8+AdYJlaBTu1qUHaCBrY3TmopPvYHj3JO/dhMNHy/nDA865B3pAY1TSRK2r/cAMkfIgZ0Temr1WdbtzDtO2pbwBPuM+L5Rj51GIBCJNar7my3tu9lSoEoA6pGgTUQC90ZvlHfbx6X4HkyBs3HdThq8dt6yTsAq/UVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWFT2Qnl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sJsF+QUe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770946149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxtKY2oW1YBZo5vKqUoQFLmHY/8Z8JRSUUM8/7xMXv4=;
	b=VWFT2Qnlm6/SPUjJWXFHy3HGYCta7hnpxM6QOubXUf5CfqNZNRG3Bk272Pgua+fzPFu3WJ
	rhX+Le8IZmBCKW5KVbYw/3f+JNY4k4MIIGD5JeNZjo9KcSLhGOAxxkEDHk20al+iJ+um9E
	vHMFRPhLPRGwcHgg8t59c1J+H8y0/kw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Fyvna8eJMA6EhkRjiwPAww-1; Thu, 12 Feb 2026 20:29:07 -0500
X-MC-Unique: Fyvna8eJMA6EhkRjiwPAww-1
X-Mimecast-MFC-AGG-ID: Fyvna8eJMA6EhkRjiwPAww_1770946147
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad6045810so3633825ad.3
        for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770946146; x=1771550946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxtKY2oW1YBZo5vKqUoQFLmHY/8Z8JRSUUM8/7xMXv4=;
        b=sJsF+QUePWtFYP+r505kX/Hnni/9FjcLJz+bqcwQy03W9V8qXy66kH6P08c+4Fm+VU
         7u4l9a4rsRq1e1qdkFPP3hCGZfzRquqJj2H2wa5dxibl9wXBz2LG6efm0Hyv4o2HxnYx
         wja1k+fA2JZnW6Nowq2QjuS1/FiiT8lcbtUk0A4dRHv2EjVPDzeTIskIn1R9FnWI+e/r
         vi0cjnI2s3EFRQmuqB84TT8XKM+kxibQ5iF92/9b73vbaS/lq/zKIrwiLZ0HlnPmuZBT
         +V7YXdDNJBUIhXH5N83i0LVPsdLFfe5RkD3gRPJWBpZMIMP1MMSYVPpWuokuJlvW5xRW
         /FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770946146; x=1771550946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxtKY2oW1YBZo5vKqUoQFLmHY/8Z8JRSUUM8/7xMXv4=;
        b=gxN+622l9yBPYWLLD+fDb7E3M0KbAwvkEUw0DnZYclkD1hPSyFO5eJcmzxTFyPKXkJ
         jtt303fbgIDF8ahRA83NYoI0ZOyTqA47iiIawCuJJwWlkhbcVyE5iK5c4rE0RHV5rc6r
         o7qNi6lLC2ISNNQEmRuTEuj0BQMuWMbPuJxXExjuQSkJgtf0Nr1lLldUbne6RBPddNIm
         I34RsL/Nw8WV4B3yGGq5HuFuNjrH7y2+trxhSjcJdSo31Lq3ofGKBd1+ppzDYsA15Ina
         bAjQIXqKOGL0HwChpiJXg5hhZg155yvTNeEtJZZ/f+/n9Aq2gvuk6PtwKawgtJmm7nct
         QcYQ==
X-Gm-Message-State: AOJu0YwF554CfFb6vlBkBd/UwYt42toS5Tqxu9+uay2VgmWLN2wgv77k
	UNNKYFfuLqz6a9QKJAKadrNRFIuPbng7tMNoZf418HvsZesikwXs6dbK6Hffza/SCR9uNTx5B8Z
	mKeKvNb6ilIfZvuCJXB/aRIbd38BnRT1a4SppffZOGdWFuyqUyzThAYjcMv/5+Rqyi/ghU/QuS2
	iAbHHD7/xiuM3noS7kQpodbjzaYtd2W081W71+YkpnS+IvJhwvzjM=
X-Gm-Gg: AZuq6aKDMFz/Mixnlh83c9ijSzuHClP4S/Iw/sCjPOBCAxZg7icem6XKa3rWyT6o+II
	zQVgv02lRRGSDCWPun7shqKDItKZHlBuExGABc32+b723dq+VeEru5M7vo3IUcZSY9oGMdpFyov
	p+VqWxbAuCoTipKjNBuuX+7SQ/y7hNyuId6sNkFs06W67vyrWE71NUO5x9guCOSXuj9Kx+DSKfI
	KcUmt5m6eQ3HxvwX65uQ47wET8QqhkByomOnp+zYEWbPv+jouEcBB6AE7fmg2E4926Uu8Nojcmj
	JwgCEBJcSAwvwlQoOq+w697f1gXWotCK30N1CVr2N3XWO1I7XTKx0Rl6JNMFLxFB8avPR0sIVON
	Sug5UUq3QQ8OI
X-Received: by 2002:a17:902:fc4c:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2ab5053ea30mr2483285ad.27.1770946146340;
        Thu, 12 Feb 2026 17:29:06 -0800 (PST)
X-Received: by 2002:a17:902:fc4c:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2ab5053ea30mr2482775ad.27.1770946145756;
        Thu, 12 Feb 2026 17:29:05 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2999879dsm65059095ad.80.2026.02.12.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:29:05 -0800 (PST)
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
Subject: [PATCH v3 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Fri, 13 Feb 2026 09:28:47 +0800
Message-ID: <20260213012851.2532722-3-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213012851.2532722-1-coxu@redhat.com>
References: <20260213012851.2532722-1-coxu@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,intel.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8499-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CE97132496
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
2.53.0


