Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB1637AAD
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiKXN5F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKXN44 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCFFFFAA4;
        Thu, 24 Nov 2022 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298174; bh=SccepFkG1BaYDhxThv4kTIw73gWWQ8B34c8oBRXziP8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N5oSIApeIyqhSeyC5gdSR0djmO35Q82/vTO7AnK+pUNovI047gP53VxHdyEh644Gs
         vDbkjFbFt4syPSalb34P3JmOTUqPiUORWZ3cu/CtvTl1I5MDTSI5LbrbRykKs3MPPB
         gDqmJMCbW/daQoZ5iTvHIoqr6zvwolRhD2aLsgkpb99iWmZybH3HfbmPqUJnkMNObK
         4M2a2Ouq50SagnRldDSMKXrD4VUHBcq6CmZ+/BDhv32/We5dpWepTL9XotCwnkiFVu
         TYXuIvIFTdnNeOaR/smYBw2k8Rv1UALGd+DflsGFfHRtoG9vBH3jN5QSKi9OQr1Lm0
         TWJ58lS+6OZLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1pPH3Q1hnS-00hcyE; Thu, 24
 Nov 2022 14:56:14 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 13/14] tpm, tpm_tis: startup chip before testing for interrupts
Date:   Thu, 24 Nov 2022 14:55:37 +0100
Message-Id: <20221124135538.31020-14-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:zL2CNXLyU474XTdrXuPgbob0QK0DB8meDAMR4XbMdR/tbE5lv3k
 k6dilEu5PY/7pIfCkYcsG9ONqgIh7Yw14eA/C71RO2XlIIRNDC/vszFhWB6E7PjthtspBOF
 bnGzBzzik2FbNsoASv1b3OfHAbGE6h6nhndFb/bw8w++/zya1A07LDjeoY7MMXfTDUMrYbf
 bxYBAriPFhSep3+hjLCSQ==
UI-OutboundReport: notjunk:1;M01:P0:1LYpu2fBXps=;CrGmYwKDDI8dwJQBn3y2fmWp8Gs
 IA7PqgPDCI0YelnX1m174eoQ7ICsvUkRLf1qhlw0+1kEcAK/s11cWQO+JCsG2tBuUYf6t/N+s
 4dXVf06KzusaVhyfHT9ULvmQtbNi53Bex54+G9IBwrvtHJzY3SDYxpA9KfYYrOATllrP9XKGe
 ytOWAHB6oOlnLA1OPJd70P9KkALdtKQq187b2MY6T7GN7NCcsoz3AVromPiCdF1PLIfZdWdsH
 CSwfcRCgOlL6tzkTLO5HdsRlGBQDto3v9YpHtHqKwPtSqgL529thm0QvOy7DpAcYfG0UacLCk
 l/RrWNlHMjSzjYLDqmjDU6hrMG+wJ1qGq9SP8Ag5RhPIzJkvXFVWpLX2UzNF0w54Oly8nYZkh
 6JLFhVMRhZJyqxlKIc09Rn8JSf6jaEwHsOlGs8wk9Q35d4H2LWF9CatxP3A6q02Ebg/pnFx41
 mj7jZk4qEGpvEqEqSUd7lTtEMRIbJr8T5J4oRMasG2bXXTok66l+ecll1GWZzvZqnrBo8+sqf
 2vENlVO5QQiHp+7CYFzhVyaL2kfGIBHJ90QCKc2FRI81DYEz+Sudd000dC/TMmjA+gOAxwrqE
 4dZM/+C223BAwUhs6oJRZieLki5Gm+BXafGFJWENkDez2vfSTqaObWy1O0+3Fsg5K67R2Be5n
 PSQKkM6gUaWh7oI9xMVfrzOq2NYGjQDmhS/dtqOFM2p/w2xAZOF52M3EhYEhIEh9JmtmDJfhy
 CdMQCRHDF5Cm9pIRuLdV1IDx/MmcxYg2MhwON1ghtxxte5TYdXZ+QIpebHcJdIFDnfGKJs4XO
 4GOu4AKLF9SNddSHjn1qu/b67IKA4NLdlFiEB4QYUQhpL0nsFgH9aBIqZebPWX9tG84Tz6cgR
 5PXiwM0vVzJRDLlq5Jj3PJc29ZfEBRVsIlCC7fTsVyDIDlSR3vya9bCIdI6r7b1Qd5yws60o0
 be2bAg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfZ2VuX2ludGVycnVwdCgpIGEgcmVxdWVzdCBmb3IgYSBwcm9wZXJ0eSB2YWx1ZSBpcyBzZW50
