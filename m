Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3636A9E3
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 01:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhDYXt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Apr 2021 19:49:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:50365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhDYXt2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Apr 2021 19:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619394514;
        bh=Stlpopoc3a1Fg0eLd5v2nD9hwQJyUidlQLbgZr47CmQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C0udvBcfxEYwu1NR/pnxcdlwxC1LtJ9Cu00UiNM6U7Gr+tNsHdiPhb5aaqk3LReyK
         jKVn6EyJLRQPfIGT06JUGUPYaofu/gyjiBQDXCbE9gOIzCnC5K2Xuh4ieEcXWl/GJG
         tjhWE6/KOro+n4LEoBFJUyI5CaqiafEJvNzDRxsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1lwj3K1wQa-00M53G; Mon, 26
 Apr 2021 01:48:34 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
Date:   Mon, 26 Apr 2021 01:47:17 +0200
Message-Id: <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ST8i+uEEIueXGAgIOWci1Nfv0106tGM3xl9KeRJSO9wCpjH2oZ7
 OXvH9yYOTchGMNJSQwRyYXfDo2UWIUPhDQuM1u6pwV+FEHCbFbOKvtsPr9BE4z8yEOTa82f
 732Kl66hgIJCaVOiWyjbEApfGsb3FshYei6EsGDQLOKJxlFPOjWFZbCyw9deLGrnOLoPwFm
 FS5tWF+IVWfbWuLLWODdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H2PPUkFEGlg=:xuNH5Fb41dWMrPFTAudlzO
 Kpu4xthkr4u0aRW2RJIUjzrMQ4sBzNdapE+8ED+nc/OcR4wD+KlVeCHum6kz3tC8YjtmjpKvQ
 sgu20HwNqd1i+ecqmzfbUdBoAGg4vuyZaP6Br0CkHIvdDFykfdMzGLl94lC1bpe4wltjodRdD
 z1Ncf1nNRqHCYDb3ztBCXk4KuTP7wJDDl75EWLblq6HVbD8H0RZZ9um0U2MHZ5pbh8fSa0pA0
 WfAjXC4V7uKnnf6IRH8wzs7hDS3xfnDcCpTiQzK9OHozlrOkNTOU2OmMotDHuiGwOv6JAsQAf
 Q6GuC3T1eK7qc5a7zxt1GEctr2WRQhvW5AT7Z8BNthln/pODAr1VQOTnJnV8QajQIekW9FyDx
 Em3pUuqrJTYadyoHF3xqoKe8n3HvHUZ28uRzXgQlATUvV5vsK+T8DTzs9UV7fGQbBGj8ar1wE
 u+5VX7kdn6Icf0XSwTTVgVyEPMU5hfoq/S5IcqiL19MDEc+pL/DOFIIOkJtsvhBbIyQng1UDu
 BWoyhRU8eT7ve9Agqds6PvOriWEYtbesvjxAdsGmMHHg+4IkKF5WEpqVqUSvgEBPicmxau1r4
 iT6Kw0w1F6m5Z1pDjBrhzPUrFH2RLoBtu2fHjEgOR5GXCEoaknDP3YtZv2Fc18bIkGeMA/nlO
 qe1uHHbhuxZNqe5pB3Zeu7WmTXbwbmHxaIWBKavKJrnQduMuh3qtb/Zd0i/Eje8KFYMGtQ8DX
 JUEFyT2mXADkIze9qi40qyCrAp96spHbvy8DVNn307oxyk8p9hm79PiJPglp8mwcBV6yuoKCh
 vVPS8JzzRSCPaUNdoL6G/az/g3/S2TOb2Kxsz0jn0K137KHMSQcja9TDyJHI76EEXoR0hBQK+
 byu4cssZJcYRs5HvytejaNqOYH5r9DZitZ47ENbUmr8KzWDWsM2V1iHqz1Kplev9wEHyVNhCu
 gAxNgwKUPb+43GS3duOrlyb75qqtppRv7yVoZYB1Qy5rawmQJF6a9ANy/dKZaIETY91rcCxYa
 yht0O+CuS+GpXYYQDHCmgiNivTHB/57/GhuGs3DJxFBIJk9GkynwpigPZXjwu2Cnz3PM/Fz0G
 cvO5ZTOkDv/3VgMUtuXMICp710hPPt54ulwdhyD33VC/QcOvRj0oAhA/MdamhDt32uLE9rPVf
 aC7mPp5Gqvg1nfwUIc3K7j0aLd0fMwE/G96vnkznVp2nyMj7Qlm5MMLknx3mL3SBBhJ0I6ERf
 t5UVHFY1RBiTAsbqh
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SW50ZXJydXB0IGhhbmRsaW5nIGF0IGxlYXN0IGluY2x1ZGVzIHJlYWRpbmcgYW5kIHdyaXRpbmcg
dGhlIGludGVycnVwdApzdGF0dXMgcmVnaXN0ZXIgZnJvbSB0aGUgaW50ZXJydXB0IHJvdXRpbmUu
IEhvd2V2ZXIgb3ZlciBTUEkgdGhvc2UgYWNjZXNzZXMKcmVxdWlyZSBhIHNsZWVwYWJsZSBjb250
ZXh0LCBzaW5jZSBhIG11dGV4IGlzIHVzZWQgaW4gdGhlIGNvbmNlcm5pbmcKZnVuY3Rpb25zLgpG
b3IgdGhpcyByZWFzb24gcmVxdWVzdCBhIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVyIHdoaWNo
IGlzIHJ1bm5pbmcgaW4KKHNsZWVwYWJsZSkgcHJvY2VzcyBjb250ZXh0LgoKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxMaW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGU3
ZDFlYWIuLjA5NTk1NTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3Jl
LmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAtNzgxLDggKzc4MSwx
MCBAQCBzdGF0aWMgaW50IHRwbV90aXNfcHJvYmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2NoaXAg
KmNoaXAsIHUzMiBpbnRtYXNrLAogCWludCByYzsKIAl1MzIgaW50X3N0YXR1czsKIAotCWlmIChk
ZXZtX3JlcXVlc3RfaXJxKGNoaXAtPmRldi5wYXJlbnQsIGlycSwgdGlzX2ludF9oYW5kbGVyLCBm
bGFncywKLQkJCSAgICAgZGV2X25hbWUoJmNoaXAtPmRldiksIGNoaXApICE9IDApIHsKKworCWlm
IChkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGNoaXAtPmRldi5wYXJlbnQsIGlycSwgTlVMTCwK
KwkJCQkgICAgICB0aXNfaW50X2hhbmRsZXIsIElSUUZfT05FU0hPVCB8IGZsYWdzLAorCQkJCSAg
ICAgIGRldl9uYW1lKCZjaGlwLT5kZXYpLCBjaGlwKSAhPSAwKSB7CiAJCWRldl9pbmZvKCZjaGlw
LT5kZXYsICJVbmFibGUgdG8gcmVxdWVzdCBpcnE6ICVkIGZvciBwcm9iZVxuIiwKIAkJCSBpcnEp
OwogCQlyZXR1cm4gLTE7Ci0tIAoyLjcuNAoK
