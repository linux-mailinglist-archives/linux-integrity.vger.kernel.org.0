Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59152A9969
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgKFQZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 11:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKFQZ6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 11:25:58 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8670C2151B;
        Fri,  6 Nov 2020 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604679958;
        bh=VtRmxqvZFt8z4aGq8o2hPztnn9cvXvtOAj4xVPgOahU=;
        h=Date:From:To:Cc:Subject:From;
        b=EboiWL8iO7ZiSYO4H7wbsCThopHFR9rTNwe6gzgvr53TIRDlIHjK4DsJgV+0lwAFm
         kB7B6UEoelky9JPqI10GgQZxQt/PyFOJ7ufsYyjT+h/fwaw/IZVPFtYZpUPY12m/fQ
         yTYoKpxcsu0Twj5bOw68Zo6Y9U6Eyh2lP+1TAE6U=
Date:   Fri, 6 Nov 2020 18:25:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, jmorris@namei.org,
        dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] tpmdd updates for v5.10-rc4
Message-ID: <20201106162552.GA50264@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Here's two critical bug fixes. 'rc4' because it is only two days
before rc3 is getting released.

/Jarkko

The following changes since commit 521b619acdc8f1f5acdac15b84f81fd9515b2aff:

  Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-11-05 11:52:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10-rc4

for you to fetch changes up to 8ffd778aff45be760292225049e0141255d4ad6e:

  tpm: efi: Don't create binary_bios_measurements file for an empty log (2020-11-06 18:21:08 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.10-rc4

----------------------------------------------------------------
Jerry Snitselaar (1):
      tpm_tis: Disable interrupts on ThinkPad T490s

Tyler Hicks (1):
      tpm: efi: Don't create binary_bios_measurements file for an empty log

 drivers/char/tpm/eventlog/efi.c |  5 +++++
 drivers/char/tpm/tpm_tis.c      | 29 +++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)
