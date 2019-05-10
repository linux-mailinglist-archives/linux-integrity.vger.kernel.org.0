Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E41A540
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEJWcq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 18:32:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41788 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfEJWcp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 18:32:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so3649415pgp.8;
        Fri, 10 May 2019 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKmOBQf5IncjEXCWsVLHLC0KbVC3GdgkUervdoFVPcA=;
        b=V/5bCc1jNN11FgSQ6PXDu16MySi4h9zjlLPsMQBuyaGNZv2vO3QLKd5B71zdftRIFf
         TWkFHD4JIbrM2wZJxvv28RVzSrxx1A6FdlyDtESPEKUmjWq+HHHz1GuHbFqxxjHIhMkL
         WLzjn/WQzrqv1wjNJQzrze9qFCPSVysgQrQjJWaTl5Y2UgGv7zSJXqBrSiaL0iyIuCzK
         omhDk1jb69/T8VieGuzgZL33YHaNHQ5uzAQ3lC5c9DXYUxhnrOZ0YielK1+RX8LHoq0C
         +IvtCkEmVxMCCSbP1uZeVzqHY7m80KUciviHsYZoZdBLrxih1USJRiGn0Rq6xOGUSDIU
         FWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKmOBQf5IncjEXCWsVLHLC0KbVC3GdgkUervdoFVPcA=;
        b=atBvqQcYoyzgyRzMVEhR92D/+dAD4xS7fwwywjrEB/Iw6NWkNl5UQ+2197a9G0tbXX
         NTjpjK6hS8nuG+IHL5AZiWul/D1lqxuxVI4lQIbQfx2kCwWDKkubNCPd8kTRw3jmlNk1
         6U8/ZMHxTQ7nivy6KsMyddn4W8k/7xvFXkLdZZVlTW2iXHT7LoYPJsQ/q8JvewxvlnY2
         sQYZuuKLiQdILAjNayKYnB9Yz7HGkxKiveK4t3vhzuMy41H+PBCZTHF/d98BNIkn3wFz
         jKVwbQyMtTiGt2hX4BKLID11JIoKN65LztFxMXdJYtOcm1p2SykcbA8bDt+1klmFdn70
         zk1Q==
X-Gm-Message-State: APjAAAUiXK9fuVy02LVQFeLKoWreWchIg0mI9UFPsqbq9W5Mc+0HlY/W
        on3ceBRKFnbemtruVJ7uU6bp6qK3nn0=
X-Google-Smtp-Source: APXvYqxJTHGwD0t57MAis7J0+KT+YNo/NTvosz7eoJLCzQ1JxTt1BSJ2Cl0Qxuy5U2QG9WWobQ3vYw==
X-Received: by 2002:a62:6444:: with SMTP id y65mr17653467pfb.148.1557527564828;
        Fri, 10 May 2019 15:32:44 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id g72sm16907374pfg.63.2019.05.10.15.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:32:44 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 3/3 v5] call ima_kexec_cmdline from kexec_file_load path
Date:   Fri, 10 May 2019 15:32:28 -0700
Message-Id: <20190510223228.9966-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223228.9966-1-prsriva02@gmail.com>
References: <20190510223228.9966-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1d0e00a3971..e779bcf674a0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -241,6 +241,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_kexec_cmdline(image->cmdline_buf, image->cmdline_buf_len - 1);
 	}
 
 	/* Call arch image load handlers */
-- 
2.20.1

