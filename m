Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B46245B4
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKJP0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiKJP01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FF3FBAD;
        Thu, 10 Nov 2022 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093945; bh=nqgwkXJ1VF0LrftbG+WhB8X63vmoXLOswuQ4uFOGVgY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Du/fYTIY8QM5kUQOMWwW+yoe74wBiBLkcObzmHernPtNUBh/Hr8ek8qepXmhgJRrj
         /Mhd5eRqpUQfDPfujoikMy4kC74QMGa8NxV7ySqkf/BvB+LfGNBvkivrNagguyk9MC
         hZle4bxtYUF/umCDkWadvbbvS85NCB37OhHifA214OTBefCHstwKKOtJnqUuY9MRFU
         N5WBBG3G4XHhlsEsq5Y7tBW1L25IrGOCW2jZ7alHplvfQFYWpwCrGZ0p7WZCdwB6Rv
         3EoE8Bj7+L69ohfqPfAUCcxHj3dIJE7++U2kYU+DlpopQzEINnc6cVgfetwbhCFfQl
         VzIy9IZS8P9VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1pW2Hu2wmV-00fmFO; Thu, 10
 Nov 2022 16:25:45 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 09/12] tpm, tpm_tis: Request threaded interrupt handler
Date:   Thu, 10 Nov 2022 16:25:30 +0100
Message-Id: <20221110152533.24243-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:u4QcJuVH+P/3GCogrdX2jH//mNIoFzb3BBPVjX1/s/IgGyxxBXx
 N7KA1zeCXDJWHrlxcIC0NrbuLqo8bfMEjpuJVHsWXE3legHWnGrjrlljr+xsJ0+PWA3BPgk
 1GgQUu9ZrHiX5g2GjnPVHTbJOqFpQXJUDQc1uIYtqmTLRZlJ63GpjRMtbU9phXsmBmeyyIb
 d5zrFyQccRiRaXAuoVMvA==
UI-OutboundReport: notjunk:1;M01:P0:tlE5Q4GK4Ns=;RC6GCSG6I+BsDu/lmy398p1YnRy
 2pinMMplLLNIGpfkKrAKVRZuCIwUCGVmYl9niSIewPYvGewCphyC2pH24TjYxyU41cNXEk3g7
 brq0jvjxWK4MBLMWouJQvDOnIJzdyp13zeKfHBeebwUF+N2bdbmH0mCt7VhxNbIExiKgdqL6t
 20ftIQKuHkqSG44aoaTi/JN5Zc4JtaBoIusle78Fs5U8HEj9+Cm86SV0z4fnXyBHbSKx+BGBM
 yBOT3tkvs+XL7NJ7HZIiv+fKB3fszQYkL/La7LGiSgXmhsnhSixvrV+LrCGEIlui9i5plHaxk
 T2bXBxQzKMASMZJYUCn4EwEmKFDkzIDsRnwuU9K1PMuKbn/x63ZnJ0kiS2MQwHVLUfPEyTX8S
 3aYrp0h/jK5j4wbzsRdQhA+20BNgm3PWojHpGljV6PIs+/IJmyE0OseQnJq0/3VIzulu21z10
 DSkJiQudVwvB1p0Rz54HtG9qaOIIKBv66uFUnNxR+s7BvDeEWxm6nPWlRQYH+8zy3/kjz8w5z
 CQ9nbqfxJqwG7nY4NnPtRhsTBhhTDOcxZV8UMaJZhgV2XQzTA4eU7eiAGmEmRbsBTEHbXKXJ7
 KYNO1NLrnffD+UsoDccaOSXsVqkd8aZ9oTI9gKuVDAVjl5oUJgMsWUSBJjpqKBGPqz4Npf8yq
 w7vc/M+kJ8/HzBU9SSchxilyekR434GVoDAW9EUZJvBFY7SWLgqeyLWaNS9f8hr5GhWEEZM/U
 nmvak3g+HRWMvRlNx8sx1FDRmmKBEHQvyka3Si+iDLXn4ddN2PKDEWxVJ1n/Iv/Gis/SMxvxb
 +60Q5F7/PR9oX4pzQvVOwTQ1c7SUUlkmFmsHz72i552ozpPmn0/3mTUi4n3bKlQ33bCoZ/K+Y
 DHDnEbwNXRfCJzY1ofY6xh5sVoFNDxurfNrE1zK4k40frAwwPnmyejd7DRFbrnpdF/Uawnpyz
 isIqlCsN8vLOO9wUq18tcJNa794=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBUSVMg
aW50ZXJydXB0IGhhbmRsZXIgYXQgbGVhc3QgaGFzIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBpbnRl
cnJ1cHQKc3RhdHVzIHJlZ2lzdGVyLiBJbiBjYXNlIG9mIFNQSSBib3RoIG9wZXJhdGlvbnMgcmVz
dWx0IGluIGEgY2FsbCB0bwp0cG1fdGlzX3NwaV90cmFuc2ZlcigpIHdoaWNoIHVzZXMgdGhlIGJ1
c19sb2NrX211dGV4IG9mIHRoZSBzcGkgZGV2aWNlCmFuZCB0aHVzIG11c3Qgb25seSBiZSBjYWxs
ZWQgZnJvbSBhIHNsZWVwYWJsZSBjb250ZXh0LgoKVG8gZW5zdXJlIHRoaXMgcmVxdWVzdCBhIHRo
cmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBv
IDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIg
PGxpbnV4QG1uaWV3b2VobmVyLmRlPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNyAr
KysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGVjZGU2ODRhOGY4MC4uY2VkOGVhZTNlNGQ1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTgxMyw4ICs4MTMsMTEgQEAgc3RhdGljIGludCB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFz
aywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShj
aGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRl
dl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlyYyA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCBOVUxMLAorCQkJCSAgICAgICB0aXNf
aW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAgICAgICBkZXZfbmFtZSgm
Y2hpcC0+ZGV2KSwgY2hpcCk7CisJaWYgKHJjKSB7CiAJCWRldl9pbmZvKCZjaGlwLT5kZXYsICJV
bmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBpcnEpOwogCQlyZXR1
cm4gLTE7Ci0tIAoyLjM2LjEKCg==
