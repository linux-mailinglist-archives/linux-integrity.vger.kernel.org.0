Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F431D11D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 20:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBPToi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 14:44:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:36947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhBPTog (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 14:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613504568;
        bh=nWbcaKKehit077fdEvd5MGTgMvwfylN8XsUyrgaYfr4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K4cI19GxTgimj1UqvYnCP2JN3Cwh8tecnKDbAsc1+MKj4zBUblx2W2gBrqWlNrqQ3
         TyuWivxYZLL2WIyuXRR5Afn30iVYsKafaGEh9GENtatN4IwzuzPK2qNt7acdroZ/cO
         QFTzrK4eTJSlY96G3NIrMsFFfBUIntb/y+ho95Fk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1laPUu0T4y-00kKph; Tue, 16
 Feb 2021 20:42:48 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v5] The following sequence of operations results in a refcount warning:
Date:   Tue, 16 Feb 2021 20:42:12 +0100
Message-Id: <1613504532-4165-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613504532-4165-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1613504532-4165-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:7IlV/RCyAingVHmKH1Obv83nHNtZjgl2NnpVE4XyTpEfgUz3SfZ
 jJJwi1L7w5/nxRQwoKUkIJpo4koS9RwOV4nSGhU4BmeyiVEjxrjtC5bvE7psKRks1e6R9Rb
 qEnh6RHi18ay3iwGlcIzHM5ydcgZ6EGb5rh7TdTEd1JHEh6nQxJ9wLKUaEmEREJhErq9FTU
 KXvJCCOVJcNv6uX6U8ECQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0nBZU30zXoc=:yKGEEJYQkRkyySEkJLxDa5
 aCmfeHIxsrRdrZZfCOsTFsIxqO5RQZUcceiqx0AQJGx7yHLKn87UWVZxh47BGVRUOVaHRnb8/
 bMHwRDuITYa97SvhSRZ1yqVkIp5KX1sWf30CiX0VOyTeFBU8oouzsExVeQpJgUs3cCHcd/pu6
 zgXQ9yb6pHsPNAVqRHL+mfJ3CPxqxGWpPwqz5KPXWYPtdgUQMJU0w1/4EEusbivcepzyCHUmG
 +l0aAyyPTjlbFAEqUmoYblv65rsTmDgtyhjmsmVM1TwYcJe3mKpX/kTclS7Jx5LRoGrNvB9Vp
 B9aEZ0Fy162GEGBIUM+aZhJhQ5Pq78I8nn7zX2dd2XoqiF1k9Nz6YXINrX0xrNLF22+4Y4e59
 9vYmn7TH/KN15IMf+nR4PJWON08SnC3HR9zgfxIy6aq/Ydgi9brTYbYB8LbGLMZezuQcPVaNB
 t9Ertc2R1+87/Ixq5Yg4H2w+H3de0+bZg/S/zUICHeBOq+ZwNkVEWUk+UqevHHK6QA6V+8oIL
 6t/acAB2pLcf9ulhmqyG0C/kJOrjf1bSYZ2c78nrAe4Dc0+TJ1sYayndEMOpFwStRMpTi4aMo
 B/GL6NSx0xbNMge7pfsgQr1PADL8+sM5DxZqGzsePjMYdw73PtBxs2S7ZLhCtP4urBsjh3dwJ
 SlUbewJs0a7G6iTeY1+6FCpnMUdyX9SoE5swISpb9gUOJ500XlKInt8KhkMXLkQlSAQwI76Au
 NfZZT0r73BpHiHpASSchn4D07qJ+qKPsoHqCAEvgZkLllMhf8G801zgNLJ9jnaAG5Zq9h5U0U
 sFcFXwiWAtfxSlAaPLjeopUJT8oCwQOrFrkA8uHAyNIgB7EwxaByUwjUiFRmf2hNgGrq/ehbd
 K8kdjNZ8gTtrLt7tTbbg==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCjEuIE9wZW4g