IHRvIHRoZQpUUE0gdG8gdGVzdCBpZiBpbnRlcnJ1cHRzIGFyZSBnZW5lcmF0ZWQuIEhvd2V2ZXIg
YWZ0ZXIgYSBwb3dlciBjeWNsZSB0aGUKVFBNIHJlc3BvbmRzIHdpdGggVFBNX1JDX0lOSVRJQUxJ
WkUgd2hpY2ggaW5kaWNhdGVzIHRoYXQgdGhlIFRQTSBpcyBub3QKeWV0IHByb3Blcmx5IGluaXRp
YWxpemVkLgpGaXggdGhpcyBieSBmaXJzdCBzdGFydGluZyB0aGUgVFBNIHVwIGJlZm9yZSB0aGUg
cmVxdWVzdCBpcyBzZW50LiBGb3IgdGhpcwp0aGUgc3RhcnR1cCBpbXBsZW1lbnRhdGlvbiBpcyBy
ZW1vdmVkIGZyb20gdHBtX2NoaXBfcmVnaXN0ZXIoKSBhbmQgcHV0CmludG8gdGhlIG5ldyBmdW5j
dGlvbiB0cG1fY2hpcF9zdGFydHVwKCkgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSB0aGUKaW50ZXJy
dXB0cyBhcmUgdGVzdGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgICAgIHwg
MzggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3Rw
bS5oICAgICAgICAgIHwgIDEgKwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8ICA1
ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtLWNoaXAuYwppbmRleCA3ODNkNjVmYzcxZjAuLjM3MGFhMWY1MjlmMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0v
dHBtLWNoaXAuYwpAQCAtNTQzLDYgKzU0MywzMCBAQCBzdGF0aWMgaW50IHRwbV9nZXRfcGNyX2Fs
bG9jYXRpb24oc3RydWN0IHRwbV9jaGlwICpjaGlwKQogCXJldHVybiByYzsKIH0KIAorLyoKKyAq
IHRwbV9jaGlwX3N0YXJ0dXAoKSAtIHBlcmZvcm1zIGF1dG8gc3RhcnR1cCBhbmQgYWxsb2NhdGVz
IHRoZSBQQ1JzCisgKiBAY2hpcDogVFBNIGNoaXAgdG8gdXNlLgorICovCitpbnQgdHBtX2NoaXBf
c3RhcnR1cChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCit7CisJaW50IHJjOworCisJcmMgPSB0cG1f
Y2hpcF9zdGFydChjaGlwKTsKKwlpZiAocmMpCisJCXJldHVybiByYzsKKworCXJjID0gdHBtX2F1
dG9fc3RhcnR1cChjaGlwKTsKKwlpZiAocmMpCisJCWdvdG8gc3RvcDsKKworCXJjID0gdHBtX2dl
dF9wY3JfYWxsb2NhdGlvbihjaGlwKTsKK3N0b3A6CisJdHBtX2NoaXBfc3RvcChjaGlwKTsKKwor
CXJldHVybiByYzsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHRwbV9jaGlwX3N0YXJ0dXApOworCiAv
KgogICogdHBtX2NoaXBfcmVnaXN0ZXIoKSAtIGNyZWF0ZSBhIGNoYXJhY3RlciBkZXZpY2UgZm9y
IHRoZSBUUE0gY2hpcAogICogQGNoaXA6IFRQTSBjaGlwIHRvIHVzZS4KQEAgLTU1OCwyMCArNTgy
LDYgQEAgaW50IHRwbV9jaGlwX3JlZ2lzdGVyKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIHsKIAlp
bnQgcmM7CiAKLQlyYyA9IHRwbV9jaGlwX3N0YXJ0KGNoaXApOwotCWlmIChyYykKLQkJcmV0dXJu
IHJjOwotCXJjID0gdHBtX2F1dG9fc3RhcnR1cChjaGlwKTsKLQlpZiAocmMpIHsKLQkJdHBtX2No
aXBfc3RvcChjaGlwKTsKLQkJcmV0dXJuIHJjOwotCX0KLQotCXJjID0gdHBtX2dldF9wY3JfYWxs
b2NhdGlvbihjaGlwKTsKLQl0cG1fY2hpcF9zdG9wKGNoaXApOwotCWlmIChyYykKLQkJcmV0dXJu
IHJjOwotCiAJdHBtX3N5c2ZzX2FkZF9kZXZpY2UoY2hpcCk7CiAKIAl0cG1fYmlvc19sb2dfc2V0
dXAoY2hpcCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oIGIvZHJpdmVycy9j
aGFyL3RwbS90cG0uaAppbmRleCAyNGVlNGUxY2M0NTIuLjkxOWJiMGI4OGIxMiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3RwbS90cG0uaAorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oCkBA
IC0xOTAsNiArMTkwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHRwbV9tc2xlZXAodW5zaWduZWQg
aW50IGRlbGF5X21zZWMpCiAJCSAgICAgZGVsYXlfbXNlYyAqIDEwMDApOwogfTsKIAoraW50IHRw
bV9jaGlwX3N0YXJ0dXAoc3RydWN0IHRwbV9jaGlwICpjaGlwKTsKIGludCB0cG1fY2hpcF9zdGFy
dChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApOwogdm9pZCB0cG1fY2hpcF9zdG9wKHN0cnVjdCB0cG1f
Y2hpcCAqY2hpcCk7CiBzdHJ1Y3QgdHBtX2NoaXAgKnRwbV9maW5kX2dldF9vcHMoc3RydWN0IHRw
bV9jaGlwICpjaGlwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGRkYWYzNjJlNjJjMS4u
OTRhMmJmYjI0NGIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
CisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTExMjksNiArMTEyOSwx
MSBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHBt
X3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCS8qIElOVEVSUlVQVCBTZXR1cCAqLwogCWluaXRf
d2FpdHF1ZXVlX2hlYWQoJnByaXYtPnJlYWRfcXVldWUpOwogCWluaXRfd2FpdHF1ZXVlX2hlYWQo
JnByaXYtPmludF9xdWV1ZSk7CisKKwlyYyA9IHRwbV9jaGlwX3N0YXJ0dXAoY2hpcCk7CisJaWYg
KHJjKQorCQlnb3RvIG91dF9lcnI7CisKIAlpZiAoaXJxICE9IC0xKSB7CiAJCS8qCiAJCSAqIEJl
Zm9yZSBkb2luZyBpcnEgdGVzdGluZyBpc3N1ZSBhIGNvbW1hbmQgdG8gdGhlIFRQTSBpbiBwb2xs
aW5nIG1vZGUKLS0gCjIuMzYuMQoK
