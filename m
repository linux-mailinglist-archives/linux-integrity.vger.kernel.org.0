Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D2601DFA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJQX6Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJQX6O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7617E320;
        Mon, 17 Oct 2022 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051072;
        bh=aGoHsAcDuhhqSpkLQAxXzsC5Nh/HzN5f5Q02AEnI5+I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CQnw5FNrGJNnfwbeZ1tCNB1MFkNeGujM/NnltvNvJFZ+3HE68JAsYfdnHlrbJFaYt
         ITQouyu0X5vBCOMrTTjL7yYz1FAT4lQk5gn4PxAS9CK21sZkSiYqyReuI7WPue98TO
         jUBoYujT8tC6ibZMa0tpPKVZNq07e+oJd9XPXQ0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1ovYKl4Awa-00FQ7i; Tue, 18
 Oct 2022 01:57:52 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 05/11] tpm, tpm_tis: Only handle supported interrupts
Date:   Tue, 18 Oct 2022 01:57:26 +0200
Message-Id: <20221017235732.10145-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:nUbU4NRPZD5rhgOWoMvN+mlSIdLkSir1mw9uGxYDN1Ie3MUq4bE
 b9JdPFI1/+DemG7CeEmSXQXUrvg6FGea8VUVDHIWTSheUhkUuTjydUf1DgwkBig3Il+8Gq2
 snTZ6Bbv/sP4Bgk3lvGcl3hZJ9j2Qoa8g9g+qTY9L36LI/JqK98AjWxm6WBkIzYqW3U/hW5
 0Whp5kZD342S6FwgL/uIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EkqpYWXdsdo=:3kQz8APDD0Ord+K1eyK1j1
 fgUdmtsx0UJNG2isqOZnZmQB/DvZx3IQSm8pRoewuJ9Ay4uj86XACRw+yN/C1k3w0Aek9TSpp
 rUjVM/vHinU51WDQdrCvLR427oAh5wawwcJ3ifRpDapopc6JFqrD1gGAuVdBaCWEUArD959VY
 f5GxxyFlHw8VymMlOS/ggpuOfmXk/VxV5RQ+3kCkzs7tOzGp3G8YVMDS40R4qFPKB/HTPLLnC
 nF21JKEG2rdMMOfZrDm7aAbvO/O3x4Pm/fg0gaByF2BOm3r+E1kj0KrOZCo3SlredNYChs3Mt
 WDyKs7sXETYFQT2pMKxkSRSbfaGoe0NA+BzoFrlk/eaWohBj3+iiL7XhzxJtRXUE82atk3hE6
 Wj2hvZFaAdwFZ0Td6S7nBAAJWEk6kdaKIICy31H8DsFu1Zmg94/+lBEbAuCwCAB6OgIpvJ+gM
 dM3qwhKuIGqI0fp+ZXRcD6uRoUHaafjNr+PvHaVdhcJ/pQ/Y3zMSs8HiFVo29yKG21CVaNaL2
 O8bncCvQ1IdfBBhGmm2Y//8BDSMI6DDgEgqci/YDocXghvh8J8duixvfdlqFkNacgHAs9yLZO
 Hhr23lN1/sSbP9JhcwBBB2iHXHbzRJV9GflcEKyw/4KiJ9Er6h3VLKwSXg+XMpuy2Vz8Wa3r1
 kF1ZW0jRpzdvrvc6MuePFFQkN0bO28BwsxqRdJJ77qlKv+/YysHN5wQ06LUXCPu01GjU8OVA2
 JUR1MH9d3/89k+MCUvu3D/pBBa4BeXMixvuyq8ZnAjpvEN1ydZoOfstMpYDqhcGM8fsZLSy6V
 eJB6pEpXWWQaVkcY1iWWM5hfqrxtMs++MrA7m3VMpvYw5LBSHtGXD8p9GrUVtQeiL1BjC89fl
 Xxh6Jv/uSvKO5l16apTiFiFtunEiTUkSaA9Wm2bKoapMap0eTmLhOgRTEVsBY9VVET1FdTzbW
 6GtpQKb8qR0sQfY5YTLd/zqLyvemAQzJk15uk2uG01wurqaglLqAGb//PImT+QU51nC/5T712
 rBLxu4AyVT2zv/xTfdpGdJ/CkJNmEU7w8HFm/bvHkBxR4nAJ7IzKmGD6o0BuZWC34N48Tf9R6
 0qKgrt/S6zCe6ZLD/D/xPPJqE7cgjbPLJetfqRFo4ArArBR9ySypL9ynkn3GAjrMMCiu6Fa/q
 kHYSxFYAvmh6MCz2tQw5MLGzgJwkemjaOwlXydgARqbILtPqgxOuSgMbWUIKcwW0BFcMhKBRg
 Y9Sj44bR0I6f0j8Q5vqn4drbGHdPK2xFvI+X51IRx7vY3M0a3ORjAdz3pU4y9wS2/lpl0eVjA
 4Nt47s23yteUS3FEqS7lBCq77oREHTCwPEMWUu0Ip/p3ZezxcjJar6Uq/lCqLRbFbVwQSywT6
 MnaPmeYx9J1sA6Ts6vlGq3LREvxC9vmOdCSt4qqlKfs0xlIQD1SqP0LL5Z0UkYuPjMNDANweK
 +zVSnSyhh4VFvm8pcIcCN/m22FyUCWZ2Z22GZ5roGPe8CefVRtz0TvU8nurFEv2YHVY0lIKVl
 Tn1avMzuHtlCtOmzugKA4KFxlsa4XZrDPpOAAPchMjtwP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkFjY29yZGlu
