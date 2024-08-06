Return-Path: <linux-integrity+bounces-3293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543909491A9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 15:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB5928280B
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869681D2F42;
	Tue,  6 Aug 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGAoIWjF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD011C4618;
	Tue,  6 Aug 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951383; cv=none; b=IWfPH26hEqb8LDqRVO/eJakoVU6RYhTRT4RrRK6MF/82umg6gUXZoOCNsEXZk5jHbXW4cXyYN5+hyFAypLEzNMmWEx6C9JAeBGJsRYylNLBYOB+5DkY1Jv+zZO/drZu2p/7Uflp5auFNWhm/VKfr8agU9F0CnD7uObVNwp3ezDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951383; c=relaxed/simple;
	bh=xoK3u6p5Pinh4bCMH8Qvee7uSsupNR3FkLr/Mki+zQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gp87owiGsw2W1wu4VkTuKTH3NJsxRhE0pF5iar30K768z1uYI0QN/z57lKwszRRKV5xfA5bQ5XxLB8qopVcLuZ1H8Qo/aQYYN6NNrZgAcwE37ecAOhnPtKNaKf8jEGw/Bz811UdwsMM7Ti/msv6lqUUleaLplpOhvZR29bYwUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGAoIWjF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f035ae1083so7502301fa.3;
        Tue, 06 Aug 2024 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722951380; x=1723556180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ut6upCPAHGtdM401qJi3TYb4r5pf3c7Q0q5XDfXZJ8=;
        b=MGAoIWjFqRXF2z7ubMbhtNna4BGi9IzcJkpve/eWCIh9cqLdObosMYZYScSQ0juasf
         ZVA0jrzodkpWQKwWqcBG0Sacxz1Ffa8+BUcAXewwn7dbzj+XsRO1GbkjkMxE4TBEZJuw
         n2p4N+syIJ7nRmd/12zd6iGBTu99SRDolg5JW8aQA6hU2eUzIi+rnv3moOE8UI1Os9dF
         Qk3D1JixPPXsqGW34I7i6XLVxbTC0Stj47i8O0hYWDwTri3dnCFWIiZw5oCePxTIx8E0
         xFqH0oaOhUS88oxb2k/MhPhrBp4dxhEwqpkUkSp1CDXq620FKCbvUvOgOAnemPb2oBJO
         IbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951380; x=1723556180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ut6upCPAHGtdM401qJi3TYb4r5pf3c7Q0q5XDfXZJ8=;
        b=anvFhKfwg3N5euqMmHJMnvZpZ/ZJ2CTluPEhLQUm9CiEnfMivWmlYuucrijlRcGAUg
         okFzfrnJLpT4NYtqeDo/ruAdQnVTHQZqBy0tshnmA0i0xEjYdIIzvU9FQKGsWHV8OBDO
         UzWtotnicb1dfnJGK3Tee5LWx7N1b6UUfLFDgjQ2N5ziySAWL53c/UsniZMszS5by3KQ
         U7guiwc4qsoX+q2TcPXEmj76WKQAGqz3oUgnbXN1IF7ld5V7um/mZI13XPei5IZ5mqDr
         E+jZj/YZw893xmOiUphSuSVM6hTDA4HztvjHife6LlStQ+j0A54wrLhHl0LUajILfCFX
         9NOg==
X-Forwarded-Encrypted: i=1; AJvYcCVknEW/NywzbTzjVHQkgGT7raFRpqfwU5Au7gwpmU4oLOrBrYeu0Obp7Fi8gYkY5t5gQktr5SAm2NH5+LcMU/JhwrHmuuwFFpe7jQHZYkw0TDM9x1qfUOvBGGMFqhO9g8IR77n9+jZP0LJTG5pyGhXHzI6f9i+F
X-Gm-Message-State: AOJu0YzNZY9iwulvue4JOKSg5dyGuNPaks+bBSvAyvAlFkOwu0sdjJ0n
	3bcVRpNwrxn7h7cmgCqH737lcAICU7mhUAEFi7/ekIdTNawfsE8Y
X-Google-Smtp-Source: AGHT+IEwlYKWkJ21WuDyAmxQ4rLymW9QgfgHwCqKEjHiMxkeWunseYbjVT9Uga29artIk1IChuvbBg==
X-Received: by 2002:a05:6512:4024:b0:52e:f77b:bb58 with SMTP id 2adb3069b0e04-530bb385a75mr9183720e87.36.1722951379565;
        Tue, 06 Aug 2024 06:36:19 -0700 (PDT)
Received: from f.. (cst-prg-92-246.cust.vodafone.cz. [46.135.92.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80df8sm545913166b.160.2024.08.06.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:36:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] evm: stop avoidably reading i_writecount in evm_file_release
Date: Tue,  6 Aug 2024 15:36:07 +0200
Message-ID: <20240806133607.869394-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EVM_NEW_FILE flag is unset if the file already existed at the time
of open and this can be checked without looking at i_writecount.

Not accessing it reduces traffic on the cacheline during parallel open
of the same file and drop the evm_file_release routine from second place
to bottom of the profile.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The context is that I'm writing a patch which removes one lockref
get/put cycle on parallel open. An operational WIP reduces ping-pong in
that area and made do_dentry_open skyrocket along with evm_file_release,
due to i_writecount access. With the patch they go down again and
apparmor takes the rightful first place.

The patch accounts for about 5% speed up at 20 cores running open3 from
will-it-scale on top of the above wip. (the apparmor + lockref thing
really don't scale, that's next)

I would provide better measurements, but the wip is not ready (as the
description suggests) and I need evm out of the way for the actual
patch.

 security/integrity/evm/evm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..309630f319e2 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1084,7 +1084,8 @@ static void evm_file_release(struct file *file)
 	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
 		return;
 
-	if (iint && atomic_read(&inode->i_writecount) == 1)
+	if (iint && iint->flags & EVM_NEW_FILE &&
+	    atomic_read(&inode->i_writecount) == 1)
 		iint->flags &= ~EVM_NEW_FILE;
 }
 
-- 
2.43.0


