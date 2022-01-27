Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC949D7E6
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 03:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiA0COd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 21:14:33 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:49195 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232881AbiA0COb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 21:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1643249668;
        bh=f2+hKX7ZjpgXeWickBv9h0zklArTVddDzY2IvRqIHbA=;
        h=From:To:Cc:Subject:Date;
        b=KFBlfWSyQzjjiXFMmm1xwmq5u9uyKAxBcSOBYAJ8kirGC3rdzxmXFvbyrSlsKRWvZ
         gzZJuYgxuQI4zzUiL16WGpqVScgOOFazEFUYgmhtCmbbFZxV+uvmVpSvQO/wgQ6Yhg
         KnzTJiCj96D04Sy0MhlEvaiKlFV237V6Y//qAZfg=
X-QQ-FEAT: oHWrrGTW1dDsFGnIWaujQqI6HtP+N16t
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: OBvbJS/7aDyUH4zGt5t0a2JXRNroDbyKmBypMIgcvPnIsSvLP62QehXLRIY/E5
         JwD+KidU6kmNqCcTW0ijaiD56SiCrZQFbcUFGyQNlNcn10iX7n30N4aPcCGMLSOxQ/IpnkeznE1va
         XmFWDkmHAWt+3KUUYZPe94J4bfmXxCeudXBNGUp5AYUyORz30GfaGcUmZP++evvtY4ytfQJCRCrj/
         DL3zvhTY1piqOhnzeCzBaQWrmrtHxsKC2gKzKPuqaMLdhjw7nU5gp8A3130InztI4BwjtjQeFi/IM
         iWXRSUppJ7cPM8LbwqPb9pA/PPITeKGBU5Ohpjl7IITLnG0KBbBP22f9BFbJ89TXGB5239HupU/h3
         xGOrRVuRBtX8KOcd6o5iOXi0QWmvdVA3ReO0YcYgpmMvIqkddVuUbAhoDhY7ZjuuUjY5YkEorHj7M
         wS+LI9sKZnITvlkxuuYh80LKXMDTADvo34R3Wk2VJNK7R2zr8d5LAIWNBVW0rpvU6rRJmbA5g0/ZS
         g4PEa4tkVIvQHVmVFoSEmbsogAUgu2xHLiMosnbxQE2AUys1jWKxmgII3IWQXSPgkP3qNvdnUa25i
         /r9aRE9U3WZj+gR1wYbZCo+xsLJMHmluLBdWZz6ZYLP8/MzqYnCDEhNYSeCWSeLCQHF8PCIwzI9V7
         4i6P0AMAcyylEBEYMIgG9dxTzWSz/OhD5PKr5a4zDviNmJf+2vLp8affzeT0gTF8REQNrQg+szmO+
         espU81WQzOw94bUmnhkTlIIvg31wppp6MxxGxh+XOVUtYdVWhMm5hdZaqJ+rI5b03gSc0KfuSuYHD
         +tA7xaWy7eA/uCDP0SAnRwGEgCHQLtalYJVZreTKw2JafsF7gSGaUs8=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 39.149.171.117
X-QQ-STYLE: 
X-QQ-mid: webmail813t1643248745t8210637
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?TWltaSBab2hhcg==?=" <zohar@linux.ibm.com>
Cc:     "=?ISO-8859-1?B?cGF1bA==?=" <paul@paul-moore.com>,
        "=?ISO-8859-1?B?am1vcnJpcw==?=" <jmorris@namei.org>,
        "=?ISO-8859-1?B?c2VyZ2U=?=" <serge@hallyn.com>,
        "=?ISO-8859-1?B?bGludXgtaW50ZWdyaXR5?=" 
        <linux-integrity@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgtc2VjdXJpdHktbW9kdWxl?=" 
        <linux-security-module@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] integrity: check the return value of audit_log_start()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Thu, 27 Jan 2022 09:59:05 +0800
X-Priority: 3
Message-ID: <tencent_0685FF3C104366D05C368E2E0A88F043A507@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogWGlhb2tlIFdhbmcgPHhrZXJuZWwud2FuZ0Bmb3htYWlsLmNvbT4KCmF1ZGl0X2xv
Z19zdGFydCgpIHJldHVybnMgYXVkaXRfYnVmZmVyIHBvaW50ZXIgb24gc3VjY2VzcyBvciBO
VUxMIG9uCmVycm9yLCBzbyBpdCBpcyBiZXR0ZXIgdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1
ZSBvZiBpdC4KClNpZ25lZC1vZmYtYnk6IFhpYW9rZSBXYW5nIDx4a2VybmVsLndhbmdAZm94
bWFpbC5jb20+ClJldmlld2VkLWJ5OiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29t
PgotLS0KQ2hhbmdlbG9nczoKVjMgLT4gVjQ6IHVwZGF0ZSB0aGUgbWFpbCBsaXN0LgpWMiAt
PiBWMzogYWRkIHRoZSBSZXZpZXdlZC1ieSB0YWcuClYxIC0+IFYyOiBzaW1wbGlmeSB0aGUg
cGF0Y2guCnNlY3VyaXR5L2ludGVncml0eS9pbnRlZ3JpdHlfYXVkaXQuYyB8IDIgKysKMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2lu
dGVncml0eS9pbnRlZ3JpdHlfYXVkaXQuYyBiL3NlY3VyaXR5L2ludGVncml0eS9pbnRlZ3Jp
dHlfYXVkaXQuYwppbmRleCAyOTIyMDA1Li4wZWM1ZTRjIDEwMDY0NAotLS0gYS9zZWN1cml0
eS9pbnRlZ3JpdHkvaW50ZWdyaXR5X2F1ZGl0LmMKKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5
L2ludGVncml0eV9hdWRpdC5jCkBAIC00NSw2ICs0NSw4IEBAIHZvaWQgaW50ZWdyaXR5X2F1
ZGl0X21lc3NhZ2UoaW50IGF1ZGl0X21zZ25vLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQly
ZXR1cm47CiAKIAlhYiA9IGF1ZGl0X2xvZ19zdGFydChhdWRpdF9jb250ZXh0KCksIEdGUF9L
RVJORUwsIGF1ZGl0X21zZ25vKTsKKwlpZiAoIWFiKQorCQlyZXR1cm47CiAJYXVkaXRfbG9n
X2Zvcm1hdChhYiwgInBpZD0lZCB1aWQ9JXUgYXVpZD0ldSBzZXM9JXUiLAogCQkJIHRhc2tf
cGlkX25yKGN1cnJlbnQpLAogCQkJIGZyb21fa3VpZCgmaW5pdF91c2VyX25zLCBjdXJyZW50
X3VpZCgpKSwKLS0=

