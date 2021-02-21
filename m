Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD38320E80
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 00:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhBUXVv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 18:21:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:36443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233466AbhBUXVq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 18:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613949603;
        bh=9l4grb4JhaiOmeE7yd0boXIUdGTQ9zwbuNUNShOzo2s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CLXNG8kI+b/wtd6jti9gcgdTgQ35clvUo8bv+CHe56+b+SOovkjExxwpqpyDIAkIw
         ENWJZpEOQ53vZd7Mf6GnRoTnQr1Nc5cluReotvL2kjKFiYRA8j4Z/9uf7WpEa/h/o+
         Qmy73vlIpi9B+wRf7FMzD0piWF4oZmP8/OoiKDUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1lvitv1xzs-00zplc; Mon, 22
 Feb 2021 00:20:03 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH v7] TPM fixes
Date:   Mon, 22 Feb 2021 00:19:26 +0100
Message-Id: <1613949567-1181-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:plCDYGuZwHGXgxLZ9vgtgZ7bhxhyOiA2PYuMltHs6UmGEaSaufG
 vgNTzRAjbEPDVHa2bBQPkAqsyRi1zvVL1uzzGo1CUfSpq6jR7i0ulRVu8dej1fzIS4xr61O
 IbTrOBVMJP5EJkvPjnzcl6Lh3sPTSdoKTpcsFQEE+tZMCt+H10F84OFgPHBl4J+HoKlBfwM
 al/EqNh+2/wdnlFCAsXpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1JectwVZFJ0=:zUvp61boCapZZ80rrp/0PK
 AN/pMh4Lyu35jFjpKorlNDBQiL6cN/9Y31amMJhtOstF3tlDtIwjONAA9HIwDvsTCOitE77kn
 2OSyz6uhnJ6MtmGZS99Fx1lllHa6HKV6NIIV6K8VBmah5b8v1EEzukqKEW2w69YVJk9O+C+/s
 bEnZvmVrRfu/psx9RB6uX2hJJIdfZZL1ldPALQBhgllrNWcroJaUrM08sY/2SvolMp2eze8Ef
 SGe6FIDv+XaY+2ATosYeRK6aXCWANlfib/A8A2ep5/i/b8RVIRIdyMR1c4Hib9r8/bZE1IMuY
 HBe9GsvJWF9p2ZgmpneWtfcmy269c93wMNn4VQBDwpTCcTxOAOK8JxPQr9nD5ZFR0F7eqFYur
 7mMOVJyYYTyIBsbbOisLjNfaEmCF5bowNV1HyCx1cF6MRU7IudW2fLM+9O9DE/+m1LeUAgTrZ
 TEWUdL6dLq1saaAIkZ66e2T8WoUlE4Vrbm6vKYA8clwrpro8mS2p8QAdzI5GI5/KJOL5a8MD/
 fqwbnkrKSLcWcKoW9wBSPjubSPOECUPlxHGwbdRS3rGT4VTMlGw3GoyouvkgWU7U1QmuyQcSx
 o14iQnoRTcrftIaYnlIifQrPADpdGhIVhJLOHsbjaqOn0vjk9OaAfEOA9u0MgkQi8hjxZzpK5
 SAfzuMHC8VttV3WLxq+tQ8GtHqNQyCYzVYI4WmLhJBTJ8T1exWuSZTCO/3NATBQVtarRXSgDH
 j7Elw7o+duKhCk3piZNMS5H+c8gq8jIyWJ22bG/3V+UVnen2A0imyVIq36srQgsHmBTJb50Jw
 HJzZ7YhdpttrMKyz1KabTP/MdDEv2+nhqUhYOAVz6InwkHX/LZKcyFE+gyvtkPgoWaaAVm5Fx
 0Gt//SqaeplHhmsGD5JA==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIHJlZmVyZW5jZSBjb3VudCBpc3N1ZSBpbiB0aGUgVFBNIGNvcmUg
