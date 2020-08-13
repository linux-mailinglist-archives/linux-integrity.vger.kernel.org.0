Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7444243EC8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMSZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMSZk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 256DAAD3C;
        Thu, 13 Aug 2020 18:26:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
Date:   Thu, 13 Aug 2020 20:25:23 +0200
Message-Id: <20200813182532.6931-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

we talked about Docker based Travis CI builds.
Here they are [1]. Working on it revealed few bugs, that's why they're
included.

I've resent 2 commits ("man:" prefix).

I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/swtpm [2].

Kind regards,
Petr

[1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/717681733
[2] https://github.com/stefanberger/swtpm/wiki/Using-the-IBM-TSS-with-swtpm

Petr Vorel (9):
  configure: Fix tss2-esys check
  man: Fix xmlcatalog path detection
  man: Generate doc targets only when XSL found
  install-swtpm.sh: Ignore certificate for download
  install-swtpm.sh: Update ibmtpm to version 1637
  Remove install-tpm2-tss.sh
  autogen.sh: Cleanup
  tests: Require cmp
  travis: Switch to docker based builds

 .travis.yml                    | 106 +++++++++++++++++++++++----------
 Makefile.am                    |   4 ++
 autogen.sh                     |  14 +----
 build.sh                       |  97 ++++++++++++++++++++++++++++++
 configure.ac                   |   7 ++-
 m4/manpage-docbook-xsl.m4      |  38 +++++++++---
 tests/install-swtpm.sh         |  10 ++--
 tests/install-tpm2-tss.sh      |  19 ------
 tests/sign_verify.test         |   9 ++-
 travis/alpine.sh               |  50 ++++++++++++++++
 travis/centos.sh               |   1 +
 travis/debian.cross-compile.sh |  23 +++++++
 travis/debian.i386.sh          |  11 ++++
 travis/debian.sh               |  54 +++++++++++++++++
 travis/fedora.sh               |  49 +++++++++++++++
 travis/opensuse.sh             |   1 +
 travis/tumbleweed.sh           |  45 ++++++++++++++
 travis/ubuntu.sh               |   1 +
 18 files changed, 457 insertions(+), 82 deletions(-)
 create mode 100755 build.sh
 delete mode 100755 tests/install-tpm2-tss.sh
 create mode 100755 travis/alpine.sh
 create mode 120000 travis/centos.sh
 create mode 100755 travis/debian.cross-compile.sh
 create mode 100755 travis/debian.i386.sh
 create mode 100755 travis/debian.sh
 create mode 100755 travis/fedora.sh
 create mode 120000 travis/opensuse.sh
 create mode 100755 travis/tumbleweed.sh
 create mode 120000 travis/ubuntu.sh

-- 
2.28.0

