Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8463601E03
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJQX61 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJQX6U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B48680F;
        Mon, 17 Oct 2022 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051073;
        bh=PbG1OYX6Y4kEPBzVrb+ulM+TX4iJNklZW45J9wC/7KE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KGtWOlMGgNx7n09+tKlPuD6lxv3cZbh2ucucazoy9nsOts6rTDFQXDvFgjHBxrMnW
         MmtyxzbrPcv90argVqs7cLTJva56fODUm3Q5sVSseyK9hUgwsOJjZiXrBRHLX5OVqA
         c1zURgJ6uenfI+S+t0uALGz6mdmw+A6E6CkaTgBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1orPlC2ldD-00Bpcr; Tue, 18
 Oct 2022 01:57:53 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 10/11] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Tue, 18 Oct 2022 01:57:31 +0200
Message-Id: <20221017235732.10145-11-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+Q245lTUnEiVujLhjvtNoaAeMRZ564XmmtJA1FOAgd1QoYjag6I
 ucpHK1Neq2jBwcV5z02NNlIfrQyxyLdDLMY6NuRvAX77OBG4YVr38aba8tkpAywHJbsMc43
 HbTOPzXQLYUYN8hao5SrtXK3bLbzGn2hRo7y+pqibPJb37xD/5iJ1k8/gsx9hRPoZGZxJWN
 1dDD3dEhi0Q+lgHG9ib1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmmYQAqyqLY=:gOvchMX92CmjVRyT9DSMTT
 7P1gR8zjFRUCKYya372G9xXafC8uNc3hDei0GDOhw2ZjQFXRQ972S/e5KqaqkeQNNK8zYVhwJ
 V2mf2ctLRG0GMDKO35yuEUvcpbZOcvos/KJfk5vzDPooMAZyL+eotHhsgKxluyC+Ekj/6rShF
 hsCQO7vNP8jPFvpCr9+a5mj0HMWiwao/obebd3SMw3g7927pcrwH0ujomjI6HNg0s7R6Dh/2j
 d8uyPdizUUzUjxoC6gfvGKXl4QaCH3flpyTQ26x521rYmVbkFEXoTMH1T8dYGabweNBFj1PIS
 kGOc0JtKnI/Af3+aqlIpHAjeEZqYnX+H54B/I5pKykykF5O/r3vbC/X33ZZZzEqVVqiRSdifZ
 kdG1O01UOeno9kixpM1aHY9XhjRgw7izUXjXGzGbBxntp+rMbuiU52scHi33GP2Lm0xa9Q+pk
 B0CKKGNSDc8FZfdmo7a8MCwwhI+wF0yOeIoo+Lo26gZaXGQXTUid0BwW9X1MH+ow1XzcRjAY6
 ykEjUIM5Mtv9xB3HE6sXbJQLqA5MC0LcnsW1HY/9zZ9h/IjKKso617/XaGWSH4W08uhisSmSB
 XRFT8rQZtdYiOTs+htAnyB6MjMFv+XeQP/LYe8xhrY82/ip5uSnMtSOuDdG9+YoURcHRxcTkP
 OP/9IJFxNNZWlJy4dq7WqpVwMBfcMIT/XXjWNO7t1zeDtcwJLIJXJkioXtfV5wfWHaTDgCpoW
 h4sy+yRUPvkwIVHyt9BALmdOdMaBG2XuCdf97hWaf1STq/zIQnZ9w/4QtJQMA/dLT3+anccEE
 xNRqe41SAGnKT0tyjgp90qM0cP2FWRfIr6CRgBG2WgIn6MHHmWyplpiVSgLJojit0AwLHCl1k
 piiOtuapcffgwVLtqatuM1P5UrhAO39HZbgNK2e0/TU3ohh1GMhjm5ixR3U4eH71IvzgpfDSV
 S6YpwsT/dzCMziYWo+GaTVach95smGJ0ZJZUHkxvNFqAdN20mOW98bi/Toq9Logdq2DdKL58e
 nnWZ4MdwS6gTNSYo7QeZv3pInjOqEQoAD6i4P6HZA7714gKMkFbkVSQEXbdhNoJ2aKzyzOBmk
 vVxRvokKUB3ECY+x0RLdXKkXBHgvf3uqLWRGxVuvwUhtmuAywzP5aKYTnE2sNRFEH8y7YDamj
 xnOmmfTboqS1flS0kvEalAThp8x3IcaMA1Ke+W3gzZikGskd4KDLzoejGjOO/7lymQpu9dps3
 3TfxTctMINjQFCqeWNSrmaCrdS+sm2/+q1biiqhKUVctz1W3LfjNFCj1yS81F0/ZPNy6ydJXt
 qHVcHeXp/ePDMYxsyaI7XoZZTJfyCG2cFXzCKjfC8bF7D05eIMBNwDRd3zz+4bxReGprJGMcx
 f60dloO87Owm96TWIMzpWnX+qYpQMCg3bCEAKgA6SE8zVV9ccf91D4g8RicHFsbdjpYEI8gha
 6qr6tUi24KfNCrMVVgDm0or2grb1SkDzpEySpUp0TQk7Ka+ns3T4uknuPTP7HOSODXIMHlOyz
 ZbMm11i/4JFoSXtKGt6yN/aUaEctdIpp9TZ4Exk5IyLlc
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDFlMDY1ZTdhYzQ2MC4uNDJmNjI4
ZTUyY2RlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3Miw3ICs3NzIsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgdGlzX2ludF9oYW5kbGVyKGludCBkdW1teSwgdm9pZCAqZGV2X2lkKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnByaXYtPmludF9xdWV1ZSk7CiAKIAkvKiBDbGVhciBp
bnRlcnJ1cHRzIGhhbmRsZWQgd2l0aCBUUE1fRU9JICovCisJdHBtX3Rpc19yZXF1ZXN0X2xvY2Fs
aXR5KGNoaXAsIDApOwogCXJjID0gdHBtX3Rpc193cml0ZTMyKHByaXYsIFRQTV9JTlRfU1RBVFVT
KHByaXYtPmxvY2FsaXR5KSwgaW50ZXJydXB0KTsKKwl0cG1fdGlzX3JlbGVhc2VfbG9jYWxpdHko
Y2hpcCwgMCk7CiAJaWYgKHJjIDwgMCkKIAkJcmV0dXJuIElSUV9OT05FOwogCi0tIAoyLjM2LjEK
Cg==
