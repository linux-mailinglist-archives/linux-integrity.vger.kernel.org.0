Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A356124C41
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLRPxi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 10:53:38 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53050 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRPxh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 10:53:37 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 10:53:37 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47dKDD63nsz9vcSB
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 15:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GmsiTC23ozmH for <linux-integrity@vger.kernel.org>;
        Wed, 18 Dec 2019 09:48:28 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47dKDD51mJz9vcRK
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 09:48:28 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id y188so1608783ywa.4
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24iL5/uUkW8WBrQ+DwpF6Dwk7XjHT1zZjAzHIUDTH/4=;
        b=iWhjT4BTr9LLloEH90ZsH1TvIWOH57cw1MQgcHeDYwOIDfS2k/tzc3ep0QbbE1E1/0
         a3PXogSZAAdSAYBtNaacCxr8oPsRDVX+7p89iaFIspNqEjFU01luRm2avI+bUsbf7pLB
         J56L1XiP+cBb4qlGzneNwYGeEZzMf+HMwzFyi7L2CWEivK6Gwj4BFQ4zBCLEh21Mp5al
         vQzZhSPGrvFmZOEMIyuNUrLoziYSjQkHZDONVva7a++X+SwD4hLw08bg/Euyl05egjHd
         OCHNKwDx4YXZFTyzOlftoV5C9+zmCh1YY/5g6EVOimzmScpjd+hmeezAjXmOXZfZhjnn
         SsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24iL5/uUkW8WBrQ+DwpF6Dwk7XjHT1zZjAzHIUDTH/4=;
        b=TKKRRYzPfZisKwxpYG6hUyCv0o9QgcwdqcdAcKUIz4Y7kE2uoluHLVDsWdhfPkrkX6
         q+dVXnGGm6VzGgF1CnEPvnBcYUFPMZEl9D4Kf34IMMaeD80ubP5EM/0DoB6XYJpywhv8
         6zG+eWdVIRQK5zFEc2ja6hejrOrkUwAgNDhlxvmqlF8tjKK2yIrLlBjjGD+wSxCP3L6w
         7csgzJ3kbiSWz2wHXwFg73JNfmlAlkDxNswvWkV82yGGBYyYZTNn7r4UnmWqUAIv0ujt
         qjoMym1pW7i6QMJUzFILNe6EPpqCG04+rlembQcMr6v1t0xjKX4yoCHXXYI9RU5K8SKX
         DgHQ==
X-Gm-Message-State: APjAAAUXvHXw4G4YQSBj5mtJEETJhAQFFlU1mSEFAZc1DVCFC24zFkWN
        9cG0PPJ+qzpxlTeO7pP5XgCJmIgNtCcuemsVR1MjNfM/6CFyopQ0oXuOB4oaexqzxFFVhPV3n2G
        PQ7Rs7xyo229hGxH99PtvcpuZXZ+0/8fX
X-Received: by 2002:a25:df15:: with SMTP id w21mr2537599ybg.7.1576684108469;
        Wed, 18 Dec 2019 07:48:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUs2lA5D65kMHLl6/mRZQTuLTuD4Ghfd2R8mcUBxkI5G82Qt7wVJf30S63EhVsq0vzQPq5Yw==
X-Received: by 2002:a25:df15:: with SMTP id w21mr2537588ybg.7.1576684108258;
        Wed, 18 Dec 2019 07:48:28 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id j4sm1050738ywd.103.2019.12.18.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:48:27 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm/ppi: remove impossible assertion in tpm_eval_dsm
Date:   Wed, 18 Dec 2019 09:48:25 -0600
Message-Id: <20191218154825.11634-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
However, if ppi_handle is NULL, the kernel crashes. The patch
removes the unnecessary check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: replaced the recovery code to completely eliminate the check,
as suggested by Jason Gunthorpe.
---
 drivers/char/tpm/tpm_ppi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index b2dab941cb7f..603f7806f9af 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -42,7 +42,6 @@ static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
 	     union acpi_object *argv4, u64 rev)
 {
-	BUG_ON(!ppi_handle);
 	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
 				       rev, func, argv4, type);
 }
-- 
2.20.1

