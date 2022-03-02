Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F194CA10D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 10:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiCBJpq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 04:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiCBJpl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 04:45:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A63E0DB;
        Wed,  2 Mar 2022 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646214280;
        bh=u9LSPz59K1AzPPN6pInj51OX5iy0BC9R1p2p2gRRKlw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RgiNI2s9vyP54Ko9/bcmrrJQiUWzk9+jfb9hYoQFLW4NukPqoz/JnX8ryxn6dyRsA
         cAFmyCUfn/952XqDYp7oowb6tS7b5YXWFwM5H9IW85DgUnnzD0ZkOA3HEGIW3CDTf0
         J1dIqkBqnS/X2S1BJpShANLGb0C4ooEanfUyRyX0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1nZqD41NCU-00Oo4K; Wed, 02
 Mar 2022 10:44:40 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.rosenberger@kunbus.com,
        LinoSanfilippo@gmx.de
Subject: [PATCH v9 0/1] This patch fixes a reference count issue in the TPM core code
Date:   Wed,  2 Mar 2022 10:43:52 +0100
Message-Id: <20220302094353.3465-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XbTfDc6oHSCC25zdRUunVw99wBhP91zXTkKy535tLuopP8UW2zH
 UcwxtuHNs9MHp6wXsanhY3J6y2Qi4FwhC2vMWIWlDLUGuLC2a8OAPnGkrs/66MAMVac5Oyf
 14CIbMrQ3eJI4V+k3z05oP1KT+aX9/BiL9g/rogezOCbEXL2LcrdUQIruMBxoHkFnlB7XWr
 SCm5lfZtS9mnNVr9v1lIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KwwNtkS5whI=:tA2uaPOWm7pkCpadfCQx8o
 2R+zz7vHdl7YyLLJ6Kju4vO5MVpY0RdLf8s/eTo1Yl17dbgxLe+B4AxatJzMx4meEMBdM0+9x
 /Pw+dKYMqIoc827ykUUfS3V3ixd4+rNr7AW+8K/DoXq7W8wykCYe2tHvCm5nqHDUN5ICRAtWj
 8hO7a/SALSJjaJzivSFCi/h99lHIRkNZJGEYGqmksfR9uF2OqiXf52fLQyKk2S/jByXRSZQKl
 iXwg9fxuNN9MT+KkmumrS4x7VOzH7y3awgedFf0RTOj+0zUuDyG52Xh+YhGeOdF/7TEE/KXbm
 mEd6bZ3i2/saERfK/DVpQR73Q9vVXzTscCyWo+YSToJ+Qdx8nRTYrPMrKKJ1r/K6rWT/H3jx4
 t7iaxU1fAy+MYdqMhhlAQcmc2roJ/5FYicwNLVg4uO6s8tnpyk0abMxsfsXHixP1lZWhSKLPh
 lpETKQxF2eJGc9dHGC1sqbhmOxsJDvk32feyLmd3gnho4Fu5sD/KEFzCGQM642oHHiTZU93lh
 K+rxX9QTbSRuVOsvCe9s8/LsT5crF/hf4xA+8w318xUBdc9JkujzbMvC7QfTGu61y0Zq7JCq1
 fKWVvqRxpnhURmqjYNuTzOIKM/7abO027/9jfCGsmjVI6Y0NEVmRhBnn9mwWEjIDW3NU2jS7W
 eJQnEpL2Sgtl1ZVxijBdZYN5GeJUJqmIrXuz/BIeTQ6aNxa0uLRUbcFu9qMVqKkNKgLCaNdGg
 Svl8SvgPkmBJp0XBCEaCqvZP5J+wSq6xx9DiIRddJWlQX7mF+cIwOQMOYpQrs682pAl4WRJwd
 0ogTZoJ1oOEIJ6ogYbw6ySsUIgLAgzr8MVry6sfvHlcVPhZ1AJ6zMa+nmrFS2xqST5KlmZrRX
 S6HiJz288+wVoQeztMh47pLBHsqTBwbDSkd3RIbypxKb+3ZzG6WBuXPCCDyhpA1rktRMqE3Sp
 3sJgSa06vUdPsv5wSlADotR5jjHECsxK5bqgpTSakDnMjpkDs2y+FCl/TSMzutbLr1LXzdmhh
 8eXKuvhW6MjvbXKTmTWwbMUNerawRm7YN1H88QZxhxzB94NOsSBTsDYbrFncjYLd8jkqKu7Ao
 xToYPo0BPXVs+M=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Q2hhbmdlcyBpbiB2OToKLSBhZGQgYSBmdW5jdGlvbiB0cG1fZGV2c19yZW1vdmUoKSBhcyBjb3Vu
