Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919DF48C465
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jan 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiALNHE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jan 2022 08:07:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353366AbiALNGx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jan 2022 08:06:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF3451F385;
        Wed, 12 Jan 2022 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641992811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0D7iElc2KBU4F3mP8SKPzfDB41mMoY/kXSh/x1Pnzy8=;
        b=UsNnxGAeV0fwkDNUYiW7BW27V2BxPImo6KrmWXhl70oPDX0PnKuw53++kLnram5e+ji2sK
        9/q0HV+iFRRDqrkOZ9zQkKK6GqWZkFEsw0uwmhKGLFPOWZEDxMVECEez49M/vn4KX6HZcQ
        tVHroNE+M5gAZy/1qZokn3nMhdAl+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641992811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0D7iElc2KBU4F3mP8SKPzfDB41mMoY/kXSh/x1Pnzy8=;
        b=pw0THi05QwDNihuOTbytvxfEvxp0BbxqJcp9HW1EyJMpbF/2EBv95Q0iIBgLZA1X+TU2kJ
        NvwBE9/IvV4zYlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75F5013B61;
        Wed, 12 Jan 2022 13:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ARgCG2vS3mEDTAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 12 Jan 2022 13:06:51 +0000
Date:   Wed, 12 Jan 2022 14:06:49 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v8 0/3] IMA: Add tests for uid, gid, fowner, and fgroup
 options
Message-ID: <Yd7SaS2TIaUrlcIN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211006103059.9617-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006103059.9617-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

FYI patchset merged with diff below. Fixed
* "cat: '>': No such file or directory" error reported by Mimi
* use /proc/uptime to not require date

Thanks for your work and patience.

FYI we had some discussion about merging patches earlier - after they met rc1 or
next-tree (I guess getting into maintainer tree could be accepted). Feel free to
contribute to this discussion:

https://lore.kernel.org/ltp/20211221113042.21357-1-rpalethorpe@suse.com/
https://lore.kernel.org/ltp/87lf0ffw1y.fsf@suse.de/
https://lore.kernel.org/ltp/YdW5WEXgrotentzM@yuki/

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index c83006f6d1..095028e163 100755
--- testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -5,8 +5,11 @@
 # Author: Alex Henrie <alexh@vpitech.com>
 #
 # Verify that conditional rules work.
+#
+# gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
+# support") from v5.16.
 
-TST_NEEDS_CMDS="chgrp chown id sg sudo"
+TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
 TST_CNT=1
 TST_NEEDS_DEVICE=1
 
@@ -28,16 +31,16 @@ verify_measurement()
 
 	tst_res TINFO "verify measuring user files when requested via $request"
 	ROD echo "measure $request=$value" \> $IMA_POLICY
-	ROD echo "$(date) $request test" \> $test_file
+	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
 
 	case "$request" in
 	fgroup)
 		chgrp $user $test_file
-		$cmd
+		sh -c "$cmd"
 		;;
 	fowner)
 		chown $user $test_file
-		$cmd
+		sh -c "$cmd"
 		;;
 	gid) sudo sg $user "sh -c '$cmd'";;
 	uid) sudo -n -u $user sh -c "$cmd";;
