Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894DD560D2F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiF2X1l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiF2X1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1A24F13;
        Wed, 29 Jun 2022 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545244;
        bh=rvhNW71j9WjbkK+WwiRm/itDduq081D1SK95P44Pd40=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DQPILKvBISTA7EHXGHDLqdtdxTZWToCf8pSAI0rmVMWdSp6lltGq+tFW6qVgSa4+s
         sQBUCsHxHc9rOEzeUhfXAJ44hYyQOEtzmkdJjzq4q9Ow+p9RnMpyIRBVgwdmnTNOqp
         gcZmAc6BQXYAkYcijNI0TDZSEzuJguhS5mfUd3dg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MirjS-1nRpxQ00pw-00eqix; Thu, 30
 Jun 2022 01:27:24 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 02/10] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Thu, 30 Jun 2022 01:26:45 +0200
Message-Id: <20220629232653.1306735-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:lCmI/VIZRRhTn9k7p1XCSCVWoC8yP5MpZUkj0y+lB/CYEgL7Uak
 cp/85+QHwaJrGXOBeahieR2MwW4CVQG/30f8NPUa9Yo7h1Tc3ZUoM00OnToI+fjFMdt8Tc5
 ha2CebNSuUA9eR9fK3DeZ7oS/Yz+hBKHyTPo1GI/mnuGJVuGM8JDEGEBAF+W9kd9MGJqdqg
 zWMa1rcZQI/JKnhTsrYGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:neVAYdnlpbM=:Snqgt/Ij9MzApfs3mv9PMG
 xv2KXxQpJttBxqfVw5tHnrtpfh8FWfmyI8bRTZf6HFzmrTSB7NqEg6mdhVzQdK8cHOXWSY1xV
 R/ttwXmV1z2zIyn9QGycoHjvJECL8+68s3N6o+1B+PU3z8sC+lYKILZrTaUcA0h24oO3PvitQ
 qIu5x9MxbNVfrynU6VsuuOZcSa/k+g06DyC9ML9aW5SQ5UXvIx5bEvwqg5JV8CQKQA0XIh5QG
 G59Yqy+qAa9cRmwXfmjA35oyPT/GLecagdKpECkKisqAi8+rQ6zce8/lQfKJF2FhY3a0SYGPB
 gWSYAHCyFzXqaffcj8rVkuH3sYl44vBayXmdlhW7lDKL/KR2q4RoMC7Y56ql/Ba9U6KBAFy6z
 5xSy8/FjIRTwhKz3bgRS9UKwPGT/08JQKntq+bv353xbmZHrUJmsU6I8SisqnQcx/eldenxiQ
 CkVJCgSjDZ+HP5eDbf2qqGgf8Dj1vpoL6Dxj3K70U8+b3sSifAXWpAFu+6UZxjWsIOMvroF1t
 YFBhD19opUrnf0aC+QN2WHwZwq905VNUbUlJFCCSy+3Vtrd9Sb4uOTE8gLx3E4cp5YGBadFHa
 0edkTMOTLTDRkeRKxuEWLgg4fUkSMM6R3cQN2I0BN6D7xYl1XFuEBLpeomY4psl6KsR8PNmvi
 trVwllMcBH3YgUXpEcK2Y6UXhleAvi0/vqaLn1t1G3gNDZxaS463uVLzbjGAJJlFHdrZ8yTVH
 kZ02Si71Wa2r9EThy/UBfPIsMq179RYLwUisLuTN6tCxTuu3uIos/vVwcGfO8yElFz94lJmzR
 bUUGV8tvnLFV4Fq76WGTYPaPl0UGwRnzFKrN50oYCDS6Iap5bwBTUBRFCpZph9bCQ+Lt3b6qS
 CptdMjqjsbu1OwAPZ21SX8hZP0Y6ouxK/wXpuQERvlx6sieuzg7XxslwB1uD0fyxaDidDZdiN
 MRj7VcPO/Qku3zeLZX0rSqln/DmaSLTPhnsfD9ejn9g/eSOLP6Mq9zMN3hNxytdDfKW+3r2NZ
 toYANi4j0L5iRxRkFdkRZxyJtZNPiabjPtBkg5CA1aOIqaM2Ise/n+CqrR260a5WR70mscuLo
 F/kTbJfNcGJ43+XrQRJYv80ldZYM1ZkbZatcYiaL/MHgUESkmr9cbGoQg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIGRpc2Fi
bGVfaW50ZXJydXB0cygpIHRoZSBUUE1fR0xPQkFMX0lOVF9FTkFCTEUgYml0IGlzIHVuc2V0IGlu
IHRoZQpUUE1fSU5UX0VOQUJMRSByZWdpc3RlciB0byBzaHV0IHRoZSBpbnRlcnJ1cHRzIG9mZi4g
SG93ZXZlciBtb2RpZnlpbmcgdGhlCnJlZ2lzdGVyIGlzIG9ubHkgcG9zc2libGUgd2l0aCBhIGhl
bGQgbG9jYWxpdHkuIFNvIGNsYWltIHRoZSBsb2NhbGl0eQpiZWZvcmUgZGlzYWJsZV9pbnRlcnJ1
cHRzKCkgaXMgY2FsbGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KUmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+ClRlc3RlZC1ieTogTWljaGFlbCBOaWV3w7ZobmVyIDxsaW51eEBtbmlld29laG5l
ci5kZT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXgg
YjVmZDRmZjQ2NjY2Li4wZTY4ZTQ1MDJhNTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAt
MTA4NCw3ICsxMDg0LDExIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQkJZGV2X2VycigmY2hp
cC0+ZGV2LCBGV19CVUcKIAkJCQkJIlRQTSBpbnRlcnJ1cHQgbm90IHdvcmtpbmcsIHBvbGxpbmcg
aW5zdGVhZFxuIik7CiAKKwkJCQlyYyA9IHJlcXVlc3RfbG9jYWxpdHkoY2hpcCwgMCk7CisJCQkJ
aWYgKHJjIDwgMCkKKwkJCQkJZ290byBvdXRfZXJyOwogCQkJCWRpc2FibGVfaW50ZXJydXB0cyhj
aGlwKTsKKwkJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIDApOwogCQkJfQogCQl9IGVsc2Ugewog
CQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7Ci0tIAoyLjI1LjEKCg==
