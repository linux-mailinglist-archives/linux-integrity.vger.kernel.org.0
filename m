Return-Path: <linux-integrity+bounces-9546-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFblLy6NB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9546-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:16:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BF557BE8
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E1F830230F0
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098B3ED5B2;
	Fri, 15 May 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLVei2OK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552A3EDE7C
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879687; cv=none; b=LB/DokpqMKWBeDcrOYeP8eGj3YlvKs6xmkKxxWVqv/Vd6sORZD7WXf70b4fD6wY8EuamWNE5NRaL10fqm/SkNDfWdWfUgwiCLTj57sAET14lRvdJm7kNZ02C8lFX3eQZ9grF2yqI99A3fWbsaiyZoEdY6abpa6SR9AIgxFNwTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879687; c=relaxed/simple;
	bh=Ty5sURnTFWVnfbnIBPkCCksC+Y0itcL3NCDAmhozFyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inLPefpyQDsIkIbgGsvbqa6GjxlQVoXNhdSXOOWKQQkksNb6gr/PwNzh8AhPeDI4MExrmdQG98S33v2t/wdMbpQVwkerDlDrE/VJhfFRosWz0Na5nMgSWmvKTlxwd8tPC5ZfaCvNfTGdFre6w8TjIDB5RV34bGboWDa+rrpPzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLVei2OK; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1329fc4bf77so360447c88.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879684; x=1779484484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=KLVei2OKgLlVbyE5IdOmusvNTPkfJwn3fij9b7ObCFleGFkdpcXRFdMUq/VyKNaknc
         SycDyYTf5pW+1obDdaJCDNorLVWlM/gWhFNomolW60ut0gTEtjt7d88Ok7bK1KPJc2pk
         OcHWM9tF7izGnrarj96Bm0zFPjqszojR+nShHoiUw/R71rO1+tlz4EwBCz29nX+9g2Iy
         07TE0jykFzYdtS7a/8cjPTimcxOYYFoL1CoIKQTaVgz0ALK9BkAH5lpIRaHgkqCtj9Qj
         MDcy53FNoSF0UP1EEQKKbMel7vzhhXIG/sftDh9E2lIlvznng+81oqD1Xz719k5aZmQy
         CrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879684; x=1779484484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=laJ5FfXIX7DeAPaNoD605VmyPCIOQqheSjGKP52ntx0ap9Q8pIzLDKp6JAvAE7VF6E
         H6zUBOISqVBZG2ju0+gmyfc0n/EqnamIOKSDtzix2MhZPlqzIso1ArPXcUVXniXP3OuA
         +xWoOIK1SnGG7lzLCAw2DDZLX08uMOmMQv+8tHvpkN+oL2HLQEPPGkjpG/SZn1XhFVzW
         LYEcX94xdv7B4hm5AeYzwXUx+ZxYKNN2Ec0mCgHpdrG6Ji2Aw73Zp2OSn9bwj4I3M5Kz
         JZyYkcVZDMVXccYubJHoR/i/tTu7hW56ewqmEyfmSPnhcJG8Ju0COTS2omcOIo5f1USY
         Icjg==
X-Forwarded-Encrypted: i=1; AFNElJ9qN+njrKlCPw+biJXB637Eif/wqbVP9ZKPjGhyjgQaxyAHn4JBT892mtTyxVg4DWn8JMLanPYgOuPna0L+uZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2yKC5GUBfkowDvm+6gfKuvlM0kG1Yn5zcnXZpCC+3RlDFLXE
	xRezVy5scYUzo04CsGIpb+IdGV+DTd/9S1rz7d35hSPfTkP2cYIFAR5d
X-Gm-Gg: Acq92OFcHBWZwDgOL+zg2H+48gfQCjawxtExpjCyY3aaT3NfFbKo3JVTAGs9SBte+dI
	o1dvQFOEQ3jpPnw98pm31TcA6VWTS2oZBz5Xc77hd65TwJbb3jgimqESPbfKFIwB+TNe9fNqpWr
	8bur1o+VaeRsASC8QoeL8R2vW1Q47TkLwIbUcjXiPWAbvgdbpiWuMYmNgXquoGwLlB1AgbFIZyJ
	CD1nDnrWN+XEcZE2OzvDqkovoi4xW6dhhntT7Tr+5sUSPBIpUTxMVg4lW0UXpSn2XJlWtbKRrSS
	dtszADDMB3+hmdfvF1OSlKkAZeWCxsBw6dtg+Rkca5APaaXtnHrIkrXAGN5hwzJIE0WG+VJvgJo
	JeHtCdkK3kYGTq9M5aXWfhq+mJI61DqpBwuUCEvlxjxVdSKcoUyt3lmYS1YVhUByOGmdqvHq12W
	8rozaZ+6rYlWoSXi2Rdl8jwswzmE1RDfAY/vcKd11VFA==
X-Received: by 2002:a05:7022:928:b0:130:ca3d:fa74 with SMTP id a92af1059eb24-13504a545d4mr2603120c88.42.1778879684210;
        Fri, 15 May 2026 14:14:44 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm11364153c88.5.2026.05.15.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:43 -0700 (PDT)
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
Subject: [PATCH v16 11/38] tpm/tpm_tis: Close all localities
Date: Fri, 15 May 2026 14:13:43 -0700
Message-ID: <20260515211410.31440-12-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: A21BF557BE8
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
	TAGGED_FROM(0.00)[bounces-9546-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Close all the localities while initializing the TPM driver. The addition
of TCG DRTM support requires this.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..1fbb74a565f4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,7 +1111,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1176,6 +1176,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * In order to comply with the TCG DRTM specification, relinquish all
+	 * the localities.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
-- 
2.47.3


