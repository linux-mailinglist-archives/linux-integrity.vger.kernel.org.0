Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BCC51F6F5
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiEIIq1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 04:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiEIIOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 04:14:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3842130C5B;
        Mon,  9 May 2022 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652083626;
        bh=y3wkeJ7ZYRxjhV+SmNN+0jvODpsGU4EpwvD7/wY3xLY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JwAQrkge+fYwTqZgi96aUV3rd1GrvJ6hobZrcDdBGezzjV1JV2jx/G+lVOKfea2YO
         LjlkkZZKHwauOsp/4vOP97upxsEQO2/2y9zRfWy8xAy0ahKEIncJHgQHKe88hJv9ev
         f8jfz31p2sLCzRgqWB55ETHxN33aXKFPa+OkSDxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1nYcL33stc-00FUCT; Mon, 09
 May 2022 10:07:06 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
Date:   Mon,  9 May 2022 10:05:54 +0200
Message-Id: <20220509080559.4381-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VEe9AQBEptDU/mhnL5y7j/e8z2rQQDtj6jhRmqTdV+HuixTmL63
 9rK++fzpomo40G4KKg3h0Nqk99a925rN3ikK7h5TL+0/qaV1KfltA42T6nh+MWAtJmF9oar
 4miIyP4VTLgn6Jxj6thQiLyZ/ZtvUhTpMk8xjO9ZVT+94/vGPqug/xi0g9f1kZ3up9qsPZ+
 nshBxZycf9c11gvVlJM1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RD6S0MjoskY=:V1yn4RcqaWhPTh5QOMXWZv
 y8IguvIC2ztdh2IpQJxoyvQiFc7JoVd5/wKo+BoFzOmboF/abX5yw11PRi8PhVIcveQcopGD0
 vY1ZKhmry02BixB0bH92yleD32xupfOM6oO0/kiO7XU6D8GCXfHc/TWZ+Ncsgz1bwMy//Gfuf
 ucAkAaBlAw522e4zwnpSR+iPD/Csk3jJA25kRjhbtehXggZ7qwGklnwPXEkZN5Lfo3fVeLWqc
 lfqoVkJwrND/1XnGkyHhKaJI2aeP+PCuHTwqqjs/NFC3i9wdBHksFdjbzlQicwnyR5sZUl2vh
 dWkxO7fKx29A3D9vf79yyTB7cRm4lIMsvvkR261mESN8h4BQOW2jSgkCeZrjbniSQNp/FN7ir
 xSyP7xiDRtf5HkYhoGmeXa03FKk7HHUdExVMSTCxVXcxe0AIiBjgJUzhE/VpSxh2zWdHRxzqw
 n6PMft+NkRWWCVEWyP6Rc1XTryrrZjZAAHKpZpRvSVDc3PWLoYG/pFUvjLl8xsYe3vRQYHTm3
 SAk05jmthyTEBT4i7y34GweQpNeMTLcLTpAyvjvOGneBJLvKzFO+Moet1x7ghteMXGfGuXHGN
 NcwTgF1RSeEXCSmvPrl5DglNQBo4D9x5DyH0MAnzFvTwNgnulBb2wEOrDkV2mGQCqA457jtlU
 FQNkeFqWScZSOALYM0pwdO5TIuGB692MXIn/cYM1qvzhS7MT9q+pXyNyQfwF5DgteUrcqHXXO
 QaKy7LDEIpMnEGCyU2OiVbXzK8UkYaH0qPQFD+e+226lxEvxXwChbYvb0Dzq1x83bv7G45247
 V3GmOyRnIpOcFO8T1s87vbx37sUK4EezEQZLwD2ZMoIRa/9LaUivk7v/vvq24vrfwYAfWoR9u
 3uiHUGQFgHn6u1F+ILk3JMyYj81c9kGg2Bw9wd4Wn/ZOzy4GHy/Zo/A7ydBeDZ4J+cyQ/b+bQ
 tTcK4DCg5TcARGsg+MIbIGvXFgtTIAVZbDwyT/+G7IZLsduiWIspBTBKElKsuyUokGlEM/DFy
 G1VUq6XhydKhQM7L4b81s6hWJ3zgRk6K9hF69lu9cpQyrpZJ7Coyoz6JCYohurF+M3YaOxlcY
 M7kRElkorBTw+k=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkludGVycnVw
