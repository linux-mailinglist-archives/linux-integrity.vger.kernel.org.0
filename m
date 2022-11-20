Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE5631450
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKTNcn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKTNcb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80DF27D;
        Sun, 20 Nov 2022 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951125; bh=1jiHlANZ8thD5aPn63BXGYT+VamFBFNIAjBcdG+2s2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ESJFfUJNvLFaEbcb5D3Iaq5mvXH433duVgAaH2oyhqUEKANpXBFF9tTRw3dFazHOh
         IgHsxvR12p7evjL6IepKdvLMZDYDSeupz7pSEGkEnwlkSVrFJvVcnyW9VpLJO1237y
         eF957fI/wjSTAnnFjLpOFznT7mfzeoMxZ/UdsgJo0Eu/+BxIDrvaluYjn5lZDGeTmL
         aZId0F8IzQFs6s0uADyJMNztiI2TBATIV3tIY11712gTAOPDQ6a1kzWiIJcAdCeHad
         sjton3aicJ/bR2BIudzVQgGBB5TyYcMoYzn4hQT4jHtZQYXh1rqix5uKf8aru981L5
         OQ+2R5FifreNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1pCLRF13qi-00tC3L; Sun, 20
 Nov 2022 14:32:05 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 02/14] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Sun, 20 Nov 2022 14:31:22 +0100
Message-Id: <20221120133134.28926-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:dVUxQWuZX1rElk66a9cVkpJrvR06Gi4LdaXs27+gK9dEmE056yk
 33YAC81FsrqNb+F/GS0ziIoLFBYuf/Ser1dsjsD/4e5vFweOIsrVSUSvXBwt6aOzbT7gOOK
 SdR3z4KY3rT6/XHhk1JAXxj5+whdmoKD9QehN5J9EQM2t2eLs4CbNOI1MR3o2UDfAEfp7W8
 ddAtyJyMrv1Gn4egUOHCQ==
UI-OutboundReport: notjunk:1;M01:P0:OxC45659cqI=;3PIefNXqEQ/fzKvFqqkFufmg4bn
 cPo5ZmNr4LTUzuafbBkqgupOfwG0K2zz5Mh19dzlindm2ufM7EfiLxzeKUPSawBTZcbExOwk4
 7VQl1T7s/TXiZwnncMLq6svmx0TYUZpZaOeeveOXc7WGZ0EX2+IV6Ushkib+46S35AQFEh803
 bwlOFwNC3L3EASKmpSAhoJ8+ehkaofXuCt3Q17YfvLLFZ2k8aNp9YZUxTDXK4x8Rv1aJ5HTyt
 8ec/w2OT/BG5Y8lvlYW4L+5++wWGbO5ef8p9KYv1nlulGQk97jridFM0CamkOIWod4OO0944E
 M3600oGGFMgmNZxw/85j4l+o4XnUavuGtq9nsxitroj1T8zyOzJ1JmiiBC4YCkj0hB87o3Aaf
 SKfSru4E/+2BMLt36y4XHOhWe202lL97RzPqYJZCiknrd/UNcIfQwq5zW6iiAYYHr2hU/h9P4
 UZ0xNxlmsCcvkc4ZQH7sHvhXkdq1qLc9xkLOBpubGgtT+OcESJ1fbQ3pCKxex6Mx7sgK0geE3
 gSzXuhYjzOS0UDGDEmANFbI723PRjqhUb2Ib3zy4wIS/2x2Ig5FOdGoFTWgokNECtcW3EaTzo
 NxMGuIooMpSRGtJpF+gI2vEPn2SyUXMvjhHmXzwRUVGAaNSYi0np1AU0mJBgu5lnYYefKWS3c
 okCLpGmWO/Xh7HOvIqfi0N/XlDlZZdHd1DBZl3jgBCtn5PZZOeSp/CNYQ8KRnOq0OeJS3nWjA
 NKrcnMKIUp3Mh6yXW0mGVH/LmiqryJpQnBYmF0OV81pthYhcwIDkoHFQYkAEZstIQwiarM4XF
 3egErqiaJzc+PVN6mxcOrsv9XeJ8HarLD9ERs09I7+RIWLiszG5HNS1ttFsFUDqZ+gqMmud+O
 kXLQu6gVbuvQ19HNOvZMqV83AAe6LKWA7JGMxPiR18XHRDAwicxWt882u6Efhj8cHDxK5h+U6
 98uJew==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIGRpc2Fi
bGVfaW50ZXJydXB0cygpIHRoZSBUUE1fR0xPQkFMX0lOVF9FTkFCTEUgYml0IGlzIHVuc2V0IGlu
IHRoZQpUUE1fSU5UX0VOQUJMRSByZWdpc3RlciB0byBzaHV0IHRoZSBpbnRlcnJ1cHRzIG9mZi4g
SG93ZXZlciBtb2RpZnlpbmcgdGhlCnJlZ2lzdGVyIGlzIG9ubHkgcG9zc2libGUgd2l0aCBhIGhl
bGQgbG9jYWxpdHkuIFNvIGNsYWltIHRoZSBsb2NhbGl0eQpiZWZvcmUgZGlzYWJsZV9pbnRlcnJ1
cHRzKCkgaXMgY2FsbGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZp
bGlwcG9Aa3VuYnVzLmNvbT4KUmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+ClRlc3RlZC1ieTogTWljaGFlbCBOaWV3w7ZobmVyIDxsaW51eEBtbmlld29laG5l
ci5kZT4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKaW5kZXgg
YzAwMDhlZmI5NWRjLi5kMmM5YzlkNzY4OTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwpAQCAt
MTA5OCw3ICsxMDk4LDExIEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJCQkJZGV2X2VycigmY2hp
cC0+ZGV2LCBGV19CVUcKIAkJCQkJIlRQTSBpbnRlcnJ1cHQgbm90IHdvcmtpbmcsIHBvbGxpbmcg
aW5zdGVhZFxuIik7CiAKKwkJCQlyYyA9IHJlcXVlc3RfbG9jYWxpdHkoY2hpcCwgMCk7CisJCQkJ
aWYgKHJjIDwgMCkKKwkJCQkJZ290byBvdXRfZXJyOwogCQkJCWRpc2FibGVfaW50ZXJydXB0cyhj
aGlwKTsKKwkJCQlyZWxlYXNlX2xvY2FsaXR5KGNoaXAsIDApOwogCQkJfQogCQl9IGVsc2Ugewog
CQkJdHBtX3Rpc19wcm9iZV9pcnEoY2hpcCwgaW50bWFzayk7Ci0tIAoyLjM2LjEKCg==
