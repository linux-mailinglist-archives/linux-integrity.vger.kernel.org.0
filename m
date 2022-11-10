Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF36245B3
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKJP0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKJP01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23613FB99;
        Thu, 10 Nov 2022 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093944; bh=A5gzN4mXM9p6SpYjvt1lyWJmsiJr8fpb+zizXUo+H9o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aQYQBr00g43DpNg8GIwA7D2/ec+yjFMyRLzCm+1dyHU3YM9oMFDvnMJbcyYmVaaTe
         NKd82ePb0x8TE5kqri7H9vT5gHl2dwIayrPSBORsh9rlVJZ+dOuMq+95p4NR8BOuli
         j2IT7XWLWVLRmDDeR+wk248ITd1SXnVIqV9fICua/UX797eQV8ff3nGs1WY3aMqMSk
         Zj7mySuI85pKWf6KQgccM7oGv4jGiMzDZsC291lfZ5Nzkow8vDvvm9/qRrd+rEuTXc
         J1bL1DbRZzmEpWxMChFjbst3RkiPRkHUBAoKnmwAjUM4IVXB61DSpqxCza+TMXSEax
         ZA3RjYvCViOOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1p0Gqh0Zch-012mEg; Thu, 10
 Nov 2022 16:25:44 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 04/12] tpm, tmp_tis: Claim locality before writing interrupt registers
Date:   Thu, 10 Nov 2022 16:25:25 +0100
Message-Id: <20221110152533.24243-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9JTDDUP+gYrcmMFZPrNVpj07srKJyJojblE902lVdz7CnXEmkn+
 nwSSGUKFfFNIGWWHdG/A+jG73iZcg2QVhPYDse+9pAYnS5dzKw3RJ0n5Daa9UhOy5qQNWiy
 dRkUa41KJkfekRHGHGxb2nJS8pyEfuclc6/s9FVfjQ80KMDyoBkMcQMhGDWtEVEJEkAEmDY
 4bOJh2FDixzjOoNULIYtA==
UI-OutboundReport: notjunk:1;M01:P0:99nGA77ETq8=;zqPhrmF94xabbY0BG0vFtOY/9zR
 EaSOZO7cx8OzDNHXr0yxk97BnfJ/qYdiTyrSZw49oNEAVtXtyKjnJAiSr7zw/3FX6Neq0ZVXt
 fcOnE+J1+xfAmZwRz8sD8BEsD+EKZr1QttLMqari3wEb2lDHFV3FThxBkvXNbNl0AArvbMsn2
 e1B7XRgqgSF4GA+B/wM2f31zgVGiMUK+vhK/K8fYXy5mZOaEEEELeESxzCHIJIMXE0pGjxJ4T
 aTwC+4urnSbU0Ddoj5wpCSJccg2UOR/04yBkUPm3ViNiGR0scVQFzecmqUh7iKg4jgoNnlHj9
 8ZypagiW2DxybRrsP4DLedUZEBY58A0jfBRxBOx5Wwgo6x7rORZmzj6POgD/JxpYHxdQV5pMi
 8jClLjzZCIIA3HJaWvQKv8KSZWh7luuv60hyNa3LxVqRXbd5WHMdfgCqcrftTz+HIaBWyq9qN
 Pmi13NeT92C6b3Lm99IFfIetD3Efsv7fl4dHkpPleQQ8EnEbpQA77ri7jf3InnnQ1FMZRB1lf
 jqGhok366TmFHjX61vI+xkrYvClk5E8XCJ60Eur19udFw22QygiDCd0AJycNd0WjsYH5RML5c
 ZVRmApi2+ukLnb1WVB9LyjzC/e+nf5Epdhp/fKjX2bdscJyEr0yrQgZfqeP66Y5bH6bd90uL3
 dTkQxj8qdxwlyJJhAUyCNIl2p9eR1XcKHZ0rW8vnlaa9bLui5KbRA2BaROBmOtWyjWdE6mruB
 Upkj6Nz9VHv9YPlfQhYJcR5UaOLGCyaLpKPPlQyr7RS/iCDbP5VCCc//3XC1uji5L6Tq6TO1S
 S0XU1VzqXWREUIOTuq0kl8DhKFbJDn5KF5GcpECHeXqXKJxba/xINY2CnAG873tRVC5cQe8xU
 hlfH2PfcdiL8HraYnruGxbiKBM6NBcluYt1OuClTvzzSa5CyF/SUxV3tYU4Mk9zHGM4+9XbgU
 eJDBSYKRQyEOzADh8RyPU08Z2Fc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
ZWwub3JnPgpUZXN0ZWQtYnk6IE1pY2hhZWwgTmlld8O2aG5lciA8bGludXhAbW5pZXdvZWhuZXIu
ZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDI1ICsrKysrKysrKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDYwM2I4MmNhNTZkYS4uNTIyMDVh
MWZlZTllIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3MCwzMCArNzcwLDQ1IEBAIHN0
YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwg
dTMyIGludG1hc2ssCiAJfQogCXByaXYtPmlycSA9IGlycTsKIAorCXJjID0gcmVxdWVzdF9sb2Nh
bGl0eShjaGlwLCAwKTsKKwlpZiAocmMgPCAwKQorCQlyZXR1cm4gcmM7CisKIAlyYyA9IHRwbV90
aXNfcmVhZDgocHJpdiwgVFBNX0lOVF9WRUNUT1IocHJpdi0+bG9jYWxpdHkpLAogCQkJICAgJm9y
aWdpbmFsX2ludF92ZWMpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNl
X2xvY2FsaXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCXJj
ID0gdHBtX3Rpc193cml0ZTgocHJpdiwgVFBNX0lOVF9WRUNUT1IocHJpdi0+bG9jYWxpdHkpLCBp
cnEpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNlX2xvY2FsaXR5KGNo
aXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCXJjID0gdHBtX3Rpc19y
ZWFkMzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJpdi0+bG9jYWxpdHkpLCAmaW50X3N0YXR1cyk7
Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMgPCAwKSB7CisJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwg
cHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1cm4gcmM7CisJfQogCiAJLyogQ2xlYXIgYWxsIGV4aXN0
aW5nICovCiAJcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJpdi0+
bG9jYWxpdHkpLCBpbnRfc3RhdHVzKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJ
cmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9
CiAKIAkvKiBUdXJuIG9uICovCiAJcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9F
TkFCTEUocHJpdi0+bG9jYWxpdHkpLAogCQkJICAgICBpbnRtYXNrIHwgVFBNX0dMT0JBTF9JTlRf
RU5BQkxFKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJcmVsZWFzZV9sb2NhbGl0
eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9CiAKKwlyZWxlYXNlX2xv
Y2FsaXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsKIAljbGVhcl9iaXQoVFBNX1RJU19JUlFfVEVT
VEVELCAmcHJpdi0+ZmxhZ3MpOwogCiAJLyogR2VuZXJhdGUgYW4gaW50ZXJydXB0IGJ5IGhhdmlu
ZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KLS0gCjIuMzYuMQoK