dCBoYW5kbGluZyBhdCBsZWFzdCBpbmNsdWRlcyByZWFkaW5nIGFuZCB3cml0aW5nIHRoZSBpbnRl
cnJ1cHQKc3RhdHVzIHJlZ2lzdGVyIHdpdGhpbiB0aGUgaW50ZXJydXB0IHJvdXRpbmUuIFNpbmNl
IGFjY2Vzc2VzIG92ZXIgdGhlIFNQSQpidXMgYXJlIHN5bmNocm9uaXplZCBieSBhIG11dGV4LCBy
ZXF1ZXN0IGEgdGhyZWFkZWQgaW50ZXJydXB0IGhhbmRsZXIgdG8KZW5zdXJlIGEgc2xlZXBhYmxl
IGNvbnRleHQgZHVyaW5nIGludGVycnVwdCBwcm9jZXNzaW5nLgoKRml4ZXM6IDFhMzM5YjY1OGQ5
ZCAoInRwbV90aXNfc3BpOiBQYXNzIHRoZSBTUEkgSVJRIGRvd24gdG8gdGhlIGRyaXZlciIpClNp
Z25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0t
LQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyAgICAgfCAxNSArKysrKysrKysrKysr
LS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmggICAgIHwgIDEgKwogZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX3NwaV9tYWluLmMgfCAgNSArKystLQogMyBmaWxlcyBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hh
ci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmlu
ZGV4IGRjNTZiOTc2ZDgxNi4uNTIzNjllZjM5YjAzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMK
QEAgLTc0Nyw4ICs3NDcsMTkgQEAgc3RhdGljIGludCB0cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUo
c3RydWN0IHRwbV9jaGlwICpjaGlwLCB1MzIgaW50bWFzaywKIAlpbnQgcmM7CiAJdTMyIGludF9z
dGF0dXM7CiAKLQlpZiAoZGV2bV9yZXF1ZXN0X2lycShjaGlwLT5kZXYucGFyZW50LCBpcnEsIHRp
c19pbnRfaGFuZGxlciwgZmxhZ3MsCi0JCQkgICAgIGRldl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlw
KSAhPSAwKSB7CisKKwlpZiAocHJpdi0+ZmxhZ3MgJiBUUE1fVElTX1VTRV9USFJFQURFRF9JUlEp
IHsKKwkJcmMgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGNoaXAtPmRldi5wYXJlbnQsIGly
cSwgTlVMTCwKKwkJCQkJICAgICAgIHRpc19pbnRfaGFuZGxlciwKKwkJCQkJICAgICAgIElSUUZf
T05FU0hPVCB8IGZsYWdzLAorCQkJCQkgICAgICAgZGV2X25hbWUoJmNoaXAtPmRldiksCisJCQkJ
CSAgICAgICBjaGlwKTsKKwl9IGVsc2UgeworCQlyYyA9IGRldm1fcmVxdWVzdF9pcnEoY2hpcC0+
ZGV2LnBhcmVudCwgaXJxLCB0aXNfaW50X2hhbmRsZXIsCisJCQkJICAgICAgZmxhZ3MsIGRldl9u
YW1lKCZjaGlwLT5kZXYpLCBjaGlwKTsKKwl9CisKKwlpZiAocmMpIHsKIAkJZGV2X2luZm8oJmNo
aXAtPmRldiwgIlVuYWJsZSB0byByZXF1ZXN0IGlycTogJWQgZm9yIHByb2JlXG4iLAogCQkJIGly
cSk7CiAJCXJldHVybiAtMTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19j
b3JlLmggYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCmluZGV4IDNiZTI0ZjIyMWUz
Mi4uNDNiNzI0ZTU1MTkyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5oCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmgKQEAgLTg2LDYgKzg2LDcg
QEAgZW51bSB0aXNfZGVmYXVsdHMgewogZW51bSB0cG1fdGlzX2ZsYWdzIHsKIAlUUE1fVElTX0lU
UE1fV09SS0FST1VORAkJPSBCSVQoMCksCiAJVFBNX1RJU19JTlZBTElEX1NUQVRVUwkJPSBCSVQo
MSksCisJVFBNX1RJU19VU0VfVEhSRUFERURfSVJRCT0gQklUKDIpLAogfTsKIAogc3RydWN0IHRw
bV90aXNfZGF0YSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfc3BpX21h
aW4uYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19zcGlfbWFpbi5jCmluZGV4IDE4NDM5NmIz
YWY1MC4uZjU2NjEzZjI5NDZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNf
c3BpX21haW4uYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfc3BpX21haW4uYwpAQCAt
MjIzLDkgKzIyMywxMCBAQCBzdGF0aWMgaW50IHRwbV90aXNfc3BpX3Byb2JlKHN0cnVjdCBzcGlf
ZGV2aWNlICpkZXYpCiAJcGh5LT5mbG93X2NvbnRyb2wgPSB0cG1fdGlzX3NwaV9mbG93X2NvbnRy
b2w7CiAKIAkvKiBJZiB0aGUgU1BJIGRldmljZSBoYXMgYW4gSVJRIHRoZW4gdXNlIHRoYXQgKi8K
LQlpZiAoZGV2LT5pcnEgPiAwKQorCWlmIChkZXYtPmlycSA+IDApIHsKIAkJaXJxID0gZGV2LT5p
cnE7Ci0JZWxzZQorCQlwaHktPnByaXYuZmxhZ3MgfD0gVFBNX1RJU19VU0VfVEhSRUFERURfSVJR
OworCX0gZWxzZQogCQlpcnEgPSAtMTsKIAogCWluaXRfY29tcGxldGlvbigmcGh5LT5yZWFkeSk7
Ci0tIAoyLjM2LjAKCg==
