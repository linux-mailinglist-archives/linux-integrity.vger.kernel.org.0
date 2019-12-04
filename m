Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D64112EBE
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 16:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfLDPkt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 10:40:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40575 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLDPkl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 10:40:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id a137so278544qkc.7
        for <linux-integrity@vger.kernel.org>; Wed, 04 Dec 2019 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzcsaP9w6MtdwnTCcp16VdCAYOhvH887rp/95iRWQVQ=;
        b=kl4D5bwqnbSucJmMwroPQGUi8vdiy/KN3BwAawDv0FO/VVAdiPtbDITjYyGGah4BF3
         a/73mNg8kI48HQdaNb1QKKqoPvqL5X2enjy0liqn2PB7ZmacHQldTWntbtMxCGCwtr8e
         kh7MayOaGH8NXvoKfqDpMI0d8WB64uuz6gkOx6vbgndE8NqHbqLnG5uruiE+iRaT1JHW
         LsKNr6Dj4ztOWcJHsrBalH4XlKVwrsTkMSdODFciIRV2DiBhoxF7lpzYJA+mhSiGK3He
         yQQMOyZckfKmtublkzjnoCNEzCnsghEFqEPafDb7NUZ/UowQA2yBG5dQ3pdsMYN4F+xj
         knLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzcsaP9w6MtdwnTCcp16VdCAYOhvH887rp/95iRWQVQ=;
        b=XGlu5zjQ8/2ZDnE60TVkYq6/ikdadk1ESOPlX/RufCaNQK4KIpWO7jjyQXIO/RFkdY
         YaPI21J3l3pzerHzS1j/5s7Gl75wLpZHS6cwM/AyyGKGB4BbV3r/A+M+l7EuxBgTNBgZ
         z8zKJ7VXMT2VwW/ZPeU4J+ykvqusznvPF/QrA7ufRF+pbOPC+aGHeeHcnownlrWk6Qu5
         SJOJ0APZDg2vZ+FdnDi8tMBb2uo1/FDDn0y1Zf9pee3jcE2dNOsgsbCX429rVVeqtgW4
         /KTCRc5MyZXVrP86KK1nnd1DkySnykClOOGs2TK+3xvCkjb1h+SLEzGo5KPUjWjo1pVF
         inqw==
X-Gm-Message-State: APjAAAVMIR0AVA/NlzMUR9loKuI7yyut6S0CwM1ds/zepauekwgIMpQC
        r9gx6tmfOt3QsiBBJBZ+BwBx2w==
X-Google-Smtp-Source: APXvYqwbHqmSIMaGHCldLdUxFkVwopIpvrtZm5CXX9fnNsfkRpFdzeM155lG9p5Sq1HX4dEysXr66g==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr3600708qkn.188.1575474040601;
        Wed, 04 Dec 2019 07:40:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y28sm3937692qtk.65.2019.12.04.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:40:39 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH v4 0/1] tpm/tpm_ftpm_tee: add shutdown call back
Date:   Wed,  4 Dec 2019 10:40:37 -0500
Message-Id: <20191204154038.2276810-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes from v3:
 - Synced with mainline
 - Added Tested-by Sasha Levin, and Reviewed-by: Jarkko Sakkinen.

Previous versions:
v3:
https://lore.kernel.org/lkml/20191016163114.985542-1-pasha.tatashin@soleen.com
v2:
https://lore.kernel.org/lkml/20191014202135.429009-1-pasha.tatashin@soleen.com
v1:
https://lore.kernel.org/lkml/20191011145721.59257-1-pasha.tatashin@soleen.com


Pavel Tatashin (1):
  tpm/tpm_ftpm_tee: add shutdown call back

 drivers/char/tpm/tpm_ftpm_tee.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.24.0

