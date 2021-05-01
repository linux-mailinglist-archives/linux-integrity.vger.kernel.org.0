Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932637077F
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEAOCa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 10:02:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:52145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhEAOC2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619877687;
        bh=bdgo8J4TivRhaCR1yMOLb0GbU9YLD5pDkm2mF7GPaks=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FUnpwhDN0gy0rPzqdmRT8cm82auiNAPkUBlJrN7Al9fLpJEqrPPfRrM9s7zaqCVeA
         UyINw8uNkbl2askCsqW9QHmi6WSpD4/t9ko07je8Y9qkjs6wUy2plyI+yklz7utNaC
         JCOlBTLrggeon6DR6pO+2AYSxB5CPfMFybVEMKZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1m1XnY3dBy-00TFYd; Sat, 01
 May 2021 16:01:26 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v3 4/4] tpm: Only enable supported irqs
Date:   Sat,  1 May 2021 15:57:27 +0200
Message-Id: <20210501135727.17747-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:7jLZxRXA8T/g7l9AnnNL9N15FTgU/ED0fMkRffZPiEVIKMk8H6l
 4X2OqvLjhjaG6s6fkYNfNuWQww3zrkZzde7/xLfUaMhWVaAAMXPDnzgo4XjVsoY0kwMJfy0
 NH5GvynI8/dbk306ZAKprQ9K2YdEQMevdCHxvbCa2wfqCCSXJfS/eMjc4/wb3Ia9j+tZBsk
 7k0X1iOL+32wdxXWq78lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I/0z9n93ojk=:J5OZzIFHBaL8NZeZJPq1dZ
 3tQ3reOr3iY1hWsl1oOWQmxMqY0YfTbkogEN/dRtlI7uzyVGuXojb7CYV/dQlGUY9kfzKy0Z4
 F2XmICtP3T9B02wEdCk5yy0T/N5ELxdf0TSCtRToNJDpMbShdhBS7j9/bapJndZpLWzb8oZKg
 SG62ZTkrNYmp7bYlkOcg82WrvTYv9i4g8mYyByxUoWCpmL5wR0QOoK/Zqk0GSwVDFrUyTzJSx
 6ciZe1ibX/Uva6BTpR/At4WSqvY5SULs5s03vdH2dnqZJnfNacVjcH4fwjkD1OM90R8uC3aXn
 KtdW8HW/ow1HclaEK4kHrGi1N16GeykltbNvOp/50BgvAU+bzoiRpHvOHJPP14glhEJfq+2pD
 xW2HcEqzGiIc4GM9JvLIKN4aBfHYSbbUd+kDjjQxXw/i8USXIC057QMtTIyV6urwKRbCrqKhG
 WPpLRaRNVldBXbW60Mfq7lC8TgMglGuY5+x3yyAeF7Zvrc5O31vG1XxbaTva1kKXk+dfudZFT
 JSboEEjKeNoiNPhsIlKmWxUyKdBfECbDfsc3+3T9+IFZfJKwpe+7eITO304K5Xhl2jiy0tRul
 gr3WQek7A+WrLQzuRCnDmMM/trN+5OxK3z5/NA9F2+tggNP+YT20MkMmkRY5c7A6rdIJusB/e
 R4LFdR9bHKYNqo/ALK6hzHEO4qCcAnWRwyO4izQRktnb+OeI2HYbjxIQMZ/jXoOL6BYBpco6+
 51tmg5G8OD80Lt2vO4eh6HPW2YOrMH6LVlrmvJAikPAurrtEZezf0BKAXPmiUzm+2EDU7it8+
 Mj8Fogv4z00AXAgCLi42s/TXjt2J77/SKPF8A0EYGKYhxvP2bfRP/yt23N6rweuyHWw4LVgSp
 pWt+3y4i/rzYsF8Ox6QEV87X9qyIoEy4mzv3FA2s003PKKXeg03J0srjU9Jb+HP63ngONvduF
 /VluQqV/TZVyBc6TT2bCFvVKh6TWA4lvJ4eWuymkBZVOpK3PPdCWygAczxNlWyFvGMElS0xgE
 aDMef8KWJpXs/ac0D7ahZGcHh3rc1UIgPGxHltPTJemZZoTn0bUQR43IwnzdVKhijNv7kKzVe
 J+p2DT+zpKlyi2Lz1pWFFZ2fWwmF3qiFCIp/VOSK0tABB1ERTw9xZPWG5NoCp47NeLSi0ZPzZ
 XEGzMOduJhdlgqvfMtNksXx3a+e8xSrde3hLw43UuWV/9w8kuev6lQPynMs1A97DCcdyCZpUD
 2i7F79qOcEWbTzarb
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RG8gbm90IHNldCBpbnRlcnJ1cHRzIHdoaWNoIGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBoYXJk
d2FyZS4gSW5zdGVhZCB1c2UKdGhlIGluZm9ybWF0aW9uIGZyb20gdGhlIGNhcGFiaWxpdHkgcXVl
cnkgYW5kIGFjdGl2YXRlIG9ubHkgdGhlIHJlcG9ydGVkCmludGVycnVwdHMuCgpTaWduZWQtb2Zm
LWJ5OiBMaW5vIFNhbmZpbGlwcG8gPExpbm9TYW5maWxpcHBvQGdteC5kZT4KLS0tCiBkcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNjggKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgIDEgKwogMiBmaWxlcyBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlz
X2NvcmUuYwppbmRleCA5NjE1MjM0MDU0YWEuLjc1NzQ5OGE2M2Y1NyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90
aXNfY29yZS5jCkBAIC05MzYsMTMgKzkzNiw0NyBAQCBpbnQgdHBtX3Rpc19jb3JlX2luaXQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHBtX3Rpc19kYXRhICpwcml2LCBpbnQgaXJxLAogCWlm
IChyYykKIAkJZ290byBvdXRfZXJyOwogCisJLyogRmlndXJlIG91dCB0aGUgY2FwYWJpbGl0aWVz
ICovCisJcmMgPSB0cG1fdGlzX3JlYWQzMihwcml2LCBUUE1fSU5URl9DQVBTKHByaXYtPmxvY2Fs
aXR5KSwgJmludGZjYXBzKTsKKwlpZiAocmMgPCAwKQorCQlnb3RvIG91dF9lcnI7CisKKwlkZXZf
ZGJnKGRldiwgIlRQTSBpbnRlcmZhY2UgY2FwYWJpbGl0aWVzICgweCV4KTpcbiIsCisJCWludGZj
YXBzKTsKKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9CVVJTVF9DT1VOVF9TVEFUSUMpCisJCWRl
dl9kYmcoZGV2LCAiXHRCdXJzdCBDb3VudCBTdGF0aWNcbiIpOworCWlmIChpbnRmY2FwcyAmIFRQ
TV9JTlRGX0NNRF9SRUFEWV9JTlQpIHsKKwkJcHJpdi0+c3VwcG9ydGVkX2lycXMgfD0gVFBNX0lO
VEZfQ01EX1JFQURZX0lOVDsKKwkJZGV2X2RiZyhkZXYsICJcdENvbW1hbmQgUmVhZHkgSW50IFN1
cHBvcnRcbiIpOworCX0KKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9JTlRfRURHRV9GQUxMSU5H
KQorCQlkZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0IEVkZ2UgRmFsbGluZ1xuIik7CisJaWYgKGlu
dGZjYXBzICYgVFBNX0lOVEZfSU5UX0VER0VfUklTSU5HKQorCQlkZXZfZGJnKGRldiwgIlx0SW50
ZXJydXB0IEVkZ2UgUmlzaW5nXG4iKTsKKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9JTlRfTEVW
RUxfTE9XKQorCQlkZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0IExldmVsIExvd1xuIik7CisJaWYg
KGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0xFVkVMX0hJR0gpCisJCWRldl9kYmcoZGV2LCAiXHRJ
bnRlcnJ1cHQgTGV2ZWwgSGlnaFxuIik7CisJaWYgKGludGZjYXBzICYgVFBNX0lOVEZfTE9DQUxJ
VFlfQ0hBTkdFX0lOVCkgeworCQlwcml2LT5zdXBwb3J0ZWRfaXJxcyB8PSBUUE1fSU5URl9MT0NB
TElUWV9DSEFOR0VfSU5UOworCQlkZXZfZGJnKGRldiwgIlx0TG9jYWxpdHkgQ2hhbmdlIEludCBT
dXBwb3J0XG4iKTsKKwl9CisJaWYgKGludGZjYXBzICYgVFBNX0lOVEZfU1RTX1ZBTElEX0lOVCkg
eworCQlwcml2LT5zdXBwb3J0ZWRfaXJxcyB8PSBUUE1fSU5URl9TVFNfVkFMSURfSU5UOworCQlk
ZXZfZGJnKGRldiwgIlx0U3RzIFZhbGlkIEludCBTdXBwb3J0XG4iKTsKKwl9CisJaWYgKGludGZj
YXBzICYgVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQpIHsKKwkJcHJpdi0+c3VwcG9ydGVkX2lycXMg
fD0gVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQ7CisJCWRldl9kYmcoZGV2LCAiXHREYXRhIEF2YWls
IEludCBTdXBwb3J0XG4iKTsKKwl9CisKIAkvKiBUYWtlIGNvbnRyb2wgb2YgdGhlIFRQTSdzIGlu
dGVycnVwdCBoYXJkd2FyZSBhbmQgc2h1dCBpdCBvZmYgKi8KIAlyYyA9IHRwbV90aXNfcmVhZDMy
KHByaXYsIFRQTV9JTlRfRU5BQkxFKHByaXYtPmxvY2FsaXR5KSwgJmludG1hc2spOwogCWlmIChy
YyA8IDApCiAJCWdvdG8gb3V0X2VycjsKIAotCWludG1hc2sgfD0gVFBNX0lOVEZfQ01EX1JFQURZ
X0lOVCB8IFRQTV9JTlRGX0xPQ0FMSVRZX0NIQU5HRV9JTlQgfAotCQkgICBUUE1fSU5URl9EQVRB
X0FWQUlMX0lOVCB8IFRQTV9JTlRGX1NUU19WQUxJRF9JTlQ7CisJaW50bWFzayB8PSBwcml2LT5z
dXBwb3J0ZWRfaXJxczsKKwogCWludG1hc2sgJj0gflRQTV9HTE9CQUxfSU5UX0VOQUJMRTsKIAl0
cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9jYWxpdHkpLCBpbnRt
YXNrKTsKIApAQCAtOTcxLDMyICsxMDA1LDYgQEAgaW50IHRwbV90aXNfY29yZV9pbml0KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiwgaW50IGlycSwKIAkJZ290
byBvdXRfZXJyOwogCX0KIAotCS8qIEZpZ3VyZSBvdXQgdGhlIGNhcGFiaWxpdGllcyAqLwotCXJj
ID0gdHBtX3Rpc19yZWFkMzIocHJpdiwgVFBNX0lOVEZfQ0FQUyhwcml2LT5sb2NhbGl0eSksICZp
bnRmY2Fwcyk7Ci0JaWYgKHJjIDwgMCkKLQkJZ290byBvdXRfZXJyOwotCi0JZGV2X2RiZyhkZXYs
ICJUUE0gaW50ZXJmYWNlIGNhcGFiaWxpdGllcyAoMHgleCk6XG4iLAotCQlpbnRmY2Fwcyk7Ci0J
aWYgKGludGZjYXBzICYgVFBNX0lOVEZfQlVSU1RfQ09VTlRfU1RBVElDKQotCQlkZXZfZGJnKGRl
diwgIlx0QnVyc3QgQ291bnQgU3RhdGljXG4iKTsKLQlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9D
TURfUkVBRFlfSU5UKQotCQlkZXZfZGJnKGRldiwgIlx0Q29tbWFuZCBSZWFkeSBJbnQgU3VwcG9y
dFxuIik7Ci0JaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0VER0VfRkFMTElORykKLQkJZGV2
X2RiZyhkZXYsICJcdEludGVycnVwdCBFZGdlIEZhbGxpbmdcbiIpOwotCWlmIChpbnRmY2FwcyAm
IFRQTV9JTlRGX0lOVF9FREdFX1JJU0lORykKLQkJZGV2X2RiZyhkZXYsICJcdEludGVycnVwdCBF
ZGdlIFJpc2luZ1xuIik7Ci0JaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0xFVkVMX0xPVykK
LQkJZGV2X2RiZyhkZXYsICJcdEludGVycnVwdCBMZXZlbCBMb3dcbiIpOwotCWlmIChpbnRmY2Fw
cyAmIFRQTV9JTlRGX0lOVF9MRVZFTF9ISUdIKQotCQlkZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0
IExldmVsIEhpZ2hcbiIpOwotCWlmIChpbnRmY2FwcyAmIFRQTV9JTlRGX0xPQ0FMSVRZX0NIQU5H
RV9JTlQpCi0JCWRldl9kYmcoZGV2LCAiXHRMb2NhbGl0eSBDaGFuZ2UgSW50IFN1cHBvcnRcbiIp
OwotCWlmIChpbnRmY2FwcyAmIFRQTV9JTlRGX1NUU19WQUxJRF9JTlQpCi0JCWRldl9kYmcoZGV2
LCAiXHRTdHMgVmFsaWQgSW50IFN1cHBvcnRcbiIpOwotCWlmIChpbnRmY2FwcyAmIFRQTV9JTlRG
X0RBVEFfQVZBSUxfSU5UKQotCQlkZXZfZGJnKGRldiwgIlx0RGF0YSBBdmFpbCBJbnQgU3VwcG9y
dFxuIik7Ci0KIAkvKiBJTlRFUlJVUFQgU2V0dXAgKi8KIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZw
cml2LT5yZWFkX3F1ZXVlKTsKIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZwcml2LT5pbnRfcXVldWUp
OwpAQCAtMTA2Niw5ICsxMDc0LDcgQEAgc3RhdGljIHZvaWQgdHBtX3Rpc19yZWVuYWJsZV9pbnRl
cnJ1cHRzKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIAlpZiAocmMgPCAwKQogCQlnb3RvIG91dDsK
IAotCWludG1hc2sgfD0gVFBNX0lOVEZfQ01EX1JFQURZX0lOVAotCSAgICB8IFRQTV9JTlRGX0xP
Q0FMSVRZX0NIQU5HRV9JTlQgfCBUUE1fSU5URl9EQVRBX0FWQUlMX0lOVAotCSAgICB8IFRQTV9J
TlRGX1NUU19WQUxJRF9JTlQgfCBUUE1fR0xPQkFMX0lOVF9FTkFCTEU7CisJaW50bWFzayB8PSBw
cml2LT5zdXBwb3J0ZWRfaXJxcyB8IFRQTV9HTE9CQUxfSU5UX0VOQUJMRTsKIAogCXRwbV90aXNf
d3JpdGUzMihwcml2LCBUUE1fSU5UX0VOQUJMRShwcml2LT5sb2NhbGl0eSksIGludG1hc2spOwog
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIGIvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuaAppbmRleCBkYzVmOTJiMThkY2EuLjhmZjYyMjEzZDhmYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuaAorKysgYi9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCkBAIC04OSw2ICs4OSw3IEBAIHN0cnVjdCB0cG1fdGlz
X2RhdGEgewogCXUxNiBtYW51ZmFjdHVyZXJfaWQ7CiAJaW50IGxvY2FsaXR5OwogCWludCBpcnE7
CisJdW5zaWduZWQgaW50IHN1cHBvcnRlZF9pcnFzOwogCXVuc2lnbmVkIGludCBmbGFnczsKIAl2
b2lkIF9faW9tZW0gKmlsYl9iYXNlX2FkZHI7CiAJdTE2IGNsa3J1bl9lbmFibGVkOwotLSAKMi4z
MS4xCgo=
