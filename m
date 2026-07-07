Return-Path: <linux-integrity+bounces-9895-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ALTMOkoeTWp8vQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9895-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:42:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3E71D63F
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:42:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=R86JuE7i;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9895-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9895-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC243307AF21
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90BB431496;
	Tue,  7 Jul 2026 15:38:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA2430CCC
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438733; cv=none; b=F5esWyqQP1WJ8FNjPhlMRU0XCLz+MfyxNOC3MnCA7AbuQMHcWBgf5UQiME1bmAloL0nuaHC67F2+j/qnQ+/MKXTYm6OgaHI2xpdtXwXdJelUOd7a4HPPnkKszFDrl4ZE7H5BARJrCxCXOO1ktPzhsofpJ/rDPgPRYsSJmgo3ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438733; c=relaxed/simple;
	bh=gkAPXKFXbOoLtNAqBKO7qS549Qi1Dzx+1+ovFhoFLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2fOfbOavb9mUMJPHks3nRl3Nc+9XNyAplpl1x7ojeKeuMAwiVz4RHsWm1yxT3s93dTE8RhqO/3AbqTHpL3fuwJry82k1Y8wdL7R7jSFYTI14LR/wtp5rdW43gyX7mITHFRmAdbZvwqJWPezZMMX3IsPYPcJvVed4u1KoTchaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R86JuE7i; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so32041145e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438730; x=1784043530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vOu1MKmEYCbchrybWpjcqmihonsI67IBicqKFbwWsc8=;
        b=R86JuE7iMp+pe9TRfWpgbxlD+2LwCFrwojttgNNChu371QHvC0r/Ris1eMX0yk5G9d
         8ViWxkM/wi4+4u6C+FYfT1TZCvknxYI+CtOOo49uvkSQVX7vu12y9DBTTDr3OvCvHwuQ
         ZVBscPOurQ+zEDFWjggRpHPtpUNAqpByr6DM4FRPwmMJVPrq02VGHdJMBC7i6q1xEXY+
         Z2mh7UMr4DpgSo+H0n66sqmIZyVzUnOml1k4BW9ym7RL+Yzunw+DvbFXsWDW3Idd29Hi
         pj9RsiFeVxs2T1B2fvCfcswPXg2tg0BSIyVhLiiJ1WvqBD1rM+oecl1Jj08l/s2S1GDd
         +wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438730; x=1784043530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOu1MKmEYCbchrybWpjcqmihonsI67IBicqKFbwWsc8=;
        b=Ued/6/HDo7GOpWFm7BAgCtKLd0GOE3v3eXbUF+SUQJTMChNWjlciO0FZZReRdlYxjr
         OmDWlrhK0tWYGL5GJ3P4zbVMXw/qMhE47n5SGunyDAYgBz0XTGWu32YsBgJRyFCoOGc6
         COTSFAIwVmFCQLEFiJI7YRvlxGrCLnlu+3OPMIZfD7iQHqLDW6jjUR5iBmK7Ybyxq8YH
         jlVrs1e7WPqxeyMM+ZwyRo6yJg0vLNucrYU/f/Y2zWBCP9PKVQxx9aTf5aHSfNEm8Vzm
         8BC82LWmajMZODsiTMHnyq//3OhvSlKuF1quc7iAhcX1Nps9zte3xTc4G6VjSou+ZnjB
         POmg==
X-Forwarded-Encrypted: i=1; AHgh+RqSO7bXA7iVmEiLt3UC0P2aNs8DtgNaa28KD9/1d+h/TMevj4R4jYKuq8UrxTdowTjpjUzy/eGGMfH8RLw1P8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Wrq93wZM3P0Ng0HPKIphKHdlIM6ahYT9Ewd+RfU6JOVIblC8
	JF5LBYmuEqBTRSbtoTvAcUpzjoxAiQLLdPAmgzVVm5cEVHt6FFwNDuw3jozzKk3bYHs=
X-Gm-Gg: AfdE7cmBuAJ6cRVMhBlQm9I5dJsK9TdCgrxWtESVzjKZD8DPn2z15sFmSHGkI1scVr+
	73UQcd2oi7umbYHZfJTLfskijugK91ZSYjPXnDDpE+tAME0p6ObnaZSjhNtbtXXCIRCZC4cZNhY
	qO8AZhEL+JF4jleMSMnIrl1Muc+4Eg/DqMqbp/YiwaANaobl7EEslHyS883ugh61d4STqwusduQ
	QE/5G5I2J/22MYouEPC6+DuVdIYGBNe3M8MmL3b1UgXFGefltqqulom2EqwjZdt9Dj821v9UanY
	JgVoht5/j6OA7G+o0I6KLxF71sQVQpaPL8uYcso9bFkTCN0frXIq92Jp6qjhYjm6E7zYv7aClUU
	z9Y3HPj5CpwLWgfJlhOHYzuvNHRZLKZlu9AcbI2GOZfjno2ZcwgI0MQwgmNeV5FS/mELanty7+V
	R1j7tKjVObR+S6RItamNAvfPPnA76tAfqebNGorSfy5VhM5sENYLZG74n1CjS73BWht+PDf1goJ
	BmSuN9Ipc7aNQ==
X-Received: by 2002:a05:600c:a293:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-493df064c39mr42510935e9.16.1783438730221;
        Tue, 07 Jul 2026 08:38:50 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:49 -0700 (PDT)
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
Subject: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
Date: Tue,  7 Jul 2026 17:37:06 +0200
Message-ID: <20260707153819.4172541-4-petr.pavlu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-9895-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DA3E71D63F

The drivers/char/tpm/tpm_crb_ffa.c file uses kzalloc_obj() and kfree(),
which are declared in linux/slab.h. It currently relies on this header
being included indirectly through linux/module.h -> linux/elf.h. Add the
missing include in preparation for removing the linux/elf.h include from
linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 025c4d4b17ca..af4466cdc297 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -12,6 +12,7 @@
 #include <linux/arm_ffa.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
 #include "tpm_crb_ffa.h"
 
 static unsigned int busy_timeout_ms = 2000;
-- 
2.54.0


