Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D76245B5
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKJP0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 10:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKJP00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C213FB93;
        Thu, 10 Nov 2022 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668093943; bh=1jiHlANZ8thD5aPn63BXGYT+VamFBFNIAjBcdG+2s2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tBSnKYPgH6D47lLmnwgVr7yQSrBqh22q1ZdVRPBH9Qb2djQs6HBVqh3gn9UUbx22m
         +YAYJaMd8WZEuJrSHfXoRH3aPyFpxPg8uD1/77PoR7BoqtvKZvWBovykiyDkivK0Pq
         zTHWq1jI5R9aTeUXi5LYu12gMywSqr/hp6bcRF6tdHUpKPbPad36o1w5qSRzsJHHR5
         JV3lWDUTd/WxPGfIRet6KM+COREg7QyvvLT1qdn2r/Zvmg55P9CsI4Ctv7agjUNBF8
         7F2SdwJrjxqri1mTQ8Xo9W0P2RjYtY+2QZWQj3v/7zIRygt4MS2WUa3FNKPgY3nTh1
         cikmRSeCdBFFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1pDh7d1rP0-00y7Y7; Thu, 10
 Nov 2022 16:25:43 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v9 02/12] tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
Date:   Thu, 10 Nov 2022 16:25:23 +0100
Message-Id: <20221110152533.24243-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
References: <20221110152533.24243-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:oYO90qW9He7dtb6gu2PAAleX0GX/mDToMlKMdoDqFAGkp+nPrxG
 5WgmVLg2Pty/dWUtpqxRpsDGPHjWUhmY9pGoYGVcwdou9xk44L0dmxowttHxrMPOv5Hj2+H
 IFO7b0Z/MTh91TvfkYlNsshDZEhne8yiXVhO+DmvrK77h+sGRKv+1Z7IQOyyOGfal0yVGcE
 h3BpUy3vP49NWZTxAoAqg==
UI-OutboundReport: notjunk:1;M01:P0:E75M3kG0FRw=;PoUhlxSyeF+FBtAAvBxELEZvhJD
 22V3YfwXI1leI/YSBGvx7cAViigGaIHdBO/d8LBfZuGTZl5emWfQw62wt9EtrWMDvcPiFg3wY
 rSNR969pNvrTSHHf2Jm5WKaIMdTm0nH85yWr8D36E5JkpC7SN3GGCxJ+TCuzKoicvyZ/Tgq7Q
 EtvPw5YOGFjte3cLnwlq7oVSl+9QfS0WGE2BmdaPpRCjzQsmQQYvpeV9pVYCy0EGB6Yn7+yPe
 d5oUjdiITMDUB5/apF+dOhq9fYNjx5AOXeg299btiXsRvyG4TP9JvlFYrS4K3j8igT5GaH+7U
 t1R+en+BChgbqOevILAklwwVFE+M2VTFvA4O6kyU45Lrw6z4qWMGg7qC/N0DJngAgNuYOoVNu
 AGojVIBOfPh6Oq80Wk17fytuRBw8FCSTe45BPYsKpJz/PF1NuRa+MF2hLPqZefbyWAWq95QeK
 saOFaOEjWyRczYLzwwd65z5lznxsZrHRBKtUJvJqZrcnp2IuEku6PdKyCPVJXlLcxB6cDM+R/
 qGeBO4AI+XbZOkZD1r5Jlk+K1aaXMxe4/wKNO2YpL+/utde2ZBcb4f3X6oih1LEGQ7f9qqkvu
 HkIDjwao+6OKBdhcF6ax6MqqJv8WR7GQisStBmVI6fTodZeNkUuswUUE4Qkhz+TI/oLVXc2dx
 5izJsH5EDAexz7t0kVoIMzj97eCwD7njYUuc3fLC2hzoneo9C9iFGGv6ZIm3Tw9fsxWb9Uk+K
 VVB4unNwghLpnSMpDIob20cTxDCqF9iTWAdl6G2PGzYAt8ZkYSNWJwIrhG5/pqXMUKb0VvRJh
 skMGhLzgzgWR6TQmDs2PqHpQpELOkmjAeN7jy+hwgbLHMhDSkm/8mV6LlNWadKOHRTUvOQJG0
 Noc2dHBHESUPqrtfWAQE0Jf1y+pJwNmJmzrmowJDploqmfPiIWizuEuYH3H70MpQ/8WyWExBo
 /LQvgA==
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
