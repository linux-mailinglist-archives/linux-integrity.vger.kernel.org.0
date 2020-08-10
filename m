Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58024009D
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Aug 2020 03:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHJBCP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 Aug 2020 21:02:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57254 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJBCP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Aug 2020 21:02:15 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 99DE720B4908;
        Sun,  9 Aug 2020 18:02:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99DE720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597021334;
        bh=bX3uT8IVRl+7KtAprvDfRY+aoni4KFRAQiYEn8kFi74=;
        h=From:To:Cc:Subject:Date:From;
        b=pZZBq6z9cab2o/zBrvZpYtMX6n4NG7GyWs+o+QfQcE+uI/UeBZZknAb+RaKaG4Ngi
         NVniUwazErcCWJl8C5WLkcpuW+5gzHdtd73tmwyFM9OzqcconW7+9g7oGSjdOfhvS2
         E9nEy8nqV8b5njreG7+aK6mYS1n5L01IToLjpfWA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com
Subject: [PATCH] field-dictionary.csv: Add errno to audit message field dictionary
Date:   Sun,  9 Aug 2020 18:02:10 -0700
Message-Id: <20200810010210.4037-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Error code was not included in the audit messages logged by
the integrity subsystem in the Linux kernel.

commit 2f845882ecd2 in https://github.com/torvalds/linux tree added
"errno" field in the audit messages logged by the integrity subsystem.
The "errno" field will be set to 0 when the operation was completed
successfully, and on failure a non-zero error code is set in this field
in the audit message.

Add the documentation for the "errno" field in the audit message
field dictionary.

Sample audit message from the integrity subsystem with errno field:

    [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_key cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0 errno=-12

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 specs/fields/field-dictionary.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/specs/fields/field-dictionary.csv b/specs/fields/field-dictionary.csv
index 055ff79..5117e25 100644
--- a/specs/fields/field-dictionary.csv
+++ b/specs/fields/field-dictionary.csv
@@ -49,6 +49,7 @@ dport,numeric,remote port number,
 egid,numeric,effective group ID,
 enforcing,numeric,new MAC enforcement status,
 entries,numeric,number of entries in the netfilter table,
+errno,numeric,error code of the audited operation,
 euid,numeric,effective user ID,
 exe,encoded,executable name,
 exit,numeric,syscall exit code,
-- 
2.28.0

