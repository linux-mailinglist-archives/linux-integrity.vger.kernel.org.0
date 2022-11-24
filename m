Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5F637AAB
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKXN5I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKXN4f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A90109581;
        Thu, 24 Nov 2022 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298170; bh=1jiHlANZ8thD5aPn63BXGYT+VamFBFNIAjBcdG+2s2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UOWVQLAEwRmAhazeSMBLFFnEeZy4gaNKKbQmhUqSmkj6Ds/Ve8rIw9q2g/zYhgyS4
         073XagHy1yL/rfdAnUv7rCaphbUI7buTJJQWBFr/+wjFBL0IGjG/vC/WwoHsNxDH7a
         IwMxByKnRINLR1UX/1aoCR6xfAtkAtvYxIFSAdX54CMYfF1qVQqe30y0u/1JPjNOBT
         h1OSSuf1GrbwBERkRaMAREm82q6wx3mKvQdIejQyuxyyKwtsL5chZexwF+HNYEvvHA
         ShZBo1Z2+XrNENaTX2Nts2UX0b0FdKTr1R8CVpsoO4g/JTxsuvl73DnsJPlYRrrSBz
         B0znFO4OCbJ0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1oqDQ72fZF-0081Ir; Thu, 24
 Nov 2022 14:56:10 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 02/14] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Thu, 24 Nov 2022 14:55:26 +0100
Message-Id: <20221124135538.31020-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:DZ1Si0DEmG0L5zHqGquL0G/lLXvo4a2ppnyqcfrgWJfcYCf7Evj
 S3kJKA7ORN7oi5wckuLKqgRyKtpzDQGPPW+gaaxPTAY/62eZs2hEzMb+LktxX5jXaPLZT7W
 4UsVNmm3BRmeZIBJvlTodcp32nv9qgYVmr4gNEhMO7lXPO288X73suCMIwKiacAY/U5o+kh
 zPPJe5zd2kaImK7yWj7JQ==
UI-OutboundReport: notjunk:1;M01:P0:+7AxXzLltVk=;pdVShctUccjd2fZJI04dQxP2BEN
 zjUxWppz68TTq2Cz61wHDjPFHD4XPz55tfD3UG72J3zU77dHfFGT+dRUwtk8G1HuLFGCtwdxv
 rnDwaBtx8+v/d9YRMH2yIavLhYVwyz79yreWrcHLjbhl217evFjHK2TPnfIb2iygOKTwbSqB3
 gIjAWOctPSohtyq7UZTc+aIKvbkz4ka8JhiolhwPltFnS14+0R9FalLo6c4AHztfDirVPPP+q
 3XKPa7L2TcL7RzzOsgBz5STmXEfgczQkl+GoxEaAsYbCDe+kJEdYXPpfsrRVDGb6s9ZdKjuvf
 dUY9/r+X7vvpfNN3bdFGaDuf9UXnD8QW2ombbj54EJRmdIhUefS0XQb4kL1N9F3eTal9VvGYh
 ao/RdyrE8U29s5yMOpEUZcGkLMvYnouTb/6CsxRpMEzbpPsL4QgEzhIwiqWkzCUwrnWYeQv/P
 87cVWPoRW8m5cf1Laionh8QUl3jg1Ns9Jlqd/50FxP60nTv6I1NWiNexDZLT2Fk1tzZWuI3ev
 3Z9PXh6GwfFvtkLTl0/ivZYqhOXWf4R26xRYNPNliZxdR65NCga85Sf5M7cVszBOoEIJbG/SJ
 /0/ANPdT4V/f49NCoYUfK4MDqqOQCLwAdMmrtxPuVKyDCxokyOJQtbayCcP17wFGnkGUiCClq
 Gbu23jugtQzzfPcOqs6YKarckYAzQVtLgldOhu+21u6bny5Z7I5FH22ykDwyLcpABdPuzHd2C
 TQnyaQvtTIcitTNeLnNCzmqbguAiDt4kCy4D5dZ42tKc3NCWZj+diZLHB/tJYpLEL5eirqHIJ
 1I/trltoN1ki/n1CTSX1nAXgHtBdPAWOcav2G09awz/owNnaswUcTDVBkZ3GvyRJHp6xw4u31
 2/+M63ZIFK1MCWe8xYE3n/Uc4IMb1cOjfCPcWFmwgkMzZh9z2arIynj7UvqKgjXVdJPVe8mdx
 3UG0DA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
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
