Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514E48C6A5
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jan 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiALPB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jan 2022 10:01:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354387AbiALPB3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jan 2022 10:01:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A099210FD;
        Wed, 12 Jan 2022 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641999688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U5zM8q6Pg2VoQS63GoWOpLU7MUACogR+OPLPqujHpwU=;
        b=Z3Fqw7WZwtrtEqwlo0KFuM3WvKJSSZyXJdrghbqz47BRXCoW5aW5I7iOH4x64uxzv8RCjl
        nviCNvJ+D14YmfPlMEBqZPQf0OcoqW6mlJDTT/ZKCwij+RcysHs0x3hiF5VeQ8ZBIuMJKb
        qx8yuaepOmiia0THEbkPyHoO7Do9CCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641999688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U5zM8q6Pg2VoQS63GoWOpLU7MUACogR+OPLPqujHpwU=;
        b=NsEaHl43H/6h283EstOfThAkrth9QhMZ3V1EbGWoXIj5e/uptKDYnDZ7x8Ajl1UgCaj7JP
        ifmKGHtC+ATvVlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D93A513B70;
        Wed, 12 Jan 2022 15:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BHX1Mkft3mEsEwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 12 Jan 2022 15:01:27 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com,
        Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 1/1] ima_measurements.sh: Use /proc/uptime instead of date
Date:   Wed, 12 Jan 2022 16:01:23 +0100
Message-Id: <20220112150123.13768-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It fixes more iterations (e.g. -i2) which is more precise.
date +%s could be used, but it's better use procfs file instead
requiring binary.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I hope to get this merged into upcoming release (git freeze is going to
be at January the 14), i.e. this Friday.

Kind regards,
Petr

 .../security/integrity/ima/tests/ima_measurements.sh      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index a83c416de0..6c184f3960 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -55,7 +55,7 @@ check_iversion_support()
 test1()
 {
 	tst_res TINFO "verify adding record to the IMA measurement list"
-	ROD echo "$(date) this is a test file" \> $TEST_FILE
+	ROD echo "$(cat /proc/uptime) this is a test file" \> $TEST_FILE
 	ima_check $TEST_FILE
 }
 
@@ -64,7 +64,7 @@ test2()
 
 	tst_res TINFO "verify updating record in the IMA measurement list"
 	check_iversion_support || return
-	ROD echo "$(date) modified file" \> $TEST_FILE
+	ROD echo "$(cat /proc/uptime) modified file" \> $TEST_FILE
 	ima_check $TEST_FILE
 }
 
@@ -83,11 +83,11 @@ test3()
 		return
 	fi
 
-	mkdir -m 0700 $dir
+	[ -d "$dir" ] || mkdir -m 0700 $dir
 	chown $user $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
+	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
-- 
2.34.1

