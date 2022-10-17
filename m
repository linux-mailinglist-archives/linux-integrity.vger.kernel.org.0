Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA07601DF8
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJQX6P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQX6O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015647E31C;
        Mon, 17 Oct 2022 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051073;
        bh=jDPq1ycfLA3Z7wF+Um4FjFbBCWSe4kP5xzmSs1/LP9Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z8jztJPXlVz/DtDZuXC5yKXEEdFj49irePwI8mQLYfihn5KQcUNxGeSx7vX4PKhNR
         2L1GOXcIq6XF/mCijRb8x/F0d2AdxDkdPBLCBF9203oSrRecYTUNYE/ApP0QhA5OFK
         nPJcfZDgDR1YgSfvj4RDCNsJFknWOeuekcYuDBcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1oyf082nGu-00uKuQ; Tue, 18
 Oct 2022 01:57:52 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 07/11] tpm, tpm_tis: do not check for the active locality in interrupt handler
Date:   Tue, 18 Oct 2022 01:57:28 +0200
Message-Id: <20221017235732.10145-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:8fzQ80YFE1JxOIOkmc8gb1a4v07OCSU8Nki0/obtUv7TZugvRGi
 zzA7ROYCz6GiXpq4VB58OhxEyjcDYFiLmRXLMml1/gX39DnPWFX7Ox9Xd7L/CcniqmNeXfj
 Km7FM2q6o1+8zCE3HsJQ03Cx+/jxeeczczRqfYfwCzNctW6MaNuGjiNV7xXguqFjh2PuM3+
 AEvg6iEcV8CCeUg/DWJdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WCX/xJUkGfM=:icJMdXk5/aHxDH8ohDrDLR
 DGC5XoCM7zgSpCitZmTArL4nyIkGlMjqnyps3iMLM+IdObgGkP1oBNHn4ATbCFOmQZxu03xDV
 ZvYqKoonzDiywyrnBwqF4ZKsfNQtIr2tWzpG4qvZQDRXKUcWi/soswgpxuIIHwCY9XkkpOTjU
 UojG4FW9sjELIOk+tZ+bzlw/eGPy1/RP1/d3ugZKbQ+O6VPXcnd8EEy36aVR7vVFbTRkoIChz
 TjkT8amRPwNqYk3yiFuMu5EySX5fFlW1xgv/3CFoQX634ivFQ4pOvZz+8yohCD0PQoH2sdXbB
 kh0J/CRZYSe2AG6nOsM0Hd5OM0VxDXUGl7xUkE9k4TtkRxh1ElDCFE+485F0CW4VnQ6b1VFGj
 rn170kzBx2QmNBmD9e/DxHd0BFRiQYHJSg57VW7LPMqzPnozzrJ6KQ6ryHZUDDlqxbupOqE8v
 x9j9yStDWT+cPxZG6O0+puIpTdAai2voUha4QaYb1aK2YbwsAgUYe/sAoJIula1SCZu00/AX/
 +bMvuUtG2S8j9faJOEO1AbkmRnDbNjdbdHZjV5kTC0Sh55QuftOP1hF9wEDKjfyJq2AYez1K5
 DjIYduhFr/cKeK4gZ10X6iE4dOJ6c9L10PbBmtw6md8M/DbshyYC5qDaia5YAxVuRf1Whnvm2
 5r1qpODsBedlYKqjandNqc+YZ3x5zotWN8IY09vbUkliz5p8g2nwIwLqOKJCQ2HMBGSQ3ksTB
 hjOrw3xkW1gzdDBOj2tSlPC2rq77UiX1kzglCpFOzOS6uEr0FKifOHjPPdchiy3fxpLo5fsOl
 gTlHz6V1G29x4F6wZKlAGYoGWa6LkNRtc43FgyMOIrxNbNfz8Cbr1FNzWRVxcCr5eMdxDlehb
 cvUVZLAzGAyk1C4/9+Un5cZIu9W67RD4ybSAQEnf1FDoZMeTN+nTcRIvLsvmIZfU60fmwV5yD
 DmjQmapxqFIaB3nJ+I72M0q1o3gXHCbby4hLv/2PmNHJ564+8GuBd3lGLEbvALq1/GJmiICCx
 55jokqbvQY0aaVQnJIyXOpBws6ZBtZUoDyrqDZPLHY6SA9DRrJqwd7KcdYhhql8uXvOiCRkEv
 oBdZl2juMrVlbf9LGvv45jlXovMduNlFd78fnvXRBJ9tVICmvCvzJ+4KUlqX3LYuM79ak2d+I
 7LbFwgCwRf0+d2/7FSu2i8AklopF7dxBKvUqfVM8iDb3Lndkg5M2HPhG7SnV6uEpA64mqAXMC
 BUx/LKXp5KyQ0rNJFRev2qX1P1aKJeJjAfDQ3F/aqB4xe/XWRs6M+3ejsXCJEmBoxyeLJP3aZ
 3k/wnv7Xx3Fepp7qXVW/TquvnpQ1T/D74aex1FMydHRuYCdH4Rcr9Lx/T48vpLotP54GW6+W4
 QyIGGazDYcy7rQ6rnPbDtNiod4y2epIEuScPQtX6gV2eIPyzGlBfGOCHkitvaniMUGflDgANA
 aDeG199a4kTCd05/qizehM7Tz4wexRaGKG/y8HeznWf0Rd8LKaeY4mNknUzWRi9fS9t2Q2bXr
 5ZZZ6vZwBnuluUpJsHaWinc0mIKOB9n5QMn33Ruv7zSBR
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkFmdGVyIGRy
aXZlciBpbml0aWFsaXphdGlvbiB0cG1fdGlzX2RhdGEtPmxvY2FsaXR5IG1heSBvbmx5IGJlIG1v
ZGlmaWVkIGluCmNhc2Ugb2YgYSBMT0NBTElUWSBDSEFOR0UgaW50ZXJydXB0LiBJbiB0aGlzIGNh
c2UgdGhlIGludGVycnVwdCBoYW5kbGVyCml0ZXJhdGVzIG92ZXIgYWxsIGxvY2FsaXRpZXMgb25s
eSB0byBhc3NpZ24gdGhlIGFjdGl2ZSBvbmUgdG8KdHBtX3Rpc19kYXRhLT5sb2NhbGl0eS4KCkhv
d2V2ZXIgdGhpcyBpbmZvcm1hdGlvbiBpcyBuZXZlciB1c2VkIGFueSBtb3JlLCBzbyB0aGUgYXNz
aWdubWVudCBpcyBub3QKbmVlZGVkLgpGdXJ0aGVybW9yZSB3aXRob3V0IHRoZSBhc3NpZ25tZW50
IHRwbV90aXNfZGF0YS0+bG9jYWxpdHkgY2Fubm90IGNoYW5nZSBhbnkKbW9yZSBhdCBkcml2ZXIg
cnVudGltZSwgYW5kIHRodXMgbm8gcHJvdGVjdGlvbiBhZ2FpbnN0IGNvbmN1cnJlbnQKbW9kaWZp
Y2F0aW9uIGlzIHJlcXVpcmVkIHdoZW4gdGhlIHZhcmlhYmxlIGlzIHJlYWQgYXQgb3RoZXIgcGxh
Y2VzLgoKU28gcmVtb3ZlIHRoaXMgaXRlcmF0aW9uIGVudGlyZWx5LgoKU2lnbmVkLW9mZi1ieTog
TGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL2No
YXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNyArKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDE4
MWMyOTFiMGJiOC4uNDMzNmY3ZWE4YzJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3Rw
bV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTcy
OCw3ICs3MjgsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1t
eSwgdm9pZCAqZGV2X2lkKQogCXN0cnVjdCB0cG1fY2hpcCAqY2hpcCA9IGRldl9pZDsKIAlzdHJ1
Y3QgdHBtX3Rpc19kYXRhICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKCZjaGlwLT5kZXYpOwogCXUz
MiBpbnRlcnJ1cHQ7Ci0JaW50IGksIHJjOworCWludCByYzsKIAogCXJjID0gdHBtX3Rpc19yZWFk
MzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJpdi0+bG9jYWxpdHkpLCAmaW50ZXJydXB0KTsKIAlp
ZiAocmMgPCAwKQpAQCAtNzQwLDEwICs3NDAsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGlzX2lu
dF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQogCXNldF9iaXQoVFBNX1RJU19JUlFf
VEVTVEVELCAmcHJpdi0+ZmxhZ3MpOwogCWlmIChpbnRlcnJ1cHQgJiBUUE1fSU5URl9EQVRBX0FW
QUlMX0lOVCkKIAkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwcml2LT5yZWFkX3F1ZXVlKTsKLQlp
ZiAoaW50ZXJydXB0ICYgVFBNX0lOVEZfTE9DQUxJVFlfQ0hBTkdFX0lOVCkKLQkJZm9yIChpID0g
MDsgaSA8IDU7IGkrKykKLQkJCWlmIChjaGVja19sb2NhbGl0eShjaGlwLCBpKSkKLQkJCQlicmVh
azsKKwogCWlmIChpbnRlcnJ1cHQgJgogCSAgICAoVFBNX0lOVEZfTE9DQUxJVFlfQ0hBTkdFX0lO
VCB8IFRQTV9JTlRGX1NUU19WQUxJRF9JTlQgfAogCSAgICAgVFBNX0lOVEZfQ01EX1JFQURZX0lO
VCkpCi0tIAoyLjM2LjEKCg==