ZGV2aWNlIC9kZXYvdHBtcm0uCjIuIFJlbW92ZSBtb2R1bGUgdHBtX3Rpc19zcGkuCjMuIFdyaXRl
IGEgVFBNIGNvbW1hbmQgdG8gdGhlIGZpbGUgZGVzY3JpcHRvciBvcGVuZWQgYXQgc3RlcCAxLgoK
LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCldBUk5JTkc6IENQVTogMyBQSUQ6
IDExNjEgYXQgbGliL3JlZmNvdW50LmM6MjUga29iamVjdF9nZXQrMHhhMC8weGE0CnJlZmNvdW50
X3Q6IGFkZGl0aW9uIG9uIDA7IHVzZS1hZnRlci1mcmVlLgpNb2R1bGVzIGxpbmtlZCBpbjogdHBt
X3Rpc19zcGkgdHBtX3Rpc19jb3JlIHRwbSBtZGlvX2JjbV91bmltYWMgYnJjbWZtYWMKc2hhMjU2
X2dlbmVyaWMgbGlic2hhMjU2IHNoYTI1Nl9hcm0gaGNpX3VhcnQgYnRiY20gYmx1ZXRvb3RoIGNm
ZzgwMjExIHZjNApicmNtdXRpbCBlY2RoX2dlbmVyaWMgZWNjIHNuZF9zb2NfY29yZSBjcmMzMl9h
cm1fY2UgbGliYWVzCnJhc3BiZXJyeXBpX2h3bW9uIGFjOTdfYnVzIHNuZF9wY21fZG1hZW5naW5l
IGJjbTI3MTFfdGhlcm1hbCBzbmRfcGNtCnNuZF90aW1lciBnZW5ldCBzbmQgcGh5X2dlbmVyaWMg
c291bmRjb3JlIFtsYXN0IHVubG9hZGVkOiBzcGlfYmNtMjgzNV0KQ1BVOiAzIFBJRDogMTE2MSBD
b21tOiBob2xkX29wZW4gTm90IHRhaW50ZWQgNS4xMC4wbHMtbWFpbi1kaXJ0eSAjMgpIYXJkd2Fy
ZSBuYW1lOiBCQ00yNzExCls8YzA0MTBjM2M+XSAodW53aW5kX2JhY2t0cmFjZSkgZnJvbSBbPGMw
NDBiNTgwPl0gKHNob3dfc3RhY2srMHgxMC8weDE0KQpbPGMwNDBiNTgwPl0gKHNob3dfc3RhY2sp
IGZyb20gWzxjMTA5MjE3ND5dIChkdW1wX3N0YWNrKzB4YzQvMHhkOCkKWzxjMTA5MjE3ND5dIChk
dW1wX3N0YWNrKSBmcm9tIFs8YzA0NDVhMzA+XSAoX193YXJuKzB4MTA0LzB4MTA4KQpbPGMwNDQ1
YTMwPl0gKF9fd2FybikgZnJvbSBbPGMwNDQ1YWE4Pl0gKHdhcm5fc2xvd3BhdGhfZm10KzB4NzQv
MHhiOCkKWzxjMDQ0NWFhOD5dICh3YXJuX3Nsb3dwYXRoX2ZtdCkgZnJvbSBbPGMwODQzNWQwPl0g
KGtvYmplY3RfZ2V0KzB4YTAvMHhhNCkKWzxjMDg0MzVkMD5dIChrb2JqZWN0X2dldCkgZnJvbSBb
PGJmMGE3MTVjPl0gKHRwbV90cnlfZ2V0X29wcysweDE0LzB4NTQgW3RwbV0pCls8YmYwYTcxNWM+
XSAodHBtX3RyeV9nZXRfb3BzIFt0cG1dKSBmcm9tIFs8YmYwYTdkNmM+XSAodHBtX2NvbW1vbl93
cml0ZSsweDM4LzB4NjAgW3RwbV0pCls8YmYwYTdkNmM+XSAodHBtX2NvbW1vbl93cml0ZSBbdHBt
XSkgZnJvbSBbPGMwNWE3YWMwPl0gKHZmc193cml0ZSsweGM0LzB4M2MwKQpbPGMwNWE3YWMwPl0g
KHZmc193cml0ZSkgZnJvbSBbPGMwNWE3ZWU0Pl0gKGtzeXNfd3JpdGUrMHg1OC8weGNjKQpbPGMw
NWE3ZWU0Pl0gKGtzeXNfd3JpdGUpIGZyb20gWzxjMDQwMDFhMD5dIChyZXRfZmFzdF9zeXNjYWxs
KzB4MC8weDRjKQpFeGNlcHRpb24gc3RhY2soMHhjMjI2YmZhOCB0byAweGMyMjZiZmYwKQpiZmEw
OiAgICAgICAgICAgICAgICAgICAwMDAwMDAwMCAwMDAxMDViNCAwMDAwMDAwMyBiZWFmZTY2NCAw
MDAwMDAxNCAwMDAwMDAwMApiZmMwOiAwMDAwMDAwMCAwMDAxMDViNCAwMDAxMDNmOCAwMDAwMDAw
NCAwMDAwMDAwMCAwMDAwMDAwMCBiNmY5YzAwMCBiZWFmZTY4NApiZmUwOiAwMDAwMDA2YyBiZWFm
ZTY0OCAwMDAxMDU2YyBiNmViNjk0NAotLS1bIGVuZCB0cmFjZSBkNGI4NDA5ZGVmOWI4YjFmIF0t
LS0KClRoZSByZWFzb24gZm9yIHRoaXMgd2FybmluZyBpcyB0aGUgYXR0ZW1wdCB0byBnZXQgdGhl
IGNoaXAtPmRldiByZWZlcmVuY2UKaW4gdHBtX2NvbW1vbl93cml0ZSgpIGFsdGhvdWdoIHRoZSBy
ZWZlcmVuY2UgY291bnRlciBpcyBhbHJlYWR5IHplcm8uCgpTaW5jZSBjb21taXQgODk3OWIwMmFh
ZjFkICgidHBtOiBGaXggcmVmZXJlbmNlIGNvdW50IHRvIG1haW4gZGV2aWNlIikgdGhlCmV4dHJh
IHJlZmVyZW5jZSB1c2VkIHRvIHByZXZlbnQgYSBwcmVtYXR1cmUgemVybyBjb3VudGVyIGlzIG5l
dmVyIHRha2VuLApiZWNhdXNlIHRoZSByZXF1aXJlZCBUUE1fQ0hJUF9GTEFHX1RQTTIgZmxhZyBp
cyBuZXZlciBzZXQuCgpGaXggdGhpcyBieSBtb3ZpbmcgdGhlIFRQTSAyIGNoYXJhY3RlciBkZXZp
Y2UgaGFuZGxpbmcgZnJvbQp0cG1fY2hpcF9hbGxvYygpIHRvIHRwbV9hZGRfY2hhcl9kZXZpY2Uo
KSB3aGljaCBpcyBjYWxsZWQgYXQgYSBsYXRlciBwb2ludAppbiB0aW1lIHdoZW4gdGhlIGZsYWcg
aGFzIGJlZW4gc2V0IGluIGNhc2Ugb2YgVFBNMi4KCkNvbW1pdCBmZGM5MTVmN2Y3MTkgKCJ0cG06
IGV4cG9zZSBzcGFjZXMgdmlhIGEgZGV2aWNlIGxpbmsgL2Rldi90cG1ybTxuPiIpCmFscmVhZHkg
aW50cm9kdWNlZCBmdW5jdGlvbiB0cG1fZGV2c19yZWxlYXNlKCkgdG8gcmVsZWFzZSB0aGUgZXh0
cmEKcmVmZXJlbmNlIGJ1dCBkaWQgbm90IGltcGxlbWVudCB0aGUgcmVxdWlyZWQgcHV0IG9uIGNo
aXAtPmRldnMgdGhhdCByZXN1bHRzCmluIHRoZSBjYWxsIG9mIHRoaXMgZnVuY3Rpb24uCgpGaXgg
dGhpcyBieSBwdXR0aW5nIGNoaXAtPmRldnMgaW4gdHBtX2NoaXBfdW5yZWdpc3RlcigpLgoKRmlu
YWxseSBtb3ZlIHRoZSBuZXcgaW1wbGVtZW50YXRpb24gZm9yIHRoZSBUUE0gMiBoYW5kbGluZyBp
bnRvIGEgbmV3CmZ1bmN0aW9uIHRvIGF2b2lkIG11bHRpcGxlIGNoZWNrcyBmb3IgdGhlIFRQTV9D
SElQX0ZMQUdfVFBNMiBmbGFnIGluIHRoZQpnb29kIGNhc2UgYW5kIGVycm9yIGNhc2VzLgoKQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IGZkYzkxNWY3ZjcxOSAoInRwbTogZXhwb3Nl
IHNwYWNlcyB2aWEgYSBkZXZpY2UgbGluayAvZGV2L3RwbXJtPG4+IikKRml4ZXM6IDg5NzliMDJh
YWYxZCAoInRwbTogRml4IHJlZmVyZW5jZSBjb3VudCB0byBtYWluIGRldmljZSIpCkNvLWRldmVs
b3BlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+ClNpZ25lZC1vZmYtYnk6IEph
c29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlw
cG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtLWNo
aXAuYyAgIHwgNDggKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
ZHJpdmVycy9jaGFyL3RwbS90cG0uaCAgICAgICAgfCAgMSArCiBkcml2ZXJzL2NoYXIvdHBtL3Rw
bTItc3BhY2UuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDMgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jIGIvZHJpdmVycy9jaGFyL3Rw
bS90cG0tY2hpcC5jCmluZGV4IGRkYWVjZWIuLmExZmRhMGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtLWNoaXAuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMKQEAg
LTI3NCwxNCArMjc0LDYgQEAgc3RhdGljIHZvaWQgdHBtX2Rldl9yZWxlYXNlKHN0cnVjdCBkZXZp
Y2UgKmRldikKIAlrZnJlZShjaGlwKTsKIH0KIAotc3RhdGljIHZvaWQgdHBtX2RldnNfcmVsZWFz
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCi17Ci0Jc3RydWN0IHRwbV9jaGlwICpjaGlwID0gY29udGFp
bmVyX29mKGRldiwgc3RydWN0IHRwbV9jaGlwLCBkZXZzKTsKLQotCS8qIHJlbGVhc2UgdGhlIG1h
c3RlciBkZXZpY2UgcmVmZXJlbmNlICovCi0JcHV0X2RldmljZSgmY2hpcC0+ZGV2KTsKLX0KLQog
LyoqCiAgKiB0cG1fY2xhc3Nfc2h1dGRvd24oKSAtIHByZXBhcmUgdGhlIFRQTSBkZXZpY2UgZm9y
IGxvc3Mgb2YgcG93ZXIuCiAgKiBAZGV2OiBkZXZpY2UgdG8gd2hpY2ggdGhlIGNoaXAgaXMgYXNz
b2NpYXRlZC4KQEAgLTM0NCw3ICszMzYsNiBAQCBzdHJ1Y3QgdHBtX2NoaXAgKnRwbV9jaGlwX2Fs
bG9jKHN0cnVjdCBkZXZpY2UgKnBkZXYsCiAJY2hpcC0+ZGV2X251bSA9IHJjOwogCiAJZGV2aWNl
X2luaXRpYWxpemUoJmNoaXAtPmRldik7Ci0JZGV2aWNlX2luaXRpYWxpemUoJmNoaXAtPmRldnMp
OwogCiAJY2hpcC0+ZGV2LmNsYXNzID0gdHBtX2NsYXNzOwogCWNoaXAtPmRldi5jbGFzcy0+c2h1
dGRvd25fcHJlID0gdHBtX2NsYXNzX3NodXRkb3duOwpAQCAtMzUyLDM5ICszNDMsMjAgQEAgc3Ry
dWN0IHRwbV9jaGlwICp0cG1fY2hpcF9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpwZGV2LAogCWNoaXAt
PmRldi5wYXJlbnQgPSBwZGV2OwogCWNoaXAtPmRldi5ncm91cHMgPSBjaGlwLT5ncm91cHM7CiAK
LQljaGlwLT5kZXZzLnBhcmVudCA9IHBkZXY7Ci0JY2hpcC0+ZGV2cy5jbGFzcyA9IHRwbXJtX2Ns
YXNzOwotCWNoaXAtPmRldnMucmVsZWFzZSA9IHRwbV9kZXZzX3JlbGVhc2U7Ci0JLyogZ2V0IGV4
dHJhIHJlZmVyZW5jZSBvbiBtYWluIGRldmljZSB0byBob2xkIG9uCi0JICogYmVoYWxmIG9mIGRl
dnMuICBUaGlzIGhvbGRzIHRoZSBjaGlwIHN0cnVjdHVyZQotCSAqIHdoaWxlIGNkZXZzIGlzIGlu
IHVzZS4gIFRoZSBjb3JyZXNwb25kaW5nIHB1dAotCSAqIGlzIGluIHRoZSB0cG1fZGV2c19yZWxl
YXNlIChUUE0yIG9ubHkpCi0JICovCi0JaWYgKGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19U
UE0yKQotCQlnZXRfZGV2aWNlKCZjaGlwLT5kZXYpOwotCiAJaWYgKGNoaXAtPmRldl9udW0gPT0g
MCkKIAkJY2hpcC0+ZGV2LmRldnQgPSBNS0RFVihNSVNDX01BSk9SLCBUUE1fTUlOT1IpOwogCWVs
c2UKIAkJY2hpcC0+ZGV2LmRldnQgPSBNS0RFVihNQUpPUih0cG1fZGV2dCksIGNoaXAtPmRldl9u
dW0pOwogCi0JY2hpcC0+ZGV2cy5kZXZ0ID0KLQkJTUtERVYoTUFKT1IodHBtX2RldnQpLCBjaGlw
LT5kZXZfbnVtICsgVFBNX05VTV9ERVZJQ0VTKTsKLQogCXJjID0gZGV2X3NldF9uYW1lKCZjaGlw
LT5kZXYsICJ0cG0lZCIsIGNoaXAtPmRldl9udW0pOwogCWlmIChyYykKIAkJZ290byBvdXQ7Ci0J
cmMgPSBkZXZfc2V0X25hbWUoJmNoaXAtPmRldnMsICJ0cG1ybSVkIiwgY2hpcC0+ZGV2X251bSk7
Ci0JaWYgKHJjKQotCQlnb3RvIG91dDsKIAogCWlmICghcGRldikKIAkJY2hpcC0+ZmxhZ3MgfD0g
VFBNX0NISVBfRkxBR19WSVJUVUFMOwogCiAJY2Rldl9pbml0KCZjaGlwLT5jZGV2LCAmdHBtX2Zv
cHMpOwotCWNkZXZfaW5pdCgmY2hpcC0+Y2RldnMsICZ0cG1ybV9mb3BzKTsKIAljaGlwLT5jZGV2
Lm93bmVyID0gVEhJU19NT0RVTEU7Ci0JY2hpcC0+Y2RldnMub3duZXIgPSBUSElTX01PRFVMRTsK
IAogCXJjID0gdHBtMl9pbml0X3NwYWNlKCZjaGlwLT53b3JrX3NwYWNlLCBUUE0yX1NQQUNFX0JV
RkZFUl9TSVpFKTsKIAlpZiAocmMpIHsKQEAgLTM5Niw3ICszNjgsNiBAQCBzdHJ1Y3QgdHBtX2No
aXAgKnRwbV9jaGlwX2FsbG9jKHN0cnVjdCBkZXZpY2UgKnBkZXYsCiAJcmV0dXJuIGNoaXA7CiAK
IG91dDoKLQlwdXRfZGV2aWNlKCZjaGlwLT5kZXZzKTsKIAlwdXRfZGV2aWNlKCZjaGlwLT5kZXYp
OwogCXJldHVybiBFUlJfUFRSKHJjKTsKIH0KQEAgLTQ0NSwxNCArNDE2LDkgQEAgc3RhdGljIGlu
dCB0cG1fYWRkX2NoYXJfZGV2aWNlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKIAl9CiAKIAlpZiAo
Y2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpIHsKLQkJcmMgPSBjZGV2X2RldmljZV9h
ZGQoJmNoaXAtPmNkZXZzLCAmY2hpcC0+ZGV2cyk7Ci0JCWlmIChyYykgewotCQkJZGV2X2Vycigm
Y2hpcC0+ZGV2cywKLQkJCQkidW5hYmxlIHRvIGNkZXZfZGV2aWNlX2FkZCgpICVzLCBtYWpvciAl
ZCwgbWlub3IgJWQsIGVycj0lZFxuIiwKLQkJCQlkZXZfbmFtZSgmY2hpcC0+ZGV2cyksIE1BSk9S
KGNoaXAtPmRldnMuZGV2dCksCi0JCQkJTUlOT1IoY2hpcC0+ZGV2cy5kZXZ0KSwgcmMpOwotCQkJ
cmV0dXJuIHJjOwotCQl9CisJCXJjID0gdHBtMl9hZGRfZGV2aWNlKGNoaXApOworCQlpZiAocmMp
CisJCQlnb3RvIGRlbF9jZGV2OwogCX0KIAogCS8qIE1ha2UgdGhlIGNoaXAgYXZhaWxhYmxlLiAq
LwpAQCAtNDYwLDYgKzQyNiwxMCBAQCBzdGF0aWMgaW50IHRwbV9hZGRfY2hhcl9kZXZpY2Uoc3Ry
dWN0IHRwbV9jaGlwICpjaGlwKQogCWlkcl9yZXBsYWNlKCZkZXZfbnVtc19pZHIsIGNoaXAsIGNo
aXAtPmRldl9udW0pOwogCW11dGV4X3VubG9jaygmaWRyX2xvY2spOwogCisJcmV0dXJuIDA7CisK
K2RlbF9jZGV2OgorCWNkZXZfZGV2aWNlX2RlbCgmY2hpcC0+Y2RldiwgJmNoaXAtPmRldik7CiAJ
cmV0dXJuIHJjOwogfQogCkBAIC02NDAsOCArNjEwLDEwIEBAIHZvaWQgdHBtX2NoaXBfdW5yZWdp
c3RlcihzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAJaWYgKElTX0VOQUJMRUQoQ09ORklHX0hXX1JB
TkRPTV9UUE0pKQogCQlod3JuZ191bnJlZ2lzdGVyKCZjaGlwLT5od3JuZyk7CiAJdHBtX2Jpb3Nf
bG9nX3RlYXJkb3duKGNoaXApOwotCWlmIChjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBN
MikKKwlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpIHsKIAkJY2Rldl9kZXZp
Y2VfZGVsKCZjaGlwLT5jZGV2cywgJmNoaXAtPmRldnMpOworCQlwdXRfZGV2aWNlKCZjaGlwLT5k
ZXZzKTsKKwl9CiAJdHBtX2RlbF9jaGFyX2RldmljZShjaGlwKTsKIH0KIEVYUE9SVF9TWU1CT0xf
R1BMKHRwbV9jaGlwX3VucmVnaXN0ZXIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90
cG0uaCBiL2RyaXZlcnMvY2hhci90cG0vdHBtLmgKaW5kZXggOTQ3ZDFkYi4uYWE5M2FmNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0uaAorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3Rw
bS5oCkBAIC0yMzgsNiArMjM4LDcgQEAgaW50IHRwbTJfcHJlcGFyZV9zcGFjZShzdHJ1Y3QgdHBt
X2NoaXAgKmNoaXAsIHN0cnVjdCB0cG1fc3BhY2UgKnNwYWNlLCB1OCAqY21kLAogCQkgICAgICAg
c2l6ZV90IGNtZHNpeik7CiBpbnQgdHBtMl9jb21taXRfc3BhY2Uoc3RydWN0IHRwbV9jaGlwICpj
aGlwLCBzdHJ1Y3QgdHBtX3NwYWNlICpzcGFjZSwgdm9pZCAqYnVmLAogCQkgICAgICBzaXplX3Qg
KmJ1ZnNpeik7CitpbnQgdHBtMl9hZGRfZGV2aWNlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCk7CiAK
IHZvaWQgdHBtX2Jpb3NfbG9nX3NldHVwKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCk7CiB2b2lkIHRw
bV9iaW9zX2xvZ190ZWFyZG93bihzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApOwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jaGFyL3RwbS90cG0yLXNwYWNlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3Bh
Y2UuYwppbmRleCA3ODRiOGIzLi45NmIyYTRiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBt
L3RwbTItc3BhY2UuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYwpAQCAtNTcx
LDMgKzU3MSw1MSBAQCBpbnQgdHBtMl9jb21taXRfc3BhY2Uoc3RydWN0IHRwbV9jaGlwICpjaGlw
LCBzdHJ1Y3QgdHBtX3NwYWNlICpzcGFjZSwKIAlkZXZfZXJyKCZjaGlwLT5kZXYsICIlczogZXJy
b3IgJWRcbiIsIF9fZnVuY19fLCByYyk7CiAJcmV0dXJuIHJjOwogfQorCitzdGF0aWMgdm9pZCB0
cG1fZGV2c19yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgdHBtX2NoaXAg
KmNoaXAgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1Y3QgdHBtX2NoaXAsIGRldnMpOworCisJLyog
cmVsZWFzZSB0aGUgbWFzdGVyIGRldmljZSByZWZlcmVuY2UgKi8KKwlwdXRfZGV2aWNlKCZjaGlw
LT5kZXYpOworfQorCitpbnQgdHBtMl9hZGRfZGV2aWNlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkK
K3sKKwlpbnQgcmM7CisKKwlkZXZpY2VfaW5pdGlhbGl6ZSgmY2hpcC0+ZGV2cyk7CisJY2hpcC0+
ZGV2cy5wYXJlbnQgPSBjaGlwLT5kZXYucGFyZW50OworCWNoaXAtPmRldnMuY2xhc3MgPSB0cG1y
bV9jbGFzczsKKwkvKgorCSAqIGdldCBleHRyYSByZWZlcmVuY2Ugb24gbWFpbiBkZXZpY2UgdG8g
aG9sZCBvbiBiZWhhbGYgb2YgZGV2cy4KKwkgKiBUaGlzIGhvbGRzIHRoZSBjaGlwIHN0cnVjdHVy
ZSB3aGlsZSBjZGV2cyBpcyBpbiB1c2UuIFRoZQorCSAqIGNvcnJlc3BvbmRpbmcgcHV0IGlzIGlu
IHRoZSB0cG1fZGV2c19yZWxlYXNlLgorCSAqLworCWdldF9kZXZpY2UoJmNoaXAtPmRldik7CisJ
Y2hpcC0+ZGV2cy5yZWxlYXNlID0gdHBtX2RldnNfcmVsZWFzZTsKKwljaGlwLT5kZXZzLmRldnQg
PSBNS0RFVihNQUpPUih0cG1fZGV2dCksCisJCQkJCWNoaXAtPmRldl9udW0gKyBUUE1fTlVNX0RF
VklDRVMpOworCWNkZXZfaW5pdCgmY2hpcC0+Y2RldnMsICZ0cG1ybV9mb3BzKTsKKwljaGlwLT5j
ZGV2cy5vd25lciA9IFRISVNfTU9EVUxFOworCisJcmMgPSBkZXZfc2V0X25hbWUoJmNoaXAtPmRl
dnMsICJ0cG1ybSVkIiwgY2hpcC0+ZGV2X251bSk7CisJaWYgKHJjKQorCQlnb3RvIG91dF9wdXRf
ZGV2czsKKworCXJjID0gY2Rldl9kZXZpY2VfYWRkKCZjaGlwLT5jZGV2cywgJmNoaXAtPmRldnMp
OworCWlmIChyYykgeworCQlkZXZfZXJyKCZjaGlwLT5kZXZzLAorCQkJInVuYWJsZSB0byBjZGV2
X2RldmljZV9hZGQoKSAlcywgbWFqb3IgJWQsIG1pbm9yICVkLCBlcnI9JWRcbiIsCisJCQlkZXZf
bmFtZSgmY2hpcC0+ZGV2cyksIE1BSk9SKGNoaXAtPmRldnMuZGV2dCksCisJCQlNSU5PUihjaGlw
LT5kZXZzLmRldnQpLCByYyk7CisJCWdvdG8gb3V0X3B1dF9kZXZzOworCX0KKworCXJldHVybiAw
OworCitvdXRfcHV0X2RldnM6CisJcHV0X2RldmljZSgmY2hpcC0+ZGV2cyk7CisKKwlyZXR1cm4g
cmM7Cit9Ci0tIAoyLjcuNAoK
