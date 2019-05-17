Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8E214CE
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEQHvA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 03:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbfEQHvA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 03:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BADDAF59;
        Fri, 17 May 2019 07:50:59 +0000 (UTC)
Date:   Fri, 17 May 2019 09:50:58 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190517075057.GA12489@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <1557889279.4581.14.camel@linux.ibm.com>
 <20190515120853.GA22992@dell5510>
 <1558044649.4507.10.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558044649.4507.10.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > But what is strange to me is that it continues to execute second line. return 1 [2]
> > should cause ROD() to quit with TBROK [3].
> > Maybe that ROD in test1() should be replaced EXPECT_PASS.

> With just the first patch of Ignaz's path set [1] and the TPM 2.0 test
> [2], there aren't any errors.  Without [1], it's now failing with the
> correct name.  I'm now seeing:
I guess, that justifies [1] to be merged into kernel.

> evm_overlay 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> evm_overlay 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> evm_overlay 1 TINFO: overwrite file in overlay
> tst_rod: Failed to open 'mntpoint/merged/foo1.txt' for writing: Permission denied
> evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly
That still does not explain, why test doesn't exit before this last line.
I'll have a closer look into it. But as I wrote, I'll make these changes:

diff --git testcases/kernel/security/integrity/ima/tests/evm_overlay.sh testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index 08ec1ea37..1d05b9e1c 100755
--- testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -40,7 +40,7 @@ test1()
 	local file="foo1.txt"
 
 	tst_res TINFO "overwrite file in overlay"
-	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo lower \> $lower/$file
 	EXPECT_PASS echo overlay \> $merged/$file
 }
 
@@ -49,7 +49,7 @@ test2()
 	local file="foo2.txt"
 
 	tst_res TINFO "append file in overlay"
-	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo lower \> $lower/$file
 	EXPECT_PASS echo overlay \>\> $merged/$file
 }
 
---
If it's ok for you and it's a valid test do you give an ack?

Kind regards,
Petr

> Mimi

> [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> [2] https://lore.kernel.org/linux-integrity/1558041162.3971.2.camel@linux.ibm.com/T/#u

