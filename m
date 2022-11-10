Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE676245B7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKJP0o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKJP02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21140915;
        Thu, 10 Nov 2022 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093946; bh=btC8dh3Dw+tNF4g/eehZF3VWk3cjhFERu/V5ftrirJU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KS4pwt5e7dF5v08WVnVrcx+livLGTde0Q8qRYi7YuKyWajffO3E0LyizhO/WuJuOJ
         2oMCxeFmLe7Q+A58SOsYlEAQRpL/thR4//cU1/tus8oB7ZKE+8pfAHA47qCqljnXZ4
         d9HOdXz6/6v/LyCsw1+TJf5H6A7mj8PL4tE4inpbUF1fenztDRtSzuxs/tN/4wRUKw
         yM9yXczC3A5ZllXUoB6exdBliS8WYFlUbU0ui3cIoia5pR525Y4poSLs8ipJZmUL2n
         NPrVfsquhc6VC2NGOt2+8frYuR6VfUm6GSGTGkj5t+LznYG7cBvzqjxChPWZzdk84+
         E1WNpRyhvievw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1pGQQI1UY0-00lWbB; Thu, 10
 Nov 2022 16:25:46 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 11/12] tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
Date:   Thu, 10 Nov 2022 16:25:32 +0100
Message-Id: <20221110152533.24243-12-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:A5G0ft3dSpBNzjqm1md9SHcjwaK4bKyVV/yoMeXJ+jVjZzq7VdY
 AuBcZPbCNhA4ddUre49DAerbGgjciksv0owtEqpPumDjCsPpptePlZ1fUTttnyiT5ifaKca
 2Li0xgq0PZQ4JGvhumjQexAzOMxv3eWVjmzCz8MqRDeYU8tb7knd4TZccFrt5fkker0DUv5
 7Za0l/odSyyJ/09Vgf5sw==
UI-OutboundReport: notjunk:1;M01:P0:BBiN0L+fq3M=;NOc00iAhdsZJs8odzXGACJWmRyp
 uCnsIirG2oEPjoP+q0V9qNUUy7S4JdiQt7HrLzPsL0X2yT2YTW8qG3BfUMAkeiGJLWzj7mASU
 AuVmRfBohZ/d/fGuOiPewkiawHyhcyMWSbT0KmmJh1N//pjqeciY8D02KEETJcG7kbJJpTGue
 8+gAMUQ8R2sMHMQDPN4FnwgzJIIrw/EmJ+KFN4JdM6ql6gJKYPJZwUpqhZ13PvmK8jc1zaSU6
 diVlB0KxgEZsey1OYionJAZ3XjcCNzEp7BHY6D/HW0YZ5Dbl9ugWr1jfxioQ0HEELhNGpVqrC
 MLmFUc7yzC0//NeNlmIUWGi5PAqsHofPevpOP8rGlNzFs5ZOM6N2jeBMeghhL/meQD9gPXx7T
 vS73n+cLJQ76ccWxbJhOoKjujbofhmSGkW1H2dF62UxB0X9EVqK12S6po5j1jQLPdbBQw4Xnp
 wFvUJNdWn+zmBjM9kE5BfQ3c2AxhjN2FVgN6d1Pocjs/PHLykwrCYAEOApKyDbH7gYlZ8e19t
 Mws4BAdFMQCtMObygTNAIzik+huYcBAjRc8KWsDwCdPwDn/ENfALXyqR9u8zlCpU1hEhjT3o4
 15v6uMwnEpDFqciHAuY74cuMzop2aif2FTviSK5pXGfkjRLtvukDY+Dy4SBFvMoTTBVuqaSH4
 TUeEV5tC9B1J40k0OHF45oh3KKrpxZ56rAWWx8jnT97qRyKas1MPba3ANWqbdwLdh8+y8gnbT
 KTL6Cs85zNaUw4Z2nnKy1cPhOV9jPHNr6uQop7fX0oN5lajOVSK+XD1qbFF01sNKW3Cnq65T4
 6PYF0SioAyxELoyfLOO6w42oojNq9tjJCXPx9cFsWEcAeotAzYOECP33Pe73YbR5OVPAHx0YF
 O/kHExO3eJwp0osupJ4WriN1/SNXWWE7PgxvQ3kMvmIaZPInYmz/K81ecxAIFws9fOp8fd5aG
 MrgduvusoZZxWhctZ3afVMlsZV0=
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
aXNfcmVzdW1lKCkgbWFrZSBzdXJlIHRoYXQgdGhlIGxvY2FsaXR5IGhhcyBiZWVuIGNsYWltZWQg
d2hlbgp0cG1fdGlzX3JlZW5hYmxlX2ludGVycnVwdHMoKSBpcyBjYWxsZWQuIE90aGVyd2lzZSB0
aGUgd3JpdGluZ3MgdG8gdGhlCnJlZ2lzdGVyIG1pZ2h0IG5vdCBoYXZlIGFueSBlZmZlY3QuCgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgot
LS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAxOSArKysrKysrKystLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFy
L3RwbS90cG1fdGlzX2NvcmUuYwppbmRleCBhMGExYjFhM2RkYzYuLjQ2OWExZGI5NTk0MSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5jCkBAIC0xMjQxLDI4ICsxMjQxLDI3IEBAIGludCB0cG1fdGlz
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IHRwbV9jaGlwICpjaGlwID0gZGV2
X2dldF9kcnZkYXRhKGRldik7CiAJaW50IHJldDsKIAorCXJldCA9IHRwbV90aXNfcmVxdWVzdF9s
b2NhbGl0eShjaGlwLCAwKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwogCWlmIChj
aGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKQogCQl0cG1fdGlzX3JlZW5hYmxlX2ludGVy
cnVwdHMoY2hpcCk7CiAKIAlyZXQgPSB0cG1fcG1fcmVzdW1lKGRldik7CiAJaWYgKHJldCkKLQkJ
cmV0dXJuIHJldDsKKwkJZ290byBvdXQ7CiAKIAkvKgogCSAqIFRQTSAxLjIgcmVxdWlyZXMgc2Vs
Zi10ZXN0IG9uIHJlc3VtZS4gVGhpcyBmdW5jdGlvbiBhY3R1YWxseSByZXR1cm5zCiAJICogYW4g
ZXJyb3IgY29kZSBidXQgZm9yIHVua25vd24gcmVhc29uIGl0IGlzbid0IGhhbmRsZWQuCiAJICov
Ci0JaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpKSB7Ci0JCXJldCA9IHRw
bV90aXNfcmVxdWVzdF9sb2NhbGl0eShjaGlwLCAwKTsKLQkJaWYgKHJldCA8IDApCi0JCQlyZXR1
cm4gcmV0OwotCisJaWYgKCEoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpKQogCQl0
cG0xX2RvX3NlbGZ0ZXN0KGNoaXApOworb3V0OgorCXRwbV90aXNfcmVsaW5xdWlzaF9sb2NhbGl0
eShjaGlwLCAwKTsKIAotCQl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxpdHkoY2hpcCwgMCk7Ci0J
fQotCi0JcmV0dXJuIDA7CisJcmV0dXJuIHJldDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHRwbV90
aXNfcmVzdW1lKTsKICNlbmRpZgotLSAKMi4zNi4xCgo=
