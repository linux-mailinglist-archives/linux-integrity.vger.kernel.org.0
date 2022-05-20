Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEB52EE1B
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiETO0U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiETO0T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 10:26:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4A35244
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653056774;
    s=strato-dkim-0002; d=thson.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RfTpcBuRSxrx/rQxCuBgj+dhizmZZfnQk1VUMNUun8w=;
    b=GFjyCFD7Y25WUrdaeeLYXtt4/z3VeDxpn/4W/AJtwM2ibbhDl5HrsP1wFVPk/kKRE6
    DymMoquanWYNmqC2hn7nJN4J/lkfpPkHY7iEDkKMBrdBP8ZgwgNI0SaIRyIggaA2tn6P
    Fog4wEqDdQbM87DkW1De6/G/MAr2D/kRIWPW0Mv7TB2ZebRLwIGXt8FzzzBflMMzYuy9
    F2S0105KDFyPncvhVIq80qr3CUMKWYZ0F/aQy4tQnU9tgIuvHu0SJJ1ElvxlV77Azy1t
    sZhsyYuEDUwzy2GuZz+Du2bzd+zraleYnTUR/jaMiqtUOO90fScBve1ymqNt/229rqFK
    BefA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey4KEQDQD4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 16:26:13 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        nramas@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, Thore Sommer <public@thson.de>
Subject: [PATCH 0/3] dm ima: allow targets to remeasure their state
Date:   Fri, 20 May 2022 16:26:02 +0200
Message-Id: <20220520142605.270625-1-public@thson.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The existing device mapper IMA measurements only measure the table content
on target creation. This is fine for targets that do not change their table
during runtime, but some targets like verity use the table to display state
changes. Those changes are not visible through the existing device mapper
integration.

A new DM event "dm_target_update" is introduced for targets to remeasure
their table entry. This event is intended to be used by targets that change
their table entries to indicate potential security relevant information.
This allows for a more complete Remote Attestation of device mapper
targets.

One example use case is to verify the with verity protected root filesystem
using Remote Attestation via IMA. This was not possible before because the
corruption is only detected during runtime and not when the table is
loaded.

Keylime [1] has experimental support for validating this event, but it has
to be enabled manually.

Changes since RFC patch set [2]:
 - Added suggested changes from Lakshmi
 - rewrote target index calculation and removed unnecessary NULL check
 - rewrote verity integration to be more readable
 - Added more detailed description to the single commit messages


[1] https://keylime.dev/
[2] https://lore.kernel.org/linux-integrity/20220106203436.281629-1-public@thson.de/T/


Thore Sommer (3):
  dm ima: allow targets to remeasure their table entry
  dm verity: add support for IMA target update event
  dm ima: add documentation target update event

 .../admin-guide/device-mapper/dm-ima.rst      | 33 +++++++++
 drivers/md/dm-ima.c                           | 70 +++++++++++++++++++
 drivers/md/dm-ima.h                           |  2 +
 drivers/md/dm-verity-target.c                 | 10 ++-
 4 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.36.0

