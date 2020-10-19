Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD4292F1D
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgJSUFc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 16:05:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40064 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgJSUFc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 16:05:32 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3EBB20B4905;
        Mon, 19 Oct 2020 13:05:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3EBB20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603137931;
        bh=G++NylAPGqsjk76XfwjkgacUno9Ru5UfhSEyYNVFjJs=;
        h=From:To:Cc:Subject:Date:From;
        b=rrJegYJfNZ+G9rLGuibBWEOzBjMcRYEvTvXr2WW+RmvwuFg6nM2P+QcEWalsEwUWv
         KrCde3I/5ceJNvsLlh8CvlqwAtJtFN9oBVcDfdA8jhX0YmP1BwYNdLQXxB0e2B/9Zu
         Se4z1l/FSg7RdjSPhk+YwVa+BmXHoaMxU2Jy+bLU=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
Subject: [PATCH] file2bin: Pass the right values to size and count parameters for fread()
Date:   Mon, 19 Oct 2020 13:05:26 -0700
Message-Id: <20201019200526.12678-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The 2nd parameter to fread() namely "size" specifies the size, in
bytes of each element to be read, and the 3rd parameter namely "count"
specifies the number of elements, each one with a size of "size" bytes.

 size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );

But in the function file2bin() the values passed to "size" and "count"
are reversed causing the function to return an error eventhough the file
was sucdessfully read.

Pass the right values to "size" and "count" parameters for fread() in
the function file2bin().

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 src/evmctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7ad1150..d49988e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 		fclose(fp);
 		return NULL;
 	}
-	if (fread(data, len, 1, fp) != len) {
+
+	if (fread(data, 1, len, fp) != len) {
 		log_err("Failed to fread %zu bytes: %s\n", len, name);
 		fclose(fp);
 		free(data);
-- 
2.28.0