dGVycGFydCB0byB0cG1fZGV2c19hZGQoKQogIGFzIHN1Z2dlc3RlZCBieSBKYXNvbgoKQ2hhbmdl
cyBpbiB2ODoKLSBhZGp1c3QgbmFtZXMgb2YganVtcCBsYWJlbHMgZm9yIAogIGFzIHJlcXVlc3Rl
ZCBieSBKYXJra28KCkNoYW5nZXMgaW4gdjc6Ci0gYWRqdXN0IG5hbWluZyBvZiBqdW1wIGxhYmVs
cyB0byBmaXQgYmV0dGVyIHRoZSB1c2VkIGxhYmVsIG5hbWluZyBzY2hlbWUKCkNoYW5nZXMgaW4g
djY6Ci0gcmVuYW1lIGZ1bmN0aW9uIHRwbTJfYWRkX2RldmljZSgpIHRvIHRwbV9kZXZzX2FkZCgp
IGFzIHJlcXVlc3RlZCBieSBKYXJrbwotIGFkZCBmdW5jdGlvbiBkZXNjcmlwdGlvbnMKLSBmaXgg
c291cmNlIGNvZGUgZm9ybWF0dGluZwoKQ2hhbmdlcyBpbiB2NToKLSBtb3ZlIGZ1bmN0aW9uIHRw
bV9hZGRfdHBtMl9jaGFyX2RldmljZSgpIHRvIHRwbTItc3BhY2UuYyBhbmQgcmVuYW1lCml0IHRv
IHRwbTJfYWRkX2RldmljZSgpIGFzIHJlcXVlc3RlZCBieSBKYXJrbwotIHB1dCAiY2MiIHRhZyBi
ZWZvcmUgYWxsIG90aGVyIHRhZ3MgCi0gZW5zdXJlIHRoYXQgdGhlIGVycm9yIHBhdGggaW4gdHBt
Ml9hZGRfZGV2aWNlKCkgYWx3YXlzIGNhbGxzIAp0aGUgcmVsZWFzZSgpIGZ1bmN0aW9uIG9mIGNo
aXAtPmRldnMgYXMgcmVxdWVzdGVkIGJ5IEphc29uCi0gcmVmb3JtYXQgYSBjb2RlIGxpbmUgYXMg
c3VnZ2VzdGVkIGJ5IERhdmlkIExhaWdodAoKQ2hhbmdlcyBpbiB2NDoKLSBkcm9wIHBhdGNoIDIg
KHRwbTogaW4gdHBtMl9kZWxfc3BhY2UgY2hlY2sgaWYgb3BzIHBvaW50ZXIgaXMgc3RpbGwKdmFs
aWQpIHNpbmNlIEphbWVzIEJvdHRvbWxleSBvZmZlcmVkIGEgY2xlYW5lciBzb2x1dGlvbiBmb3Ig
dGhpcwotIHJlaW1wbGVtZW50IHBhdGNoIDEgdG8gc2V0dXAgdGhlIC9kZXYvdHBtcm0gZGV2aWNl
IG9ubHkgaW4gY2FzZSBvZiBUUE0yCmFuZCBhdm9pZCB0aGUgaW5zdGFsbGF0aW9uIG9mIGFub3Ro
ZXIgYWN0aW9uIGhhbmRsZXIuIFRoaXMgaXMgYmFzZWQgb24gYQpzdWdnZXN0aW9uIGFuZCBiYXNp
YyBpbXBsZW1lbnRhdGlvbiBkb25lIGJ5IEphc29uIEd1bnRob3JwZS4KLSBhZGRlZCB0YWcgdG8g
Q0Mgc3RhYmxlCgpDaGFuZ2VzIGluIHYzOgotIGRyb3AgdGhlIHBhdGNoIHRoYXQgaW50cm9kdWNl
cyB0aGUgbmV3IGZ1bmN0aW9uIHRwbV9jaGlwX2ZyZWUoKQotIHJld29yayB0aGUgY29tbWl0IG1l
c3NhZ2VzIGZvciB0aGUgcGF0Y2hlcyAoc3R5bGUsIHR5cG9zLCBldGMuKQotIGFkZCBmaXhlcyB0
YWcgdG8gcGF0Y2ggMgotIGFkZCBKYW1lcyBCb3R0b21sZXkgdG8gY2MgbGlzdAotIGFkZCBzdGFi
bGUgbWFpbGluZyBsaXN0IHRvIGNjIGxpc3QKCkNoYW5nZXMgaW4gdjI6Ci0gZHJvcCB0aGUgcGF0
Y2ggdGhhdCBlcnJvbmVvdXNseSBjbGVhbmVkIHVwIGFmdGVyIGZhaWxlZCBpbnN0YWxsYXRpb24g
b2YKICBhbiBhY3Rpb24gaGFuZGxlciBpbiB0cG1tX2NoaXBfYWxsb2MoKSAocG9pbnRlZCBvdXQg
YnkgSmFya2tvIFNha2tpbmVuKQotIG1ha2UgdGhlIGNvbW1pdCBtZXNzYWdlIGZvciBwYXRjaCAx
IG1vcmUgZGV0YWlsZWQKLSBhZGQgZml4ZXMgdGFncyBhbmQga2VybmVsIGxvZ3MKCgpMaW5vIFNh
bmZpbGlwcG8gKDEpOgogIHRwbTogZml4IHJlZmVyZW5jZSBjb3VudGluZyBmb3Igc3RydWN0IHRw
bV9jaGlwCgogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jICAgfCA0NiArKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oICAgICAgICB8ICAyICsrCiBkcml2
ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9u
cygtKQoKCmJhc2UtY29tbWl0OiBjOGRiOTBkM2U3MjMwODZhNTRiZTgzZTBhMmIxMDgxNDZjNTdl
MGRlCi0tIAoyLjM1LjEKCg==