Y29kZS4KCgpDaGFuZ2VzIGluIHY3OgotIGFkanVzdCBuYW1pbmcgb2YganVtcCBsYWJlbHMgdG8g
Zml0IGJldHRlciB0aGUgdXNlZCBsYWJlbCBuYW1pbmcgc2NoZW1lCgpDaGFuZ2VzIGluIHY2Ogot
IHJlbmFtZSBmdW5jdGlvbiB0cG0yX2FkZF9kZXZpY2UoKSB0byB0cG1fZGV2c19hZGQoKSBhcyBy
ZXF1ZXN0ZWQgYnkgSmFya28KLSBhZGQgZnVuY3Rpb24gZGVzY3JpcHRpb25zCi0gZml4IHNvdXJj
ZSBjb2RlIGZvcm1hdHRpbmcKCkNoYW5nZXMgaW4gdjU6Ci0gbW92ZSBmdW5jdGlvbiB0cG1fYWRk
X3RwbTJfY2hhcl9kZXZpY2UoKSB0byB0cG0yLXNwYWNlLmMgYW5kIHJlbmFtZQppdCB0byB0cG0y
X2FkZF9kZXZpY2UoKSBhcyByZXF1ZXN0ZWQgYnkgSmFya28KLSBwdXQgImNjIiB0YWcgYmVmb3Jl
IGFsbCBvdGhlciB0YWdzIAotIGVuc3VyZSB0aGF0IHRoZSBlcnJvciBwYXRoIGluIHRwbTJfYWRk
X2RldmljZSgpIGFsd2F5cyBjYWxscyAKdGhlIHJlbGVhc2UoKSBmdW5jdGlvbiBvZiBjaGlwLT5k
ZXZzIGFzIHJlcXVlc3RlZCBieSBKYXNvbgotIHJlZm9ybWF0IGEgY29kZSBsaW5lIGFzIHN1Z2dl
c3RlZCBieSBEYXZpZCBMYWlnaHQKCkNoYW5nZXMgaW4gdjQ6Ci0gZHJvcCBwYXRjaCAyICh0cG06
IGluIHRwbTJfZGVsX3NwYWNlIGNoZWNrIGlmIG9wcyBwb2ludGVyIGlzIHN0aWxsCnZhbGlkKSBz
aW5jZSBKYW1lcyBCb3R0b21sZXkgb2ZmZXJlZCBhIGNsZWFuZXIgc29sdXRpb24gZm9yIHRoaXMK
LSByZWltcGxlbWVudCBwYXRjaCAxIHRvIHNldHVwIHRoZSAvZGV2L3RwbXJtIGRldmljZSBvbmx5
IGluIGNhc2Ugb2YgVFBNMgphbmQgYXZvaWQgdGhlIGluc3RhbGxhdGlvbiBvZiBhbm90aGVyIGFj
dGlvbiBoYW5kbGVyLiBUaGlzIGlzIGJhc2VkIG9uIGEKc3VnZ2VzdGlvbiBhbmQgYmFzaWMgaW1w
bGVtZW50YXRpb24gZG9uZSBieSBKYXNvbiBHdW50aG9ycGUuCi0gYWRkZWQgdGFnIHRvIENDIHN0
YWJsZQoKQ2hhbmdlcyBpbiB2MzoKLSBkcm9wIHRoZSBwYXRjaCB0aGF0IGludHJvZHVjZXMgdGhl
IG5ldyBmdW5jdGlvbiB0cG1fY2hpcF9mcmVlKCkKLSByZXdvcmsgdGhlIGNvbW1pdCBtZXNzYWdl
cyBmb3IgdGhlIHBhdGNoZXMgKHN0eWxlLCB0eXBvcywgZXRjLikKLSBhZGQgZml4ZXMgdGFnIHRv
IHBhdGNoIDIKLSBhZGQgSmFtZXMgQm90dG9tbGV5IHRvIGNjIGxpc3QKLSBhZGQgc3RhYmxlIG1h
aWxpbmcgbGlzdCB0byBjYyBsaXN0CgpDaGFuZ2VzIGluIHYyOgotIGRyb3AgdGhlIHBhdGNoIHRo
YXQgZXJyb25lb3VzbHkgY2xlYW5lZCB1cCBhZnRlciBmYWlsZWQgaW5zdGFsbGF0aW9uIG9mCiAg
YW4gYWN0aW9uIGhhbmRsZXIgaW4gdHBtbV9jaGlwX2FsbG9jKCkgKHBvaW50ZWQgb3V0IGJ5IEph
cmtrbyBTYWtraW5lbikKLSBtYWtlIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgcGF0Y2ggMSBtb3Jl
IGRldGFpbGVkCi0gYWRkIGZpeGVzIHRhZ3MgYW5kIGtlcm5lbCBsb2dzCgoKTGlubyBTYW5maWxp
cHBvICgxKToKICB0cG06IGZpeCByZWZlcmVuY2UgY291bnRpbmcgZm9yIHN0cnVjdCB0cG1fY2hp
cAoKIGRyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyAgIHwgNDggKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0uaCAgICAgICAgfCAgMSAr
CiBkcml2ZXJzL2NoYXIvdHBtL3RwbTItc3BhY2UuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygr
KSwgMzggZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCg==
