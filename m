Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D02C8E91
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 21:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgK3T72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 14:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgK3T71 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 14:59:27 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5723C0613D2;
        Mon, 30 Nov 2020 11:58:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CEC4F12809AB;
        Mon, 30 Nov 2020 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606766325;
        bh=4RhT38g10G7wcqKLoI0zVVTecuh1LdwEcnKm/WVZ6Ew=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tmIHIVqIHwDFUYkzPapd6YmhEfYPWq/h6yOryVsY6fsDJCRomSOqrpL6UT+nvaobi
         nhL64zAxuGd5mUyKTDehI9O4i7MU90b3mrpHM8kQW9iHVlHrCx6i5IuPVZN13bwbMD
         w+gMLC+EIejPFco6eQIJQ6T/jXqFpwiaRrRjJj4A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nvq0kSXZraV7; Mon, 30 Nov 2020 11:58:45 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4680C12809AA;
        Mon, 30 Nov 2020 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606766325;
        bh=4RhT38g10G7wcqKLoI0zVVTecuh1LdwEcnKm/WVZ6Ew=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tmIHIVqIHwDFUYkzPapd6YmhEfYPWq/h6yOryVsY6fsDJCRomSOqrpL6UT+nvaobi
         nhL64zAxuGd5mUyKTDehI9O4i7MU90b3mrpHM8kQW9iHVlHrCx6i5IuPVZN13bwbMD
         w+gMLC+EIejPFco6eQIJQ6T/jXqFpwiaRrRjJj4A=
Message-ID: <5e94c7199c675bbfa7112f8b79fcb91f8d2d4fe7.camel@HansenPartnership.com>
Subject: Re: [PATCH v14 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Mon, 30 Nov 2020 11:58:43 -0800
In-Reply-To: <202011301002.yYRCOdq5-lkp@intel.com>
References: <20201129222004.4428-5-James.Bottomley@HansenPartnership.com>
         <202011301002.yYRCOdq5-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-30 at 10:10 +0800, kernel test robot wrote:
[...]
>  > 331		if (payload->blob_len < 0)
>    332			return payload->blob_len;

OK, I can rework this to use the signed version of blob len as below.

James

---

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e50563f58900..0d4c6f138b94 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -242,7 +242,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
-	unsigned int blob_len;
+	int blob_len = 0;
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
@@ -400,10 +400,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	payload->blob_len =
-		tpm2_key_encode(payload, options,
-				&buf.data[TPM_HEADER_SIZE + 4],
-				blob_len);
+	blob_len = tpm2_key_encode(payload, options,
+				   &buf.data[TPM_HEADER_SIZE + 4],
+				   blob_len);
 
 out:
 	tpm_buf_destroy(&buf);
@@ -414,8 +413,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		else
 			rc = -EPERM;
 	}
-	if (payload->blob_len < 0)
-		return payload->blob_len;
+	if (blob_len < 0)
+		return blob_len;
+
+	payload->blob_len = blob_len;
 
 	return rc;
 }

