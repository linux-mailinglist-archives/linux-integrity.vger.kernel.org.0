Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9580E11EE11
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 23:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLMW56 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 17:57:58 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39274 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMW56 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 17:57:58 -0500
Received: by mail-yw1-f74.google.com with SMTP id l12so672094ywk.6
        for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2019 14:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P50f0ZL2uY1UYmnaU7An9xVTQaVqLWmvMfnLqv/D8hE=;
        b=ZAlVpNgsWpaWUGjJ3ydTk0SJUH+MiUY4V9eh/Ae51P4XpTimSh6/+uEOblVpA503HM
         pFtt6fr8BSUWRLd92ZEVmMW5Yd/G8B2k6bJawctR9Ri5IwkNTpjAQfO2QXXLtcEhjmk6
         T7OWqMDZqydbszrCR6xP5zyfESX4n+yxrqNj8O5Y13ecYiNEChaWjvkOREj1eTbEsigQ
         n6f2IIKKQvJy4Bn/PjO+LoVv+ypMERF60BWJsKr1KJlkqgNtS+tbN3SxbBYRVDkOLzEo
         s9QL8ilqIbc2ewf8hLot8UJFb4UpvK5FA4D2tdAiWwljVObfRYbl1xNqgVFBVcsMj1Ds
         3SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P50f0ZL2uY1UYmnaU7An9xVTQaVqLWmvMfnLqv/D8hE=;
        b=JTlEwaUPmYdKls07HrpZ9yja1Yq5OUfV2ZpIq/xWXXbtrfkUImBHJnYmAIzQqxKwdq
         M7XScsQoe9fm4xf3SFlZza0VOnfxUoeHw8iAUagKJB0PAqGtdr2h4G4bmUXf5eZ6AOyb
         hQQZ04TWDhPtOx9IqYJp1E3Dozztcx9I73dsKMQcvB3SqMmTKBshlWOnLRBElvfzLrgk
         xkR4dDkW5Y5tCkm9q2zPiIcNlP094zDJ1a/KROkVy4jL5B+LeU78hhG5hN3WYrSQsudj
         RaML/AmLqARVOdDJWVQebjGigThnvyE/32+QhMKFjBH8cLpvHYgkJaaVFgYS+QFKp+aY
         lpXw==
X-Gm-Message-State: APjAAAX00Uc0BpwX21lBjElcAUx1xZKIyK8T9hbo6KSennZwJf3fMRdp
        R1WT1tT301A0/T08lOmEQ4aRFn35xooJKwssggwaiSN5Yz0Jrx8DDrybBvIddp7FE3bRrvvreaO
        QMPYAmiCeNeQ4+sL+ojyyPp+C0pczZP6aeIFu4zv5da9vj/ek+JduCJTfsXs65Jtbwxha0mfp+i
        CSIHyyy83IGxacIpavlJs=
X-Google-Smtp-Source: APXvYqwfK2jbSJ51gES6pxnbB+Jx7JYOcFPHuY8kT3tTVj3kn1raRvsRONiY32BSyPg5RjbqyUNg7SevgSbxc9eN0nB2/A==
X-Received: by 2002:a81:9c14:: with SMTP id m20mr10031332ywa.143.1576277875471;
 Fri, 13 Dec 2019 14:57:55 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:57:48 -0800
Message-Id: <20191213225748.11256-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] tpm: Don't make log failures fatal
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If a TPM is in disabled state, it's reasonable for it to have an empty
log. Bailing out of probe in this case means that the PPI interface
isn't available, so there's no way to then enable the TPM from the OS.
In general it seems reasonable to ignore log errors - they shouldn't
itnerfere with any other TPM functionality.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: stable@vger.kernel.org
---
 drivers/char/tpm/tpm-chip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 3d6d394a8661..58073836b555 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -596,9 +596,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 
 	tpm_sysfs_add_device(chip);
 
-	rc = tpm_bios_log_setup(chip);
-	if (rc != 0 && rc != -ENODEV)
-		return rc;
+	tpm_bios_log_setup(chip);
 
 	tpm_add_ppi(chip);
 
-- 
2.24.1.735.g03f4e72817-goog

