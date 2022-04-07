Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77864F7DD1
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 13:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiDGLVb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiDGLVa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 07:21:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95C19533A;
        Thu,  7 Apr 2022 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649330355;
        bh=+8FAwpjcDILWSNDx21CKUAniktty0diX3BBBPxBxwd4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HQ7EXUW0mimX7QIrI44zFyjDh1CIh0dfexOujOd9tC4nKczWDM7KLVMS1i8p6jjsL
         n5MGBhKbaC36g95F/K4g/ttes1M4KPgbXK913YLQdOBfb//D6IvP8COwOO2RnB6m7Q
         3pszwSvSQ7hDnM3J1JR7Kq0Z8gxaWMsDjpJlKcDc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1oIwmS1vaJ-00k9ZU; Thu, 07
 Apr 2022 13:19:15 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 1/5] tpm: add functions to set and unset the tpm chips reset state
Date:   Thu,  7 Apr 2022 13:18:45 +0200
Message-Id: <20220407111849.5676-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:vsXneH/Z/sGRwRqqSWBf86QGc9y88g1044oI/ue+S4oOjAaxNqb
 CZDLh+ocCxBVvKtNTa8zcPm3jvF9NTUQLid2fGsZ5JhttpSBPCAMBaJHtKkeh2/ff1GcHsh
 ZO/65USFf5MPdLOAEVmhmFCVLs7vwC8ujUn5iCqXZJWyisu7QthBih+rtrhgH23WBVqWYws
 EzsD9GVfGv8Qn2v3gA2pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pNlkzPablvw=:/QgYjB7n+D6+tavd5UU/LT
 F/d8/GAxkJ5hYiBBQlPdml3OKDzUcWGrgydsqndoVFb8NUu7jrvL2NWkl9TUrIwcQAYLlUdlq
 UW/pvwERv47aNxozlZe6NOa1+eTr2O79+w3p8OcOIkkrRtwScRVqwyW23ZssOrN7ar93kfTjT
 LcNvVc9yzVYswD4y/YPpJFzbiQ9pHLxpp5cT0XBQqSxsGWlYxTzlpekx4A0jCToaLmBG2ucX+
 LEJecDdvbHE+nTrXi4F5c9CnPO51VrqYVDk49bSY5S+YizkU/Ox9E/+GH8Zc08RNqXsHPjenK
 /nDrK/cVEzda36HEVbGA3uIuZewzCBYyxtGZh8n37/qPxeHDBRr/V7DFgDL2pbVVMOhBM/Lj7
 z0vdFdtXDGadXfa6wHZMLXtmXeXRaQv0mmJinYOmpyHRCQXW1j25WF05TpJv0iVMiiZSnWZ44
 TlSL5HPJsTyIdkq2CVFo2t8hGwp/ga0c/PQz4XM81W0Al3udM8nSude3cN6m28Ry5MQyThEBs
 nl9wHfkx78xStox1eQk3sq6LUO+/ZdsaWaPLOh+2mmklQnXfGn/Oohi8hKYosJy7JvUf/cqqI
 SNaSDioYjzEl7sl47eEp3rwr8Y7DH1Pp9k2iJ6mdztpvfqwxGJJhKE2orrWd9RCJVG08VmjyA
 DZwsMRqHiyqtIFapu3azOpeNCgbE6paFlTJ3sj6idSs2KvUgg2rjGFZ3IFgH9vjlq6lAFtbLh
 iMqMscVlGfQPz7ImS5kOv+etImzn8TmUzPfAfeEq3PHTDdp6V4rmQKbW3SA69YxA27h9dOtXY
 7dx3bSeEJZfqXXYRTX4mDl1hxuqB0P8xAKDjmJHV1X8TC0rHE9hCEQvGDELE/J/jli7Gf8zav
 lp2K7M7xoSsdqTUUymKPrJSg7bso17x7USnn8KWpTrBUiHKSyhAce77Z2E5gQrn0y2r1lzuCE
 Y1tH9w9s4Tew1Vj4i0tz38bqH85oimDXf4Hs/dQlMKoB6V8C3aWuwb1ljZigroZdIqotBu4f4
 JBXttiQVTW3CO6zJBw/gDRBHfgMDfpuu/FppuiH+uAR58ig1CR9y+dk4oRvF2PT/cMP34JJ9C
 sc5OlLBhbAYMGk=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Q3VycmVudGx5IGl0IGlzIG5vdCBwb3NzaWJsZSB0byBzZXQgdGhlIHRwbSBjaGlwcyByZXNldCBz
