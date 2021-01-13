Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377722F5768
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbhANB65 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 20:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbhAMXj5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 18:39:57 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EAC0617BA;
        Wed, 13 Jan 2021 15:29:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D4E851280507;
        Wed, 13 Jan 2021 15:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610580397;
        bh=s0c634nlcedkZkA291f6sVLCwg/uFDmds8y8Ez+P97Y=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=XkgCvVwcbmaeezzLFoGXHQYqYRWvXOaJafk4hPDESwLQDtb3C4E6GHkKwhUg/ZKgx
         26FQf9ohoYhKUb0CbeZB+xYiCGCwRPEQj8DI4GPXR3uOves5MA/JhQtF3APGRERj1m
         LxVSsIwlp2pxI016wbZnYGH1wroOnZgVvO5cUKmM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S6AadztpZrLS; Wed, 13 Jan 2021 15:26:37 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 75B5412804FC;
        Wed, 13 Jan 2021 15:26:37 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH v5 2/2] ABI: add sysfs description for tpm exports of PCR registers
Date:   Wed, 13 Jan 2021 15:26:34 -0800
Message-Id: <20210113232634.23242-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adds the ABI entries for the new

/sys/class/tpm/tpm<n>/pcr-<hash>/<m>

files which are added to export the PCR hash values on a one value per
file basis.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/ABI/stable/sysfs-class-tpm | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index 91ca63ec7581..d897ecb9615f 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -194,3 +194,17 @@ Description:	The "tpm_version_major" property shows the TCG spec major version
 		Example output::
 
 		  2
+
+What:		/sys/class/tpm/tpmX/pcr-H/N
+Date:		March 2021
+KernelVersion:	5.12
+Contact:	linux-integrity@vger.kernel.org
+Description:	produces output in compact hex representation for PCR
+		number N from hash bank H.  N is the numeric value of
+		the PCR number and H is the crypto string
+		representation of the hash
+
+		Example output::
+
+		  cat /sys/class/tpm/tpm0/pcr-sha256/7
+		  2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
-- 
2.26.2

