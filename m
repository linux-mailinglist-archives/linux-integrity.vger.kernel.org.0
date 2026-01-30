Return-Path: <linux-integrity+bounces-8379-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OE6OEYzfWntQgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8379-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:40:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F927BF2DB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB038301680F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 22:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88E38A9C2;
	Fri, 30 Jan 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YOYIrEYL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0438A9A8
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812802; cv=none; b=k7wEEx3y+HR2oR/SQbGY07v70nJ5jLc//XyoEOn6PHav3klYlXsi9bito0kK13q905iMEqPI/IpGQfpErZxEy5Qn2Vq9KsQIN7v76ZwBQE8GnGfvPh6Sa8iYqly4Mkg4rUVqie8kVtF2N1PUxfO3ycNA3Wc1Dbw38W3mjMHtSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812802; c=relaxed/simple;
	bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS1XcvSqEmRrZPGERAzT8q8c4zbqJL2aQLFEup+8m21HS0nuvO1bROnzbGwASwXTc8WFbJv7CZ7PbaOhO8fFSs+wDHcZNYQ22kfx9cQ6MBwAaGkpxSP+njIz8RR1yojaE2IHqLmTwV2nE1Ii0emuXmZdrVbs3PhTQ9FMKZSKJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YOYIrEYL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c715116dbso1832471b6e.3
        for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812800; x=1770417600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=YOYIrEYLSK+OwBtj0/SiziEZrvSggpPapTl/A8IcZiuCMzAzbck2AezXIrkI6FZBni
         ElhmNNdFgJoQlhbbQvakPZrGqbswkRRZgmj/kX2P8CwxPIjTQ1jMldHGbOYmTjFGB4Oo
         4B6QOuRWPZuEYSOsOCG5VrSfMqk3uieU1I22eedsFsqEPGkMPAaZ6oSwqWxMllmD1s/z
         89SFm2uZZzjfbG94BsyqfCuMmNvUnvFxEOYD4qUciUSbKf8v810yYVkxzkUUi/QMd/5L
         qaT0SePIda0ReozNvrgksypvVBDbZdgr8dKrOhvs6knDvxmqcjQGVgNFdbz363CsyFfE
         LItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812800; x=1770417600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=BdfhQZ+YfpMaNfBTjNLqZLzs2VLFkzGt+1BODOYr3ysm/wN5wLDqEoyP71SexF6qDz
         dx3UCh8Rdfv2rHtlSjQFGdn3btGPREmY757J9BDjpPALtnEEakNGSl5WjH3NjP2TeXag
         ZeHwg9an7/S0yw3Oq1BH2p7v5La+doh44ejNqGbeh5d/qxFBeTq61sx3C/JELoXBMvez
         GJ/t6g7PDPiokOPMNpfMQYko+5cp9P73YRRPIQXcDCKSqKoHEsRXVTBNMfmom7ZCkgOh
         QO6LpFYnLkfzAb7GPBcB4f++lZw1r5xIK5u19PlQAOb1kAWz1kK5M93M3XKBKl3rGZYX
         HZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVV6BPXNztNWfyJg5TRy3Rz2UC9cWv7pc22ugvQBGw6a1HanlYVxyhGrY7eOr3NRckmd10EP2niuRxQRis4CaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHtA924SW1VDs7VZsvFV3LjZTXRYvU2D566CSg7cVSs8q54YC
	rO0pQVowoHyPk6WUxpz0IyLEdEY7o0VQFH6ExNOmWOipXq5r4HRJwEUHb/EjWgsEgmOoElRidY2
	IOn9f
X-Gm-Gg: AZuq6aIwuizC4z7IgCA/7dxq0kwiAweqBwRhAac00e427lOxXz5IRHZiaxEvKBRObyK
	mqvBFQxb/ZLhLisiNnvLzgMFke+bNcrveUGv4WM0+qZbGSowyhtGl1KwEvoc7+aaLY4TD0bYGGA
	CiOoZ8goyXvicbmrEAfb4+Fco83BVDed6ceoK6E69zKyEAhVNtRVpKEPxHE4QRvUGoNLvlbhauZ
	jKGm6fq7GrL/OeOPojC9LJfk6B01E8Gz75UC6Yt54iLDeDtFjBEvtGf0TSOhZJIaFJD+AgR0J6q
	QcerBXVNwgkbdxdIjFm4RSzB5HFR0gzXTViPjWF+SYXq3DWCSYJGVQ/kNDdTIawZs+FHBA6bVEc
	vpJHjatXKR/pn/6nmeU0vub8OBFhZfL2rWqGGdRZpZlZd+8OlokCrQnxOhpyXMhnVNPRmkGk=
X-Received: by 2002:a05:6808:11c5:b0:45e:d128:4d13 with SMTP id 5614622812f47-45f34d19956mr2522871b6e.49.1769812800117;
        Fri, 30 Jan 2026 14:40:00 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:39:59 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Fri, 30 Jan 2026 16:39:54 -0600
Subject: [PATCH v5 1/3] ima: Unify vfs_getattr_nosec() stat comparisons
 under helper function
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-xfs-ima-fixup-v5-1-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
In-Reply-To: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
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
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM8lcduKiPT2v6M91vJwSr90uuaDvHoZheB/
 F9zKNZBePSJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPAAKCRCrJbR2A5LT
 bSSED/sEVZhlYPnUNKkoKX0RoLgIVqQ1qaf8NUtXQvOWWKw3yRufG8Z20gSOt4Xhmuw7C2alPNL
 8LL5hiT5WrMjuOL/PPX9AXqaBDEpCLhUbPQoR5g3ar7lBvOnEMBdKO1tUgqE1HpTcBwT52wkgl5
 9Yt/I3KjWimJf50jNOhlS10Bb4a+UoIbTPTfRPuJ6mTZwi9ov7IQL2cCzdbf8RURF9OGyyzTjX1
 V/UEI8hRwljjwU3c2LVKhsy1NSrSrp23skSVtGe+M5+j2ZB2B8WKAT8SGNErBHbZJ84r4Ocv8KM
 3XKaIl1iQPA7ZZgQDWovxs4FYKAiaNT0mKCcgLCyzh3kzg/Vq1VvnsZpeD9VeUGjv6/25Mr2/U7
 CZmohozREPihYLOHpFLXB7u+dG8/E8io5+G5L0QMug943Yx+V44L0SZBk7z1iQXILscb5uM/EJf
 wqOTQBOHmmWCvT5Q0JDsX2CRPnojAl8evdpQguUM7jXZWWFXqEML0j3iVuIfhbF2LxqrWfkXjtj
 NO1oHSoGBCBMjiGqE/mW0NdZ4SRf//jyH80O8phnCO9SK192ynXXiHqufKIEPqvTunKPjPa+Va0
 MkR4lwI1FM2+fk0lRExqD4H/pudElvIJBnUswN6ARQdZpBwXbvJy1xlZYUfcGUFWcNEgzdWQr8Z
 2c14LUU0n1dZppA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8379-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: 5F927BF2DB
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


