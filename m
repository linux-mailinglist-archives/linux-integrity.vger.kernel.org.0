Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD31F2F1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfEOMI5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 May 2019 08:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbfEOMI4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 08:08:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60F9AABF4;
        Wed, 15 May 2019 12:08:55 +0000 (UTC)
Date:   Wed, 15 May 2019 14:08:53 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190515120853.GA22992@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <1557889279.4581.14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557889279.4581.14.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> The first two patches are fine.  From the test, I'm seeing the
> following results:
Thanks a lot for reviewing and testing.

> evm_overlay 1 TINFO: overwrite file in overlay
> tst_rod: Failed to open '(null)' for writing: Operation not permitted
> evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly
I've fixed '(null)' [1], with that one applied it should be 'mntpoint/merged/foo1.txt'
But what is strange to me is that it continues to execute second line. return 1 [2]
should cause ROD() to quit with TBROK [3].
Maybe that ROD in test1() should be replaced EXPECT_PASS.

> evm_overlay 2 TINFO: append file in overlay: mntpoint/lower/foo2.txt
> evm_overlay 2 TPASS: echo overlay >> mntpoint/merged/foo2.txt passed as expected
> evm_overlay 3 TINFO: create a new file in overlay
> evm_overlay 3 TPASS: echo overlay > mntpoint/merged/foo3.txt passed as expected
> evm_overlay 4 TINFO: read all created files
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo1.txt > /dev/null 2> /dev/null failed unexpectedly
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo2.txt > /dev/null 2> /dev/null failed unexpectedly
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo3.txt > /dev/null 2> /dev/null failed unexpectedly
> evm_overlay 5 TINFO: SELinux enabled in enforcing mode, this may affect test results
> evm_overlay 5 TINFO: You can try to disable it with TST_DISABLE_SELINUX=1 (requires super/root)
> evm_overlay 5 TINFO: loaded SELinux profiles: none

> With "evm: instead of using the overlayfs i_ino, use the real i_ino"
> patch, I'm only seeing the first failure.

> Mimi

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/8a35daf6bb175391fd43cd28d9ca2d0d5b06157c
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_rod.c#L117
[3] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_test.sh#L150
