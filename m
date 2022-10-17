Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0702D601DFE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJQX6W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJQX6S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D07E320;
        Mon, 17 Oct 2022 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051071;
        bh=1jiHlANZ8thD5aPn63BXGYT+VamFBFNIAjBcdG+2s2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WfOSUaFoPW6HJeqbKH+NcSgdPAX0B5ef9lmxQeZCm5eQ+sWUG/h3zZ4BlUZ0KeB3L
         kON0QSj2zBrS+jNnsuLuQTr0/3NG+Y9SSUVUyhz2PFmGzw8wORNnT+ynp+UsV9TMgx
         v2nDioMQ/Q1N8I2dE4d8JIS02DjoW/0SEI+NvxP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1pVj2245BM-00newU; Tue, 18
 Oct 2022 01:57:51 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 02/11] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Tue, 18 Oct 2022 01:57:23 +0200
Message-Id: <20221017235732.10145-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:whnPCRKszgC0VgfRk1iaMt3PYAXQaO9DbMnke0FD70ejHgdIZYz
 FW/+L6Nx4I6sLOM/msmQC4djx9ELQ+m18UrEng6kHRW7mw17Qaibyts6KutKT0BhfxYH+Uc
 L5af/A0V5731fnhpzS1NHJHtlCThZ0D6d1QcWUl/jRxL31Hms7DGOFldgxd+htzPZeTIrWM
 No9LCspdPnw2jXliLZInA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rm9hQAolfWY=:AmHIBZamZBq/hhplD7Btke
 2DoMix2mAEavR3w14Jtm9aNsIWhRJCpVK+hnveXnRd52Ixa2ZX10mv39/shArTBy9TQyJEUGz
 7/gtHpfqmTV1pe94P9k/URq2ZWf+CxX4ZAZaiSuoZAGofLIMq5m1fJOUfQwMaWPlE3DCkYToI
 FL0CQ642K9h5mkfBlmy6GdyN1HIT09FkQy7GYx7RCMiVREx7KFRS6YWotUOfSRUkHDqgUUVr9
 ZvwV5lmVZR2j2sqioiAeEoRv7y7f9p9BxjywIgWEz+itmc5Kek9QBC4fjhCzUGHxpLfnwvF0w
 AJq0TYSFpn/mewbi5M7W13RQK1UfHUQ7s3VqGqAdWOSji/I78jATelWLSHi0ajB1taW+QT5pN
 oyCSCLwL/9QMQHlxsJnJISC7208RqPqn3hBGHT5IOEPGeyi21aTaQecWfZlQDB1TmmQpPPt1j
 1XK4HP+vVW2/d6FB/yxX/dmK9u4n9YneQic5RwwQYJ7HG9GT5VfrNT2NFfO2uqxCWeii1eLRM
 aWkdw1e5s+qf6Q66ZmyyBQ9eNuob/D7P7BKbBQTT+78Hi+b9wwUJQvKCZxKELKr7uSLt9jalk
 MI4njFeWEjZPgMF4p7PCZmY+hVnYq4zUMLK0XsCq2VhOQlhoh8o0bKeUkvaLB/As9Qp00UE8/
 gR35AP+CuF3YopqVgmc1iSVb7IFQFfrJVeHfgCbUNJj/28YNsD6BZHxzuQWfsRTnnmMpe2Hwd
 wkQ4okUDfK5FCRbRj0Biq17luNv0D8UQA8OX3uhWdwzIxmKBVpl+hdSvMHQA2hYjXiAB1Yi8n
 WOhM2+eoz8VZX6wIaHQXGCYNs1sHk4FcQ9X6HvEaeSJaHQaTNjcxF8pMCWbHT20u10AmVU5LJ
 12NQLB2jk09kkrjaDyINJuQP48OPgA7Jv7NL7YMls1kdut2rg5S/jPqaTpE5yhemfJIE6V2lc
 5qKfzqBgFzvz4DxHapuEg0jIL0vGrBqqgO55LwYXo1P0bY7nWIjvxf0MLENepRDmmm3jZFPXN
 E0NqQpMyW+Va/88Esuq8ZjVG8lTkI0u84ZKZzpUagh5QbBG1bPBorO3H1071M01kBX6OUDok2
 JWgQ/B0ZXg9VjR2ocLU66+3dYQbkIaQtFroJnXsVinCmQ7r638tUA/6DUf8PcAtLN1GeXfEYx
 ps7/ro2SXh68CZhuKGE0DGpH/DcdtaePKa8nRNeehVvfX8c+bCg6o8RlDtWY7/yAMPWomdCD5
 H0DszsuFqkZrSz2SCc2KaUYPQTrkrtRz0tka6xLs3O5EhYZV40eM4ZlRLZDDG/eswGEfYyYsF
 mda2pkEOZ/biKe+aXd6mRKuYMB/CHNAXzYcK6f8A1eaR1ja6jWxu8VmYPHSRBWYZ61mG73H+S
 tFZrXPOZqN8/oHPtd0zjetF8buuUOnnsodwj9kvo5Lzl7/OQyEWqIo4skQfH1z0tNDDIt5bcj
 UAqK5lIa/lJKbkEzTzhqrVGcbx//5pLCK1DL8/ILORwOA6pny0LYtpOahjH/9QK4HWsEtc8SE
 iV29t0sjcJ0tpTnpsV55iAvdsNv/0ciNuyL3MUctNmor6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
YzAwMDhlZmI5NWRjLi5kMmM5YzlkNzY4OTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAt
MTA5OCw3ICsxMDk4LDExIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQkJZGV2X2VycigmY2hp
cC0+ZGV2LCBGV19CVUcKIAkJCQkJIlRQTSBpbnRlcnJ1cHQgbm90IHdvcmtpbmcsIHBvbGxpbmcg
aW5zdGVhZFxuIik7CiAKKwkJCQlyYyA9IHJlcXVlc3RfbG9jYWxpdHkoY2hpcCwgMCk7CisJCQkJ
aWYgKHJjIDwgMCkKKwkJCQkJZ290byBvdXRfZXJyOwogCQkJCWRpc2FibGVfaW50ZXJydXB0cyhj
aGlwKTsKKwkJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIDApOwogCQkJfQogCQl9IGVsc2Ugewog
CQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7Ci0tIAoyLjM2LjEKCg==
