Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D38486B4F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 21:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiAFUky (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 15:40:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:45637 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiAFUky (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 15:40:54 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 15:40:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641501288;
    s=strato-dkim-0002; d=thson.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8N6fuXdGncvZ1J0hUeIkBEXDSUkj0JStVgw0N5dRD28=;
    b=YjTz5+7OQR6DCFRoMdA8mMNM/sAk2EPy9LuELNdLRSBskNsNx9ck1yJ966lf1UVlFx
    H84UdKf/miZE46j8EX/neTz1wVvkszwF3BL8ZbfHQwAvhBma5iT6ApfMFvBOFq0arEG3
    4CJ4AzgOH/yuHdkxU9aeJcSg35Qr/h8HOWTn4gFRz8oXj0LPYRhTWbxFvcgHlHPKrmV9
    lJ2+tZvth1iEb261nKDWbM2ghGAcIw0o27Jz2+WPV/q2QbbRE+7JvGiUb0XGP1KQPQkV
    IF3NzrxjOMPd/CY5HWi90d9/wdPJGNJ/sSkmSJTJwrW4VtOfPozmYDr+EpPe0wZwvUcM
    l8pQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id k3f463y06KYl05e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jan 2022 21:34:47 +0100 (CET)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Thore Sommer <public@thson.de>
Subject: [RFC PATCH 0/3] dm ima: allow targets to remeasure their state
Date:   Thu,  6 Jan 2022 21:34:33 +0100
Message-Id: <20220106203436.281629-1-public@thson.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current DM IMA events do not cover the case where a device changes
their attributes to indicate a state change. This adds a new event 
(dm_target_update) which allows targets to remeasure their table entries.
The event includes the dm version, device metadata and the target data.

Currently only verity supports this event to ensure that device corruption
can be detected using IMA which is useful for remote attestation.

The current implementation does not update the active table hash because
it would require to rehash the entire table on every target change.

Thore Sommer (3):
  dm ima: allow targets to remeasure their table entry
  dm verity: add support for IMA target update event
  dm ima: add documentation target update event

 .../admin-guide/device-mapper/dm-ima.rst      | 33 ++++++++
 drivers/md/dm-ima.c                           | 76 +++++++++++++++++++
 drivers/md/dm-ima.h                           |  2 +
 drivers/md/dm-verity-target.c                 |  6 ++
 4 files changed, 117 insertions(+)

-- 
2.34.1

