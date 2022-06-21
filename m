Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53631553397
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiFUNeQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351464AbiFUNbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC62AE10;
        Tue, 21 Jun 2022 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655817937;
        bh=nG5TFXtaC8PNjcCZBi+MuXoKdmTiTe8KMPDK4ENUAc4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iMgMfSK2mXDNnkP+XMQ2NUuY3poFKmqCGW8Yr+3bBrD3YMRL+rFHKgtyfC/tgMdqa
         qp49iyRDMNH++hD3SuD+xDcPhwf2aYyZ8w7jv5nU01yoO6dw3/9u5shS0snhZrgUXR
         gNMFibTaRJ6pbwerhP+o39/Pot9npFmZwzg2+/lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1nf0R62K6r-012DYz; Tue, 21
 Jun 2022 15:25:37 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v6 4/9] tpm, tmp_tis: Claim locality before writing interrupt registers
Date:   Tue, 21 Jun 2022 15:24:42 +0200
Message-Id: <20220621132447.16281-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:09LnH54cpStXE0uTVUiQV6pfDV4LO4SkQhy0j666VacW70TuVE9
 KAkn8YYYXOBaH/wSS05mFd3JxVlYDVOc3xzYxnOq1SKi8zZjP4MOmsG1+s5WSbGRaiZpUA+
 wygqgZcfcCIi0zuxxoPkGyIXFXQgdYUbhtL+UwyYk+WNblb/vNaumCEL/Zf4tYTmQAtzxRv
 cFZ3HVzWsRWgVe3hXaYLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rv21BbkZ3Vw=:bNA5aVx3G6I9cguEHz5qj9
 vpYftr2YlA/UoZAFEP/wyvFTNLEiEHBDCkc9y/1tfKY/N3jdolOXf3hQU0A5FwzDje+u0JEMH
 0kunrtDu5JyfHBYGZlPXxRa7V9AcUsXApvJHv9z15EmTsikJVOiP3hRSSwzTxyaUfvDOWFWRd
 xI9m9aA/ttP5ORA0rFod4qHCke9dOyUMH0oDJ1lcNV3/mTwXZXEdhtTOQXjXJOrzc9Oda/F2J
 GudKVN3JqCmuoNu8dL827jBbWtg/nRrcR0UFTbzF/g1Ff2i3ffjlJzPolqloLRXGEIrBN9gn+
 aDwm+fvBK/m6zewIXTuae3svcSABJ1fOmHxhoJZAyPftfDsIRxEM5msbqDNJSAjyTUroaTtbH
 IRbRUIFcxfzU1Jl1pVFdYStwIdP0/lTaA7KttAn4BP+ganqVoTvrZJAhVfapbFTAKbLq6wwn6
 iGV14dyKc4px3TvGArp4QvBCt/RZeXzB90C0OhnLcj8/pB4iweVMdBieQxeiQ8t0vogrvr1PW
 GJgQPcDnxP5QuG9wgQp5zINosKDp8VvkpsAs9E+VSeAWGjF9hc+77JtinC3Yc4YlIcJ9Fdc8+
 1n4mKq8guGbD6ewkIOsEb7+llGoIkNRRK3j5OL1kv/VN/DzhIlLThPdKalXb9hQ4WBZE7o+8q
 k7OtDacirkB/nt++15c38TAW36f5koMSOH1rsnw3LrBymLeVOG93SeFPVZvL062QM7cYqMmuA
 FUTqYVT+OB19s8pQzUh5Q2p38G63DEzAkFsJIoiCNQ724eR1VyNuUM55O0gBbsSGhxD3wgP7G
 dJgL3Cx3vFf/fIQOIVRKTFxOKPnYeW26i6wyNgKk/w3TqQ2EhsDumlmnlRbnetDQN2m7LLFi6
 BHv7S+nBXCumONzPSYsJwWATD43xs3R78jdVqZoYqJTI3+hrGhyuWs2+P7iJeN0QkORe/Ohh6
 w9CbpW0Tuzyv0IWxQmOPyXZFgX2ogPEBWIJ0yh6WhSsvQkpOokpJPIhQz5GORvxJnBuPZH8sI
 3GcDhZg8vVf5WqozV1CdMevD6CD2woByZJnoyqijwIyHvRyTCAtWW/vPlCpYbjkTvzf0Qas9j
 FG8wVH2SYWlGhgGb2QQ1DpPHveQZFsQ/XBsM5HAOMccIf16JYR5pT0a+w==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcHJvYmVfc2luZ2xlX2lycSgpIGludGVycnVwdCByZWdpc3RlcnMgVFBNX0lOVF9WRUNUT1Is
