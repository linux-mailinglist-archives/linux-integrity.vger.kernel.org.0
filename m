Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B147A7169F3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjE3QnH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjE3QnE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 12:43:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27744B0;
        Tue, 30 May 2023 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685464952; i=linosanfilippo@gmx.de;
        bh=u1Qi/uyeai+mxP4oIO4LBNtj6oBBjuv+rvd8DOos6DA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HmYDWFS+CGdZg70bqpCf3Dic5L4jdOeIbQtheZlf2nloF21QvWfy3R0GzAwH6M0Se
         YmPIQZIFHweJaadvK30RDb1frF1IBuu8XhGrhVR5W4gH7NWNuksDpuUA9LUofU5Ts1
         IURs2C8PkKITbLoW9Vxc/+UKDdKQEe3P7FQ/6o08iCRWHZFc6mFvpagoRA47vB1rGi
         9XpMIiAcaCirUTUxHsorwtucWfC/BZoui+sHcfBOMSFoCwfdH2fW6tpwIJEBiryCVB
         M5b26FUoUM8PO0N4tmQjnEq5CXMP547iIoeMgy81seS36EEjyNhhQP9v1SH/IPq2D/
         s4+QixkHMHsDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.2.106]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1qMOan3hwk-00uqW5; Tue, 30
 May 2023 18:42:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     jarkko@kernel.org, gregkh@linuxfoundation.org, pavel@denx.de
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        linux-integrity@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: [PATCH] tpm, tpm_tis: correct tpm_tis_flags enumeration values
Date:   Tue, 30 May 2023 18:41:16 +0200
Message-Id: <20230530164116.20770-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:TUVoDoK2i79i8sGtpHBNTotsLMum/R0RJEoMsqgZp0r24XisBnL
 Ff93M1mjHQlxFQsP1RfB5Kv9C260ahJhyrDBi6qcnUq+JWpM40a4WR9u6+Og8dxZVOrLG2Y
 Wfgy2Bl7jcFaSAk74Ns0UUmBpLCQRhijzMQyGCxpJ7zZKaLeFALX1qLoezM1JTstx9vNjnx
 Z72OQUfUMCdTI/+Hyq6cA==
UI-OutboundReport: notjunk:1;M01:P0:6GuG2S5CW2M=;hPugnMpdH8eeolGEee7DcQ92SGP
 HPxbNtb/5cmh+ZkisVbeA2rI9JrTZal7+tL4CCeFwKzB2INMLwYfLwin8mw4DHiMLT8xyZ83Q
 RvldsgU15PEy++idb8Ai3ESxTPQBOO2XTmskknWJz2INdz5H2ZXFhN81MhOj08r87kcY+Ebu4
 khWHpGmtw2+hCJAGi567yGwzGaUMEF1uF3TYocbUUZHrV+AChiLW76FCxvo8SsbIV4K0QR/5P
 skyVGihoRm2C1GsnLmFS4ro7eTVY6byNq1oeFE9EA0FL/8VToLdPbocAb9CT5hytM9IPeAt0o
 rOS+UFjTfvaZgjdYJ3uwuSw1KVzabCe1htXaorhj2WxSjSUXkixxZ2saeulMXjM4mU1wqButF
 /twZuoR6c93xC+RC9uwm88sOMOryy4cdU5noh4fGiILrSJc5/pxQQ2KWTFoMgT+y6gwOGSXaJ
 lypUOhGpIKdyBk7ciyhzOXVe0FB/HXsrynd3Dm/TIa+JSkz51fLIDaC3zuu6aQ4s//mDS8jvt
 +fTrwTQ3edOl39FzzoSKmWhDHBUIVNrG/vnSicc5UebUNWD9na1LGojjQd0k93lccT1oMHprJ
 yJFC0YhjIsAD31BUYUEw+iyKmr0aqOpPiqFGMf9WqIvOsabtSOv4XeJMn60DLJSx8Tjfob4Ke
 Pl1JN7GFezJ0gM11WnCn+CwZNBWdi5ofuhx6pKoWnDOa9B8VNN+H26ZwkOefs7LXDphlJ8sFw
 6mdkKt9ODCgt3HRiCy2CWXSVCu7RTeqJAaeg7Z3hiVOFEtrM8IT+/djomWWiPESktzWHz48KK
 3K267BwRWA7unQQUanCJW/O2rUjM+7mh5zu95IStXxzP0UV/JI5r5vRcfKaWaPEaUkkm7o83I
 lKXj/cF45tVQgUmor9mr5wLdknn10o34RqWlooKBrOH25Qxu5LB/y4ovUjF5/ySkh7KRuCpup
 iKzqYg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCldpdGggY29t
