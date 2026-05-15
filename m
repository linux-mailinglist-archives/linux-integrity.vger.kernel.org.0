Return-Path: <linux-integrity+bounces-9541-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK5FC9mMB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9541-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A6557B4C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63B96300C31F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDCC3ECBDA;
	Fri, 15 May 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObM+UCfj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5A3ECBE3
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879676; cv=none; b=ktMet6MhwilIXl7XILjmdeOLYmNWrCEY5H1j4vRCzK8JtioxgROGH71LHudE6jk5Uf8c+9JnDIW5u8+I20KxT7eh27vuappHdK6ezCkuOxMMEqMXJrygTGJxK+lr5XG/o4r+Q7UBRf3RnHtMd0cu7Xwy9kn+YEg12OPqOUdXnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879676; c=relaxed/simple;
	bh=tgSnXEl/4HoRNelt6PM6wKCfW7tff83XdCqIyzj9aek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv0K7TYIsConnicfz0JmwbOYQKB0pZ3WKom9l+wo1eHnP5pCHLGZZ1EvhJrRmqN4/jJkxs2kMNS3A+5+4D7GsPlFGapEdBubUHJ3mC3dymfPbZLLvqdGXTeP9+PGBAl/485xQO03o5fKb9hL+UwnL1MyKlrN/3eMkzxvUatwrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObM+UCfj; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1354195eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879670; x=1779484470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=ObM+UCfjlsSeq0ZhH2iSw6wylKUn+YVk5t13OqFDfdGfbbozLB7YQAsohbocEPamxg
         M666walSMK+bu4f9T2c4JE6zuA0wm5Y0MWQOtYn31jq13dsxCJ/7NExqYnPmw9UFYFXQ
         2jco6BxXkT3ocPurrRUjIjfmO7d89AGKLRV8X+sqGZKOUFMmy/yBJb9OomC8c/MAGGnk
         X8ynJploJbAVYG+Xn47zvRjtY8LTzBd1R4jxcs/PqocpOqwbu9iB++n3gkB/tQL5OmWN
         1UE8UNEZ/yHl5DMhrOWCIFuJnOO2hJR7uO7iBYQfjIo8Mj3biG8SazcBNV75QEM79d/o
         r96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879670; x=1779484470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=N7ZN00CBsYSS5F/KdYzJ22dzEsg+wTNjqmkmnUsxWxZZL1ay7FECxus66tMTDahi7q
         MaqYJYeXC+IRpCfqJj0y1p5kYpxneLqanc28Fke4rJvQ2lZOMx2jsC4xkcCyUDXlpG58
         UEwF4lmB4f3kE6+wQkmtbIWBm+gtrb2v80MvjGM/0dC3iuTvnc9GHhFntwjnVK4sxNz9
         EYKifBC1M4rRpCqam0ancsdSQdpLoWuaMkJGGfWsAEGHjp0liIfoDyHIFpTHxH/VT3MJ
         rzoP9YG1hi3ut/ND2qTOt92BzrTZmnb2oX16765BJjHFEE4985bgUteBWTD9va0gkCYA
         zvmA==
X-Forwarded-Encrypted: i=1; AFNElJ/JBIYSEBeIJRMwNAWgr3lfZw1yJkfPSZ6zamiFjf9msDjB//2qPejvUegSB7jP9fVFdNtZ+xP6E68OEQsCC0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1dAT+b84UKKl8LzFfVVLCZJtcJUOlwLQpuUTxeHVZ+b5qcm+
	fPH0HRgnLmGqfx6YY4VmaZ/J2+zjtLIi6soO6N8xJTIsK1eUzJ7A60ET
X-Gm-Gg: Acq92OF8V1jW9WdIabyZPxkTgdnKOpRcwhMxEEJdJ2ivtLln+3gfqmkE1T962N1rTJw
	fINjGHHnq6wqZzZ1OdR/jL0C8+t5IPijFH8yQVfv/SLHWWtradnlE0Xr/hSTvgpP3iFwyKc3uji
	CWZ76BuW0Ll5zNLXYIle4IsTBxnz4eyMPGQDY0Kn1BUwSbpmotHdC8ZW6hFC7KAa+uxUCKHdNJj
	b3DczrZd/3hP0V9oqIp0lDuHSqfcNBwjS4h7Zxh98vkEQbG8kce84lNvfGeex1dEki7GgghlAP+
	trPuj+kzGKqCh+dA/3CCg2XrUzPWbtcaNTBs+a9pim8WUB0Y+QvCyA2VPXnPVxlpyY2Tk5siTV7
	EH8Zifz0QN8UD/nOdSqyyyRp9M1plnRDiOeNVBies/ZaTCBLcud2DpgvEFl+m2dVXgXe0U6XE7r
	rFTfQ6oljD4Ql21PZGYdjjtleygjUsoTg=
X-Received: by 2002:a05:7300:e6c4:b0:2ff:c84d:44d2 with SMTP id 5a478bee46e88-3039815cae2mr2917959eec.12.1778879669685;
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm10323215eec.30.2026.05.15.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 06/38] tpm: Remove main TPM header from TPM event log header
Date: Fri, 15 May 2026 14:13:38 -0700
Message-ID: <20260515211410.31440-7-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF0A6557B4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9541-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alec Brown <alec.r.brown@oracle.com>

Allow the TPM event log functionality to be used without including
the main TPM driver definitions.

Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm_eventlog.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e82558..367b70ecc4b1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,9 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <linux/tpm.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_command.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
-- 
2.47.3


