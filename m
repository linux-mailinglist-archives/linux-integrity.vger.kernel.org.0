Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10734F7DDB
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiDGLVl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiDGLVb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 07:21:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CFC1959F4;
        Thu,  7 Apr 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649330355;
        bh=T86PXNHzUiQ9diUoGWfpe352m8YYGi+nE1MveqW7gqk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GyUAD+aPOXzYQpi+6xVupTHdKonp1XYCqXBTTIfjrGa8hmfsNLeAvrWn+rfYQEMXu
         2MTuJoDBX5TyHs/k6bLzz6yimvvt9FyfXdQ9lVZ52+jAbo00i2y76VIIr9Vl44tUhF
         paSe9xSf00EFN5LQSyuXFQlCZpONPdNaEyI5sUA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1nztIP0Wh0-012VMn; Thu, 07
 Apr 2022 13:19:15 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 0/5] Support TPM Reset GPIO
Date:   Thu,  7 Apr 2022 13:18:44 +0200
Message-Id: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:95WZG1t96y168i7Ni5zv4URToJsq22uNWbfzOa/k/DmPGbGAbVV
 8FPZgE5gaUmVlItiBPNzN1MvAGTflCpVpEPQaoyOZs85cKge/QK5M42aA2q5ofiZhf2rEbo
 koTwhjvTJz2f7uHduCQerLGBmRjly0KQIN9O/5DDR/9ymbhBDqRzRX5VeCQxgiUt3Wji1DO
 R6gc3FftnE5ZuJGxc64Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pJCiAE4wdF4=:XbDQRCnStVFNninZ09C8gJ
 DdsJ7T4Bm9ETEU/omEqkngygkV08REglcaOHUAkJJAloB+5FqwpMDVw+5btNmRrM5/j7cQ0qc
 xt9i0VIoL20m5GFFAu9Cxo0l+xWHuFPG40UDrpmdCsl6W1ZF9C5KcJhSeL6zVP3B3Hz3TYxTD
 2jQB21VaQgQhn838yNGLp8H/AmdiRh03GE6a6NpSdRtNo2CoobBUJTHk9UdNXOocFHHlX4ZBq
 2FAeR7mW/gXgziGMPzyUIy7Fe+J3XDEm1N4hW3b5Qgj0p1AGRFWS9m525sY5qdBOhWf+3Qa4l
 r2N2DicCIrT53dRIucUJgQsrq1OtoxhYsENuQpBwWprcI17CHF9yVh6p/3BNq/KMmfLOMZxQG
 TBImzpxHqoTxU8gzXoS5A5ZnW9czw+xq7LmfBS/f8/CKRj9eIUx3NcMHVeZixtgYhdnRE7TsA
 kYxJ18IfhiaPYhqxW5iECrFfT2oP1HrDD+N01hNCNj8Zu4jY2/kkn7dWt7jVmoim2qQY54AVR
 VtLR/Ax3YRXE+INY4CXgp3Zh5PgOHJrei8PwGlfxR9ExuxPErGLrlk/eYQaUR6zT/gTe/LMqA
 YJj579eB4QdtaJ1iSKzBjhbOxT6J3iuxmYxd12Fo888r6AoXtd900OYr9eLBj+EoQr+SS+hzg
 MZQKzMPAnTU2qHyX+rpYRBbsR5UvEw3u3Liu2R2tJPqdOPK9k5AtLuUhFafbR37PnioLG8k0Z
 QaSggrmLLp+D3/TRKrIAGFxkqONbgDfcDi6DXSI8B5ZRCSaQZkifEemvOGo31kPITwGePIXaf
 PDuYmFV89n7iq+Dr3T+pFR/V7Rs65/1hWc0sfPbwNfGmQPFdW10YdlTL4qpRNxFSU17nlptGI
 YDk1jGOf5wuCP+Meqz9TMkWIfZBGVcZJYsRzKJ4fIWIoV9DmhgVYl6Pr/ENxB04rwfZMuM6LP
 /u6Og50YshiFvHGSUcGBJapBoGrCPqZba7JLe5WjUmiJe06zFYJV6Er+2Erw8jj0/2H8b3lYN
 EJr6b7tSSEuztpGPdOhVa5HuB15psgoj3fjhm+coFzGDxaCdUP2V8BJ8QrIFYRRC6C2PP1Tj7
 wHYZTKsQZt2g+c=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SWYgdGhlIHN5c3RlbSBzdGFydHMgdXAgd2l0aCB0aGUgVFBNIGNoaXAgc3RpbGwgaW4gcmVzZXQg
