Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E97601DF5
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQX6N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJQX6M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F87E320;
        Mon, 17 Oct 2022 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051071;
        bh=vmr8i0HILdqGMwVhgOxfm//3j+C4M5iWtBnT+hrsrRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UGR6R5tth0NiE2sA+sAhH8DeYrTP+DQD34wTB2Wlw0RCmkXhFI6No+HlWROdxyAeP
         PEYttZNttt5RXA/1U8R/o99TEuYgGKoDjji0pZT2CdQDzKFTu/VR+0BksmmQtzCKOl
         ijJVnIpnkVNup3ylMPgX4aapOK4wrjV1iZ9YyZcQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1p4jAL1OIc-00yD3U; Tue, 18
 Oct 2022 01:57:51 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 03/11] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Tue, 18 Oct 2022 01:57:24 +0200
Message-Id: <20221017235732.10145-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:hwsqVwRGmzxbKnmZok/36mfl4BodcJBOVORnYPI4rKLdbIMNacV
 c0iREGdvWzG7xr0Rs07Wt5kCpgSm1hz0agH5T5HR2glpgCNTu5qJGmIalB2EJuBwb665zx9
 GdENV1JJqCu8AVSKSz80BvpQCkp5ghJPfHvI9yQSXQSAXlVowtXoAeviPKPWLkY4xWrBS9e
 W7pcPzws0Tr4/6laWoAsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9A3C9J8xsi0=:xhEDeVdqtWK8nVvwgkjcyb
 kVMgGVABNovTfkpUcW04gaoZ0euRCyHixetKp83nqUYtpQWULBsPIdyvgBDsi0rNp3tdxigPf
 muYfytgqFZWLRAExG6NO2TIRJ6lSYUBquNRIfoX1J9A0Vbv6iDNkNXWXg/TKWRK7eLkMtYqSi
 TVi4QfHGSXd/PP3Rued4iw6i73iSxjRKMUT5ubtvnuY1fvRJjL+WNfSt0Tv6kIdOCndK9B30i
 Ne+P7k4PD7id7VSW4AS81MqOQxgRw96LiQY7xcGmNtcLvLAIt1TVQ4jgHRPhm/Ror3fNNTa2P
 yuXsf+M0PfVivN6jkzohLsKEzAH84KqZjJkczHcQbkkBfwnbfVjkRHLB/eSckzzuuuiIQtxT+
 cscYqmtS9s7PpfjA8/7tGstHf2c+V/022h04oerkZ/EUQ0fWUbSjcHYPUcDHyDyhHO2PGscuQ
 SxDB7sei+bd54L//LXnmAV6zTnuSsITIDMoc38VAq5mH1XpEzcUTHdZgJQVE4y+ruGLbC3wo7
 TUfDgot0I+0Bf+kp4TZgqRZgAjEGRbVrogeyc+9JNJrtpI0NYY7YiGEcvtxyPqrbV76VgU/JM
 z8v1OHqIatILgR4+qvrvmH2mAjLxvgIcavvGW5nyD/X1m7wyK0jFE/2Ob4Tbd7Or4yK/+FDlF
 fwFhXM1d64vKxPDlGJybSqYsR4AomLf/LUF1o1VzRn/YjIgk4mCB3HfBrabCa+6Oc1O0dKAl8
 +nY0NheI8O8AwNW/IIfX1RxJTmAxC5l37NEgi5f57xF8fAXZunim5iujrfX8vyIENu/2v12UH
 qfytwMK7gu2BqJoUGYSMxAOTwd1lEd/niN+TQ+JiIRSrd2/iaw13NGINwPVEG1VJyNXtkzt72
 vzR9EC/kYYRrFzirzLLqDzFz8C8wd1TaFMk/nWwe8AMZ76Xfl+g8OXeRcm8owVHoiWFuaXbTF
 oK424Mo21Z1Bj6vLUD2IP+rRZf7CtpWUM7HInGsXv9wlB2v14QJifKNPWbeBa+LOratVtBQBE
 /44+wpUGmGnqF1ryjNWKKa6Mzf9sYVrNA08uckZO7Bk6PcHIX4UgOarWUsQ0HIINgqoLUMSYD
 znNxcTzI6ma5S51w5TJNQCOlU/SPkdn/2r4fJuqWukdOv77gRPWNA14qjm6bvao0bNCq2Lbso
 1mw38xRtG6puqwTzmI+LseVvPlw0hSdrx6NKN+cYWgBQv0FHPQfimUDL/sNLJaWNH1HSkNEoq
 it3YMPXgXKnetGD4DQEuYeX9Ndhepk6ssBIQSkIjoysdAYXavcJdPxFGIxKftwW5qG+gxWWXY
 1Y2+RHUAd9VgSZNLploXaWMYPWrbaEASLU1UnT147svmsirifjx0TxiouQuqskzROt+r4hJjh
 +aIR0xtkhmhjlVYfCAv60IkDYHYOyt9H3zmMAc4RNsqamNeXVyxJgS22cFqlHzBp5/bbKlKBw
 maOiSmc5D+TQit/tBaPkjj5r8TH+OgbTLrTMW1N6fAq2Alt6jyfEhq3HBliJHChs9lcwYWu4M
 ntXcDj552AgAwEiWwgLE88aUeTllycuX5qlAYqk1UBL4t
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkJvdGggZnVu
Y3Rpb25zIHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZSgpIGFuZCB0cG1fdGlzX3Byb2JlX2lycSgp
IG1heSBzZXR1cAp0aGUgaW50ZXJydXB0cyBhbmQgdGhlbiByZXR1cm4gd2l0aCBhbiBlcnJvci4g
VGhpcyBjYXNlIGlzIGluZGljYXRlZCBieSBhCm1pc3NpbmcgVFBNX0NISVBfRkxBR19JUlEgZmxh
ZyBpbiBjaGlwLT5mbGFncy4KQ3VycmVudGx5IHRoZSBpbnRlcnJ1cHQgc2V0dXAgaXMgb25seSB1
bmRvbmUgaWYgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKCkKZmFpbHMuIFVuZG8gdGhlIHNldHVw
IGFsc28gaWYgdHBtX3Rpc19wcm9iZV9pcnEoKSBmYWlscy4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpUZXN0ZWQtYnk6IE1pY2hhZWwgTmlld8O2aG5l
ciA8bGludXhAbW5pZXdvZWhuZXIuZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBk
MmM5YzlkNzY4OTMuLjYwM2I4MmNhNTZkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0x
MDkxLDIxICsxMDkxLDIxIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQlnb3RvIG91dF9lcnI7
CiAJCX0KIAotCQlpZiAoaXJxKSB7CisJCWlmIChpcnEpCiAJCQl0cG1fdGlzX3Byb2JlX2lycV9z
aW5nbGUoY2hpcCwgaW50bWFzaywgSVJRRl9TSEFSRUQsCiAJCQkJCQkgaXJxKTsKLQkJCWlmICgh
KGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpKSB7Ci0JCQkJZGV2X2VycigmY2hpcC0+
ZGV2LCBGV19CVUcKKwkJZWxzZQorCQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7
CisKKwkJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkpIHsKKwkJCWRldl9l
cnIoJmNoaXAtPmRldiwgRldfQlVHCiAJCQkJCSJUUE0gaW50ZXJydXB0IG5vdCB3b3JraW5nLCBw
b2xsaW5nIGluc3RlYWRcbiIpOwogCi0JCQkJcmMgPSByZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDAp
OwotCQkJCWlmIChyYyA8IDApCi0JCQkJCWdvdG8gb3V0X2VycjsKLQkJCQlkaXNhYmxlX2ludGVy
cnVwdHMoY2hpcCk7Ci0JCQkJcmVsZWFzZV9sb2NhbGl0eShjaGlwLCAwKTsKLQkJCX0KLQkJfSBl
bHNlIHsKLQkJCXRwbV90aXNfcHJvYmVfaXJxKGNoaXAsIGludG1hc2spOworCQkJcmMgPSByZXF1
ZXN0X2xvY2FsaXR5KGNoaXAsIDApOworCQkJaWYgKHJjIDwgMCkKKwkJCQlnb3RvIG91dF9lcnI7
CisJCQlkaXNhYmxlX2ludGVycnVwdHMoY2hpcCk7CisJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAs
IDApOwogCQl9CiAJfQogCi0tIAoyLjM2LjEKCg==
