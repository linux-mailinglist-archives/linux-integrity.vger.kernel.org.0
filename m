Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E655631456
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKTNcs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKTNci (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848AB7A;
        Sun, 20 Nov 2022 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951128; bh=oScRVbxrfAZvMb4vGMxtk0THIEPoRWv4PH6mpzzQxyU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BIsKDu9oeKvrALhGSAcrokwQfOIXZZdmtP22KCKbqiS+dD4mhMEu4dRm5H1hRBhKG
         ZnoutdrPJewrCEBcauz1gcFlvHcGsu8cS0pQCU7UoeIg/1ieF6eV03XjWs37woIL64
         n522vv32jRvY0/euLkMlUApdc9hJ4OJkN5Qy3CAtrnPCRmbt/7uHfJDsiK6V9n6URD
         5uSMLCXMVoODZgP99ZyfMWfZGEgXWnr7tSe8gp3i5b8uHg1PvPOCrkOXpYZchqcJ0o
         T8YxJVVSoL/63XURzZIV5OAG9K65iOL2/mJuxBTyNbc3st37kAcwfhClAriXJkBJmY
         3TSND06Ta8aqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1oiz3S1l22-00DotB; Sun, 20
 Nov 2022 14:32:08 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 11/14] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Sun, 20 Nov 2022 14:31:31 +0100
Message-Id: <20221120133134.28926-12-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:84xPu3tCUK7zirPgmWTPn+CQfvQtzq9WkhaRX7+boR4TkLhrnOf
 g79mgN5DxYpBbTu+2iAPgUpC+mRLb8F5Toqpr01QbqCVvNAFIEVo8Oip6IwFpMtFl/sdZ0A
 0PPkjD6FApCR4ldNCUga/kuiNUP+mENaq6xHCPkQJLNjw5t1dRtPKp2zl84pvdw2L/HlB66
 nbkO1VEqsCOYCc3HfdfTQ==
UI-OutboundReport: notjunk:1;M01:P0:38sDud5K77I=;2r4LHhx5wFQcp81SQEy+mGfWmDT
 fnLE8e969kQ8lOHGNbx2PbfY3myXkYjBqa1879OBiYEi95v0qusWI2Kv17iG3yNxdD0GdOZOV
 CKA5N9MyP/oTfCjerxtXD3b1W3nQ7H1QAa1Ffz0nWd0hsDP9hbqUxduthWKPPP1XPvdO51oux
 zIm9cM4xoMdTsJYq6+Uzi1ywTLNrNfjE1EuJxPTCHpg8/yFJblVaYPz2Ue/qOYT54zX0qP45t
 ZMTgcj1gybtmimxoRnSZrIyzaEp+cZsrPaCI95b2KqKpupqjgFybhF3D4XfLLhdQaZWvLY94W
 qyV5cGp4YKuaSJEvTQUVZncWFTKungOinQCx7U349SlGIPlMsU4WAw2r68A9T8V6reAx5JpSo
 Wl1uZ4co/o0dTCTudXXLPVzQZx618ZQm6k591m0y2AgFYVy0gqNWh8MNiWRjsYjKxZoWNqnYJ
 ql0NQnjshQ5nlL5/yf68Rx/dj5hiEP6YG+XBAH/ysqH7nHj5W+uVvY7uR08xklJXbXhtjTFD2
 sNrTz4EqFU4YCe9cH1DnUO87VGgN1qwR9zV/CKQm1dCoWQoJPePE1PkBMEMlwU28q5DccNW0p
 yj330R+jS62JWu4bO9xG4yebvXjizW/Sikfwgc5wrGuINFzLk56uJDCXk/PpFLTHrrkNeMSpz
 xnq//WurEtCX8pv6cDC9+bIW0+jdYi0CB/f0YSPKeaiM7ppxka2zk7ggl4iTWtYgTVxMldtdI
 uB/7m7fp7MfdNFN41UI7qgNxvjpptPaZnwr1MsDWQV3rCTsVtALFxnnKUKv4yqVR4ZKsJgBLT
 wgIjmD9EySj18BkN3leeWgcmU+dfoGw2NeNPKTj+tnuTMNbWcRn7jrl1xhebr3oFJTDZwvEH0
 1XcPL3/iJEjyfHulcOGOtEU1TpZW/Yq2J2omPHV30qRYdmyJBrjfBQIqsfEbHbs8JUO9NNJjL
 HrXqOA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
UmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+ClRlc3RlZC1i
eTogTWljaGFlbCBOaWV3w7ZobmVyIDxsaW51eEBtbmlld29laG5lci5kZT4KLS0tCiBkcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDZjNzY1YTQ0MDZiYy4uNDMxMmM1
Y2MxM2RhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3Miw3ICs3NzIsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAKIAkvKiBDbGVhciBp
bnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJdHBtX3Rpc19yZXF1ZXN0X2xvY2Fs
aXR5KGNoaXAsIDApOwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVT
KHByaXYtPmxvY2FsaXR5KSwgaW50ZXJydXB0KTsKKwl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxp
dHkoY2hpcCwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0tIAoyLjM2
LjEKCg==
