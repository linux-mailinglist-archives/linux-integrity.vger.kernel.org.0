Return-Path: <linux-integrity+bounces-2765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018488D6DAF
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Jun 2024 05:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6861C2167E
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Jun 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D454428;
	Sat,  1 Jun 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hattorij.com header.i=@hattorij.com header.b="CV/JlPkk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861C7EF
	for <linux-integrity@vger.kernel.org>; Sat,  1 Jun 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717212622; cv=none; b=iaBL0LIPE0V5Jc3096gQlJv7kwD4cvM8eromdURgr1bQ7Gl60byhmw4sdQIa4wNJidbaX7ngj7MO9t5T1k1l+LUqp3Jo6/lTrNXBdQQXeuj2JzW1T+jWMjHLyXtZf+SHvN5T41fzEOdNpHLXh9n7DuoB7nV6BAzlyweSfl06TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717212622; c=relaxed/simple;
	bh=oenWFS12hPZMMofBmJLuUoBVd1MifsFx39PJ1lzBHkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S/UaeOpt055im/9zoL4dTDqLpbmAi1ix0pX6z3YIWZ9/USZTG/Uq9A96LGKmNqiJFxu6GlOpsMaqbeVscm+0+1MlNC1hYpwCTA8/uMvIw/KZuX8LuXPyC3sYwyYp19aUfLHBza6ykSWtCm6jneCtwQo5Cg7+HN/XFblSMz1Haxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hattorij.com; spf=pass smtp.mailfrom=hattorij.com; dkim=pass (2048-bit key) header.d=hattorij.com header.i=@hattorij.com header.b=CV/JlPkk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hattorij.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hattorij.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so1629532a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 31 May 2024 20:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hattorij.com; s=google; t=1717212619; x=1717817419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIiWOfVdpEPFg4kUIaBA6FcOX6/D7fXuQZkBIHlEz0g=;
        b=CV/JlPkkLmxUhfsMCsxLYhAN0QjU7EYbI54OqlvSFXTGbeDThjpet/psgE4IarkjFN
         oWpQXR8JJFosYapyBDovA0XimH+rsf2MDRLh4zTui4R4YBqycHNGOy00bTFZV8PAC0IH
         9fjPTO7mPOeRudFMN0b6v0yPE0flCjETOTJClvNbJpXjUAcoB8uad3zmdOHXh85njbBM
         1IUUskCZXCMYIFO6Q44+YbVVtknJJK9Z5kHua3ntohS15eKDCldMrt7hhdH2V4zb/IKY
         A3OsGXif74w95aCxA6caSHjvZ0JKa2PDm3IBEn+IDEmRrSy/wEWIAchbz8Ww/5wWTrrq
         hjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717212619; x=1717817419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIiWOfVdpEPFg4kUIaBA6FcOX6/D7fXuQZkBIHlEz0g=;
        b=j4X2J4O3Wbhr1Xy86bQ50HNa83WGydE1VZskNVKgHQZSyvyQ7kfkZA7u7DhtqnA2An
         3tpOpJx+lfS6Ygn6qAFcX+nYVoWll4fSD8qDRyDbJ54j9HwHK2eevePHmlOsSP5yoj+i
         bNAPhPSXjFax3b8i9LUHFtZvIeTbKJfybEoLkXvDyytZamghDVvNe49i7kkc+OkEQmUf
         7GueQemnJ9ZdAYvrm2KDtBeIOmH3uLhnipVbMKeMsjYOLEbauNzgj+R3Opf3ieS5dh3g
         1JdGhIxvA6ME9+Rjs3SB68cd+JqqZKH6uLd9IZ17fhrPFmgBKXxx6/jbiS7Rtj7LS9Yw
         Om2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6SH6uEd+WMSbI87gpn7lUKcYBWvwuSq/pG4pHvUF4TuVvKu2x/yhCWkah7GIPrE9KKV/tARETnUvrCDahwO6oedvAY7js1Fs9AozvIURH
X-Gm-Message-State: AOJu0Yw2G7JjaxqG7JbLXVdv/R2Rlilk1u2CWP5i+v6oy/oM99IZkLcH
	Ew3nv5f5mGhgrcsgDwPy5K8DVDWUCMEHezB7xT0okzqRRzq6gauuDn+ahmfOBJlGiCJ8eUJRZtE
	X+enH3A==
X-Google-Smtp-Source: AGHT+IG6/j/an+yViEDvdbOtvJNnqaE80YvlcdlxNxD4ZNLpxbAZKrzC28TjutgZAFWkdPVSUvlGbA==
X-Received: by 2002:a05:6a20:7354:b0:1af:cf12:c7ac with SMTP id adf61e73a8af0-1b26f20f57cmr764353637.34.1717121514348;
        Thu, 30 May 2024 19:11:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:c800:5a33:46a:2ee9:941f:9c84:df0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425d6016sm397787b3a.72.2024.05.30.19.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 19:11:54 -0700 (PDT)
From: Joe Hattori <dev@hattorij.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Joe Hattori <dev@hattorij.com>
Subject: [PATCH] tpm: tpm_crb: Call acpi_put_table() on firmware bug
Date: Fri, 31 May 2024 11:10:21 +0900
Message-Id: <20240531021021.2233654-1-dev@hattorij.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `crb_acpi_add()`, we call `acpi_get_table()` to retrieve the ACPI
table entry. `acpi_put_table()` is called on the error path to avoid a
memory leak, but the current implementation does not call
`acpi_put_table()` when the `length` field of `struct acpi_table_header`
is not valid, which leads to a memory leak. Although this memory leak
only occurrs when the firmware misconfigured the ACPI table, it would
still be nice to have this fix.

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


