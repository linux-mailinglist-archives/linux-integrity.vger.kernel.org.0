Return-Path: <linux-integrity+bounces-9896-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bGMWDrseTWrRvQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9896-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:43:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1871D744
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=alxOoBbm;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9896-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9896-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 931A430A7AE8
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4E433BA7;
	Tue,  7 Jul 2026 15:39:00 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE342F6F2
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438740; cv=none; b=ofLU+UpZ399iy9S8DspPDzMXz7PTyXBz3dceSIn63GaBj5QTM8zcrjJq64JgRWYDgS5CGhV1fA0Ak1Zqq1bzvbKvg6A1jbZpS5+YFZ8hODZMukWwRV/1xhDhGnlczsftSqgZcbWHHWj/bpkvn1M3Iv8S72tZzxAa0gQpWNodi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438740; c=relaxed/simple;
	bh=WlxI6D6l0R5RgwB+XCAILtOwfVKifVrQwkT3eMDmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIBw5B6KZ8yxERzyRzuReQaVRcJsM6sEcQvLUP7rxeb1ek5hiPrW+/rBRpLt+cu1eBLCt60S3RIlE4cM7EJdWKF2LWEECufALWNhybGcZGnew4EIYuWh+CXhNL5DOhUNYY9rm9aRcI/C3UuXM5InkvKa6y8PfgOJJYlVf9ALzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=alxOoBbm; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9552285e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438737; x=1784043537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=alxOoBbm3yE7v/C/+wdfPXGx59/B9HpE2+KogRvtm514wDoSe3RvFCnpneguOgfbUy
         NOeXPe+mbwoczw8AjVGyHEeLqxeCO8pH3whmpl6Ej2kqPiH3/DoS1OKRyhxoreFsx1FJ
         ODOuzyvk0JKaT1RvQRvVeo5WB2Prc4+xxOhhvNQMCSJWKW91efoShT7RgAR97blhsn9V
         +qNTHbMl7C2b4/kUeWkGYl5RINC8oz08P+q82I6CVEF+jKUd9WIKQz1PPKUhzZ9uAYgR
         MHQNMHrvUcjZOj+xPXu4qP6j0gs2vf3d9L4IEx+XlqNJBftEp9z77m/D6ekKuGuSIPJ0
         ef3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438737; x=1784043537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=Keuh8ebSXz2AmJ27JKraaFXCWtTBFy203ceqrhK52et1yD2Pg/a8SoAcWJQCicMPKM
         H5unLx0lLZ9xcCZ9FRxjhdxHlfkgUm4rybx7mP4U1HkZyvaq92BjBGMmGY2kgfn9ux+W
         5TGrcbqlwaDjymo7/KLd+v/90KK9MesrgnKxFYqnE6QlyTQR1Xud9p8OjWNINI427Vss
         tkxHl5vDIi97+WhMbzZ7GqjHQxXbmjVnEY2cu9EWyc09y1RHm/iU+dbkoQh7kLvW9mAu
         Vyf0hCHEW+1JvZqslMy1scgidsjLPtoOxfsVhR6k9iZaG4vr9Tql0xMFcjkUHDIOgv2h
         1Vmg==
X-Forwarded-Encrypted: i=1; AHgh+RpkVOyDjGaUseHW4Q9CN3TWs+PaEb6YArYCMdOq5+wCo9DR3aiXCwcUm3FOd/F+usBcLO3Xj6wPUklmYxvv8WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAscshci8mDIakcXMlmKseigVPIHlaBXnVJXhnJ9QRtOC0FAqR
	AOOpK+v3jIQPtVao2EYRRVurhDSvm3HeLQEpF9Ef6o+vsTx0uT04ziFdnX5sCSWyR6A=
X-Gm-Gg: AfdE7ckYHoxGkhQdBuLrRcPviLCG6Vq8tPJdF05+nRv9ApKy0Q/+CWGQeA6pzoPkhgv
	yL1EtBhv/LiUBcFJ/pmFrZ0Rl6+IKJve5M+sFgc6aRrEcfGrigthUeAzsPySB+Y23jiizhrL7Tx
	PUVnFmsrv8p+8kQuHPwew1/jJxkMx/Z5+C9ogsUNhxIPOASm6S1zZqrINMZI2UL22ysk1RkbVDe
	XPSKK9lbjzKoDBK2eUKPOWTMz9oY/WBlo1LCdb7uvdQbBdjBsqJ6hRyo/QNrsWz5mIfPxhCkOYA
	FsRlwUHrLCTMHMEpJVWjXZ6aji4vmQjLxbx1HicYx9S3bTDd8DXsaqfCqcG5AxVDbJDOkEUgFd4
	+vAmtqpIueenpNHKmNnnuYvMcB+J5rm/wnSeeRckZxB/HS2fC4jPz+3C2ia0PIjN0pVpulgJHdB
	VBWXBc9myPtqOJj3iLERSBDh50h2hK6R+vhZAeZ+4vbxyw122bev8BKh72ecoPzqxlxw2gvax3s
	KjBg9qaF6km9g==
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493e1011e8bmr32534765e9.9.1783438731805;
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:07 +0200
Message-ID: <20260707153819.4172541-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-9896-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:atomlin@atomlin.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,suse.com,google.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BA1871D744

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7661faadbedd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -17,7 +17,6 @@
 #include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
-#include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
@@ -29,8 +28,9 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
-
 #include <linux/percpu.h>
+
+#include <uapi/linux/elf.h>
 #include <asm/module.h>
 
 #define MODULE_NAME_LEN __MODULE_NAME_LEN
-- 
2.54.0


