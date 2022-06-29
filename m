Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E86560D2D
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiF2X1r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiF2X1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597624F13;
        Wed, 29 Jun 2022 16:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545245;
        bh=FO1qKvjwo5OYPnKK1TQ+U7MMExJ4/KOfblZ/tjJSnxI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jtTO7FOnilg87GhuFWwBPTq/qv/GMfnu/MrKug3vt4+GVjenkEbVGxAGCAn3aKMs0
         /BGnUY7D/HUMk1hbZluL60hnO/UqNijfROrt95whTlCFgA7lpL6Uo9iH1++A7k1X6k
         7iBfo5oLl62nnCCjDTn4sXVk9YuiYy2MoxRAmDeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1ngOgG23zV-0108ik; Thu, 30
 Jun 2022 01:27:25 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 06/10] tpm, tpm_tis: Move interrupt mask checks into own function
Date:   Thu, 30 Jun 2022 01:26:49 +0200
Message-Id: <20220629232653.1306735-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:NK8V6gYmS9shuxcrgqlJD2IVankIghQH/8sonM50vYYQWUMuy8/
 M6RiAs5r3z2QL7Dq1LGMWSkqdc+/QXaqtXT5PfT1r1goRtROuQfOQ6zzGdPN0ZKhcNqYT7i
 R50Y+jzin0V7tRBJqXSxKagbDHcjJJpsMmcTh8suHkSqofml97iD24sxJJyI0Ua9CgWGWxg
 XV+CpN7+fUi3NapKcUqKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zETysfYVlw=:Z4puwgExUg62rspa9x73sk
 HBeJyveXQ29pji3+OnyuK/bmRWdX3lqtN0rHD7eKyqhRs1Fkw9gBUL61ZtfA+T4DEGl39ABx2
 IE4aoOlr8K3Xay++20AX+Iek28fkQ+pHHuZ1WspveKXUJsfWlRKKXqf/OsXl9ufkC4WqKnVsX
 qmv0USFh2sAFZywJh9mkBX4lLkpwuaDumfYc6jlf3EHcWjvJZXceLS7CG65G/dSvViXrDSogB
 860dD/gEli6NrtuhRvsnFTM61LtdQ3jFO7LvXBs58Bxrc/nZ3yG/ObWJNdtWCt15+82u75Jdz
 5PGWmkt5fiYa7j7KBgmXJTj74Vgf68brLcy8VxW/drNR2UZJRc/gRmREA+EAcTqzL6ReysysK
 h6wymat8V6PEhRaTB52leBE0j3HG3xHmim8677hWuTvIfars4rwBLqIHBMDMrjnKHSDvyMIt8
 G6XpY6CTkj8q45YXhwXisizdRA2GzoOtelyOqdlq/jey3TwHpe69ixP2dRnlhO4CsD6SfkqLW
 BQSrIvjGUy4ewzMX4TebejFfbkd+jd6agnH84a4KB/BfvGDt/Mju5Xogn34mqa9BO88JpTMC+
 dCeehcj/OAcGlBrPt5Ca0Rg0zNTlUsmW/LlfWPhol1w7Vu+baapj1MrV2Gs0Hp5qmSzz88hwK
 i4IsoZtyatfSBl/uV1cADxzJ1Rt0TMe14aBO/QHTgr+u+3z02VlCM6W82Pw/xGIjwhwLu+S+c
 6+JS2otPjK7QGDInWdifGgw/vJYRTmTOAxgCA5oJo4xGkMycXsI70ZnkE3HPLHIOxPqMbKnFK
 tg2qIBKRi19zxJJ3gEc3G0O920yHmFv63uMsA/JKpBDYZcbjKX1VQ4ted4LxmM+DHDB0B3CeF
 aVcFvOHZ4f69Yjm1qnwEoPDaUK4NPnyoEpHR7DB9/4OpSH8jVWg0WJXeqqLIhZHdQjn3/F3Iu
 KsXD9cy49e86/3lo5TDdvBjZ06K4E/xBmsIdtuKEZZTm7cIpFBjVUn3OggTrS8VbN5nKFtR5E
 6jLU2bk9mtnN6O7fLHBP3FyeLx1HFiLRTxdzkFdZw29QqyMAV9zIEAloxRSDKqYFr2Ht8g3Qn
 odH8HDvoUF4wLFQzeC4wXN9OJ668jvWNyrVGqElID7tsQoUCLA+7E+KIg==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkNsZWFuIHVw
