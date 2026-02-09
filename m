Return-Path: <linux-integrity+bounces-8480-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB+qG/dPimmbJQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8480-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:21:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC22114BB9
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0D0F3006D4D
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Feb 2026 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE230C60D;
	Mon,  9 Feb 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UjWsGNw3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2F2EA173
	for <linux-integrity@vger.kernel.org>; Mon,  9 Feb 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672115; cv=none; b=hJ72AIX6dlvqmi5VVKlRgjaI6sqf97rR9MRkU3zgQchVN4Dsyt1RnL14RvjoZyIKiO2sEjRhs6bN3kvo3PnJ74HCq+r0FtamdnFBYLitkrWhVb6N7RKjbPUhmWL8YQMXQ/xwchPMIDVh6L+OjzVWuJY4xa5FQYOzM3t2sSQu+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672115; c=relaxed/simple;
	bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R57amnqquyensQdlFEuZJaZ5RHomq/S4Ixizv9lUCX5LlkjAgnA+X68s/3iQM4eE7NnTV/J/YzB9IHLelT+s+1R+P5XqbRwH8P5VcIk+sNQLlZZTzgKX4ozuQnhEAV/8bt2eh4Kv2dk8maaQF/Pkv5e0KGW90OV0rfWAbuRrISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UjWsGNw3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-662fe3ff6f6so2571062eaf.0
        for <linux-integrity@vger.kernel.org>; Mon, 09 Feb 2026 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672113; x=1771276913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=UjWsGNw3GBANp1Ibh+JJia1OeYMnwWi09DWePej20aQMtbCT1fXT/G24nTO6bGhMmL
         SwIJ6FnnfZ4gofxXO0Xd+VWhVCl71k753SK+tXn6CJCqBdciNTdsP8zHaZCoK9XcBE6B
         RXQkqkxqXWNycwtMRR5rkMvfaBb2cZXJhej9zxrOzsn5O98IpiL44p4HVs0yHSp7UBXE
         5dQ7rF51s3JaL9ZWDJ/WfSZ7LJ1zGoIfvTm/WtnEt+zMixPEzcKgRQd6kfn9R52XvMnn
         GJi0Fm6RP+TfOCK6hwxUgrtVOHTzlytSVIRORoUdjQxqfQ/4OEaaykkckgbTO6JhTO6o
         6bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672113; x=1771276913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=K806e7L0ilem6A1caFLWScjUmf5PrBs/W53Y36LeoTJXNuBlSyHFmkJFPdw+S9gFCo
         n8lPvXGq/xyZtKjMvgMSNTF5vlrF1M98E0ipQavPccZsmTueINKdOHIs5vgvFl0sxEbN
         uahDTn5rvwHXxIRzuCq0hKeXhPINYa4dCkrc0bK1oKaQSwaAEZ0DDLaeAwdvYQlNXJXv
         q/vFazfxOK2pGiOOwsb7nw81zn/r/K2CAw9jcHcpQo1EbNv9sr85e76ipTw660n50ZYU
         FiiBL9s/Qisfxymk02GR+oZ3C+JS32Qay20gIsY1bZO0nArxN3ZT5WSnUIXt8ZemLzWW
         EORw==
X-Forwarded-Encrypted: i=1; AJvYcCVnHim0NaskkYGB3l0VhW640KXckGeccJLx9QkGQ6jmxm0iewy81azv0nS7jZDTqVCP/FhXhmZzVHKph/TfxYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lFP8zb9wPAtixB080um6wJU+dm2FDhegf4cDYz0lVa+80cGk
	Gl2e9Pr/Nqo1asujM2Zfutvc630ZEXpWOQt46LiXAhf3bpGXwqhFV6qVxGtjQjE348c=
