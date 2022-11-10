Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E26245B2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiKJP0l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiKJP01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FC3FB97;
        Thu, 10 Nov 2022 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093946; bh=UIWWgQ8b2fsRQvPfPfHkm6StxCKq+xmUwy+9yaUc8mM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BjTOY1Xban+J7tuRw9hNZDmSQpSfFdGFoM74bNhMXFwvmdWwXD4e4NyQ++zOgAL4s
         hLKL7mWHv9BzDYs+xe6d9ILU80K+mQowxr9K/ojkEv+817WoBbxvajKkvFwL6WsUUI
         mw6FGOkOuPX2akB/wJxeXaSclPIE8vysxxvDaU8aZmtRhZIFfmzEt2ADjlLuN9YMkW
         bSE4+uqzw4PPi/pylCPhkfHygYMHhEX649WAch/v4EtqLxLP3iGVx+h4XTwqtdou/P
         X9Z0BkODbyMlbuWDDKLJy8Vcta3Q5WmN67u3mvJuQx/egRyxPIZU5y8w3tywnsfiyM
         DI2umVjQrcNdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1pOukZ0B1Z-00d29g; Thu, 10
 Nov 2022 16:25:46 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 10/12] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Thu, 10 Nov 2022 16:25:31 +0100
Message-Id: <20221110152533.24243-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2NYx2+Ps04Palgl1CFkfiIo2TjusG1YVxjgYjN2mHwYOy73ZM3U
 H8n/wi2pJbkHzUBOhGvW3nUkq2/M0wCFYzjta7Z0TMx4TvtUdArQhsph6w68hBRQnifEd7L
 bNS5bmuLQwGr1CRKQkrzO7XoVVgCZZ0f8M/Jbktx02kMK7xA5+Fbm84ScDHgpZ7uvst3vrU
 U0pb5hCGgledCXaQrg5tw==
UI-OutboundReport: notjunk:1;M01:P0:RqxsIU8P8jU=;s67SjEbbNtsoRtz0NiA56GTdUZI
 dO0BdJIhcxeMJtooWqcsH/HxhzaBKrkA0YHiqEoA5kVPd1hu9r0WnsCUN/EBs+oJbHlaZ+8V6
 WxvLQfc03RwIiCBM8rrqx9J8xX8BMLjCUemFHPBcN8LoPZbFpNLW9o1gJLXwmqgEXcsTBxOV6
 Mm4xavlAqaNQgTVExNAk9Dwfvr2/8Bbbo9bMKnrZWrEGXfglg3UoUpoNl5sfOYz4HsL9NhOBL
 x1L4PFrKBE16JPONBEiHJl2/aBEb3eFaNuUIXBRKR46kx8M9X1ym041CJhWAlyA3baX/Zi0X4
 trrdljAVoGYFYdMxOE6ieqQnautVv3xPtopg9PK2fi15rUelT83Mq0EnNA92E70X2+CtI4FIq
 33hj+0vjw9EZDQWHK/JjWFx8e9+78+R48YAmZyQ10DNpRlE6tmMtmQjL5jU+EdBVn1Qj7QeFP
 mTrWvNJMxCNR2uw18+GnHEgGWg+Y+dEgZkoxLI+dlb9HQOgi+22GvWAMehRdOwCs/urS6iAXM
 EEzbe2MjIwtVOFKKqrLV2Yyw2UZoHLu2TcNSd1GAyrgK65slMpflhiKtKhkZnm4sgn4PgdSSq
 Ou9lv900KettuK6tH+kg0OVqJoODarszSJbv8glsl/Y8v/+DgUDWJcrL4WINjLEuknDRWZe7M
 vFqVdLe68ygRtwNp5vhbZiPSzL920geyX2eEsiX+kbDKfU8MWLHz4IY2YMzIy4IoFjMqWmXgT
 kvn2e/KrvdLEo4HrHpsbVN+WyQHH7XUwbEMHPgC2O1VaIxtvnSMCyILJj3PDm1IQqnfixnj2l
 JUoEBnVm3Mq/rIIEucnPGawbd4p4ABailymKtKU55plW+vRPfbxIbfysXhuh+ampBvgchsCO6
 hssqwvQFvmLFc5yKY8jvaHElXaOZZORKA5BwTwJqRy1wik6GxIAZZkAKmYypkaszCjvjDMB5D
 4vR1IFQV40K55Oav7HkKglytYs8=
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
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IGNlZDhlYWUzZTRkNS4uYTBhMWIx
YTNkZGM2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3Miw3ICs3NzIsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAKIAkvKiBDbGVhciBp
bnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJdHBtX3Rpc19yZXF1ZXN0X2xvY2Fs
aXR5KGNoaXAsIDApOwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVT
KHByaXYtPmxvY2FsaXR5KSwgaW50ZXJydXB0KTsKKwl0cG1fdGlzX3JlbGlucXVpc2hfbG9jYWxp
dHkoY2hpcCwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0tIAoyLjM2
LjEKCg==
