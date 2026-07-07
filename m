Return-Path: <linux-integrity+bounces-9894-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lpFmAjEeTWpzvQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9894-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:41:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C171D627
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:41:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=G1JrFb+o;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9894-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9894-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30F763005175
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E914430CE2;
	Tue,  7 Jul 2026 15:38:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D342F6F2
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438732; cv=none; b=CXTeS0Md//rdRkdR6n7C08cvlCEKvK6OmBu0hE1nkXvFnJ02VgRPZSHuSd+MeWDtU2xouw5HFc0SQdNZnN9hnPgKtwiz56abX92ksWxpDrBwWkobvanvQIbDgIAXVs0jFGO5hUjzLOUTNArW50FOSQWzvd3vW22lznLvGGatXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438732; c=relaxed/simple;
	bh=Oe/4C5CNRzZ9YU+v00jSZhbg5LdWqb5vYdjw2GlJdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMOxiD1biRsg6Q95MFo1uD/qHH60r3FO8VZ47reEFLWdkdJxv7ZG6sUJ3sFw9kUWwZWaVfogs7lrmdBVIzWbl4wReRkzeHlRZvL2/FwmBEUWh5uw0qcD5TTivRz313apTgvb6rGaK3keTEFjr35nSie4vJGDTuVnC7iDUY4XYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G1JrFb+o; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so32040735e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438728; x=1784043528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=G1JrFb+o6K3b2DQ4aApygcAtsuTlbZ//RZ8NQgCFFEcdCbT3ldUHbRDBV7BnPtt9uV
         amIGFzJ1n8vaPDUHwrkKlGGk3WEStRjCPWHRTq6wfCvdZFSnw4xyGXQZQlwt4UCjkbYo
         EG+3T8n8+zp/EfAutVDqG4s/AO2nYEo9NLn+YiLXvVYvIpBe2uLJ/26V2Pgyjo20CcTv
         Mg9TJbQTw8ga8Zop/C2M29xCiS8IehfpVnqoLu9vg66W+EC21tcwqSwcj+hggHGkAytT
         Kyr97wP0u8mno9kY4/+1zBtiDLFIRQ6u+ZlCLo13wedVnp3TpP0TQlpuK/OzEVxZZ+F/
         TFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438728; x=1784043528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=YLMhSLK6FVNqIs/dnUPRGl0uv2SMxTKwf25UUI+60vqIy8ehkgY7CAZF7IbP8qzY9x
         08NavD8LxFATv8TnibGYg/ku6jHYCFfOuV2eiJhdKT7bTDduSKo1qPHET9F7i4AMSJot
         H8c+D68HE+iL+wFS99ZpeG3Zw3kVLkT1rvZjrlGI0HCAwfy4pFajBZFLDvt+hCjwrMlH
         HnjeSQGb7dJ0LdZwiROZHI0q9nhBybIPy4MOIluxv/8NxFav0ftJtsdt3/B/oQ9QT4cb
         gyMWIuMHT2sWilVUtTvbXi/nVYZXbROEo3gArwm2g7lCMMV688pfm3ow5Ae8hhPzujkm
         mPwA==
X-Forwarded-Encrypted: i=1; AHgh+RrBzcMKjheXpTSQObdR3bFAvdZwjWe/Tb/7kRhjf6xJu9KDvS7v2mPpNnjfkWUcrkgY3GTYv+t9p3uU1LVQMK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5tpjq34cREGXDG49GSFi/ynEJAbh+PhspKmR8uXwWpqiBBIL
	Ob9PmdsrzEzwUVGXPUyd2tLDP4I9fJwzJz7uZ2n9OM6Vmml6Rp62HG57c1PybFOW0+U=
X-Gm-Gg: AfdE7cmM3w7JQG3J6YANarQ/ciRfhp+VItsIBcnh+UweYkzy8UVDqCDIKFz7IaS2qXl
	bAzv0Nhbd1yNlPfgNmes/IUF1zzmwCXfhriW2g+SFsFMQvf8Mf2fQmb0hnlIhrMai+Y3GHdqQLm
	qc/HT9rd4uKObsFbybijBC1AL+suBzLTRxR81cyCZNWHgxL9l0VEUbIfp3dwdqqRjhwekKqivUm
	t73MhpsUsgOamwrdqvBXG2mobYLspEyG0cfmoVx+UTtk9Gz/9jEk3GlIMdP6KgNMgIPWG/nKh1o
	w+isGwcxvB74zHWCiyUE9ahVgUbz2+8xe4D+bV6LskgN+v7wCya/VHAEUhItgNtc6Yt7zqUDXFX
	wPxLwuixQu9Wp/gLUUJQmeenoXh74JdketZFoMoLIWFxEdCxscbDnOcAqNqJMgRc0KMELBAb6vH
	4Hp0aNSf1jV48F5tzb9Xkhm9p85UzIJcOCoJ11Vangv4IfmrL/vMpzVSSYtLKuaL0AbV88h0Qoq
	NqBE2XjgrKbHw==
X-Received: by 2002:a05:600c:3514:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493df05f8d4mr59362085e9.11.1783438728542;
        Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:47 -0700 (PDT)
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
Subject: [PATCH 2/4] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:05 +0200
Message-ID: <20260707153819.4172541-3-petr.pavlu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-9894-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:atomlin@atomlin.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,suse.com,google.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 802C171D627

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index e6a264c996ce..4fe3ead4a091 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>
-- 
2.54.0


