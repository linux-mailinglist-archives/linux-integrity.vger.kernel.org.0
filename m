Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33AE637A98
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiKXN4h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKXN4c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E270CFFA83;
        Thu, 24 Nov 2022 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298174; bh=ZQrQ2undxx4v+6nZgOuKeQ4fsU8UgfXoZI9MOOth8tE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ddo6u5hs4cj434HcTpvwD7vW5+PiLY02huNtyJ4ohWXaqqaSRC8kFnEX1Oj1/186W
         f5JQW+ArJNDd88wHAGIFB2/Ewor1o5IZfXdV2Z0j8BuswykfniZffgtTnV8/ObB118
         wSquDx1nblWyPykGdYHSUCxaDbA3ILAfhhHyRoHqnlI3D/Yi8mph6U/QXLBLH6wPE7
         LQPlao0reGbUfmLBZZuMBYXJp+ZPnO8MytdAyXZOiTFvNjA5pxttEx7N9UwwvV1Kno
         Gc+YCMSIrZyYcP6CuhEegwtY05QLm88r0wfeGr/D1OQPcxkV1dLWDvCj0Cd4t+6+GH
         WcpSx9yqGegkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1p3SuR0Ny9-013PDZ; Thu, 24
 Nov 2022 14:56:14 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 12/14] tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
Date:   Thu, 24 Nov 2022 14:55:36 +0100
Message-Id: <20221124135538.31020-13-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:yRmIK1f7+KxuNnECWFfKad/tTssuC85ALDbC/SoyTS81qtmvqpc
 AwTK5Hk2uvTdkpPGPYrmxnkYAyuykDIPFH1hQ8ViCKeKAg7N0jx9eMxVXT+BHCbIQfwq1fm
 ++obvjcECsK1RpCjoFxvWhSV3yVS3dMTB6GuYJlWd27RYjG5hP4SlLg60HP7rwVWtJUhxjs
 PtxAMW45nsfvyImDBW3gg==
UI-OutboundReport: notjunk:1;M01:P0:Z2d0MsdV5WE=;XM9FBqeSHw8Rx9MapvOY3cFSXaZ
 TC5cmrDnDLdiVszxx1katTwJrXLSo3xzmP6t7u08luQvC/KkeXD0ldetn3rkG1HPwy9iWqwGq
 HTEjSyYryS4qLssywWSmBK/MFilZoDrJXB8wrmNlaIrQ2YMzmfioHf9cisgqeSJ8cTbvTQe7T
 OqKjs88MgELFapfpNiIdFG2ECoa1XRc8Ljf7Dy9bLdqTXBk/L9+Rx9SU+PKZQfvt73wxIEmed
 IT6+WXiK/N3U/c/dkmBmxufp8QdyNzml3LnEvt3s7sLaxRqo8vHOWbw/mPslxwduN8ZTDHbt6
 MsKUIPoK2SnJbI/Qb8Kg+aP/c/SbJusfsRlDbUuuEzLImH/eCHxI62Wvl8otGYrjMBWoKcIpe
 vrrWbx/pNkjvul8uEem7bDNd5MUhuU0PQnqRQPyKvhW141WcPrJu4+ubsvN/jfuFCfE5aSxqG
 yUufGqqCnIlCDEJgI2WaV0PV43V/AKwCJUOn2UayRRbTmbOhC/YcK6zeTt7G3oO2iaj4URrH4
 nxtNfyQQz1RCHu931HXJ3bhZUl9JmhZ0RPLtNpFwN5PY0HTQwjLgSng+UJ6PJnTJT48ElV3cs
 Qnqd/Dou35TyR0FnUz/yFPp19Wx7VyQ8NGjGuCKbL+feZiGECgKNXDbl4ONCKW+f2pE82YHfy
 TzK6AsYIx7LAYCxub+iQNn+HP2wYSG76GmQTd/a2W/67l2KmKf3h2WMf7OXt2zt+vGSXUIkBc
 O2NSzOU4YvLQlzs+Ax4Zml/Lmx5UllM7uPJpcjVkWpYO9zwtz9Ie3n3gvwEesjZhD+/ac76Mv
 q7/nKY0UHSpg5Ytl/ZRswiXHZ8zjKg6f2d/W2hfIfG2XHaRFZXOJR/uoPWdHjhpTjWlgyGy1W
 MCNjOFAwR8+vBlX789a8++OwFeg+s8yAlF/1NagbadH7I60qS43p9pKBJrcmhgp6KrqzgNcTp
 HunYdQ==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcmVzdW1lKCkgbWFrZSBzdXJlIHRoYXQgdGhlIGxvY2FsaXR5IGhhcyBiZWVuIGNsYWltZWQg
d2hlbgp0cG1fdGlzX3JlZW5hYmxlX2ludGVycnVwdHMoKSBpcyBjYWxsZWQuIE90aGVyd2lzZSB0
aGUgd3JpdGluZ3MgdG8gdGhlCnJlZ2lzdGVyIG1pZ2h0IG5vdCBoYXZlIGFueSBlZmZlY3QuCgpG
aXhlczogNDViYWExZDFmYTM5ICgidHBtX3RpczogUmUtZW5hYmxlIGludGVycnVwdHMgdXBvbiAo
UzMpIHJlc3VtZSIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwu
b3JnPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAxOSArKysrKysrKyst
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBlZGEzYjEyMmU1NDAuLmRkYWYzNjJlNjJj
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2
ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0xMjIxLDI4ICsxMjIxLDI3IEBAIGludCB0
cG1fdGlzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IHRwbV9jaGlwICpjaGlw
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CiAJaW50IHJldDsKIAorCXJldCA9IHRwbV90aXNfcmVx
dWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwog
CWlmIChjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKQogCQl0cG1fdGlzX3JlZW5hYmxl
X2ludGVycnVwdHMoY2hpcCk7CiAKIAlyZXQgPSB0cG1fcG1fcmVzdW1lKGRldik7CiAJaWYgKHJl
dCkKLQkJcmV0dXJuIHJldDsKKwkJZ290byBvdXQ7CiAKIAkvKgogCSAqIFRQTSAxLjIgcmVxdWly
ZXMgc2VsZi10ZXN0IG9uIHJlc3VtZS4gVGhpcyBmdW5jdGlvbiBhY3R1YWxseSByZXR1cm5zCiAJ
ICogYW4gZXJyb3IgY29kZSBidXQgZm9yIHVua25vd24gcmVhc29uIGl0IGlzbid0IGhhbmRsZWQu
CiAJICovCi0JaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpKSB7Ci0JCXJl
dCA9IHRwbV90aXNfcmVxdWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKLQkJaWYgKHJldCA8IDApCi0J
CQlyZXR1cm4gcmV0OwotCisJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIp
KQogCQl0cG0xX2RvX3NlbGZ0ZXN0KGNoaXApOworb3V0OgorCXRwbV90aXNfcmVsaW5xdWlzaF9s
b2NhbGl0eShjaGlwLCAwKTsKIAotCQl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxpdHkoY2hpcCwg
MCk7Ci0JfQotCi0JcmV0dXJuIDA7CisJcmV0dXJuIHJldDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BM
KHRwbV90aXNfcmVzdW1lKTsKICNlbmRpZgotLSAKMi4zNi4xCgo=