bWl0IDg1OGU4Yjc5MmQwNiAoInRwbSwgdHBtX3RpczogQXZvaWQgY2FjaGUgaW5jb2hlcmVuY3kg
aW4gdGVzdApmb3IgaW50ZXJydXB0cyIpIGJpdCBhY2Nlc3NvciBmdW5jdGlvbnMgYXJlIHVzZWQg
dG8gYWNjZXNzIGZsYWdzIGluCnRwbV90aXNfZGF0YS0+ZmxhZ3MuCgpIb3dldmVyIHRoZXNlIGZ1
bmN0aW9ucyBleHBlY3QgYml0IG51bWJlcnMsIHdoaWxlIHRoZSBmbGFncyBhcmUgZGVmaW5lZCBh
cwpiaXQgbWFza3MgaW4gZW51bSB0cG1fdGlzX2ZsYWcuCgpGaXggdGhpcyBpbmNvbnNpc3RlbmN5
IGJ5IHVzaW5nIG51bWJlcnMgaW5zdGVhZCBvZiBtYXNrcyBhbHNvIGZvciB0aGUgZmxhZ3MKaW4g
dGhlIGVudW0uCgpSZXBvcnRlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPgpGaXhl
czogODU4ZThiNzkyZDA2ICgidHBtLCB0cG1fdGlzOiBBdm9pZCBjYWNoZSBpbmNvaGVyZW5jeSBp
biB0ZXN0IGZvciBpbnRlcnJ1cHRzIikKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxs
LnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKLS0tCiBk
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUu
aAppbmRleCBlOTc4ZjQ1N2ZkNGQuLjYxMGJmYWRiNmFjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9j
aGFyL3RwbS90cG1fdGlzX2NvcmUuaAorKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5oCkBAIC04NCwxMCArODQsMTAgQEAgZW51bSB0aXNfZGVmYXVsdHMgewogI2RlZmluZSBJTEJf
UkVNQVBfU0laRQkJCTB4MTAwCiAKIGVudW0gdHBtX3Rpc19mbGFncyB7Ci0JVFBNX1RJU19JVFBN
X1dPUktBUk9VTkQJCT0gQklUKDApLAotCVRQTV9USVNfSU5WQUxJRF9TVEFUVVMJCT0gQklUKDEp
LAotCVRQTV9USVNfREVGQVVMVF9DQU5DRUxMQVRJT04JPSBCSVQoMiksCi0JVFBNX1RJU19JUlFf
VEVTVEVECQk9IEJJVCgzKSwKKwlUUE1fVElTX0lUUE1fV09SS0FST1VORAkJPSAwLAorCVRQTV9U
SVNfSU5WQUxJRF9TVEFUVVMJCT0gMSwKKwlUUE1fVElTX0RFRkFVTFRfQ0FOQ0VMTEFUSU9OCT0g
MiwKKwlUUE1fVElTX0lSUV9URVNURUQJCT0gMywKIH07CiAKIHN0cnVjdCB0cG1fdGlzX2RhdGEg
ewoKYmFzZS1jb21taXQ6IDc4NzdjYjkxZjEwODE3NTRhMTQ4N2MxNDRkODVkYzBkMmUyZTdmYzQK
LS0gCjIuNDAuMQoK
