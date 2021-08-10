Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C603E8450
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 22:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhHJU30 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 16:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233083AbhHJU3Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 16:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628627343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dq7pMDF6LAgIiRVP35gKbCTye0QjcWd4VoAneU4gEL8=;
        b=B1NQKx8oYuXFvS5tiKsBkzOdfxBPLqbrtu8iNus8fBwCyaYYeKW8YwgjyNZ9z+FlKwoVWZ
        aDA+PgQiLnAp/yfola7pZMDyovYl+Zxq7W8zUVw8+Qk9bnsVJMQlPHMihFolXrHhfsUSZk
        zowWuywrayFkNaRNjnXCk95g/y3v03M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-UsRi0r2qMAq_zjLf5GN5Xw-1; Tue, 10 Aug 2021 16:28:59 -0400
X-MC-Unique: UsRi0r2qMAq_zjLf5GN5Xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6EC987D541;
        Tue, 10 Aug 2021 20:28:58 +0000 (UTC)
Received: from localhost (unknown [10.22.18.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4775D6A8;
        Tue, 10 Aug 2021 20:28:54 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     vt@altlinux.org, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
Date:   Tue, 10 Aug 2021 17:28:51 -0300
Message-Id: <20210810202852.236354-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The variable "password" is not freed nor returned in case get_password()
succeeds. Instead of using an intermediary variable ("pwd") for returning
the value, use the same "password" var. Issue found by Coverity scan tool.

src/evmctl.c:2565: leaked_storage: Variable "password" going out of scope
    leaks the storage it points to.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 src/evmctl.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7a6f2021aa92..b49c7910a4a7 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2601,8 +2601,9 @@ static struct option opts[] = {
 static char *get_password(void)
 {
 	struct termios flags, tmp_flags;
-	char *password, *pwd;
+	char *password;
 	int passlen = 64;
+	bool err = false;
 
 	password = malloc(passlen);
 	if (!password) {
@@ -2622,16 +2623,24 @@ static char *get_password(void)
 	}
 
 	printf("PEM password: ");
-	pwd = fgets(password, passlen, stdin);
+	if (fgets(password, passlen, stdin) == NULL) {
+		perror("fgets");
+		/* we still need to restore the terminal */
+		err = true;
+	}
 
 	/* restore terminal */
 	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
 		perror("tcsetattr");
+		err = true;
+	}
+
+	if (err) {
 		free(password);
 		return NULL;
 	}
 
-	return pwd;
+	return password;
 }
 
 int main(int argc, char *argv[])
-- 
2.31.1

