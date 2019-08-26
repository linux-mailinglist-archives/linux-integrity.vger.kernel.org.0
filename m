Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBE9DA16
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHZXnU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 19:43:20 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:49182 "EHLO
        5.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZXnU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 19:43:20 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 19:43:19 EDT
Received: from player735.ha.ovh.net (unknown [10.108.42.75])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id B0F061DDA04
        for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2019 01:24:56 +0200 (CEST)
Received: from 3mdeb.com (093105046241.oswiecim.vectranet.pl [93.105.46.241])
        (Authenticated sender: piotr.krol@3mdeb.com)
        by player735.ha.ovh.net (Postfix) with ESMTPSA id 56AA5926A453
        for <linux-integrity@vger.kernel.org>; Mon, 26 Aug 2019 23:24:56 +0000 (UTC)
To:     linux-integrity@vger.kernel.org
From:   =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>
Subject: TPM 2.0 Linux sysfs interface
Openpgp: preference=signencrypt
Message-ID: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
Date:   Tue, 27 Aug 2019 01:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7658371166347840629
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,
I'm moving here discussion that I started with Jarkko and Peter on LinkedIn.

I'm preparing for 2 talks during LPC 2019 System Boot MC and one of it
will discuss TPM 2.0 sysfs support [1]. This was discussed couple times
[2] and explained why it is not done yet by Jarkko [3].

Why is this important?
- there seem to be no default method to distinguish if we dealing with
TPM 1.2 or 2.0 in the system
- distros use various tools to detect TPM based on sysfs (e.g. Qubes OS
scripts)
- tpm2-software has ton of dependencies, is not easy to build,
development is way faster then distros can manage and packages are often
out of date or even broken, so using it can be troublesome
- for deeply embedded systems adding fully-featured tpm2-software
doesn't make sense e.g. if we just need PCRs values

Jarkko comment on detecting 1.2 vs 2.0:
"Detecting TPM 2.0 is dead easy: send any idempotent TPM 2.0 command and
check if the tag field matches 0x8002 (TPM_NO_SESSIONS). The sysfs
features for TPM 1.2 are for the large part useless as you can get the
same data by using TPM commands."

Ok, but doesn't this mean I need TPM2 software stack?
Peter mentioned that it can be tricky to invoke such tools early in boot
process.

Finally, I do not feel expert in the field of Linux integrity and don't
want to argue for sysfs if it doesn't make sense for TPM 2.0, but if
that's the situation I would like to know what are the best practices to
solve above issues. If you think there is something important to be
discussed in above context please let me know.

[1] https://linuxplumbersconf.org/event/4/contributions/516/
[2]
https://patchwork.kernel.org/project/linux-integrity/list/?series=&submitter=&state=*&q=sysfs&archive=&delegate=
[3] https://lwn.net/Articles/624241/

Best Regards,
-- 
Piotr Król
Embedded Systems Consultant
GPG: B2EE71E967AA9E4C
https://3mdeb.com | @3mdeb_com
