Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1307031C49A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 01:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBPAcv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 19:32:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:35141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhBPAcv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 19:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613435468;
        bh=RvQaQiSV/kUQIP/UO5uO3Npt9YKdUclqg6AY+ow1jvw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MXOoQXz2fwMqadezSG0g0sLEHNXX/cIIzGsZjmM/N9qDcF2mZFAnBBMsl1H3vFEc/
         x6JboI0jbm2B5Q6dQ6sPN2ro2OTsIazx1KbAblsdtdqlsAIY01069LsUJ2oMa1uM9f
         IG3cDSMQQPd4m2CwcyAmfo62TH9yroVBaFV06OhQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1lk3ge15Ia-00chnN; Tue, 16
 Feb 2021 01:31:08 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v4] TPM fixes
Date:   Tue, 16 Feb 2021 01:30:59 +0100
Message-Id: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:u88CQWiGIeWmB6YVjPPfk3KMHxkGp+xl4+BFnHbjDdp2gcPU+PE
 Z61T3aQRaaA3KbuHNDlula4U8wRa8tuA9REJIk23JiCmVs0HBBd9hNJ9qV9nPH8sdsvMbxM
 PkF7/7HhFujC/QDO0zmdWkafuyin6DUpTSVS4HAycO3CgsrKQ0mCfRy+FxM6LwJisf97LK7
 ZGtf0Qrkx9f0sHHjQ2CuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HvvRn21dB0=:J9VHaoYbRRkZTFszGUeojZ
 FvI+lqBmJOkxxA2YNhCdIFhGest3T5aUbpvrtOo7iZJZJDjXznld9n1B1ZwKTgAzlyqmu1MV+
 nGaYwYY9Mh7GBFxc0ovQM7xckiCQIV2PJrNGiTT1KeWj8Hu2gM3cE01zXyFC8ScFqNr1rxrFW
 wTSfpoXLZum7gcJuYgQCGSIlcYyoEoCQMY7QNMO+hDbYYX+VOnTpFd8JQwIJc7wdsprSvw6aN
 FX2zczimsrB+j344WlR57AmtJOx2anbgPGoSkkGWO+HH1+neNWFcCIOrZRP7wmoJZDGTqj9Hg
 CNVP70xtly+HdWy3699fOXLIiT12ZND6oB1KyE3HjRfQd45nofDqPvPDAClmBwePVRN14hogj
 uh25K/o7Vw3evTj10bIZQhYwPArki5CwJrvd9xuAUfCfxW1AfDtvsqnSkcXgz5uWgc0S3u6kp
 o3bmMPvakxK95jBBZLVRfz4Kx4KCfXGx9CnmufGhIniuAnpQnXBddLLh0p7EkX2VtDkvufzgM
 w8ZZm8XP0Pwx1ZCdcm77vbQpX/jSc6sNldsjqxef2u2vw/98yw5NfjGZz+fmkualUEvYfOeSO
 5fDw6gld059ezq/+0JsewTkSbTZ/Xjl9mW1uVNAKaY5CNcbnH7Tb9YuNHBQaLvEjU6TK7V4Lk
 CLlBDszZZgNySmwSlGHNBO7J+Vjj73KFc1aSu4RD8v0dA1COnp0sf9Tj2tRfJeBa6re5twgG8
 k5vQUHoAmgQb/4Kmlhvnce7jaHzkW2hMozHIAiDH6BZzCL8Io6TnPOg8V5ar1DWnyO5yIfWt6
 TgzDfUGX44U/YuyVx2a+sDAmPThvjbwVUbeEr1lY/uHtY5ez/WboXSfDM+t7ArEaqQuxGVD5g
 tjp7i0yQqsSG/GAyBoqg==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIHJlZmVyZW5jZSBjb3VudCBpc3N1ZSBpbiB0aGUgVFBNIGNvcmUg
Y29kZS4gSXQgaXMgYmFzZWQKb24gYSBzdWdnZXN0aW9uIGFuZCBiYXNpYyBpbXBsZW1lbnRhdGlv
biBtYWRlIGJ5IEphc29uIEd1bnRob3JwZS4KCkNoYW5nZXMgaW4gdjQ6Ci0gZHJvcCBwYXRjaCAy
ICh0cG06IGluIHRwbTJfZGVsX3NwYWNlIGNoZWNrIGlmIG9wcyBwb2ludGVyIGlzIHN0aWxsCnZh
bGlkKSBzaW5jZSBKYW1lcyBCb3R0b21sZXkgb2ZmZXJlZCBhIGNsZWFuZXIgc29sdXRpb24gZm9y
IHRoaXMKLSByZWltcGxlbWVudCBwYXRjaCAxIHRvIHNldHVwIHRoZSAvZGV2L3RwbXJtIGRldmlj
ZSBvbmx5IGluIGNhc2Ugb2YgVFBNMgphbmQgYXZvaWQgdGhlIGluc3RhbGxhdGlvbiBvZiBhbm90
aGVyIGFjdGlvbiBoYW5kbGVyCi0gYWRkIHByb3BlciB0YWcgZm9yIHN0YWJsZQoKQ2hhbmdlcyBp
biB2MzoKLSBkcm9wIHRoZSBwYXRjaCB0aGF0IGludHJvZHVjZXMgdGhlIG5ldyBmdW5jdGlvbiB0
cG1fY2hpcF9mcmVlKCkKLSByZXdvcmsgdGhlIGNvbW1pdCBtZXNzYWdlcyBmb3IgdGhlIHBhdGNo
ZXMgKHN0eWxlLCB0eXBvcywgZXRjLikKLSBhZGQgZml4ZXMgdGFnIHRvIHBhdGNoIDIKLSBhZGQg
SmFtZXMgQm90dG9tbGV5IHRvIGNjIGxpc3QKLSBhZGQgc3RhYmxlIG1haWxpbmcgbGlzdCB0byBj
YyBsaXN0CgpDaGFuZ2VzIGluIHYyOgotIGRyb3AgdGhlIHBhdGNoIHRoYXQgZXJyb25lb3VzbHkg
Y2xlYW5lZCB1cCBhZnRlciBmYWlsZWQgaW5zdGFsbGF0aW9uIG9mCiAgYW4gYWN0aW9uIGhhbmRs
ZXIgaW4gdHBtbV9jaGlwX2FsbG9jKCkgKHBvaW50ZWQgb3V0IGJ5IEphcmtrbyBTYWtraW5lbikK
LSBtYWtlIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgcGF0Y2ggMSBtb3JlIGRldGFpbGVkCi0gYWRk
IGZpeGVzIHRhZ3MgYW5kIGtlcm5lbCBsb2dzCgpMaW5vIFNhbmZpbGlwcG8gKDEpOgogIHRwbTog
Zml4IHJlZmVyZW5jZSBjb3VudGluZyBmb3Igc3RydWN0IHRwbV9jaGlwCgogZHJpdmVycy9jaGFy
L3RwbS90cG0tY2hpcC5jIHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25z
KC0pCgotLSAKMi43LjQKCg==
