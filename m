Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4990EAD55C
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfIIJJj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 05:09:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41720 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIIJJj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 05:09:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so7450260pgg.8;
        Mon, 09 Sep 2019 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkgxfyyynI7isiueWlzcBjvaj2ty8uVTrVmQjQhJboM=;
        b=KyRRriKUZdEP7SymqzKEAIo1aivwNm+LsxEQIgia+ei8L68Fm31A0/EofVFAGS+9m2
         Iv6POZsNwoAbTwOp1icRWHENj6yWlrRLRc7DdxwHR/jT1Zkk/NA5XfUK2oSJFLocI7ng
         lKTdCSYK5+Nx6y2q71Y0f45r7nYDbMib3oAYBwhn9qq3U5IJU2hbMLpLyJ+GqXJEDzXO
         0O5IdFzML8z5ST3xEApfWCV6ufmncsI09YcWRqS1BmpbU/w+P+WFEMvQ5SfeaQb0uU8T
         g1CIL4xfuZ0KdaYvwvBk3HtHEGrLkRrOXYTHQanQEMIE0RxiJsilYhKlp3RNlWR84wBU
         nIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkgxfyyynI7isiueWlzcBjvaj2ty8uVTrVmQjQhJboM=;
        b=mcoyXrSbDWPOJzuNC/eTMmwNdzbFtU+rmcJuqYikje6d/6wltwDouHnTkp0c3u7ibH
         QSzJqjIgZaUBB1gCRNUSStwQWtMcr3D3AQ11Idrg9w3HV5AK4Rs2+usGrJLyF6nSBLLs
         oytOEBne3QLX6WiCN9MxMvtkvWlPObDg+sZp6CsSj7fLv9XCZ8eY1yE+U59SRWO+r5Nq
         9J8KfqUvJPnYsE1TjezIZgozAMZQdPRHwDxlkIgS8DEcSeFoMeMob77fMfW9cu5KtbWm
         z116Fcw2euqYahAv2ejDVLFAp5jxEZt0RQAMQK4o9sZNLdlkf7oy2kh/b27WtPQJkkpQ
         M/6w==
X-Gm-Message-State: APjAAAXM4030o0IGqt/FiK7OrXbp7EYPyK2cVYNemRMLmCGfAPT0xrqj
        R0bUAejhormCqrKAet5RGizWoqdGBvw=
X-Google-Smtp-Source: APXvYqyv7Q8AbgbN732fMmWQJKwZBg3kWDKD62OgiYUFSzKN/ulKIEF0BavL/fEXOgGiW44l1hBEmA==
X-Received: by 2002:a17:90a:f993:: with SMTP id cq19mr24573494pjb.51.1568020178081;
        Mon, 09 Sep 2019 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id s18sm19122962pfh.0.2019.09.09.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 02:09:37 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH v2 0/2] Enhance support for the AMD's fTPM
Date:   Mon,  9 Sep 2019 18:09:04 +0900
Message-Id: <20190909090906.28700-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch series enhances the support for the AMD's fTPM. 
The AMD system assigned a command buffer and response buffer 
independently in ACPI NVS region. ACPI NVS region allowed nothing to 
assign a resource in it. 

For supporting AMD's fTPM, I made a patch to enhance the code of command 
and response buffer size calculation. I also made a patch to detect TPM 
regions in ACPI NVS and work around it. 

Changes in v2:
 - fix a warning of kbuild test robot. The link is below. 
   https://lkml.org/lkml/2019/8/31/217

Seunghun Han (2):
  tpm: tpm_crb: enhance command and response buffer size calculation
    code
  tpm: tpm_crb: enhance resource mapping mechanism for supporting AMD's
    fTPM

 drivers/char/tpm/tpm_crb.c | 69 ++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

-- 
2.21.0