IHdhaXRfZm9yX3RwbV9zdGF0KCkgYnkgbW92aW5nIG11bHRpcGxlIHNpbWlsYXIgaW50ZXJydXB0
IG1hc2sKY2hlY2tzIGludG8gYW4gb3duIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1ieTogTGlubyBT
YW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KU3VnZ2VzdGVkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rp
c19jb3JlLmMgfCAyOSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5jCmluZGV4IGMxMzU5OWU5NGFiNi4uYmQ0ZWViMGIyMTkyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmMKQEAgLTQ0LDYgKzQ0LDIwIEBAIHN0YXRpYyBib29sIHdhaXRfZm9yX3RwbV9zdGF0X2Nv
bmQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCXJldHVybiBmYWxzZTsKIH0KIAor
c3RhdGljIHU4IHRwbV90aXNfZmlsdGVyX3N0c19tYXNrKHU4IGludF9tYXNrLCB1OCBzdHNfbWFz
aykKK3sKKwlpZiAoIShpbnRfbWFzayAmIFRQTV9JTlRGX1NUU19WQUxJRF9JTlQpKQorCQlzdHNf
bWFzayAmPSB+VFBNX1NUU19WQUxJRDsKKworCWlmICghKGludF9tYXNrICYgVFBNX0lOVEZfREFU
QV9BVkFJTF9JTlQpKQorCQlzdHNfbWFzayAmPSB+VFBNX1NUU19EQVRBX0FWQUlMOworCisJaWYg
KCEoaW50X21hc2sgJiBUUE1fSU5URl9DTURfUkVBRFlfSU5UKSkKKwkJc3RzX21hc2sgJj0gflRQ
TV9TVFNfQ09NTUFORF9SRUFEWTsKKworCXJldHVybiBzdHNfbWFzazsKK30KKwogc3RhdGljIGlu
dCB3YWl0X2Zvcl90cG1fc3RhdChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHU4IG1hc2ssCiAJCXVu
c2lnbmVkIGxvbmcgdGltZW91dCwgd2FpdF9xdWV1ZV9oZWFkX3QgKnF1ZXVlLAogCQlib29sIGNo
ZWNrX2NhbmNlbCkKQEAgLTUzLDcgKzY3LDcgQEAgc3RhdGljIGludCB3YWl0X2Zvcl90cG1fc3Rh
dChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHU4IG1hc2ssCiAJbG9uZyByYzsKIAl1OCBzdGF0dXM7
CiAJYm9vbCBjYW5jZWxlZCA9IGZhbHNlOwotCXU4IHN0c19tYXNrID0gMDsKKwl1OCBzdHNfbWFz
azsKIAlpbnQgcmV0ID0gMDsKIAogCS8qIGNoZWNrIGN1cnJlbnQgc3RhdHVzICovCkBAIC02MSwx
NyArNzUsMTAgQEAgc3RhdGljIGludCB3YWl0X2Zvcl90cG1fc3RhdChzdHJ1Y3QgdHBtX2NoaXAg
KmNoaXAsIHU4IG1hc2ssCiAJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSBtYXNrKQogCQlyZXR1cm4g
MDsKIAorCXN0c19tYXNrID0gbWFzayAmIChUUE1fU1RTX1ZBTElEIHwgVFBNX1NUU19EQVRBX0FW
QUlMIHwKKwkJCSAgIFRQTV9TVFNfQ09NTUFORF9SRUFEWSk7CiAJLyogY2hlY2sgd2hpY2ggc3Rh
dHVzIGNoYW5nZXMgY2FuIGJlIGhhbmRsZWQgYnkgaXJxcyAqLwotCWlmIChwcml2LT5pbnRfbWFz
ayAmIFRQTV9JTlRGX1NUU19WQUxJRF9JTlQpCi0JCXN0c19tYXNrIHw9IFRQTV9TVFNfVkFMSUQ7
Ci0KLQlpZiAocHJpdi0+aW50X21hc2sgJiBUUE1fSU5URl9EQVRBX0FWQUlMX0lOVCkKLQkJc3Rz
X21hc2sgfD0gVFBNX1NUU19EQVRBX0FWQUlMOwotCi0JaWYgKHByaXYtPmludF9tYXNrICYgVFBN
X0lOVEZfQ01EX1JFQURZX0lOVCkKLQkJc3RzX21hc2sgfD0gVFBNX1NUU19DT01NQU5EX1JFQURZ
OwotCi0Jc3RzX21hc2sgJj0gbWFzazsKKwlzdHNfbWFzayA9IHRwbV90aXNfZmlsdGVyX3N0c19t
YXNrKHByaXYtPmludF9tYXNrLCBzdHNfbWFzayk7CiAKIAlzdG9wID0gamlmZmllcyArIHRpbWVv
dXQ7CiAJLyogcHJvY2VzcyBzdGF0dXMgY2hhbmdlcyB3aXRoIGlycSBzdXBwb3J0ICovCi0tIAoy
LjI1LjEKCg==
