Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EA02EB232
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbhAESML (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 13:12:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:37148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbhAESMK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 13:12:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67AD6AFF0;
        Tue,  5 Jan 2021 18:11:29 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] travis: Use Ubuntu 20.10 groovy
Date:   Tue,  5 Jan 2021 19:11:20 +0100
Message-Id: <20210105181120.31417-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Eoan is failing:

E: The repository 'http://security.ubuntu.com/ubuntu eoan-security Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.

And 20.04 LTS focal in Travis is still fails on debconf issue
("debconf: unable to initialize frontend: Dialog")

Old 16.04 LTS xenial is still supported and working in Travis,
thus move to new groovy gives us good coverage both old and new releases.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 9bea5d1..e73b24e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -38,7 +38,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:eoan TSS=ibmtss
+          env: DISTRO=ubuntu:groovy TSS=ibmtss
           compiler: gcc
 
         - os: linux
-- 
2.29.2

