Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC47393036
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhE0N4O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhE0N4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648EAC061760;
        Thu, 27 May 2021 06:54:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 69so16643plc.5;
        Thu, 27 May 2021 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8dJXOXj/a5+ejIWizBsQbpMyEmF6R+/8OKq341nCHk=;
        b=GqGHIUxs6du8Fbom7M2nj7Seu+N0V2VDzDFE9PQSArT6DQUlI/qwWhhNRgrCQpOsbi
         aBWuvCXNvJTKpev+goFk9/3bq87zk+v+YW7lH9WQjE7Vg+fMa2eULanMKzrydnKk2lGg
         qQB7OlbHsH9a6Kf0pqzcm5FbDDnnls6IpLxyTAQhxT1VwyPLCnpZ/DiOx9z6PE+xl+DS
         Z5Esg7VQx+DwOpKnimR/5EtA/MwquQgTrL2N3ABFfFTCsshAUkCnZr59kvCgE03dvnRf
         jLp4v9FjTshRL5l8oKOcufqwFc9uZ9fxOrIPlquttlyZD/zuMzWY+F3sdtSleTRawJj7
         MW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8dJXOXj/a5+ejIWizBsQbpMyEmF6R+/8OKq341nCHk=;
        b=dGSYU7EUGfvljLj+ZnyBonFbx3T+lloswY4CoWVxUSIh/HcNjP8JNFBGF2SnuKZqU0
         kkhluLhGuTKtIzNDFC8HR+wTGAJeenuXTheikmFTIxHTR31zhKBPIATzfq8AuIo5Cd8l
         gvRoCc6ToVR+BZucdLXGdFlEUeIVTgPWzze8vh8mbNi+Qghp+qsfo1cMLjC1QhBnVaUk
         kGh3RVU0/gVsqaX3STRjM9CYazNM5xO5zW08wO96OA/zvLRPyLlFce+pdCqcnFm0wbE2
         TC+cA8VuQ1OqtauzfQKolu0shCn/k5BL78JUZr8kAaRdiFBBWjoNSSQlxZdi1h5oPexb
         L+dA==
X-Gm-Message-State: AOAM530UcCzTiXcMl12OgWvQYaX4sdDeB/oVv7y0l7xHWeHbeIcEd0S2
        pIePdaUdMes5uzEy5CUNSbxdnEjozmc=
X-Google-Smtp-Source: ABdhPJz1VFFolGWKr9eopjNl2wVcrDJeBIJJEZ9s0D+6pEjHmkYIWTtEmJneqKndldoKrLSOGkDjCg==
X-Received: by 2002:a17:90a:cc06:: with SMTP id b6mr9750142pju.19.1622123675771;
        Thu, 27 May 2021 06:54:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:35 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 3/7] lib/mpi: export some common function
Date:   Thu, 27 May 2021 21:53:31 +0800
Message-Id: <1622123615-15517-4-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

Export mpi_add_ui() and mpi_sub() that are used by the following
eddsa patch.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 lib/mpi/mpi-add.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
index 2cdae54c1bd0..d34c6c1c6fab 100644
--- a/lib/mpi/mpi-add.c
+++ b/lib/mpi/mpi-add.c
@@ -62,7 +62,7 @@ void mpi_add_ui(MPI w, MPI u, unsigned long v)
 	w->nlimbs = wsize;
 	w->sign   = wsign;
 }
-
+EXPORT_SYMBOL_GPL(mpi_add_ui);
 
 void mpi_add(MPI w, MPI u, MPI v)
 {
@@ -138,7 +138,7 @@ void mpi_sub(MPI w, MPI u, MPI v)
 	mpi_add(w, u, vv);
 	mpi_free(vv);
 }
-
+EXPORT_SYMBOL_GPL(mpi_sub);
 
 void mpi_addm(MPI w, MPI u, MPI v, MPI m)
 {
-- 
2.27.0

