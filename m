Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E236393032
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhE0N4K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhE0N4H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28CC061760;
        Thu, 27 May 2021 06:54:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 29so3731650pgu.11;
        Thu, 27 May 2021 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpcfhByCWLnkIfQzL/uOONDYsb5SWspN5/XaKvO0A8E=;
        b=HkZR1KP0VzPl8524VMWcpeo7UIIGFYkPyIqTFdVHKpe4VK4R1P2/u6pnBdq/gzk2Bu
         RuTwtUs9OobB0PMZI0ewPry/EeZY5cXsH08I0WGKeQ32xWcdLEf6K3u+L7K9b7esxcQu
         eYKA9zz8BzRWUpZ1Kom4OYGZqZr2zR7LJyjdCP3unKWjIdwbe3LoVCtLJhcq7yxIBDyr
         K5CQ3EU/2U6F2mMxmnnpAJ+NCX/m2HDXlQq/5262fqQo7W0CEGT5zUgXPUcEDoYQq8c+
         ArqpgkJv8VmDtjISzf8aFQCvEt04sy0VLiNgEqhYycOzO8zw6b0VUMm6p/vxuJsV6c3q
         LeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpcfhByCWLnkIfQzL/uOONDYsb5SWspN5/XaKvO0A8E=;
        b=dDI4hkhLUBbU/T5v5HwXOojpNbFxAdD9KJUVSaojo2GrPpV4hj7AqW7mfYwl5p0j5a
         4jRlJfjvX2eiRMaPKZBrmjjdBiS2Ob0B7IGefNKyTQj081iYNrqXaUSxTFRIU+lGQ4Hk
         y6bfF6DdxdikBZMV284LKqtrVN1vK63aZUkzdLKG3Xve33M9tqDqyZfCavom88E5r0lm
         QqcQZIYgQoz4hqF++p58VcBuAKkegfjGHMOvWabecGYY03KogTN2FYk8YSFwCGJRDzLf
         9tJM8OWTe6tUPw4YUluhD7Sk2+dnuv3o+aq7stKFxtBVni0Z4xT9NkPCH7KjyPZiCfQP
         P6TQ==
X-Gm-Message-State: AOAM530xepLBf63o2ajIBUVjeB7Z15LkN+aretveMxoXWIWKx98GxOeL
        qJk0Ag6NOihzqQdouC9fgNXnjTfeCt8=
X-Google-Smtp-Source: ABdhPJxfXmH/3BgN59PL8lFBTtFBaCP9siNZybveFB6s3OkRX4uE3lm9Cyr9pb79lZlATCRkuv8KtQ==
X-Received: by 2002:a63:471f:: with SMTP id u31mr3843233pga.85.1622123673170;
        Thu, 27 May 2021 06:54:33 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:32 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/7] lib/mpi: use kcalloc in mpi_resize
Date:   Thu, 27 May 2021 21:53:30 +0800
Message-Id: <1622123615-15517-3-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

We should set the additional space to 0 in mpi_resize().
So use kcalloc() instead of kmalloc_array().

In lib/mpi/ec.c:
/****************
 * Resize the array of A to NLIMBS. the additional space is cleared
 * (set to 0) [done by m_realloc()]
 */
int mpi_resize(MPI a, unsigned nlimbs)

Like the comment of kernel's mpi_resize(), the additional space
need to set to 0, but when a->d is not NULL, it does not set.

The kernel's mpi lib is from libgcrypt, the mpi resize in libgcrypt
is _gcry_mpi_resize() which set the additional space to 0.

This bug may cause mpi api which use mpi_resize() get wrong result
under the condition of using the additional space without initiation.
If this condition is not met, the bug would not be triggered.
Currently in kernel, rsa, sm2 and dh use mpi lib, and they works well,
so the bug is not triggered in these cases. 

add_points_edwards() use the additional space directly, so it will
get a wrong result, and lead to a failed eddsa verification.

Fixes: cdec9cb5167a ("crypto: GnuPG based MPI lib - source files (part 1)")
Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 lib/mpi/mpiutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
index 3c63710c20c6..e6c4b3180ab1 100644
--- a/lib/mpi/mpiutil.c
+++ b/lib/mpi/mpiutil.c
@@ -148,7 +148,7 @@ int mpi_resize(MPI a, unsigned nlimbs)
 		return 0;	/* no need to do it */
 
 	if (a->d) {
-		p = kmalloc_array(nlimbs, sizeof(mpi_limb_t), GFP_KERNEL);
+		p = kcalloc(nlimbs, sizeof(mpi_limb_t), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 		memcpy(p, a->d, a->alloced * sizeof(mpi_limb_t));
-- 
2.27.0

