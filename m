Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808EB54651F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348335AbiFJLJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348299AbiFJLJY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9814642D;
        Fri, 10 Jun 2022 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859346;
        bh=8pa7jmlaKih9YrYAMoxNaZ4QPmCYmk4V26CTRIglNhA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bSwRaHR586/m1GevqhL75iI+ujBW/f+Qho62120MsI46IzSmF7WT2qizxPIgoUWsy
         dB9XuBFuHOXL0dsV3vct/qFqU5j4xwXzLb788zN9aAhAW8D8KdPMPGjcyVyQyZjyhF
         NYlg/nYA5Lx5M9IwDpdiTyWWJBgKS43lMKgSh2hk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1nztED0Tpv-0020n7; Fri, 10
 Jun 2022 13:09:06 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 08/10] tpm, tpm_tis: Request threaded interrupt handler
Date:   Fri, 10 Jun 2022 13:08:44 +0200
Message-Id: <20220610110846.8307-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:V8BbFXXEchexOiGgDifqmFJO5c+ZfjhBgyOVfLvGI3Jop7tZA7S
 /9n1aO6Ae0L/iEXqIrJI5j0YQZicb743GM7rpdSeE2LuitpKwhZ5Fioop6mFwsg3XvH7ADP
 7piw+gvaZLsbMuEk9s59YPTbxx2lui2Q7LE1/CfbIyzUqvvsBfiQbiTQhaYE0nIAPK/Dc+E
 OJlBLSO9Btad+57sP0lOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wbm3A45bWdA=:Slu9pDXD1h6gIoApPQiRbx
 hEt9s++g1LT8l9m0HPDFkZSMSh2VLOSgxHBeej8F+3AhYwFw7cNIBVCeKYsmqhX40BFq+NxFy
 xGohHFan6E7SyL1ud7B6OK81PqJI/D0VQ6IqkfSMQHRcJC8LGl6IGbCqxNusHBofNClbKoFxk
 n5Kt4npdEsstwhDqxQERfWydCuAdvjolcYtUmka8+SbPiQzt43MRECgU3EvzgkPjjchp1Hpl5
 82CPcDuJEBUebzmznWLsvhlof7XOeAugEY4juIARMVNZtxTXWIZsHnOoRKvSB4LbeRjJkKYw1
 MLCWX8OFTOEkagEZ93IIpRYBdrbULKnit5NXp0+hD3mi5rrCo1FgVksuSYPyImc6CVtPaIQlm
 SXG1mVcaVWEZGsTVeQOK0QoLDRQsGs/+ytMm5n4uEjN3pKhcdtW0EfdnZlGXXPPcNIhKBk+ZX
 7Yrxq3pNoDKv0nmhU8OvDClMELfl5zx1ZE1gn6rr4FILNSn4kNT+n196ePKeX4HziAlrAvIxQ
 UT2WrBdvZoLn6CydfyHSBsPFf2/GAtMFGtRsVVdzKxh9xZbVcOo13mcpczlvojMbfXtebCNmW
 cX7E8yG5xSDHK3RFlg8GZUyh+yI4MgL8Wq9LKisyPk0BrkaP0lXloVnXZ4MHm0JgNiGV3Fyh6
 +Z5Fyo9bR1PsIdRcpSQpUzN/AQP+lJJhxwVtdGnURp59ptkTRsCUNMmj2L7b/S789qupfQiKJ
 20E4LINskVFQzccor/psdgbXksenzhH6wXyt6mZPVWH3GVxrbE+CeSVqpspHsiPYQfOGurs09
 ciJ1glUdAMfb2qYfF7dt0BrSbxeSoRBZGnzg6wYMoLhuYX7FU6O8uFwPRbTz5ofKfXK3lwDv9
 ++6cxnieAe7lof8HG+oEFD7UofKwC7ICANFE5a2n/yi41uOOoeSWtqF6qcVuhk35c2t7az3WX
 +jcRBLt5ljXOK5/oVEZRQgpH6cn2kBkFldhtrLM9Dbdc9VhB13Cf3KljMUT7NovJ3/873ljR5
 WkWOOpn7kRAzCNn3pvFpq84/+imT+Z8qexXzZCtd+klgp00DYVF2Ajm5sDj/2l9JoiNb6OhkD
 uixaOSZUPO2l5nhsE7iNK4AB4Oqtx3UhA5nFHvWgFSVirWtNgBZUSRexA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
cmVhZGVkIGludGVycnVwdCBoYW5kbGVyLgoKRml4ZXM6IDFhMzM5YjY1OGQ5ZCAoInRwbV90aXNf
c3BpOiBQYXNzIHRoZSBTUEkgSVJRIGRvd24gdG8gdGhlIGRyaXZlciIpClNpZ25lZC1vZmYtYnk6
IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCAw
ZWY3NDk3OWJjMmMuLjhiNWFhNGZkYmU5MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90
cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC03
OTQsOCArNzk0LDExIEBAIHN0YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0cnVj
dCB0cG1fY2hpcCAqY2hpcCwgdTMyIGludG1hc2ssCiAJaW50IHJjOwogCXUzMiBpbnRfc3RhdHVz
OwogCi0JaWYgKGRldm1fcmVxdWVzdF9pcnEoY2hpcC0+ZGV2LnBhcmVudCwgaXJxLCB0aXNfaW50
X2hhbmRsZXIsIGZsYWdzLAotCQkJICAgICBkZXZfbmFtZSgmY2hpcC0+ZGV2KSwgY2hpcCkgIT0g
MCkgeworCisJcmMgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGNoaXAtPmRldi5wYXJlbnQs
IGlycSwgTlVMTCwKKwkJCQkgICAgICAgdGlzX2ludF9oYW5kbGVyLCBJUlFGX09ORVNIT1QgfCBm
bGFncywKKwkJCQkgICAgICAgZGV2X25hbWUoJmNoaXAtPmRldiksIGNoaXApOworCWlmIChyYykg
ewogCQlkZXZfaW5mbygmY2hpcC0+ZGV2LCAiVW5hYmxlIHRvIHJlcXVlc3QgaXJxOiAlZCBmb3Ig
cHJvYmVcbiIsCiAJCQkgaXJxKTsKIAkJcmV0dXJuIC0xOwotLSAKMi4zNi4xCgo=