ClRQTV9JTlRfU1RBVFVTIGFuZCBUUE1fSU5UX0VOQUJMRSBhcmUgbW9kaWZpZWQgdG8gc2V0dXAg
dGhlIGludGVycnVwdHMuCkN1cnJlbnRseSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBkb25lIHdp
dGhvdXQgaG9sZGluZyBhIGxvY2FsaXR5IHRodXMgdGhleQpoYXZlIG5vIGVmZmVjdC4gRml4IHRo
aXMgYnkgY2xhaW1pbmcgdGhlIChkZWZhdWx0KSBsb2NhbGl0eSBiZWZvcmUgdGhlCnJlZ2lzdGVy
cyBhcmUgd3JpdHRlbi4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxp
cHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJu
ZWwub3JnPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAyNSArKysrKysr
KysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
IGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBkMzJlOTNjODZmNDguLjA5
ZDhmMDRjYmM4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwor
KysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03NTYsMzAgKzc1Niw0NSBA
QCBzdGF0aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2NoaXAgKmNo
aXAsIHUzMiBpbnRtYXNrLAogCX0KIAlwcml2LT5pcnEgPSBpcnE7CiAKKwlyYyA9IHJlcXVlc3Rf
bG9jYWxpdHkoY2hpcCwgMCk7CisJaWYgKHJjIDwgMCkKKwkJcmV0dXJuIHJjOworCiAJcmMgPSB0
cG1fdGlzX3JlYWQ4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5KSwKIAkJCSAg
ICZvcmlnaW5hbF9pbnRfdmVjKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJcmVs
ZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9CiAK
IAlyYyA9IHRwbV90aXNfd3JpdGU4KHByaXYsIFRQTV9JTlRfVkVDVE9SKHByaXYtPmxvY2FsaXR5
KSwgaXJxKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJcmVsZWFzZV9sb2NhbGl0
eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9CiAKIAlyYyA9IHRwbV90
aXNfcmVhZDMyKHByaXYsIFRQTV9JTlRfU1RBVFVTKHByaXYtPmxvY2FsaXR5KSwgJmludF9zdGF0
dXMpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNlX2xvY2FsaXR5KGNo
aXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCS8qIENsZWFyIGFsbCBl
eGlzdGluZyAqLwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVTKHBy
aXYtPmxvY2FsaXR5KSwgaW50X3N0YXR1cyk7Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMgPCAwKSB7
CisJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwgcHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1cm4gcmM7
CisJfQogCiAJLyogVHVybiBvbiAqLwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9J
TlRfRU5BQkxFKHByaXYtPmxvY2FsaXR5KSwKIAkJCSAgICAgaW50bWFzayB8IFRQTV9HTE9CQUxf
SU5UX0VOQUJMRSk7Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMgPCAwKSB7CisJCXJlbGVhc2VfbG9j
YWxpdHkoY2hpcCwgcHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1cm4gcmM7CisJfQogCisJcmVsZWFz
ZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJY2xlYXJfYml0KFRQTV9USVNfSVJR
X1RFU1RFRCwgJnByaXYtPmZsYWdzKTsKIAogCS8qIEdlbmVyYXRlIGFuIGludGVycnVwdCBieSBo
YXZpbmcgdGhlIGNvcmUgY2FsbCB0aHJvdWdoIHRvCi0tIAoyLjM2LjEKCg==
