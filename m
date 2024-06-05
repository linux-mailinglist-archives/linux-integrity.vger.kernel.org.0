Return-Path: <linux-integrity+bounces-2835-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CECE8FC4A0
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178A81F22403
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 07:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5718C334;
	Wed,  5 Jun 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hattorij.com header.i=@hattorij.com header.b="ZqkqGbtF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872B18C32E
	for <linux-integrity@vger.kernel.org>; Wed,  5 Jun 2024 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572845; cv=none; b=huqYt4NimqgxB/43GBa4VGhCebe8VLMc85QQNXV7tQRdMcux5fIaVaug0w1Bvb86y80VsYddmTEJ1wZ0sWm+OXyiVElJ6RKE6N7TG5GuNUwBR4l6bDZCeIGAeIN8WhU7gVWbP3dy0IkcWFQX7+xgYXcss2eXgHzzSS5EwFp5+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572845; c=relaxed/simple;
	bh=NbQTpGX5zuQl4UlPy8c4p8Am6xZhOpBZNNCjhNzvruE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXITUQMK/04isP7FlOhXw7TNnP5RNu4yS6pxUq+o2TsODkwv9MF8UGjFV9aQVErmATWXCYf7bDJ6crYbYtae7b/YG4+rIK+y/gs/Gs0WO6QMdqyTAJOqu5oSm59wyGkoQ1r4gXzIuuhEPTdZThL+FOZ9Bo4x2LUCIMo6pvhKgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hattorij.com; spf=pass smtp.mailfrom=hattorij.com; dkim=pass (2048-bit key) header.d=hattorij.com header.i=@hattorij.com header.b=ZqkqGbtF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hattorij.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hattorij.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6342c5faaso16124065ad.2
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jun 2024 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hattorij.com; s=google; t=1717572842; x=1718177642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbgUIHzX7MpQLRCU9qKX2t7RhFraTfDGZhoNCFgjQVw=;
        b=ZqkqGbtFMHBkDkfsxEl94ylDpitXdGLlNlt51yGSdfL0KLoMPeykRQBnMVN+/qSvxP
         VyYrYjK+sAnZutedkVbg2igGuwsAbw1DgnhYn7rZN+b/Xa16JAEufEkBs2hdj8bQa/nT
         zVH96RII9CyY4hYktb5uG17ho1WTEzJchCIpYszRmIFTGFQxULqoXsjvnnKbERZHz0f3
         K+FimvZtVgdtnbnEpXQ6BRbNFKdQ5q7vR5GU7yfaTpdbfabwWCl4+/53owQBj1nwdK9P
         4OLCI0RQ9m7cj7OQ+mFt3xAvvcYs6L0yZ2so55O/e+75AF+cQmF+XBFHemBf6cQTVE0w
         rp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572842; x=1718177642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbgUIHzX7MpQLRCU9qKX2t7RhFraTfDGZhoNCFgjQVw=;
        b=ZdqB4Jg+jZl9StB0j0EiF23OK6dFdzJp3jfLOcbBM1C6M/rRkOXjxaDpCmsiaGovl0
         YtROMImzJqIU6P2uFl27KzNjmOU8EWRxBgIAnicduzzW43p8lxP4t5E9z75pet6C348z
         w2wmWzo64XUun+BIoJ+a+F0hsyaKRbcSYVyq28vzluWWBW9DxpWaj/ugyZTxqHo/zJ1g
         ttuDrMzfmx8KeSHhX6Nn1282NjMYsYu9yUaNT0oApfBd+OFfu0mjA3LT3kGL768i+hI/
         ayeCLjki/p9sUuw8SdZ6XJ02+7yvVxgVQnmH59cTAJo+5sD8xA5rzyF2uPuGdLwF+nwy
         C7dA==
X-Forwarded-Encrypted: i=1; AJvYcCXrBFp0xCsclpSpN655iaSScyJgfikW/O/8Lj6//Va+x1epE1I0l1TpUMj4o9OlbRgd/j7y8TFcPTaylamfxfSuPEMTK5O9Pl8SAoCwhJ74
X-Gm-Message-State: AOJu0Yyl/T1CXYj76x181QSELBm/2vIz0W6kvwRRLvrbWz0Eoapz4flT
	dZEMge1y6GjgsYJXHuF+Ukd6Vbfg67ED8MZTp30Z1bnm3QmTHVm5Ztg6HM7ofLs=
X-Google-Smtp-Source: AGHT+IFswX+hbM52BxW7389kSxGsUpoKX4HrtnckJzS9fK+H94jackQ6Z9Ua9xJtHJSQ79DGSvJwPg==
X-Received: by 2002:a17:902:ea0f:b0:1f2:fb89:1d3e with SMTP id d9443c01a7336-1f6a5a03d96mr24644615ad.7.1717572842337;
        Wed, 05 Jun 2024 00:34:02 -0700 (PDT)
Received: from joe-ThinkPad-X1-Carbon-Gen-9.protected.u-tokyo.ac.jp ([157.82.128.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f676917bb2sm53570735ad.230.2024.06.05.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:34:02 -0700 (PDT)
From: Joe Hattori <dev@hattorij.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Joe Hattori <dev@hattorij.com>
Subject: [PATCH v2] tpm: tpm_crb: Call acpi_put_table() on firmware bug
Date: Wed,  5 Jun 2024 16:33:29 +0900
Message-Id: <20240605073329.1640668-1-dev@hattorij.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <D1RIRVZ2K03E.1JHL5XMMLN9JL@kernel.org>
References: <D1RIRVZ2K03E.1JHL5XMMLN9JL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jarkko,

Thank you for your time and feedback on my previous patch.

1. Drop the hyphens.
 - I have removed them from the commit message in the v2 patch below.
2. Wouldn't it be memory corruption, and not a leak?
 - The validation_count field not returning to 0 causes
   acpi_tb_release_table() not being called, which means memory is not
   being unmapped. Therefore, I assume it is a memory leak.
3. Why would ACPICA return corrupted data in this case?
 - It is mostly unlikely that it returns corrupted data, but it would
   happen when the ACPI table is misconfigured by the firmware. Although
   this event is rare, I thought it would still be nice to take care of
   the error path.
   
Please find the updated patch v2 attached to this email.

Best,

Joe Hattori

---
In crb_acpi_add(), we call acpi_get_table() to retrieve the ACPI table
entry. acpi_put_table() is called on the error path to avoid a memory
leak, but the current implementation does not call acpi_put_table() when
the length field of struct acpi_table_header is not valid, which leads
to a memory leak. Although this memory leak only occurrs when the
firmware misconfigured the ACPI table, it would still be nice to have
this fix.

Signed-off-by: Joe Hattori <dev@hattorij.com>
---
 drivers/char/tpm/tpm_crb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ea085b14ab7c..68fe28208331 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -738,10 +738,14 @@ static int crb_acpi_add(struct acpi_device *device)
 
 	status = acpi_get_table(ACPI_SIG_TPM2, 1,
 				(struct acpi_table_header **) &buf);
-	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+	if (ACPI_FAILURE(status)) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
 	}
+	if (buf->header.length < sizeof(*buf)) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	/* Should the FIFO driver handle this? */
 	sm = buf->start_method;
-- 
2.34.1


