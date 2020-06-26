Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5298E20BCD0
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFZWkK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:40:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37888 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgFZWjj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:39 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7AC5520B4904;
        Fri, 26 Jun 2020 15:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AC5520B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211179;
        bh=Wp7vF9KAeROGzIEtToLc6tm4PKDm4WsK82PPSN81ys4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsImo1ZEQWJt4PwXGw15yqesVY/C1JgDZ/bAk1AjD0ZO3JMKWVYAFQKfKx5ouM/wu
         wfLGcadifHWBEGDQnIuEKFnN1fhKVmA7amKhLvxBYSoiEOeAzUUPP56ZU/0+3f281f
         HzbNwRQJbjbKlwX9oDkufoOAFqWDcnFHcqFqklzA=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 06/11] ima: Fail rule parsing when the KEY_CHECK hook is combined with an invalid cond
Date:   Fri, 26 Jun 2020 17:38:55 -0500
Message-Id: <20200626223900.253615-7-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The KEY_CHECK function only supports the uid, pcr, and keyrings
conditionals. Make this clear at policy load so that IMA policy authors
don't assume that other conditionals are supported.

Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - No change

 security/integrity/ima/ima_policy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 676d5557af1a..f9b1bdb897da 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1018,6 +1018,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
 				return false;
 
+			if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+					     IMA_KEYRINGS))
+				return false;
+
+			if (ima_rule_contains_lsm_cond(entry))
+				return false;
+
 			break;
 		default:
 			return false;
-- 
2.25.1

