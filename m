Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365FF54651E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348883AbiFJLJ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348215AbiFJLJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA814641A;
        Fri, 10 Jun 2022 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654859346;
        bh=f0hgcapl/IoE42TzU30gGyD7O3DJqxrqwIi8kJgwDuE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K0l9Q28V4fQiCGQDblJ+XmxBcV/+PLzeV0fXd+UDX+sDmKLddhM8FRHHXhLPxTZEM
         c0yIf3UY37XSJnQDH0VAjA2ieMt8454gbsyxWQYZI1sZhoI/TBMKXZzQ1sQD9VYBiU
         a4+9WjPqIopmNPxI+Fha41V7L9Z3Fod1d7UVWmeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1oAO8x20lN-00SwNX; Fri, 10
 Jun 2022 13:09:06 +0200
From:   LinoSanfilippo@gmx.de
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, LinoSanfilippo@gmx.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: [PATCH v5 09/10] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Fri, 10 Jun 2022 13:08:45 +0200
Message-Id: <20220610110846.8307-10-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:r2WmL5qwtE3ol7sMxd9LN5OA98P6W11HBYUkZV0WVdnn4S5mjBi
 FoR7Hq6GxMzpJQ6xiWxULZFad9HcvJf7+qmGV0WF2cIXWJgr0Lzs9mMJHwbWSrkhNzEswi6
 Tso3sqqew0wLds12+ibPVwLqCr1uJ6WH2TjHYqPlSyZCgMsRkP9BtM4NEFZSvU8SECQOx0q
 ycEirgRA4oMDln8zLCbUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8R2t1Zfv7vI=:eF6U6B8g76Klv5jD/ERrYx
 6rpAT+LAsPjV33u7FwzhTB0Xb3OPr0DiH0A8N2zvKWJ2xaI8+BE8UPAqfrGgy9CiH8FaB0P2g
 S5N3sIti4io+q/7oCNxM2XisV5G14eCHo8rJ7/ZCD/yG9lgnqY91978bgIY/guP/va6RBfudR
 6jIKkb/VXZiHM8K0Lefqv0bO/M5/+5Vu2gPTxrwtxDfYpNr2SLMXzFtwgwYC+3IfkVT/eyfW6
 EoyfIa8j9xrXvVZWHxOC7jtCC0gzTnBzaTf0iVmlxN7SzS0p1DVD/xqZAKUF1ybtPPUkEiXTP
 0z1uI3Qy7qA+jIeC1mHBhBs19LBvwc/sF4cgxEGQaRVhaPp0NFFWrzfvLY/pV2OVWLQNKBaRO
 1u5uAIUGtlj8ijshrNxzr1+EKx3e8LayRij08ziQPMSt2c4vbs8+x08T0r2eIB0NBK+wp7LRK
 klWysN3dwCBUQ7fK+EycmDBg+YD5Ux3fy9DBILT5LL2i92QFQ2CEE5vYY8M/srURcTMMtupZf
 nZCYK9Abu0xSLYVceMRH6BgszHwV/JGEqk+xr3kvjXeLeVpOMV4sz4UyBknbJDGopcSnb/JxL
 1+d+niMWnk77u2ruRLVAvKOSgqBMzS/Th7ynxLlEWCMkSEdIYNZ93DEgIUjKAitVIYgvKiy2V
 aJG4Y57YRpbPe96xg38ZQAZGhTmbFcpQKs/SBafD7yKzG0XhhDVF1aVhwjjZ3OeUa3tnTAM1r
 Q2TGCC6jROegDHztYnbTdzxxUr95Z/1v41BO4PC+xy9kdTiQP6eyBUQD8T498eFtPjLyrLp0B
 ZOmCIKf/mtmiEpXUgtF5wlUZtvnb02dYY/9aLQqVphD7SMykEhrgWM3kEC7CT7Lt1TBvbE+m5
 BmB1d2Zsm3iQFmFZNglHq6KMBsOuZd3XSw2pjh9F/m2XZgIJYhCjrgjAg4dtPCJz6lGcMb3Qu
 XE17MkT+LZvqjytYYbNyp9rCg5/MmfB8sG9uQhG2Xa9rYuhlGqtoKQeV2Kn3VrTnwDFwhVE1G
 2waroHGqHRAtBi363pMI6irCLhVRHzuUSQ2ATGQIOTTev/HpCr1hdWEhGBG3LoFQfPO5aNFrb
 HlvHxS4BcHh1AERknna5EOke9fXXxqEFUOKXA1A5Evn8BCxzLlm2ENO4Q==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldyaXRpbmcg
dGhlIFRQTV9JTlRfU1RBVFVTIHJlZ2lzdGVyIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB0byBj
bGVhciB0aGUKaW50ZXJydXB0cyBvbmx5IGhhcyBlZmZlY3QgaWYgYSBsb2NhbGl0eSBpcyBoZWxk
LiBTaW5jZSB0aGlzIGlzIG5vdApndWFyYW50ZWVkIGF0IHRoZSB0aW1lIHRoZSBpbnRlcnJ1cHQg
aXMgZmlyZWQsIGNsYWltIHRoZSBsb2NhbGl0eQpleHBsaWNpdGx5IGluIHRoZSBoYW5kbGVyLgoK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMiArKwogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rp
c19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDhiNWFhNGZk
YmU5Mi4uZTVlZGY3NDVmYjIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNf
Y29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc1Myw3ICs3
NTMsOSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9p
ZCAqZGV2X2lkKQogCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAK
IAkvKiBDbGVhciBpbnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJcmVxdWVzdF9s
b2NhbGl0eShjaGlwLCAwKTsKIAlyYyA9IHRwbV90aXNfd3JpdGUzMihwcml2LCBUUE1fSU5UX1NU
QVRVUyhwcml2LT5sb2NhbGl0eSksIGludGVycnVwdCk7CisJcmVsZWFzZV9sb2NhbGl0eShjaGlw
LCAwKTsKIAlpZiAocmMgPCAwKQogCQlyZXR1cm4gSVJRX05PTkU7CiAKLS0gCjIuMzYuMQoK
