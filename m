Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8273E3EBDEF
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhHMVii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44314 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhHMVii (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 12AAD20C28AD;
        Fri, 13 Aug 2021 14:38:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12AAD20C28AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890691;
        bh=bGT4Ic4+8heI39wiqJHz4huQx3xxxyNiPNklH/2l28E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XanzTZEkXW5Iic5Qhqw0GaAyRZt41IwixOLDV3oH8mYVH1InrFDVw7KWa6frr65mc
         Gb5Aei9+/x4WrTSayqYGM0yzgt1lgYs1IPycXXyCnfKlY0K9cdPyTmo0B3H5aI4qE3
         0KJM3hg8bi17ctVOSlU46rqBFUc8onnk4R1bkNrA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 4/6] dm ima: add a warning in dm_init if duplicate ima events are not measured
Date:   Fri, 13 Aug 2021 14:37:59 -0700
Message-Id: <20210813213801.297051-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The end-users of DM devices/targets may remove and re-create the same
device multiple times.  IMA does not measure such duplicate events if the
configuration CONFIG_IMA_DISABLE_HTABLE is set to 'n'.
To avoid confusion, the end-users need some indication on the client
if that configuration option is disabled.

Add a one-time warning to dmesg during dm_init if
CONFIG_IMA_DISABLE_HTABLE is set to 'n', to notify the end-users that
duplicate events will not be measured in the ima log.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2e82757b4ab7..948cb0dc5fc4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -265,6 +265,12 @@ static int __init dm_init(void)
 
 	int r, i;
 
+#if (IS_ENABLED(CONFIG_BLK_DEV_DM) && IS_ENABLED(CONFIG_IMA) \
+	&& !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
+	DMWARN("CONFIG_IMA_DISABLE_HTABLE is disabled."
+	       " Duplicate IMA measurements will not be recorded in the IMA log.");
+#endif
+
 	for (i = 0; i < count; i++) {
 		r = _inits[i]();
 		if (r)
-- 
2.32.0

