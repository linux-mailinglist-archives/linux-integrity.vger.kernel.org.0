Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A94560D27
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiF2X1l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiF2X1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 19:27:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FA2558B;
        Wed, 29 Jun 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656545245;
        bh=o0C44923qTpK68+z577TDUD6416MfHxXXHwGvB8ySvI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fgNkEG16d5mUk2r2YeQsHTWM1ctILEQM04NnkKlnvzR0syPOp81aJdYx8fKcpUUAL
         Bbz2MvHQDT7Ha3Cl+/882oFbnBd/GNHlqJtp35s6cqErqhfIoVctIhH9FOrPThd7Dc
         QZOitoi5Iuf5Gi0EwdgyFh6ddlNEs1MHjEiB9Dkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1oBJe93Acj-00VBgs; Thu, 30
 Jun 2022 01:27:24 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v7 04/10] tpm, tmp_tis: Claim locality before writing interrupt registers
Date:   Thu, 30 Jun 2022 01:26:47 +0200
Message-Id: <20220629232653.1306735-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:HzRj5Rb2KA7Nu5VSQVaUmCPY8sGIHyFlrsjDdpV90jnEsvtYn01
 +rLxPPjeW3H5Q4fYCy/4jweYnDv0KQyPi7vzd7wWuWu2TYYlG1mjL4Gvhkvydy7J5Gl1qYV
 gmZgKQIIB9itEX5vnDZSyPQliUsXItSnUR0lNOWqFcyLwch/BUUMa3jY4R3k1nqVKuP6E8r
 V7Q5Ixwg2yRWA/HQ2hgvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeaggYm+1DE=:9OBtesXyF9wQ9o1wIITlyk
 FVPjw+xxyB3EzeTO6odteVyYTqBgDV1pMxWxOaByHXid5ZQySNmD09d/3jO43zC2hoTDsY9D/
 FDx/9YdIOzL3679UDVEuWjmR3Lsi44c2orrZBOLzc6+C1I8HUONWZYVjO5wPYNvGKdQWDQ14i
 6LMLwYgHuGQzQh4dwRSWF3ScMV/clTezkMqG0WIib5w30TCSaDLkHHgb8lsLFJAs/kW7i0tmC
 ZZnyfan3sthR6wnnL2AeLnfblu+bgjvpl1iKr0GdmxQMm36j7smqQnzYltN2BrzLgwcnP6AxA
 5CmckGY3RGujbd0w0McIGs8R8qGZooUm727viJGqbxF7ZKIM4sa4v0fsQmwEOY8UTZ2vC+I+7
 V0yetN67UW4Bgfv5axNvscqkcgqQOYyQQBjLlxpuNDA931jYFaWpr6bcqLdanTJvN9fniSKdo
 5d7IF7ZXaOTbbmG0FI9G0mBAYaDUxPnmmvz2wJTB/3bMcwhF5I0MdgANMewFhI5sDUZNlPpcZ
 Vl0y0iAZoH01pa9el7fzaQ2btnOaFIiOlWg+0yQFphHNkSwonakZ8aDVUVdgtj+ffONw5v+3a
 J0iWxEPAOReCQ1NVSdgtQCBbHZ9+jUMXx7h6ScLaKitU6PJP4wLT1TeuiCieuawuU3yGqbhGi
 G+9NojNf2R9eCWFFy62P5QWNf2Pf32iPxtbNZZ1jZpIny58Io//9ts90WwHNO0sryypgv4i5O
 +LKyPjyIbwRzMqhL877IlA3UiJPp4wVy0+Y+mqkePYyaID9qN8UR9Ga6mP5ikP+mnUkHg7Rtm
 XDxtVGRfMguUodVsibAHG97Il1otv9V9EImgCvYxmMEiZWSeCP/kGiYc37g5IX3a9d3xQ4M6A
 jhZz4plEt+KlWPaDXQdy119pczl7pu7FCl9k9CamlULJ+PfZRXdT1y8RfhIk0gSMaG69ATYRJ
 ZMheYx3E2Prira35dwv6F0JgCRH/wgAxpOCH4WXiQNh05v3ieUp7JZX0EzXtOOHSQpYDbnsOC
 t0aIuQYQNAJ9UVdpKxjV5EbvdoGaEoGT/vzIeGLpGrJ2wMXeg0od9AnVT9VVs/oHOFSXx84qr
 GNenFTpgls78BTQ5/D3xK2QLrPUkYUPjGdLnRLbQdupkdem0W9PE+xp1Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGQzMmU5M2M4NmY0OC4uMDlkOGYw
NGNiYzgxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc1NiwzMCArNzU2LDQ1IEBAIHN0
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
ZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KLS0gCjIuMjUuMQoK