dGhlIHByb2JlIHJvdXRpbmUKb2YgdGhlIHRwbS10aXMgZHJpdmVyIGZhaWxzIHdpdGggdGhlIGZv
bGxvd2luZyBlcnJvciBtZXNzYWdlOiAKCiJ0cG1fdGlzX3NwaTogcHJvYmUgb2Ygc3BpWC5ZIGZh
aWxlZCB3aXRoIGVycm9yIC0xMTAiCgpUaGUgcmVhc29uIGZvciB0aGlzIGVycm9yIGlzIGEgbWlz
c2luZyByZXNwb25zZSB0byB0aGUgZmlyc3QgY29tbWFuZCBzZW50CnRvIHRoZSBjaGlwIChUUE1f
RElEX1ZJRCkgYW5kIGEgZm9sbG93aW5nIHRpbWVvdXQuCgpXaXRoIHRoZSBTTEI5NjcwIHRoaXMg
aXNzdWUgY2FuIGJlIHRyaWdnZXJlZCBieSBzZXR0aW5nIHVwIGEgcGluIApjb25maWd1cmF0aW9u
IGluIGRldmljZSB0cmVlIHdpdGggdGhlIHJlc2V0IGxpbmUgc2V0dGluZyB0bwpCQ00yODM1X1BV
RF9ET1dOIChub3RlIHRoYXQgdGhlIHJlc2V0IHNpZ25hbCBmb3IgdGhlIFNMQjk2NzAgaXMgYWN0
aXZlCmxvdykuCgpUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCB0byBzZXQgdGhlIGNoaXAgb3V0
IG9mIHJlc2V0IGZyb20gd2l0aGluIHRoZSBUUE0KZHJpdmVyLgoKCkZvciB0aGlzIHJlYXNvbiB0
d28gbmV3IGNhbGxiYWNrcyBhcmUgaW50cm9kdWNlZCB0aGF0IGNhbiBvcHRpb25hbGx5IGJlCmlt
cGxlbWVudGVkIGJ5IGEgdHBtIHRpcyBkcml2ZXI6CgogICAgICAgIGludCAoKnVuc2V0X3Jlc2V0
KSAoc3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSk7CiAgICAgICAgaW50ICgqc2V0X3Jlc2V0KSAo
c3RydWN0IHRwbV90aXNfZGF0YSAqZGF0YSk7CgoKRnVuY3Rpb24gInVuc2V0X3Jlc2V0IiBpcyBj
YWxsZWQgZGlyZWN0bHkgYmVmb3JlIHRoZSBmaXJzdCBUUE0gY29tbWFuZCBpcwppc3N1ZWQuIEZ1
bmN0aW9uICJzZXRfcmVzZXQiIGlzIGNhbGxlZCBhdCBzeXN0ZW0gc2h1dGRvd24gZGlyZWN0bHkg
YWZ0ZXIKdGhlIFRQTTIgc2h1dGRvd24gY29tbWFuZC4gCgpCb3RoIGNhbGxiYWNrcyBhcmUgYWRk
ZWQgdG8gdGhlIHNldCBvZiB0cG1fdGlzX3BoeV9vcHMgZnVuY3Rpb25zLiBQYXRjaCA1Cm9mIHRo
aXMgc2VyaWVzIHByb3ZpZGVzIHRoZSBpbXBsZW1lbnRhdGlvbnMgZm9yIHRoZSBTTEI5NjcwLgoK
UGF0Y2ggMToKICBFeHRlbmQgc3RydWN0IHRwbV90aXNfcGh5X29wcyBieSB0aGUgb3B0aW9uYWwg
Y2FsbGJhY2tzICJzZXRfcmVzZXQiIGFuZAogICJ1bnNldF9yZXNldCIuIElmIGRlZmluZWQgY2Fs
bCAic2V0X3Jlc2V0IiBiZWZvcmUgdGhlIGZpcnN0IFRQTSBjb21tYW5kCiAgaXMgc2VudCBhbmQg
InVuc2V0X3Jlc2V0IiBhdCBzeXN0ZW0gc2h1dGRvd24gYWZ0ZXIgdGhlIFRQTTIgc2h1dGRvd24K
ICBjb21tYW5kLgoKUGF0Y2ggMjoKICBEb2N1bWVudCB0aGUgcHJvcGVydHkgInJlc2V0LWdwaW9z
IiBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSB3aGljaCBjYW4gYmUKICB1c2VkIHRvIHNwZWNpZnkg
dGhlIFRQTSBjaGlwcyByZXNldCBncGlvLgoKUGF0Y2ggMzoKICBJZiBhdmFpbGFibGUgZ2V0IHRo
ZSByZXNldCBncGlvIGFuZCBzdG9yZSBpdCBpbiB0aGUgdHBtX3Rpc19kYXRhCiAgc3RydWN0dXJl
LgoKUGF0Y2ggNDoKICBEZWNsYXJlIGZ1bmN0aW9ucyB0cG1fdGlzX3NwaV9mbG93X2NvbnRyb2ws
IHRwbV90aXNfc3BpX3JlYWRfYnl0ZXMgYW5kCiAgdHBtX3Rpc19zcGlfd3JpdGVfYnl0ZXMgYXMg
ZXh0ZXJuLiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIG9mIHRoZSBuZXh0CiAgcGF0Y2ggaW4gd2hp
Y2ggYSBjdXN0b20gcHJvYmUgZnVuY3Rpb24gZm9yIHRoZSBTTEI5NjcwIGlzIGltcGxlbWVudGVk
CiAgdGhhdCBpcyB1c2VkIHRvIGRlZmluZSBpdHMgb3duIHNldCBvZiB0cG1fdGlzX3BoeV9vcHMu
CgpQYXRjaCA1OgogIEltcGxlbWVudCB0aGUgInNldF9yZXNldCIgYW5kICJ1bnNldF9yZXNldCIg
Y2FsbGJhY2tzIGZvciB0aGUgU0xCOTY3MCBhbmQKICBhc3NpZ24gaXQgaW4gdGhlIHByb2JlIGZ1
bmN0aW9uLiBUaGUgU0xCOTY3MCBzcGVjaWZpYyBwYXJ0cyBhcmUgbW92ZWQKICBpbnRvIGFuIG93
biBmaWxlIHRvIHNlcGFyYXRlIGl0IGZyb20gdGhlIGdlbmVyaWMgY29kZSAoZm9yIG5vdyBJIG9w
dGVkCiAgbm90IHRvIHVzZSBhIGtlcm5lbCBjb25maWcgb3B0aW9uIGZvciB0aGUgU0xCOTY3MCBj
b2RlIGFzIGl0IGlzIHVzZWQgaW4KICBjYXNlIG9mIHRoZSBTUEkgQ1I1MCkuCgpUaGlzIHNlcmll
cyBoYXMgYmVlbiB0ZXN0ZWQgd2l0aCBhIFNMQjk2NzAuCgpMaW5vIFNhbmZpbGlwcG8gKDUpOgog
IHRwbTogYWRkIGZ1bmN0aW9ucyB0byBzZXQgYW5kIHVuc2V0IHRoZSB0cG0gY2hpcHMgcmVzZXQg
c3RhdGUKICBkdC1iaW5kaW5nczogdHBtOiBkb2N1bWVudCByZXNldCBncGlvIHByb3BlcnR5CiAg
dHBtOiB0cG1fdGlzOiBnZXQgb3B0aW9uYWxseSBkZWZpbmVkIHJlc2V0IGdwaW8KICB0cG06IHRw
bV90aXM6IG1ha2UgZnVuY3Rpb25zIGF2YWlsYWJsZSBmb3IgZXh0ZXJuYWwgbGlua2FnZQogIHRw
bTogdHBtX3Rpc19zcGlfc2xiXzk2NzA6IGltcGxlbWVudCBzZXRfcmVzZXQgYW5kIHVuc2V0X3Jl
c2V0CiAgICBmdW5jdGlvbnMKCiAuLi4vYmluZGluZ3Mvc2VjdXJpdHkvdHBtL3RwbV90aXNfc3Bp
LnR4dCAgICAgfCAgMiArCiBkcml2ZXJzL2NoYXIvdHBtL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICAgfCAgMSArCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgICAgICAgICAgICAgICAg
ICAgfCAgNSArKwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyAgICAgICAgICAgICAg
IHwgMjMgKysrKysrCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oICAgICAgICAgICAg
ICAgfCAgMyArCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfc3BpLmggICAgICAgICAgICAgICAg
fCAgOSArKwogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX3NwaV9tYWluLmMgICAgICAgICAgIHwg
MTYgKystLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX3NwaV9zbGI5NjcwLmMgICAgICAgIHwg
ODIgKysrKysrKysrKysrKysrKysrKwogOCBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NoYXIvdHBtL3Rw
bV90aXNfc3BpX3NsYjk2NzAuYwoKCmJhc2UtY29tbWl0OiBlZDQ2NDM1MjFlNmFmOGFiOGVkMWU0
Njc2MzBhODU4ODRkMjY5NmNmCi0tIAoyLjM1LjEKCg==
