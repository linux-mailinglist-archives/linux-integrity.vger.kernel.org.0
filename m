Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34B2F8A5C
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Jan 2021 02:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbhAPBZW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 20:25:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:59515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbhAPBZR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 20:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610760217;
        bh=sU8YQsvbKQYhN/G29m61OE8y2Uu1LABcxzHXm0vxrvM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OYB0uL9XVIzz8IYa6FfGQuHpvegFVAlz9pZTr7zb1qkHDd+5xReB+RHvx9PEnR7aj
         3uKUIphAy+Y4ognsAnMeLzYNumIV8dNaVtwfOeeb0FoWAkxl91aGG7dxDUiaJLg5Vn
         P2PnilSXDQIixi3aYUGGuJo/hcKjrkE79jDTqe8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1lbIi42EDt-00aloa; Sat, 16
 Jan 2021 02:23:37 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 1/4] tpm: in case of error properly cleanup in tpmm_chip_alloc
Date:   Sat, 16 Jan 2021 02:22:38 +0100
Message-Id: <1610760161-21982-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XMRS6IV1vQAXXnwmkT5jix2/34hu6QM48KWS8YXNLuPRA5+WXe1
 v+n56Ee21NpJFMnVLGEpUZYG4FrtEShP0F0zo+7syBfd295zVQMOY5i8TaVnhG3ddDM1Pbn
 vxFY0/DqMoXIr9f9GSnSgMouJ2hdQlXtBE+H4h++PeMcF/hcDtODOfU6ER4FN4jSC722les
 PuWk4Yu8KjUZOnoqRmBOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:91VIO+yOdKk=:wicV/sFy5vMsPxMUDYzxIy
 oVvuYULW7atS3wRMVgHTkAofayl5wbvByUMzoWMAh6Md9I2Xa5YKNb+Pvay4YyeXIAHh7BFPx
 Nl+83xoYIXlwhiFQmHv+NtYAou1IDTKvVsgFQ2lJy0mpPnOU/iWHpKFWBFk7fxE8dpObxlOyJ
 M/k7trS5OBLdejay85IZpZB9QF9S2WwWpj3Fp5s9mz5AXapfVxSr/9Voi1EbwcNk+Xiv/xQ1h
 4R++vYuKmG4vpEw6YtTKPW2rS7KDceQvRlKvN/wqHuivVJLMUI2GsUyvHOjPms1pRvuYP0F/e
 V6iTRjPTz/GT0go3oNNQYrh52Xr2AhbDHC31J2OXRk3D056XYJJo+NNtHctOAV4qsWm5/hYfz
 nfKo7OXYfNL2muVyiPJxnE0jfFhEEUM2Ocwz5ebH/x/B+qA26uA/m51cb3y4qv944UmI0F4oZ
 HmjNcXy50PsYIc0Ust8ypmHJyvtT4+YnMdVklCncIOQ83/Nk6kj/FUHnc9HOiDw76ldWaHn2w
 gF0jweV+5eAupGWlQGkR0pg/TrB9cDQdDYn4EtCSRowdMhzFwbGmHLf8+tSFX8PRu8mzPJGbd
 Jv6F5BVAs0JIndLervTlVjb4IUNDAkeCKaaR/h2SB5YUUqJ/8qQjir0OH8gJrzxcUy7kfXklp
 lrAY8K9JGVOkS8yEGJwU7GkxTJhy/EoyCqyiTKomDMwic2rAdRL/MJH3tvDVZmxDgh0OnQYMa
 O8Uc1MnaeT2/+J1gM0eO1rcp4Z98gHGdF3xP9NHNZdWQeZFLV/OxYHtCPQ4wGPnegzaAETja7
 GYm14s9t3FmC4Giq+Y3BrRd147sK47NTLXPxOddaau7SeI+37Sym0nvbCJLt8b2ejD4TDypKg
 PzVXjh9VnPyN8dK8eG+Q==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbW1f
Y2hpcF9hbGxvYygpIGEgcmVzb3VyY2UgbWFuYWdlbWVudCBhY3Rpb24gaGFuZGxlciBpcyBpbnN0
YWxsZWQgdG8KcmVsZWFzZSB0aGUgY2hpcC0+ZGV2IGluIGNhc2Ugb2YgZXJyb3IuIFRoaXMgd2ls
bCByZXN1bHQgaW4gdGhlIGNoaXAgYmVpbmcKZnJlZWQgaWYgaXQgd2FzIHRoZSBsYXN0IHJlZmVy
ZW5jZS4gSWYgdGhlIGluc3RhbGxhdGlvbiBvZiB0aGUgaGFuZGxlciB3YXMKbm90IHN1Y2Nlc3Nm
dWwgYW4gZXJyb3IgaXMgcmV0dXJuZWQgdG8gdGhlIGNhbGxlci4KSG93ZXZlciBpbiB0aGlzIGNh
c2UgdGhlIGNoaXAtPmRldiByZWZlcmVuY2UgaXMgbm90IHB1dCBhbmQgdGh1cyB0aGUgY2hpcApp
cyBuZXZlciBmcmVlZC4gRml4IHRoaXMgYnkgcmVsZWFzaW5nIHRoZSByZWZlcmVuY2UgImJ5IGhh
bmQiIGluIGNhc2UgdGhhdAp0aGUgYWN0aW9uIGhhbmRsZXIgaW5zdGFsbGF0aW9uIGZhaWxlZC4K
ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+
Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbS1jaGlwLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMKaW5kZXgg
ZGRhZWNlYi4uZTI0MmQyZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5j
CisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYwpAQCAtNDIzLDExICs0MjMsMTUgQEAg
c3RydWN0IHRwbV9jaGlwICp0cG1tX2NoaXBfYWxsb2Moc3RydWN0IGRldmljZSAqcGRldiwKIAkJ
CQkgICAgICAodm9pZCAoKikodm9pZCAqKSkgcHV0X2RldmljZSwKIAkJCQkgICAgICAmY2hpcC0+
ZGV2KTsKIAlpZiAocmMpCi0JCXJldHVybiBFUlJfUFRSKHJjKTsKKwkJZ290byBwdXRfZGV2Owog
CiAJZGV2X3NldF9kcnZkYXRhKHBkZXYsIGNoaXApOwogCiAJcmV0dXJuIGNoaXA7CisKK3B1dF9k
ZXY6CisJcHV0X2RldmljZSgmY2hpcC0+ZGV2KTsKKwlyZXR1cm4gRVJSX1BUUihyYyk7CiB9CiBF
WFBPUlRfU1lNQk9MX0dQTCh0cG1tX2NoaXBfYWxsb2MpOwogCi0tIAoyLjcuNAoK
