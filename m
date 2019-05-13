Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3601B673
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfEMMyh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45678 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfEMMyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id n22so8935347lfe.12;
        Mon, 13 May 2019 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjPAYO25HnG81opjamBBgEbx9PUeCpkb7T1gwi9hG6g=;
        b=jAXX4HRirUwXmIVh3LlnRNtm4pIeOVVWBXb6ZQQm4YK6pckouVme1WoqH5vTD/ePqT
         yss83cEb22XXu2BesfkOh4mXarqfi/25Tp5grKdZ/PGOi9s7V/vESTmWfFItR8m6tPoR
         KlxRA19J4cgOxCrepI3MLMOTrIUYbYyr38QAUOlBV3oCFxfaBPmSjICTYi6Gjqq3Q/2T
         7QiKmRiuyVvXzqz6ONN4heFOczQ3LTrnYHpcpv1QQgga0emjH0VChzayctCqvk1vEm1P
         gjF7Q+jMpOlo68meZl3n5KNj0uDI7CxTiQdNpif3ngpn+5BhFe+4YfPLuFRd6c9N/+2N
         8tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LjPAYO25HnG81opjamBBgEbx9PUeCpkb7T1gwi9hG6g=;
        b=PYIm0lthcrBglRijgYNp30Aczkc0sdwm0NJWYQi9FMsQ48sN0McEzdw3BenkeDliD3
         vOBaVnHB6BFkuIkhjdsbiFscMylaTne60VSQqewvKhvBcy02E9UKj5o89dUi4WjmlsrR
         TWZ4VMRgBM6aav3UNQj12ok+lxuRRyN+qsA4SdJ2mj/d8SrJjZjXlHfD16lc60nIFDji
         A9m16MbDDizmvxOW2iPLCeFfOM9l9FbtpQPZieJMSSX7RBEPw4tGuJCA/Vuh2ZrIXPE/
         Ww3VVLRhdhwxApWnls3DgtLWl6nuj9XTMEHVRgT5NVVlVa+0PsHllle26rk6a7BEwalb
         Y2qQ==
X-Gm-Message-State: APjAAAX9fmyIkFx0Ud5+JjYqnqmvosrSaPpBSmwQXB/i6nQjGXg7FbYe
        a6elhQsYD3x2weAbHSVDCjHMHi+li9c=
X-Google-Smtp-Source: APXvYqyHN8sFommx6hIklyDSBzX2LyTRZXRP3Ug6RKD/z+h4Vs8O0FWOnds29AEWU+9iy+hm+ozYuA==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr14356615lfl.146.1557752074707;
        Mon, 13 May 2019 05:54:34 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:34 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 2/5] integrity: update the file measurement on truncate
Date:   Mon, 13 May 2019 15:53:51 +0300
Message-Id: <20190513125354.23126-3-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513125354.23126-1-janne.karhunen@gmail.com>
References: <20190513125354.23126-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Let IMA know when a file is being opened with truncate
or truncated directly.

Depends on commit c8213962517e ("integrity: keep the integrity state of open files up to date")'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 fs/namei.c | 5 ++++-
 fs/open.c  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index dede0147b3f6..31303063143b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3418,8 +3418,11 @@ static int do_last(struct nameidata *nd,
 		goto out;
 opened:
 	error = ima_file_check(file, op->acc_mode);
-	if (!error && will_truncate)
+	if (!error && will_truncate) {
 		error = handle_truncate(file);
+		if (!error)
+			ima_file_update(file);
+	}
 out:
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..a2771b787383 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -62,6 +62,9 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+
+	if (filp)
+		ima_file_update(filp);
 	return ret;
 }
 
-- 
2.17.1