X-Gm-Gg: AZuq6aJaMu2dQ8WzMDVd//RsD/2aI8itTd4yZ0DROCYmuPucHIQ1LKTogyvSOzqWCwS
	OwyeDxAIDQxrm4uIU5/R/Ic4ISGnVg3Ka2AGzLqT5iXsE0Wck7TxATu2T/xzAjY2zM63Ah7Wm0+
	XlKJlYPzIp50QFgkjOH67NDElThQbkGKadkN044BqUa5Lo6+qsFCBKz7TJC+nTtn7uOH733zRiM
	zxTlGtJndfBCU1xj3GL9hNTcbG2njUV/wxcFSq6m5KmV7CiTmLDm0sk5nzr327e2D4wPxpFu3B6
	44xn+49YS1KiW69GiOHEYKcyWqgjeSivHcTeJ7HNM++nhn1u7pMSqn+2/GEvorGAOJUTGV0tEmL
	rM+FMqOOAbRH1g8aS04Y10Tg4m0X87eh4o+Q2M+nxCnqxJZQxTFN3yHvrWh6C3wDO4Ld03dqW6g
	==
X-Received: by 2002:a05:6820:602:b0:664:685e:76b3 with SMTP id 006d021491bc7-66d0d205325mr5909878eaf.73.1770672113246;
        Mon, 09 Feb 2026 13:21:53 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:53 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 09 Feb 2026 15:21:48 -0600
Subject: [PATCH v6 1/3] ima: Unify vfs_getattr_nosec() stat comparisons
 under helper function
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-xfs-ima-fixup-v6-1-72f576f90e67@cloudflare.com>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
In-Reply-To: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/tn6socxTvLoAVUKBxgks8JYngsmEQKClzr
 9PM/m9505aJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7QAKCRCrJbR2A5LT
 bWf/EACRQr5bwV3DkSeYkjepPfCow9f0Jr7heeQz7lqiKJFOsMCSFCDBhJYOA23nT2Ea77SUlPe
 m/Uwiv9MG4ys0RaFvnPwtTDrVX4CUwWZrq1qaCadNlL8gfnJrHOHiwRFMkJjE5Ac332XRK0lcIX
 W7cuICWBzOZE5PI8KIwiijeL9ZAUDcGMYNu5FkRK9MkLSU5hyOr9vDqTi6o18TR2J+/FO+uCAss
 ZpKWlVck4xy821WwrgLUfCMZfYWkRd+Y2H//r7GA3Ve2/Ya25h34L9RKxNaJbmrjluV+sGhQHrT
 ELDCW2TA1MMLooG8qd07MN0LoajUHEO9amvBMOX3pdbl7okt457Ogc2GdKquP31STJFmhlJI4mz
 WulxzkC9LhFbzrCdVs2ZiJEufNxPODo1aZOs4MBqE/CT4O0m4lpCxFIGUe2cMEDCAQWXSr/bP4X
 oRIIMdOvZXk4jaAWUuYv0r9cZhQjYryDRFNop1Yxk7rne23EOLA0CLm0gWHQU6FxxiPJx908WIH
 cbH28KD9pwJ2zmsR+IT9KZUayWzkVlxTOPWRG8v0LLYSaVjoCKdN5WOAMWs2WNfOFWZvN7XR9Vd
 Dc8UZiu0RoEkK88tfAenmAtq78oIW4WDIt2XUPLV41BIG+H/ejmvtjckxEN54W8W3ugoKLlA3he
 PfKIr1+nk/S8j5g==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8480-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email]
X-Rspamd-Queue-Id: 8EC22114BB9
X-Rspamd-Action: no action

The logic for comparing kstat.change_cookie against IMA version is
hard to read. Abstract comparison logic into a new function
integrity_inode_attrs_stat_changed().

No functional change intended.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 11 +++++++++++
 security/integrity/ima/ima_main.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..beb9ab19fa6257e79266b58bcb5f55b0c5445828 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -49,6 +49,17 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 	attrs->ino = inode->i_ino;
 }
 
+/* Compares stat attributes for change detection. */
+static inline bool
+integrity_inode_attrs_stat_changed
+(const struct integrity_inode_attributes *attrs, const struct kstat *stat)
+{
+	if (stat->result_mask & STATX_CHANGE_COOKIE)
+		return stat->change_cookie != attrs->version;
+
+	return true;
+}
+
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
  */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..6570ad10887b9ea1172c78274cf62482350e87ff 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -201,8 +201,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 		    vfs_getattr_nosec(&file->f_path, &stat,
 				      STATX_CHANGE_COOKIE,
 				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+		    integrity_inode_attrs_stat_changed(&iint->real_inode,
+						       &stat)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)

-- 
2.43.0