ZyB0byB0aGUgVFBNIEludGVyZmFjZSBTcGVjaWZpY2F0aW9uIChUSVMpIHN1cHBvcnQgZm9yICJz
dHNWYWxpZCIKYW5kICJjb21tYW5kUmVhZHkiIGludGVycnVwdHMgaXMgb25seSBvcHRpb25hbC4K
VGhpcyBoYXMgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50IHdoZW4gaGFuZGxpbmcgdGhlIGludGVy
cnVwdHMgaW4gZnVuY3Rpb25zCmxpa2Ugd2FpdF9mb3JfdHBtX3N0YXQoKS4gVG8gZGV0ZXJtaW5l
IHRoZSBzdXBwb3J0ZWQgaW50ZXJydXB0cyB1c2UgdGhlCmNhcGFiaWxpdHkgcXVlcnkuCgpBbHNv
IGFkanVzdCB3YWl0X2Zvcl90cG1fc3RhdCgpIHRvIG9ubHkgd2FpdCBmb3IgaW50ZXJydXB0IHJl
cG9ydGVkIHN0YXR1cwpjaGFuZ2VzLiBBZnRlciB0aGF0IHByb2Nlc3MgYWxsIHRoZSByZW1haW5p
bmcgc3RhdHVzIGNoYW5nZXMgYnkgcG9sbGluZwp0aGUgc3RhdHVzIHJlZ2lzdGVyLgoKU2lnbmVk
LW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KVGVzdGVk
LWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIgPGxpbnV4QG1uaWV3b2VobmVyLmRlPgpSZXZpZXdlZC1i
eTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jIHwgMTIwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
CiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgICAxICsKIDIgZmlsZXMgY2hhbmdl
ZCwgNzMgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMKaW5kZXggNTIyMDVhMWZlZTllLi5kMDdkZWJjMzE4MmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2Nv
cmUuYwpAQCAtNTMsNDEgKzUzLDYzIEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3Ry
dWN0IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCWxvbmcgcmM7CiAJdTggc3RhdHVzOwogCWJv
b2wgY2FuY2VsZWQgPSBmYWxzZTsKKwl1OCBzdHNfbWFzayA9IDA7CisJaW50IHJldCA9IDA7CiAK
IAkvKiBjaGVjayBjdXJyZW50IHN0YXR1cyAqLwogCXN0YXR1cyA9IGNoaXAtPm9wcy0+c3RhdHVz
KGNoaXApOwogCWlmICgoc3RhdHVzICYgbWFzaykgPT0gbWFzaykKIAkJcmV0dXJuIDA7CiAKLQlz
dG9wID0gamlmZmllcyArIHRpbWVvdXQ7CisJLyogY2hlY2sgd2hhdCBzdGF0dXMgY2hhbmdlcyBj
YW4gYmUgaGFuZGxlZCBieSBpcnFzICovCisJaWYgKHByaXYtPmludF9tYXNrICYgVFBNX0lOVEZf
U1RTX1ZBTElEX0lOVCkKKwkJc3RzX21hc2sgfD0gVFBNX1NUU19WQUxJRDsKIAotCWlmIChjaGlw
LT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfSVJRKSB7CisJaWYgKHByaXYtPmludF9tYXNrICYgVFBN
X0lOVEZfREFUQV9BVkFJTF9JTlQpCisJCXN0c19tYXNrIHw9IFRQTV9TVFNfREFUQV9BVkFJTDsK
KworCWlmIChwcml2LT5pbnRfbWFzayAmIFRQTV9JTlRGX0NNRF9SRUFEWV9JTlQpCisJCXN0c19t
YXNrIHw9IFRQTV9TVFNfQ09NTUFORF9SRUFEWTsKKworCXN0c19tYXNrICY9IG1hc2s7CisKKwlz
dG9wID0gamlmZmllcyArIHRpbWVvdXQ7CisJLyogcHJvY2VzcyBzdGF0dXMgY2hhbmdlcyB3aXRo
IGlycSBzdXBwb3J0ICovCisJaWYgKHN0c19tYXNrKSB7CisJCXJldCA9IC1FVElNRTsKIGFnYWlu
OgogCQl0aW1lb3V0ID0gc3RvcCAtIGppZmZpZXM7CiAJCWlmICgobG9uZyl0aW1lb3V0IDw9IDAp
CiAJCQlyZXR1cm4gLUVUSU1FOwogCQlyYyA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1l
b3V0KCpxdWV1ZSwKLQkJCXdhaXRfZm9yX3RwbV9zdGF0X2NvbmQoY2hpcCwgbWFzaywgY2hlY2tf
Y2FuY2VsLAorCQkJd2FpdF9mb3JfdHBtX3N0YXRfY29uZChjaGlwLCBzdHNfbWFzaywgY2hlY2tf
Y2FuY2VsLAogCQkJCQkgICAgICAgJmNhbmNlbGVkKSwKIAkJCXRpbWVvdXQpOwogCQlpZiAocmMg
PiAwKSB7CiAJCQlpZiAoY2FuY2VsZWQpCiAJCQkJcmV0dXJuIC1FQ0FOQ0VMRUQ7Ci0JCQlyZXR1
cm4gMDsKKwkJCXJldCA9IDA7CiAJCX0KIAkJaWYgKHJjID09IC1FUkVTVEFSVFNZUyAmJiBmcmVl
emluZyhjdXJyZW50KSkgewogCQkJY2xlYXJfdGhyZWFkX2ZsYWcoVElGX1NJR1BFTkRJTkcpOwog
CQkJZ290byBhZ2FpbjsKIAkJfQotCX0gZWxzZSB7Ci0JCWRvIHsKLQkJCXVzbGVlcF9yYW5nZShw
cml2LT50aW1lb3V0X21pbiwKLQkJCQkgICAgIHByaXYtPnRpbWVvdXRfbWF4KTsKLQkJCXN0YXR1
cyA9IGNoaXAtPm9wcy0+c3RhdHVzKGNoaXApOwotCQkJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSBt
YXNrKQotCQkJCXJldHVybiAwOwotCQl9IHdoaWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBzdG9w
KSk7CiAJfQorCisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCW1hc2sgJj0gfnN0c19tYXNr
OworCWlmICghbWFzaykgLyogYWxsIGRvbmUgKi8KKwkJcmV0dXJuIDA7CisJLyogcHJvY2VzcyBz
dGF0dXMgY2hhbmdlcyB3aXRob3V0IGlycSBzdXBwb3J0ICovCisJZG8geworCQlzdGF0dXMgPSBj
aGlwLT5vcHMtPnN0YXR1cyhjaGlwKTsKKwkJaWYgKChzdGF0dXMgJiBtYXNrKSA9PSBtYXNrKQor
CQkJcmV0dXJuIDA7CisJCXVzbGVlcF9yYW5nZShwcml2LT50aW1lb3V0X21pbiwKKwkJCSAgICAg
cHJpdi0+dGltZW91dF9tYXgpOworCX0gd2hpbGUgKHRpbWVfYmVmb3JlKGppZmZpZXMsIHN0b3Ap
KTsKIAlyZXR1cm4gLUVUSU1FOwogfQogCkBAIC0xMDIxLDggKzEwNDMsNDAgQEAgaW50IHRwbV90
aXNfY29yZV9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRwbV90aXNfZGF0YSAqcHJp
diwgaW50IGlycSwKIAlpZiAocmMgPCAwKQogCQlnb3RvIG91dF9lcnI7CiAKLQlpbnRtYXNrIHw9
IFRQTV9JTlRGX0NNRF9SRUFEWV9JTlQgfCBUUE1fSU5URl9MT0NBTElUWV9DSEFOR0VfSU5UIHwK
LQkJICAgVFBNX0lOVEZfREFUQV9BVkFJTF9JTlQgfCBUUE1fSU5URl9TVFNfVkFMSURfSU5UOwor
CS8qIEZpZ3VyZSBvdXQgdGhlIGNhcGFiaWxpdGllcyAqLworCXJjID0gdHBtX3Rpc19yZWFkMzIo
cHJpdiwgVFBNX0lOVEZfQ0FQUyhwcml2LT5sb2NhbGl0eSksICZpbnRmY2Fwcyk7CisJaWYgKHJj
IDwgMCkKKwkJZ290byBvdXRfZXJyOworCisJZGV2X2RiZyhkZXYsICJUUE0gaW50ZXJmYWNlIGNh
cGFiaWxpdGllcyAoMHgleCk6XG4iLAorCQlpbnRmY2Fwcyk7CisJaWYgKGludGZjYXBzICYgVFBN
X0lOVEZfQlVSU1RfQ09VTlRfU1RBVElDKQorCQlkZXZfZGJnKGRldiwgIlx0QnVyc3QgQ291bnQg
U3RhdGljXG4iKTsKKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9DTURfUkVBRFlfSU5UKSB7CisJ
CWludG1hc2sgfD0gVFBNX0lOVEZfQ01EX1JFQURZX0lOVDsKKwkJZGV2X2RiZyhkZXYsICJcdENv
bW1hbmQgUmVhZHkgSW50IFN1cHBvcnRcbiIpOworCX0KKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5U
Rl9JTlRfRURHRV9GQUxMSU5HKQorCQlkZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0IEVkZ2UgRmFs
bGluZ1xuIik7CisJaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0VER0VfUklTSU5HKQorCQlk
ZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0IEVkZ2UgUmlzaW5nXG4iKTsKKwlpZiAoaW50ZmNhcHMg
JiBUUE1fSU5URl9JTlRfTEVWRUxfTE9XKQorCQlkZXZfZGJnKGRldiwgIlx0SW50ZXJydXB0IExl
dmVsIExvd1xuIik7CisJaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0xFVkVMX0hJR0gpCisJ
CWRldl9kYmcoZGV2LCAiXHRJbnRlcnJ1cHQgTGV2ZWwgSGlnaFxuIik7CisJaWYgKGludGZjYXBz
ICYgVFBNX0lOVEZfTE9DQUxJVFlfQ0hBTkdFX0lOVCkgeworCQlpbnRtYXNrIHw9IFRQTV9JTlRG
X0xPQ0FMSVRZX0NIQU5HRV9JTlQ7CisJCWRldl9kYmcoZGV2LCAiXHRMb2NhbGl0eSBDaGFuZ2Ug
SW50IFN1cHBvcnRcbiIpOworCX0KKwlpZiAoaW50ZmNhcHMgJiBUUE1fSU5URl9TVFNfVkFMSURf
SU5UKSB7CisJCWludG1hc2sgfD0gVFBNX0lOVEZfU1RTX1ZBTElEX0lOVDsKKwkJZGV2X2RiZyhk
ZXYsICJcdFN0cyBWYWxpZCBJbnQgU3VwcG9ydFxuIik7CisJfQorCWlmIChpbnRmY2FwcyAmIFRQ
TV9JTlRGX0RBVEFfQVZBSUxfSU5UKSB7CisJCWludG1hc2sgfD0gVFBNX0lOVEZfREFUQV9BVkFJ
TF9JTlQ7CisJCWRldl9kYmcoZGV2LCAiXHREYXRhIEF2YWlsIEludCBTdXBwb3J0XG4iKTsKKwl9
CisKIAlpbnRtYXNrICY9IH5UUE1fR0xPQkFMX0lOVF9FTkFCTEU7CiAKIAlyYyA9IHJlcXVlc3Rf
bG9jYWxpdHkoY2hpcCwgMCk7CkBAIC0xMDU2LDMyICsxMTEwLDYgQEAgaW50IHRwbV90aXNfY29y
ZV9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiwgaW50
IGlycSwKIAkJZ290byBvdXRfZXJyOwogCX0KIAotCS8qIEZpZ3VyZSBvdXQgdGhlIGNhcGFiaWxp
dGllcyAqLwotCXJjID0gdHBtX3Rpc19yZWFkMzIocHJpdiwgVFBNX0lOVEZfQ0FQUyhwcml2LT5s
b2NhbGl0eSksICZpbnRmY2Fwcyk7Ci0JaWYgKHJjIDwgMCkKLQkJZ290byBvdXRfZXJyOwotCi0J
ZGV2X2RiZyhkZXYsICJUUE0gaW50ZXJmYWNlIGNhcGFiaWxpdGllcyAoMHgleCk6XG4iLAotCQlp
bnRmY2Fwcyk7Ci0JaWYgKGludGZjYXBzICYgVFBNX0lOVEZfQlVSU1RfQ09VTlRfU1RBVElDKQot
CQlkZXZfZGJnKGRldiwgIlx0QnVyc3QgQ291bnQgU3RhdGljXG4iKTsKLQlpZiAoaW50ZmNhcHMg
JiBUUE1fSU5URl9DTURfUkVBRFlfSU5UKQotCQlkZXZfZGJnKGRldiwgIlx0Q29tbWFuZCBSZWFk
eSBJbnQgU3VwcG9ydFxuIik7Ci0JaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5UX0VER0VfRkFM
TElORykKLQkJZGV2X2RiZyhkZXYsICJcdEludGVycnVwdCBFZGdlIEZhbGxpbmdcbiIpOwotCWlm
IChpbnRmY2FwcyAmIFRQTV9JTlRGX0lOVF9FREdFX1JJU0lORykKLQkJZGV2X2RiZyhkZXYsICJc
dEludGVycnVwdCBFZGdlIFJpc2luZ1xuIik7Ci0JaWYgKGludGZjYXBzICYgVFBNX0lOVEZfSU5U
X0xFVkVMX0xPVykKLQkJZGV2X2RiZyhkZXYsICJcdEludGVycnVwdCBMZXZlbCBMb3dcbiIpOwot
CWlmIChpbnRmY2FwcyAmIFRQTV9JTlRGX0lOVF9MRVZFTF9ISUdIKQotCQlkZXZfZGJnKGRldiwg
Ilx0SW50ZXJydXB0IExldmVsIEhpZ2hcbiIpOwotCWlmIChpbnRmY2FwcyAmIFRQTV9JTlRGX0xP
Q0FMSVRZX0NIQU5HRV9JTlQpCi0JCWRldl9kYmcoZGV2LCAiXHRMb2NhbGl0eSBDaGFuZ2UgSW50
IFN1cHBvcnRcbiIpOwotCWlmIChpbnRmY2FwcyAmIFRQTV9JTlRGX1NUU19WQUxJRF9JTlQpCi0J
CWRldl9kYmcoZGV2LCAiXHRTdHMgVmFsaWQgSW50IFN1cHBvcnRcbiIpOwotCWlmIChpbnRmY2Fw
cyAmIFRQTV9JTlRGX0RBVEFfQVZBSUxfSU5UKQotCQlkZXZfZGJnKGRldiwgIlx0RGF0YSBBdmFp
bCBJbnQgU3VwcG9ydFxuIik7Ci0KIAkvKiBJTlRFUlJVUFQgU2V0dXAgKi8KIAlpbml0X3dhaXRx
dWV1ZV9oZWFkKCZwcml2LT5yZWFkX3F1ZXVlKTsKIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZwcml2
LT5pbnRfcXVldWUpOwpAQCAtMTExMiw3ICsxMTQwLDkgQEAgaW50IHRwbV90aXNfY29yZV9pbml0
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHRwbV90aXNfZGF0YSAqcHJpdiwgaW50IGlycSwK
IAkJZWxzZQogCQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7CiAKLQkJaWYgKCEo
Y2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX0lSUSkpIHsKKwkJaWYgKGNoaXAtPmZsYWdzICYg
VFBNX0NISVBfRkxBR19JUlEpIHsKKwkJCXByaXYtPmludF9tYXNrID0gaW50bWFzazsKKwkJfSBl
bHNlIHsKIAkJCWRldl9lcnIoJmNoaXAtPmRldiwgRldfQlVHCiAJCQkJCSJUUE0gaW50ZXJydXB0
IG5vdCB3b3JraW5nLCBwb2xsaW5nIGluc3RlYWRcbiIpOwogCkBAIC0xMTU5LDEzICsxMTg5LDcg
QEAgc3RhdGljIHZvaWQgdHBtX3Rpc19yZWVuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCkKIAlpZiAocmMgPCAwKQogCQlnb3RvIG91dDsKIAotCXJjID0gdHBtX3Rpc19yZWFk
MzIocHJpdiwgVFBNX0lOVF9FTkFCTEUocHJpdi0+bG9jYWxpdHkpLCAmaW50bWFzayk7Ci0JaWYg
KHJjIDwgMCkKLQkJZ290byBvdXQ7Ci0KLQlpbnRtYXNrIHw9IFRQTV9JTlRGX0NNRF9SRUFEWV9J
TlQKLQkgICAgfCBUUE1fSU5URl9MT0NBTElUWV9DSEFOR0VfSU5UIHwgVFBNX0lOVEZfREFUQV9B
VkFJTF9JTlQKLQkgICAgfCBUUE1fSU5URl9TVFNfVkFMSURfSU5UIHwgVFBNX0dMT0JBTF9JTlRf
RU5BQkxFOworCWludG1hc2sgPSBwcml2LT5pbnRfbWFzayB8IFRQTV9HTE9CQUxfSU5UX0VOQUJM
RTsKIAogCXRwbV90aXNfd3JpdGUzMihwcml2LCBUUE1fSU5UX0VOQUJMRShwcml2LT5sb2NhbGl0
eSksIGludG1hc2spOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5oIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuaAppbmRleCA2OTVhMjUxNmRjZTAu
LjJkZWVmMTFjODhkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
aAorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oCkBAIC05Myw2ICs5Myw3IEBA
IHN0cnVjdCB0cG1fdGlzX2RhdGEgewogCXUxNiBtYW51ZmFjdHVyZXJfaWQ7CiAJaW50IGxvY2Fs
aXR5OwogCWludCBpcnE7CisJdW5zaWduZWQgaW50IGludF9tYXNrOwogCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7CiAJdm9pZCBfX2lvbWVtICppbGJfYmFzZV9hZGRyOwogCXUxNiBjbGtydW5fZW5hYmxl
ZDsKLS0gCjIuMzYuMQoK
