Return-Path: <linux-integrity+bounces-9549-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAI0OpiNB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9549-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:18:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F4557C6A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7512D30331A4
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255B3EDABD;
	Fri, 15 May 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4B9AeC9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F053ED5D9
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879695; cv=none; b=qF5PaCtyyPktCawRerLtQfH1bVEP+HfnpxcSHAAa/TTDJREdyz7ywOWB6izeSkHXkn68xbq80AlfYAfr8kB8VFip8kBDfA3O6TRRgkc3UBUJlW+iPNexl9ih5/Uwj5ONWu93vd5J9ViJl+dTrZSIPxbG8BJRqAPkiiPekas1CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879695; c=relaxed/simple;
	bh=1PNKH8ntc5kC54kp2fuFbfDzJKv8jvUIR3tksHCBOAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXAca/5ewln0nKi/7ReYRYCRMiuN7IZ3Ea8oFimgiN+veXpB+i55NoQaiJfaxzPl5y3i6qoi3GsAZy8XP5GEG9Qy2ARdNG7uSTmnspkNDKWfrigDdZCraRrg4XGECUlCM930gq8yG8Mjx2hY0qR50ChNZ231X0bh3BAu4aJoNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4B9AeC9; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-130c9dcbd25so971243c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879693; x=1779484493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=n4B9AeC9zDx0FEy61vxCAx34bh29XmU3Z5BLbMHLAWE6O/wVfLEQ7FP3ZxbJ1AoO+3
         Q4IHV3iLrro6B9OWZyJ0ySCAfr2ANN3nJAxGRaz1CK03Eoyc8cXXyFDi1p4zrIbByLoF
         G/cWmmNLtCXFwLtotFmS8RwPOGBQ8Im+/5o1GAj6F/uWiCeG+pViN8+NaZVMMiMIq38q
         cMdvzU+l67iNywwvtRHAUcUPuYfZ6kAu9H14D7UOnAwYg1752Zphkw9oNYZwOz3VTv+A
         VXOCI69Ejr5PPmdrz6GB/RqJEsB8H1kWK3SuoRQfFy01STwODufsTeKZq0c9so5S+Zxy
         guMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879693; x=1779484493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=XSl96xcKoLjc+9sqc4BeiScCJucIQt13fPK+2f1nZjkm4dJwrEV/TrR7hLBlYOh5NA
         NX55sOBAOUHTftU7ZQ+ar4EDrYujDbCRmOxwk7ulwETqWU27tH1ZyAoH1Vmstyu5tyNM
         zUkymYfDWdDoTeecIb9HmUnNVQiDgIdiHZ0YxpH/KWxhgXW19Hw0icMeSbI2ExmeY5zJ
         ql9WrnFZxDpPmzoIKPv5o4xxaFBdGDh1YCmlWVqM5gjDzfOwqcNZj2qompqLtgxDIQUo
         QtR/kMkZpE5pUf3fYt3JblS78HiTNUiN3Op0qKPyoQxgPMPzilb8gDCONlnRDIjjcJri
         xKHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8tXt+A6cueaE38cua27WLTViU1lWe3yeoVeO/tMlx8+KWywl/vh26spg5Vjk3Xh39hbOzDZTisk0kD8fttRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlE74sY7mJHHc4AuZ+OkZzFU2WQVYcIkPGdaWn21rqP+veHdH
	H8u4ak6d+gnqretjSci5Sx4339gCPhiGFS7dYgWRYSEmaCnaAedfvj/D
X-Gm-Gg: Acq92OEZR3Lhoxhwx1HxGv/QA6MsP6xEE4OKLd8Nf7Y0QFhxYT7G47aM/J8Pu5scLN0
	1gbBogFXIumAuCqpeCfgh948LEf3d4ci38WlR49qM/S8HlRvY2SBdRnN3ye98Vrk/0kpFa+x0sn
	89wfwBtmUy1/HbfUp35yAyEfzrLgRIVkhxZs4EJs53ErUhIFk9mqlnWuyHPiVq4ZCzVmv3MxBos
	2fGg1FC9H7JmoxW9Kd6i/EEe9Xe3hVss/ZmiT7klfB3g3YxAZgT6lW8Hq693tW4AoEnYl4bbphG
	rk9VPzvMYB4c/tinMBbUyy1h41r4d3NHatzSrIySvlznWX3DfN4HbpY9pmtROOWSJLK+X1bqP0V
	594DzbFqdnOSraqHceFVjn7jrrBwjhN9/0ff9XTK/xJ7q+yPa20S1qziTjR6qmIwY5sQ7EmUqiA
	0i3LzqA82v/HNZZuZNYrzNp9SkuD+mUQM=
X-Received: by 2002:a05:7022:79d:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-134ffe943c0mr2448441c88.11.1778879692592;
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740184c88.15.2026.05.15.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
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
Subject: [PATCH v16 14/38] tpm/sysfs: Show locality used by kernel
Date: Fri, 15 May 2026 14:13:46 -0700
Message-ID: <20260515211410.31440-15-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 925F4557C6A
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
	TAGGED_FROM(0.00)[bounces-9549-lists,linux-integrity=lfdr.de];
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

Expose the current locality used by the kernel TPM driver via
the sysfs interface.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index f5dcadb1ab3c..772c4ae67957 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -308,6 +308,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%u\n", chip->kernel_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -335,6 +343,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -343,6 +352,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.3


