Return-Path: <linux-integrity+bounces-9547-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGsBVaNB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9547-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:17:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0022557C0A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 408A43028AAE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071E3EF648;
	Fri, 15 May 2026 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os1ZZCh1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1A3EEAD7
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879689; cv=none; b=imPaLBfRIEfpAidvUrDGr1z0Bk5D4qKcucrUzjWZu2got4MEajlQ149JM0MrdVnXf4eoWJPYkClaAuAYRTKdm5zwvSZnBzX4lK0ZvBMgkbdWHoasZ89sQlXnKCROhi7xT+MbWjbdYfcVphxo8RItz1q2pc0Yf8uXcXcXo//PNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879689; c=relaxed/simple;
	bh=YM/w2wtPzdX3RmdPxAtDTeVwrQxqc/8DXfB4OKpz4wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqhAX5wKgJZMKB98MGSbKZYVw+nbLk7HpyQgLodr7kdCSZeazNagjVWZyQthe6cjt2RArHY6Nq0EXYb3+KfEsy/dIFVdvlqt9zXlgaUkOvQJDWrMBNhUScI5Yvr91/F1GGgX8ucn873/2vT82upmkkZlxYzwX+7ZKK0op/lMHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=os1ZZCh1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ee990e8597so744856eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879687; x=1779484487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=os1ZZCh1Md5gOjiBCwlPZ8Xc0AtQRHNjZE2TTlYHhwXTWbiGH1LZ28DRDrwvDjkTCh
         RF2iReOYGP8hfSbbsgWHpDOgJMDFZrrqDRHbWAZVz6+qRHDE5VimMybaJqXfo7iwu/Vu
         bL2pEabGzP2Py4vEGE+SnI+eS7oK2Z6USfzb6tHMs7uFzrK/5kqdxByPrvaKakbqzah3
         utLW/Fz+u7uCZeaSZr9GkdYoovYiDGMfK3prCTQc0Vk9DwkaxIRZct14h5X+5fvWjZd9
         4rLtBS9EMiO8Y0RlqNuQ+ckh4OomzPGg1JQ99NjlNsWLLm/r9IqF/T7RCt3ZzIRU71QN
         Y0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879687; x=1779484487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=e5Vzh/N0iZnMD3i6jIIaVeqb21yY+4VTcrk89xqiQt3w9GksHDEizjvsto71Oh4y8I
         wbTAHqAJ/6JsKpAidT6WFRXyiwoaHJzF4zMgi9yoBa42r47Yoq5b/aX1LlKzv9Xs/pL0
         x75f6He1JI0AHPdxccc8FZkx+TnpvZKyAtz4kGbi+y7l45THTUkuCnZXDIcn5S+o+1UI
         zLJ57UvsN1uNmPTiw3dEEY6SMmzZhHLnzCtFnmIrmW7SkOXr6BTyrhIvq4YA+gKq0t4f
         xbZarc9n92yHIsnrQXHfRDLMfToyAkn09248QLeRDUWrt66dfzuiEQb7wDoIERg6ApZ0
         q9WA==
X-Forwarded-Encrypted: i=1; AFNElJ+kcGu0QE8kNDGhDjvBVMmiXwAKR71xPub/+JY9LBF2xcOh7TfjNukFwiPxp36dRYDvIeXhCNVPg0rDSYFwcEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8Wru8SCYyJv5TVsPxqwQjlLb/2U47v+4hYUJQni0rwQbyq5/
	QhcOeBzLCikC9TwTica5Dv5fdes4erCQYTT6J0RPUwl+pOryN7g/dxvb
X-Gm-Gg: Acq92OGLf3lsVQnPmYuE1rKxYV5SXsUPYA3sp6qiF3ycV/sLJNtJisW54u29ebIvtWv
	n3Ew2nR3k64OiaD3Y9vUvefq6/B4PnjXWLz8xMmxZOCnf6yUOU+gkQ1Fr82YA0w7GBgDAuTogV/
	XAyjmY4qaE2WD9QxOhqDMjj5d39VGF/Ndp7cLtWS/AwILOOSOn5yU/QcRO8CDO6rkJIwoLpu/ND
	+wxJ7uAiRvqlQ9c5rDdEJkmwmoWfA4YrfGGX5BDYvwfRB8aWTOxfa+ftlqNK7yKSjNFuPjGmhS1
	pbuf433P+FdDbNr5USY7n+R7uph9866o101VFZ/fe+JpRldWoQ6hZZlMlXuFKj74bGd7eUZAr1q
	n5zYuocxfd1+kc5KSxqyNeAn+s7A7smyDAWv+QqAVltbLOWj9dTNOCJI3Nlm6mtNO6nh4dmZxV9
	qUYy5hms6cdV6cY/cMOrgcJCyLRBZbHyg=
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-30398680c36mr2863934eec.22.1778879686973;
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6c3sm9740068eec.19.2026.05.15.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
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
Subject: [PATCH v16 12/38] tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
Date: Fri, 15 May 2026 14:13:44 -0700
Message-ID: <20260515211410.31440-13-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: B0022557C0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9547-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Validate that the input locality is within the correct range, as specified
by TCG standards, and increase the locality count also for the positive
localities.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1fbb74a565f4..70aba05f4ee1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -179,7 +179,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	mutex_lock(&priv->locality_count_mutex);
-	priv->locality_count--;
+	if (priv->locality_count > 0)
+		priv->locality_count--;
 	if (priv->locality_count == 0)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
@@ -233,10 +234,16 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
+	if (l < 0 || l > TPM_MAX_LOCALITY) {
+		dev_warn(&chip->dev, "%s: failed to request unknown locality: %d\n",
+			 __func__, l);
+		return -EINVAL;
+	}
+
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.47.3


