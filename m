Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5363144D
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKTNcl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiKTNc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA824C;
        Sun, 20 Nov 2022 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951128; bh=4OA7IK6FYkk305Zhb0W1evKbz0zZ40AwmsMipD4BkLE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NSBTHCpbkjFFSJ2iELowShWXLJ/DsbOAcN5yzEAo+5jUsmHpdecwn/PEWEp1OZu7x
         +iZ9Dzon0CDxHEUAPQ5/wq95yje7yK1+Cy3BBC9vQuXdaVn3YrEJqQyJXgP9/S6wL6
         es5TT7Kk3kEZVBCG//62/vJk6p+9guMF+uozKh29uAyHjYy0V+VZTT0AEHOCzoxPgZ
         D8tBINVQEzOIHDGqVDgjx/YSXg1UitREpki5ezClrMiita84qYb5NTRwDJH8ourAgn
         XnHOArEWN433lxP1FtaT/ia5SgJnq3Za8Ej7t8AvrspcsVpjG/vkhdC4fp5kedAF/J
         Kmbj1Tp1/rnow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1onMmA3ACg-009RAT; Sun, 20
 Nov 2022 14:32:08 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 12/14] tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
Date:   Sun, 20 Nov 2022 14:31:32 +0100
Message-Id: <20221120133134.28926-13-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Y2Bn6bdeDl3t3/ithIn9bOFj1yJNMiWUB6ywXGw5LG20I8Pov/9
 QvJYibFa1pdIC3bTtDU+GUHDY24TPVfdTvJ506nTc9DYSqmXZ7vevwNzbaHLe4jtpG194c8
 mDP0STxKk2YNQE6Yb1aUsHsM6tN8ouuh8WkQD/JMwxUCIoJ3qGr2Epui3fgaG5ZilWW0boB
 ZCZ7Hn3YNez4hQeaejUyw==
UI-OutboundReport: notjunk:1;M01:P0:Nok8fe+gyn0=;mDY6JN+z9tqG7De91VyS9iEMns/
 gRYGlqR+3QOdsfOPZlj51R4mCZZ3gnl7iSQEVPvdA5JHovRI63axlIg/Dd8Zn+Yx+daiPwAUK
 HeHDGD6ymUE7r7YujIyVkNM9HUjoCQ6ketUoT4ytRki3qvgisQ6jHEaMfc9MXFHd7bVj2sMJ9
 sO5E2suzurAVEnhQD1Kz5qMcYTQmA0VCEuDxoyqYvDEjzQxcvG/wSV6MFc64UVOA0MTePtZEQ
 c2hTBnGXmvPHutIHBKuxg2Z1cfHmaF8DF/gFMHVLfO1YBvaMc3Uc313kt5KTDCFU2cejsxdxd
 B290wl5KsAXVVIGLDX8TFjnNYtwjmk3NW64Gzni8UVX49iLwx2zN6RbMSuAtqDwY6zTyJuJWE
 JjESKjwNswHIIeFSLTNPVW1BP2QEiqeYzubFxjT5jObf4j99adDrLY0cDWrvI082D7RXTA3s+
 LZ4khSBzcT3MK8pVu1wXxG7AI0gLv1y7Tav+O9IYhtlt3abCHluaLeUNNRIPori+v3/4z/cx7
 yA0H0gVqUdp2ZR/wNL01kExlP/AyxZHQlOQOcRmLe8JzSN+hbmpSxGj/a9gUvk5oxcXRTN2Sv
 iaX+BcYq6fHLE+OYrlz0miHQMpQgjO+9wMjIvT73GBblzARx4yXhVkiUa18+bNLRTNp9a9XYw
 Hit9BrdAquEehZKoQqKXqmZzhiIaVFe+Usca+m7AvuHvB0h3kIJwdmOEj+BMKelzGctTFeq1c
 hGe38Kuo4V7pzXuXk2mqv8gQesdCNGEQ/9Oe+2GvxCTDvIXKnqbjBQXNMxGnIEZnfxsWnSQwz
 B+KvkWWEaN73/eQfrrNG3C15YNkkOZqAGvUNamGXNjfkZmoDogVZgRxHpeC0AN53WbaklZuJ7
 DUpVv3zhD167/NxRthzyuGqxgU3yh5XbSI70YPjlKydB+w9BbZK172rNC5mVfkIi7RqAqWMIk
 bIVd8Q==
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
aGUgd3JpdGluZ3MgdG8gdGhlCnJlZ2lzdGVyIG1pZ2h0IG5vdCBoYXZlIGFueSBlZmZlY3QuCgpG
aXhlczogNDViYWExZDFmYTM5ICgidHBtX3RpczogUmUtZW5hYmxlIGludGVycnVwdHMgdXBvbiAo
UzMpIHJlc3VtZSIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDE5ICsr
KysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMg
Yi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDQzMTJjNWNjMTNkYS4uMjUx
NGU2MGY2Nzc4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisr
KyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTEyMjAsMjggKzEyMjAsMjcg
QEAgaW50IHRwbV90aXNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIAlzdHJ1Y3QgdHBtX2No
aXAgKmNoaXAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAlpbnQgcmV0OwogCisJcmV0ID0gdHBt
X3Rpc19yZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4g
cmV0OworCiAJaWYgKGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19JUlEpCiAJCXRwbV90aXNf
cmVlbmFibGVfaW50ZXJydXB0cyhjaGlwKTsKIAogCXJldCA9IHRwbV9wbV9yZXN1bWUoZGV2KTsK
IAlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCQlnb3RvIG91dDsKIAogCS8qCiAJICogVFBNIDEu
MiByZXF1aXJlcyBzZWxmLXRlc3Qgb24gcmVzdW1lLiBUaGlzIGZ1bmN0aW9uIGFjdHVhbGx5IHJl
dHVybnMKIAkgKiBhbiBlcnJvciBjb2RlIGJ1dCBmb3IgdW5rbm93biByZWFzb24gaXQgaXNuJ3Qg
aGFuZGxlZC4KIAkgKi8KLQlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikp
IHsKLQkJcmV0ID0gdHBtX3Rpc19yZXF1ZXN0X2xvY2FsaXR5KGNoaXAsIDApOwotCQlpZiAocmV0
IDwgMCkKLQkJCXJldHVybiByZXQ7Ci0KKwlpZiAoIShjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZM
QUdfVFBNMikpCiAJCXRwbTFfZG9fc2VsZnRlc3QoY2hpcCk7CitvdXQ6CisJdHBtX3Rpc19yZWxp
bnF1aXNoX2xvY2FsaXR5KGNoaXAsIDApOwogCi0JCXRwbV90aXNfcmVsaW5xdWlzaF9sb2NhbGl0
eShjaGlwLCAwKTsKLQl9Ci0KLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZ
TUJPTF9HUEwodHBtX3Rpc19yZXN1bWUpOwogI2VuZGlmCi0tIAoyLjM2LjEKCg==