dGF0ZSBmcm9tIHdpdGhpbgp0aGUgZHJpdmVyLiBUaGlzIGlzIHByb2JsZW1hdGljIGlmIHRoZSBj
aGlwIGlzIHN0aWxsIGluIHJlc2V0IGFmdGVyIHRoZQpzeXN0ZW0gY29tZXMgdXAuIFRoaXMgbWF5
IGUuZy4gaGFwcGVuIGlmIHRoZSByZXNldCBsaW5lIGlzIHB1bGxlZCBpbnRvCnJlc2V0IHN0YXRl
IGJ5IGEgcGluIGNvbmZpZ3VyYXRpb24gaW4gdGhlIGRldmljZSB0cmVlLgoKVG8gaGFuZGxlIHRo
aXMgY2FzZSBleHRlbmQgdHBtX3Rpc19waHlfb3BzIGJ5IHRoZSB0d28gZnVuY3Rpb25zICJzZXRf
cmVzZXQiCmFuZCAidW5zZXRfcmVzZXQiIHdoaWNoIG1heSBvcHRpb25hbGx5IGJlIGRlZmluZWQg
YnkgYSB0cG0gZHJpdmVyLgpJZiBkZWZpbmVkIGNhbGwgInVuc2V0X3Jlc2V0IiBhdCBjaGlwIHN0
YXJ0dXAgYmVmb3JlIHRoZSBmaXJzdCB0cG0gY29tbWFuZAppcyBpc3N1ZWQuIEFsc28gaWYgZGVm
aW5lZCBjYWxsICJzZXRfcmVzZXQiIGF0IGNoaXAgc2h1dGRvd24gYWZ0ZXIgdGhlIHRwbTIKc2h1
dGRvd24gY29tbWFuZCBoYXMgYmVlbiBzZW50LgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxp
cHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hp
cC5jICAgICB8IDUgKysrKysKIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAzICsr
KwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuaCB8IDIgKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWNo
aXAuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYwppbmRleCA3ODNkNjVmYzcxZjAuLmMx
Yjc5YmE5MTU5ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYwpAQCAtMjQsNiArMjQsNyBAQAogI2luY2x1ZGUg
PGxpbnV4L3RwbV9ldmVudGxvZy5oPgogI2luY2x1ZGUgPGxpbnV4L2h3X3JhbmRvbS5oPgogI2lu
Y2x1ZGUgInRwbS5oIgorI2luY2x1ZGUgInRwbV90aXNfY29yZS5oIgogCiBERUZJTkVfSURSKGRl
dl9udW1zX2lkcik7CiBzdGF0aWMgREVGSU5FX01VVEVYKGlkcl9sb2NrKTsKQEAgLTI4Niw2ICsy
ODcsNyBAQCBzdGF0aWMgdm9pZCB0cG1fZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQog
c3RhdGljIGludCB0cG1fY2xhc3Nfc2h1dGRvd24oc3RydWN0IGRldmljZSAqZGV2KQogewogCXN0
cnVjdCB0cG1fY2hpcCAqY2hpcCA9IGNvbnRhaW5lcl9vZihkZXYsIHN0cnVjdCB0cG1fY2hpcCwg
ZGV2KTsKKwlzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZjaGlw
LT5kZXYpOwogCiAJZG93bl93cml0ZSgmY2hpcC0+b3BzX3NlbSk7CiAJaWYgKGNoaXAtPmZsYWdz
ICYgVFBNX0NISVBfRkxBR19UUE0yKSB7CkBAIC0yOTcsNiArMjk5LDkgQEAgc3RhdGljIGludCB0
cG1fY2xhc3Nfc2h1dGRvd24oc3RydWN0IGRldmljZSAqZGV2KQogCWNoaXAtPm9wcyA9IE5VTEw7
CiAJdXBfd3JpdGUoJmNoaXAtPm9wc19zZW0pOwogCisJaWYgKHByaXYtPnBoeV9vcHMtPnNldF9y
ZXNldCkKKwkJcHJpdi0+cGh5X29wcy0+c2V0X3Jlc2V0KHByaXYpOworCiAJcmV0dXJuIDA7CiB9
CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGRjNTZiOTc2ZDgxNi4uMTFlNWUwNDVmM2E3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZl
cnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTk1Miw2ICs5NTIsOSBAQCBpbnQgdHBtX3Rp
c19jb3JlX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2
LCBpbnQgaXJxLAogCiAJZGV2X3NldF9kcnZkYXRhKCZjaGlwLT5kZXYsIHByaXYpOwogCisJaWYg
KHByaXYtPnBoeV9vcHMtPnVuc2V0X3Jlc2V0KQorCQlwcml2LT5waHlfb3BzLT51bnNldF9yZXNl
dChwcml2KTsKKwogCXJjID0gdHBtX3Rpc19yZWFkMzIocHJpdiwgVFBNX0RJRF9WSUQoMCksICZ2
ZW5kb3IpOwogCWlmIChyYyA8IDApCiAJCXJldHVybiByYzsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmggYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5o
CmluZGV4IDNiZTI0ZjIyMWUzMi4uZjFhNjc0NDVhNWM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5oCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmgKQEAgLTEwNSw2ICsxMDUsOCBAQCBzdHJ1Y3QgdHBtX3Rpc19kYXRhIHsKIH07CiAKIHN0cnVj
dCB0cG1fdGlzX3BoeV9vcHMgeworCWludCAoKnNldF9yZXNldCkoc3RydWN0IHRwbV90aXNfZGF0
YSAqZGF0YSk7CisJaW50ICgqdW5zZXRfcmVzZXQpKHN0cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEp
OwogCWludCAoKnJlYWRfYnl0ZXMpKHN0cnVjdCB0cG1fdGlzX2RhdGEgKmRhdGEsIHUzMiBhZGRy
LCB1MTYgbGVuLAogCQkJICB1OCAqcmVzdWx0KTsKIAlpbnQgKCp3cml0ZV9ieXRlcykoc3RydWN0
IHRwbV90aXNfZGF0YSAqZGF0YSwgdTMyIGFkZHIsIHUxNiBsZW4sCi0tIAoyLjM1LjEKCg==
