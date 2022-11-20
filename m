Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69E631458
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKTNcu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKTNci (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6017CE33;
        Sun, 20 Nov 2022 05:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951128; bh=Fh91Z/S6CdFbZcIlWAtBWi5M+Ufp4fdLO7yRx0mA5co=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eBvdx59MiCt7nWfZqJpVdNH00Q+524VzOGZt5Iwpnu/O8aACnEjsN/r3KWjXnHVS9
         jqWWkUkabri9ZL7nf2K3/6dL9En7XegauqEXx1eJE8QqkaH0mFpmQOlWFuAbAcv0nZ
         uH9HAIEFPnK6o2zJLDwjpA3hx3ij9oQypKWNeP62VF/fj4fZs6ppnF9gH0IoKqIUXA
         hI4cSQE/AYxJWSpp7x5WKfkIbslPt3j719PrqnC8e24t/+iRe5T+FiY6jxFHBWOqet
         7fe5tqFo7Vzdvq+2hucM5+DHqxvBrIMlyGT+SUv2+TNTTUY0mBCwkO2W7M0pbpM4BX
         D7V76EGkHapCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1omFmQ0MFq-00CkYD; Sun, 20
 Nov 2022 14:32:08 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 10/14] tpm, tpm_tis: Request threaded interrupt handler
Date:   Sun, 20 Nov 2022 14:31:30 +0100
Message-Id: <20221120133134.28926-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:eOWaNTW8FLNMvyPKVdWuy8VMWOkkayU+lKPsQWbeIJ+zIUri7QD
 fQHMBToTd6EmbYjH4xD/EZ/89RUU5GzupzCyP2hk+prD23Vis0/SDMyGp8HW7OfbZZ1jkbh
 YptTTe415Q7YxRuudPV812H5jqrp66HE1/LScLLxHyTQ1p+qulo4lOVRGryMpLgYXaSfGFG
 nZonkZ+NtssoyLQG6HluQ==
UI-OutboundReport: notjunk:1;M01:P0:9dwm6XbUp9Q=;gqt37mfZgKTSzuXO8S2lBU6hWrU
 vShXolsRIQR9cMOgiNNPT4yanYtb2Z5NSk7c8h0nN0noCaTKEfb/to5TYXQEo7LK8/pn/mCKI
 VtzI5aNV/8oUaFNuvl7QSl51J3mQiIREjsckpk4Nl848cPUNbDwQuq0wu0auB4gfJv2lz5IKN
 aMQCI2QU4WvzeyU8YdbuqT7Q9FwrFYSVt+rm4QYcnC6KtedYChlFueIBdlzKpziN9Ww74wVry
 flOj+SmzZTx4drXWcNHVOATQTrxT2HRK5ke6qjukVjKd//f4PI1d18lk37um+nGkyRUkR4Q7X
 MuFQIazC45gURjhCUvJNvBmxMG9xUKSawMqYUEkRt464Jx3h3KhkDu/4dzMdhoIL5R/QjDaiT
 woNJPcP8o026UGBqFnjsYHDk8k4Gjz/fYE6JrS7/khnzkOzehR1mdlAdO4cAYOEQXQD+86KRP
 YlS9VHGZatcyvfTblqiYS1HXvfa28Zdkby6d813twthsjZ5AYB5/qclVejR1rrLAyZCMtcbZF
 8hwSG/UEgpG9tcquw0L7GZpcVhnT/WtAQnKHHHS9bX5UGAbxYwVX9tXWnpbdGpPRiEOIaU9li
 k8RY1ur4PS5cdl0sLxp1uiy7N3YvcPzePErgP9VgDvxeM7rTfGktDd/Q/I9/VsJRQbs6qy9zV
 vFlcBMRiWGfD1jZQrcwpAu1mf0EE/puQh65sZKWC4Gw4I4W+WKnGR9zyqi4vHiEWAj2Yf6wMr
 TYuqHAAKNUvGVtfuAkCgeAn3qb1U3SifUaJS/+0zYF9mDu0cLHjaD9qGGEqe1U99Bsx1W2Cpt
 dlcCiIREY5GQz1BmLamTaM/tKdfVTxDMfiRspFXTaK9LpliJVLlPX1XMK9mWSGOCK7otUPZX8
 qarwIJelf4Pr8T/370LivR+WPiZ081l5cVZ0DzMTDw+wjEqhJ8KvOr6bXkBO5pna7JxOJuvHE
 43JglQ==
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
YXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDlhZWQ5YzI2ZDJkNS4uNmM3NjVhNDQwNmJjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTgwNCw4ICs4MDQsMTEgQEAgc3RhdGljIGludCB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFz
aywKIAlpbnQgcmM7CiAJdTMyIGludF9zdGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShj
aGlwLT5kZXYucGFyZW50LCBpcnEsIHRpc19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRl
dl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CisKKwlyYyA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCBOVUxMLAorCQkJCSAgICAgICB0aXNf
aW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAgICAgICBkZXZfbmFtZSgm
Y2hpcC0+ZGV2KSwgY2hpcCk7CisJaWYgKHJjKSB7CiAJCWRldl9pbmZvKCZjaGlwLT5kZXYsICJV
bmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBpcnEpOwogCQlyZXR1
cm4gLTE7Ci0tIAoyLjM2LjEKCg==
