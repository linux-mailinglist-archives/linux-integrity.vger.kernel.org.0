Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468C3B0720
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhFVOOz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 10:14:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFVOOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 10:14:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3B591FD5D;
        Tue, 22 Jun 2021 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u7YrJuiAlEXlgRmgSKh/11hlkXQuMaoIqnd/NgYdhyU=;
        b=M0d6o6bRTAtgllVT72h8XQTmesjJiaQW3L6bS/vpgaskzhCTrVuvQQ8XpzMJtU+Y5Mouy8
        7908UiIL3am1dZHLaVmHGLS7nnCiTGvJRZAuvHOuuNTH2Z5l28Idb2Q+wQep2/s8fKl73L
        L3je6zhZliCPbFE4DVT7cek93hOMpWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u7YrJuiAlEXlgRmgSKh/11hlkXQuMaoIqnd/NgYdhyU=;
        b=O+IH6vgvj7DFURznveD9qmKhWEwXeaGyP8Zj75cXOxWFeaxEQ/ZpbBxkB43PK7Vld1AVD8
        J5uH8+R3un9sH4BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 71800118DD;
        Tue, 22 Jun 2021 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u7YrJuiAlEXlgRmgSKh/11hlkXQuMaoIqnd/NgYdhyU=;
        b=M0d6o6bRTAtgllVT72h8XQTmesjJiaQW3L6bS/vpgaskzhCTrVuvQQ8XpzMJtU+Y5Mouy8
        7908UiIL3am1dZHLaVmHGLS7nnCiTGvJRZAuvHOuuNTH2Z5l28Idb2Q+wQep2/s8fKl73L
        L3je6zhZliCPbFE4DVT7cek93hOMpWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u7YrJuiAlEXlgRmgSKh/11hlkXQuMaoIqnd/NgYdhyU=;
        b=O+IH6vgvj7DFURznveD9qmKhWEwXeaGyP8Zj75cXOxWFeaxEQ/ZpbBxkB43PK7Vld1AVD8
        J5uH8+R3un9sH4BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iz8FGdbv0WBRUgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 22 Jun 2021 14:12:38 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add GitHub Actions support
Date:   Tue, 22 Jun 2021 16:12:21 +0200
Message-Id: <20210622141224.25006-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Travis is unreliable due "pull rate limit" issue, workaround does not
work any more. Also GitHub Actions is a recommended way for projects
hosted on GitHub.

Nice bonus is that manual podman activation for distros using glibc >=
2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.

Unlike LTP, where I removed Travis CI support, I kept it for
ima-evm-utils, because you use it.

Kind regards,
Petr

Petr Vorel (3):
  CI: Rename travis script directory
  CI/openSUSE: Fix tpm_server symlink creation
  CI: Introduce GitHub Actions setup

 .github/workflows/ci.yml               | 121 +++++++++++++++++++++++++
 .travis.yml                            |   2 +-
 {travis => ci}/alpine.sh               |   0
 {travis => ci}/centos.sh               |   0
 {travis => ci}/debian.cross-compile.sh |   0
 {travis => ci}/debian.i386.sh          |   0
 {travis => ci}/debian.sh               |   0
 {travis => ci}/fedora.sh               |   0
 {travis => ci}/opensuse.sh             |   0
 {travis => ci}/tumbleweed.sh           |   2 +-
 {travis => ci}/ubuntu.sh               |   0
 11 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 .github/workflows/ci.yml
 rename {travis => ci}/alpine.sh (100%)
 rename {travis => ci}/centos.sh (100%)
 rename {travis => ci}/debian.cross-compile.sh (100%)
 rename {travis => ci}/debian.i386.sh (100%)
 rename {travis => ci}/debian.sh (100%)
 rename {travis => ci}/fedora.sh (100%)
 rename {travis => ci}/opensuse.sh (100%)
 rename {travis => ci}/tumbleweed.sh (90%)
 rename {travis => ci}/ubuntu.sh (100%)

-- 
2.32.0

