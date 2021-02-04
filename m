Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291830FFC0
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBDVzP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhBDVzP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 16:55:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08060C0613D6;
        Thu,  4 Feb 2021 13:54:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u25so6902676lfc.2;
        Thu, 04 Feb 2021 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAgqYHbywIYs2QshwFgb53FlD6EOq34SaKwHmoFcyVM=;
        b=lXdPKhc3IDXew+8Sl8q4BmrYbduDfqCk1Mws3R1KsWf0yajkhguDZ7QTNgzRSu6bpF
         Wu9d4gU2ZYPCxRpnLoszfYEP3lJkNa8NMIwznkV1ncfXvu1oZVqbE8YoolOqzgdSuIvP
         CHnu2G4Yfp/qIWAdfyNoPEvZnnEazWKWzyo4KbJwVx7YZ2e29fDtCPpylwX31/BPnoDT
         4eS5dvFtoOQbWKKUHmx1u+IXu0n4ZBwe58e8aZmsh9qyYErQrMlQ4G/g2zLMn3QBO0Gc
         n/BSHCmNED4sHSAAvRbGYcuXBSUYse6F9+S/pOK9rTd2cFwY9BX3OjqNGmCMZH5ucaBm
         ZPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAgqYHbywIYs2QshwFgb53FlD6EOq34SaKwHmoFcyVM=;
        b=DUkhdZDRSyTndW+/iJPlEK1RXkDLubV/toj+JBly1UqndB2cMXR/uaLDbqZlmC5yl9
         xKBxVn2Y/wVwjshiWT7I7Srs+/3aP21CPBFxf83MfzSHHwrw6DmbNEfHvh3qdND6hv9e
         BMsHWtkhrQ77JQbUYgyZQKIvM6VM0QqI3rjzAsP7BzJ4WRMVfsJ1LlO7AzO8kMSNWKMN
         chQH1tOc1S1cPk/fdSsK6IMfXADxLDIQAKfAfs7WfNX0zYyRjvKgixFdtx1strcONsbR
         J85pYHtW1xgUQJmZqqFhDFWzOUg18FHnrIWR68IS5R0QuBdw9oI+9D/4bRIwoHETGvan
         9RFA==
X-Gm-Message-State: AOAM531LpMKFFmgv0ll/JZgjivTL5P4n8TmX7r0V7ncKPqQPpx5c70Is
        rTZF5T6/lM1L1WIUpq2j3t4=
X-Google-Smtp-Source: ABdhPJwlWUvIhc13/2RbhPaMewunp5RbevdWqUpLZH09DlBVAan2+n6kj6b/WBNtF18AMttZ/4DU1w==
X-Received: by 2002:a05:6512:4c5:: with SMTP id w5mr753720lfq.92.1612475673375;
        Thu, 04 Feb 2021 13:54:33 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id u18sm796647ljl.57.2021.02.04.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:54:32 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] tpm/ppi: Constify static struct attribute_group
Date:   Thu,  4 Feb 2021 22:54:27 +0100
Message-Id: <20210204215427.49047-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The only usage of ppi_attr_grp is to put its address in an array of
pointers to const struct attribute_group. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/char/tpm/tpm_ppi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index b2dab941cb7f..40018a73b3cb 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -358,7 +358,7 @@ static struct attribute *ppi_attrs[] = {
 	&dev_attr_tcg_operations.attr,
 	&dev_attr_vs_operations.attr, NULL,
 };
-static struct attribute_group ppi_attr_grp = {
+static const struct attribute_group ppi_attr_grp = {
 	.name = "ppi",
 	.attrs = ppi_attrs
 };
-- 
2.30.0

