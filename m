Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BED327D51
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhCALbY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 06:31:24 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:56024 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233665AbhCALbW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 06:31:22 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 1 Mar 2021 19:30:07
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Mon, 1 Mar 2021 19:30:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     kjlu@umn.edu, "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] tpm: Add missing check in tpm_inf_recv
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <YDy4d5qO8MrNwImx@kernel.org>
References: <20210228093230.5676-1-dinghao.liu@zju.edu.cn>
 <YDy4d5qO8MrNwImx@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <27a86b26.a0d3c.177ed8d77e0.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnrvA_0DxgiMXbAQ--.63402W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkLBlZdtSjhUQAAsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

CgomcXVvdDtKYXJra28gU2Fra2luZW4mcXVvdDsgJmx0O2phcmtrb0BrZXJuZWwub3JnJmd0O+WG
memBk++8mgo+IE9uIFN1biwgRmViIDI4LCAyMDIxIGF0IDA1OjMyOjMwUE0gKzA4MDAsIERpbmdo
YW8gTGl1IHdyb3RlOgo+ID4gVGhlIHVzZSBvZiB3YWl0KCkgaW4gdHBtX2luZl9yZWN2KCkgaXMg
YWxtb3N0IHRoZSBzYW1lLiBJdCdzIG9kZCB0aGF0Cj4gPiB3ZSBvbmx5IGNoZWNrIHRoZSByZXR1
cm4gdmFsdWUgYW5kIHRlcm1pbmF0ZSBleGVjdXRpb24gZmxvdyBvZiBvbmUgY2FsbC4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4g
Cj4gSXMgdGhlIHVuY2hlY2tlZCByZXR1cm4gdmFsdWUgb2Ygd2FpdCgpIHRoZSBwcm9ibGVtPyBJ
IGRvbid0IHNlZSB0aGUKPiBmdW5jdGlvbiBldmVuIG1lbnRpb25lZCBpbiB0aGUgZGVzY3JpcHRp
b24uCj4gCgpZZXMuIFRoaXMgaXNzdWUgaXMgcmVwb3J0ZWQgYnkgbXkgc3RhdGljIGFuYWx5c2lz
IHRvb2wuIEkgdGhpbmsgd2UKc2hvdWxkIHRyZWF0IHdhaXQoKSBlcXVhbGx5IGluIHRoaXMgZnVu
Y3Rpb24gKGNoZWNrIHRoZSByZXR1cm4gdmFsdWUKYW5kIHJldHVybiBhbiBlcnJvciBjb2RlIG9u
IGZhaWx1cmUpLiAKClJlZ2FyZHMsCkRpbmdoYW8K
