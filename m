Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CC478CE5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhLQN4O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 08:56:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55192 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhLQN4O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 08:56:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1405C21114;
        Fri, 17 Dec 2021 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639749373;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aQ3+yf5JIWHypRszMvoOehD/PG7HGAeJLhf6ZiTFwo=;
        b=bkgVW+QXLWRwyooWfNY4ExMsuTdQwLeZSEr6AT+1qDU1qqq9aPy9NGOBmFjMWPWB8nARjw
        CPVIXzV6oySScKwskkjcuovWhhGkgo/9aPWx8kgVKYjGmu2BbgYh4FwEbZhkqeIwDSPj8E
        BcyUpHH5eV4cclujxFHH2W9IJnRv/LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639749373;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aQ3+yf5JIWHypRszMvoOehD/PG7HGAeJLhf6ZiTFwo=;
        b=jMHa6pAVnintD0MC+0vhqIXBXves0SaboiDm8UO6QmJ+B2lyx38VvTTondZSlCs+OhSHVZ
        jd4nTxQDWSRAC+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA85613E25;
        Fri, 17 Dec 2021 13:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GmH6KvyWvGFfEwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 13:56:12 +0000
Date:   Fri, 17 Dec 2021 14:56:10 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     ltp@lists.linux.it, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] syscalls/keyctl09: test encrypted keys.
Message-ID: <YbyW+nRbUnmfHue1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211217021726.2487455-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217021726.2487455-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Yael,

> Test that encrypted keys can be instantiated using
> both user-provided decrypted data
> (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> or kernel-generated numbers.

Thanks a lot for adding this test. There are few missing things:

BTW all mentioned here is implemented here to speedup your work:
https://github.com/pevik/ltp/tree/yael_tiomkin/keyctl09.fixes
Below is diff of my suggested changes.

What I didn't solve is broken test when run with more than 1 iteration:

./keyctl09 -i2
tst_test.c:1423: TINFO: Timeout per run is 0h 05m 00s
keyctl09.c:47: TPASS: Encrypted keys were successfully instantiated and read
keyctl09.c:31: TBROK: Failed to instantiate encrypted key using payload decrypted data: EINVAL (22)

NOTE: you can specify test setup to do things only once. You should also cleanup
after test run with test cleanup.
https://github.com/linux-test-project/ltp/wiki/C-Test-API#11-basic-test-structure

You also need to add entry to testcases/kernel/syscalls/keyctl/.gitignore
/keyctl09

and runtest/syscalls
keyctl09 keyctl09

...
> +/*
> + * Description: This tests that encrypted keys can be instantiated using
> + * user-provided decrypted data (plaintext), and separately, using
> + * kernel-generated key material.
> + */

I'd rephrase it a bit and use LTP metadata formatting
/*\
 * [Description]
 * Test that encrypted keys can be instantiated using user-provided decrypted
 * data (plaintext), and separately, using kernel-generated key material.
 */

FYI metadata is LTP documentation - here is the output:
https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.html
https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.pdf

You can run make in docparse/ directory and then see in output in
metadata/metadata.{html,pdf}.

> +
> +#include <errno.h>
> +#include <stdint.h>
IMHO these 2 aren't needed.
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +static void do_test(void)
> +{
> +	key_serial_t masterkey;
> +	key_serial_t encryptedkey1;
> +	key_serial_t encryptedkey2;
> +	char buffer[128];
> +
> +	masterkey = add_key("user", "user:masterkey", "foo", 3, KEY_SPEC_PROCESS_KEYRING);
> +	if (masterkey == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to add user key");
> +
> +	encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32 user:masterkey 32 plaintext12345678901234567890123", 60, KEY_SPEC_PROCESS_KEYRING);
nit: It'd be nice to keep 80 lines per line (or 100 with string).
Maybe use #define for payload, which makes it shorter?

> +	if (encryptedkey1 == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using payload decrypted data");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey1");
> +
> +	encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32 user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey2 == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using kernel-generated key material");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey2");
At least one of these should be TFAIL - failing test. TBROK is used when test
fails in test preparation phase. Also have look at include/tst_test_macros.h
you can use e.g. TST_EXP_PASS_SILENT().

Kind regards,
Petr

diff --git runtest/syscalls runtest/syscalls
index bcf3d56c9c..ccea1ddbdb 100644
--- runtest/syscalls
+++ runtest/syscalls
@@ -643,6 +643,7 @@ keyctl05 keyctl05
 keyctl06 keyctl06
 keyctl07 keyctl07
 keyctl08 keyctl08
+keyctl09 keyctl09
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git testcases/kernel/syscalls/keyctl/.gitignore testcases/kernel/syscalls/keyctl/.gitignore
index 3544ac79ce..f9948c1766 100644
--- testcases/kernel/syscalls/keyctl/.gitignore
+++ testcases/kernel/syscalls/keyctl/.gitignore
@@ -6,3 +6,4 @@
 /keyctl06
 /keyctl07
 /keyctl08
+/keyctl09
diff --git testcases/kernel/syscalls/keyctl/keyctl09.c testcases/kernel/syscalls/keyctl/keyctl09.c
index 4589ef3679..7481526c67 100644
--- testcases/kernel/syscalls/keyctl/keyctl09.c
+++ testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -3,15 +3,12 @@
  * Copyright (c) 2021 Google, Inc.
  */
 
-/*
- * Description: This tests that encrypted keys can be instantiated using
- * user-provided decrypted data (plaintext), and separately, using
- * kernel-generated key material.
+/*\
+ * [Description]
+ * Test that encrypted keys can be instantiated using user-provided decrypted
+ * data (plaintext), and separately, using kernel-generated key material.
  */
 
-#include <errno.h>
-#include <stdint.h>
-
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
@@ -22,11 +19,14 @@ static void do_test(void)
 	key_serial_t encryptedkey2;
 	char buffer[128];
 
-	masterkey = add_key("user", "user:masterkey", "foo", 3, KEY_SPEC_PROCESS_KEYRING);
+	masterkey = add_key("user", "user:masterkey", "foo", 3,
+			    KEY_SPEC_PROCESS_KEYRING);
 	if (masterkey == -1)
 		tst_brk(TBROK | TERRNO, "Failed to add user key");
 
-	encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32 user:masterkey 32 plaintext12345678901234567890123", 60, KEY_SPEC_PROCESS_KEYRING);
+	encryptedkey1 = add_key("encrypted", "ltptestkey1",
+				"new enc32 user:masterkey 32 plaintext12345678901234567890123",
+				60, KEY_SPEC_PROCESS_KEYRING);
 	if (encryptedkey1 == -1)
 		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using payload decrypted data");
 
@@ -34,9 +34,11 @@ static void do_test(void)
 	if (TST_RET < 0)
 		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for encryptedkey1");
 
-	encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32 user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
+	encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32 user:masterkey 32",
+				27, KEY_SPEC_PROCESS_KEYRING);
 	if (encryptedkey2 == -1)
-		tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted key using kernel-generated key material");
+		tst_brk(TBROK | TERRNO,
+			"Failed to instantiate encrypted key using kernel-generated key material");
 
 	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
 	if (TST_RET < 0)
