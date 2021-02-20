Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00832028E
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 02:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBTBeu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 20:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhBTBen (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 20:34:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F095C061221
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 194so8793845ybl.5
        for <linux-integrity@vger.kernel.org>; Fri, 19 Feb 2021 17:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fRH0suW5jtV5qAv/9hzDuKsmxWRmfZBdn7mAB9P2pvE=;
        b=byWiim3QE0knNixnCWua94fMT6ZqVaWQM7DAWjI8sOF/A9MCSvBI6ckmBOAEqHssGM
         hpLvNfDbwchtlEaPziik0j00EJn1EhPQk4wQUt/FWCjsuQgvAPEeh2uyAlyAi/Co0kpd
         m6CT/ChIegkXc7m/O1waQRYP5baJ8f46ge3bnlerhAbJDgF3JJ0eQl1bvEJ8n3N/jbrC
         HZMRSqNOxfjhL4xt8gsd0Simd6OUQORBeFGGMI4s14aGQBg9KvIfER7H6GYbM6QIoXV9
         THpQL8ebNwL2FyISBYTqsO1UKoPJRceLP+HROMTfo75rQ1+MmQFON+Fmj1G4VZPDBvqx
         MWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fRH0suW5jtV5qAv/9hzDuKsmxWRmfZBdn7mAB9P2pvE=;
        b=FZGFwQlN9Hfx9/yg3soTnPKr3WOQaQqzbQwBuOKRcZEoTjQMJWZ22cutf6VHu0OPSK
         rk3lFOAAGmdgpOcC0Fks3XR+qTXwtPeZDl+ddshoWp6y1Y11yycZ5Dp0KA8VyvNdTbze
         zwN1YfrV1NY/VdfCMvs4Mqs7K2dSOdSxBr227fSulguVuEkYJmUQ8ima+KR80z9PySNC
         1A6+djJaKxQK0jjKNJsl/1k0UXqPhwGeOq/ufAYCd3eIal737fkvOCfNavGbcR0nh7sO
         UPS9EZ9yI2UEfPdu1FHTf85Sokiu3C/HuttQB6ffN9CGfTZ+k0bxNDDQJLiWO/lMYP03
         CuqA==
X-Gm-Message-State: AOAM533f8SSEfMEKl7p2Wf46diIeiqcOSI3U1NMRoNxf81Va4OOBno9R
        wvPDyv164HbI8uRrdR8NlS/Nyj3hMq9+X3SXfKTN2A==
X-Google-Smtp-Source: ABdhPJw0f5aK68gYqHj2EspA/X0qmwp/7lJNqvTB5aZ184iu3WsFJpaXKjgNIwrLodBt8D7h3iRs7a9ti+SgjWOQKlOogw==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a05:6902:1003:: with SMTP id
 w3mr17858695ybt.445.1613784792782; Fri, 19 Feb 2021 17:33:12 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:50 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 4/9] security: keys: trusted: Store the handle of a loaded key
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Certain in-kernel operations using a trusted key (such as creation
certification) require knowledge of the handle it's loaded at. Keep
a copy of that in the payload.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/keys/trusted-type.h               | 1 +
 security/keys/trusted-keys/trusted_tpm2.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 020e01a99ea4..154d8a1769c3 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -21,6 +21,7 @@
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
+	unsigned int blob_handle;
 	unsigned int key_len;
 	unsigned int blob_len;
 	unsigned int creation_len;
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6357a51a24e9..a3673fffd834 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -272,11 +272,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
-	if (!rc)
+	if (!rc) {
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
-	else
+		payload->blob_handle = *blob_handle;
+	} else {
 		goto out;
+	}
 
 	rc = tpm2_unpack_blob(payload);
 out:
-- 
2.30.0.617.g56c4b15f3c-goog

